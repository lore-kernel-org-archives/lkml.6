Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2135C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CEE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHPqUQSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfAUNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:35:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44718 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfAUNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:35:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so15491844lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BcSIrLTLqVPAlc/mnonzR+ecGg9/bwbWnJAbuAfYKwY=;
        b=SHPqUQSOWhcxbqkoUGimiatcjmxiiQfqPxEAzL6EwvwjrQE55dFX9ypnOFcNR2b4XO
         hNcXoJh51yl3v0cAwRWFqPo3KarPW0cQxPR1V1/P2vhm2trDjqUYrVGVAzEWoFyQQAyM
         1kkfaBFViKQbXx7wsrHKTD5f71jqCbO2RJQh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BcSIrLTLqVPAlc/mnonzR+ecGg9/bwbWnJAbuAfYKwY=;
        b=mFxYm2OtU4LYJ3bU/hIizv/GOCJ8JwUZs3xD8K3sIFgM5Q8qnVfQa/spbin82gvtDc
         tO70UNHtG9Mj3Mvh5rEPKDP9aoGdpr9g3/iHIXRPw4AyWZiPeeyNewoASL2v95ag1vbq
         YtI3Jqd/+1TfaZJJT6S9hUiG4FHKaaQws4aReuSbhLWz0OLygaXJNH1b6DPz2NCtZTP+
         fwUj4X6eXvy8JEF49ivoEzGQt1uLTosrNmcliByhrg1GL0AmrZAA8VyS4glfwFQIMmAa
         9xa/FfqjwoXvtRVoHBVl+1YGQrEattbOE5oobAQUjO7C5Uw4kWWkjY8FuXmWP6iD9ng5
         DTIg==
X-Gm-Message-State: AJcUukcLOAtMUQ09gEQu8RT21A/ajwJ8uo8+8XS2ZZEEuiDCDofCxudp
        Rd1M6RDyo1qF6raTom9YL0SPtcbuV2KD5qvWBSnqhA==
X-Google-Smtp-Source: ALg8bN6kwx7Cd9e6AYTn9zaKd66y2vqKa3qFryIsjf+RY850fHnH3DzVJtNsLuw12GPtidqOenMdZUZgrnVCrh94C3Q=
X-Received: by 2002:a19:f813:: with SMTP id a19mr17696258lff.67.1548077728293;
 Mon, 21 Jan 2019 05:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20190114191450.11597-1-j.neuschaefer@gmx.net> <20190114191450.11597-3-j.neuschaefer@gmx.net>
In-Reply-To: <20190114191450.11597-3-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:35:16 +0100
Message-ID: <CACRpkdajHGy2rhTvgOfq76SYhVe1L5cYmznq-s0kVYcmzdqe0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: hlwd: Implement edge trigger emulation
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 8:15 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> Like the Spreadtrum EIC driver[1], this driver needs to emulate edge
> triggered interrupts to support the generic gpio-keys driver.
>
> [1]: https://www.spinics.net/lists/kernel/msg2764576.html
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> v2:
> - Changed register addresses to io{read,write}32be() instead of
>   hlwd->gpioc.{read,write}_reg, as suggested by Linus Walleij.

Patch applied!

Yours,
Linus Walleij
