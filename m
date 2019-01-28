Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D343C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2A22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0EMqKDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfA1Orl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:47:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1Orl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:47:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so14502079lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKK4inmtsjA81xIaKjYBVKu5Y2axTkKuwPiRoIlTRSo=;
        b=e0EMqKDglMCt+qt/WmXPBiht/hPfhoDEelzQ9KphIc6mlVevd2SIN/gDxLrClTLOgI
         Cxilcfu4O7J7xdjJDTX/1bJ9l0myeaGsJctkM4H7hFKkg98PebpJYZK86NeuC2k9YXOY
         P9LQwTY9073RxFXhDrbCelrxEVfmHbtlxbey8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKK4inmtsjA81xIaKjYBVKu5Y2axTkKuwPiRoIlTRSo=;
        b=L0GqhImBxZLrXNmA+O9KV25NX29zfR/XTsDAKEdVReP/mnzDAffFGJ8dqPsFb5RfWk
         1GT91j/YsZNGPSmc1YDJI+mVoqPDVezr9+bLaOpS1qhKr+CRlD3iECJ7WjokcbvWNDAC
         HWxMBRkAmi5q3ADf1HeGJHMeHAhSArZtuCe0mhwgdoVL7L8GlDBJ/g7Li10MgnNKEJAs
         6rwIShVTLgBmhFJBu1bBjyDgLDgna0SszV3ZFcWMVVKZEXizvikv4O3ZlT8JI1FzhFIw
         2wfTwi1e8zG31EJXFCHgQFixHgKVDGV/r9H/mgLE6wW0C9TzbJJKVScylvQEl0atIqaI
         puIA==
X-Gm-Message-State: AJcUukeEJd5GkPSzTQ1HKbFKLo7bkej3dUcUbpsvX7c68Swlvrqyomzr
        42GzuKdGhcxX96pwXUBbx1oTbS4k9mSdThohvar5iw==
X-Google-Smtp-Source: ALg8bN5/WefJ+eUnaIJ/np0vSNkMOGqPRTIuyxooAq7rRBYCcpOPnFz4BA9Lt8nzaMnnqxR7QpkePRhnLomots64HbA=
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr18730616lje.105.1548686858973;
 Mon, 28 Jan 2019 06:47:38 -0800 (PST)
MIME-Version: 1.0
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548410393-6981-2-git-send-email-zhouyanjie@zoho.com> <CACRpkdYe2NsBFC-KBQXhmsSJ-S7wN9cZZuEPKHSfQe4HZUXTPg@mail.gmail.com>
 <5C4F14E9.7030203@zoho.com>
In-Reply-To: <5C4F14E9.7030203@zoho.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 15:47:27 +0100
Message-ID: <CACRpkdbG5Abcp0wzgyVpr06n-f=Djs_zzRxwgMX1xCxwEnUSog@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] Pinctrl: Ingenic: Fix bugs caused by
 differences between JZ4770 and JZ4780.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>, syq@debian.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, 772753199@qq.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 3:43 PM Zhou Yanjie <zhouyanjie@zoho.com> wrote:

> Thank you for your reply. I am working on v2, and I have removed the
> fourth patch in v2,
> so there will be no warnings at compile time. But this will cause some
> warning messages
> when checkpatch, I am confused whether I can ignore these warnings.

I don't care super much about checkpatch warnings, compiler
warnings for const correctness is more important.

Yours,
Linus Walleij
