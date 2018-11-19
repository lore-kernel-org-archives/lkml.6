Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9472089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpHRPW9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9472089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeKTAg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:36:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbeKTAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:36:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so18044901lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28RJy74gUYpdnlBnyud84XdLUW/CMJEwOZrID6V8hxs=;
        b=DpHRPW9ulhYFiGAie+g3kYsM62vNEjig6UiyoJwV/ICVMS9QyP/LxX1FZiqjLxRT+A
         4gTJnagoI9UL9fZ9euWU5amsmduXYtdb7E2tNpkYGnetwixP0SckMVg0/XqK/P+pW5jB
         Tle4NnA9sEJ+7rCdtaLnFU85ZQR7wWxXDd3sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28RJy74gUYpdnlBnyud84XdLUW/CMJEwOZrID6V8hxs=;
        b=oaxMerEjWOWvipuY3IMdEK0qcoTq2lomsXZKIAe5QZf3Q1qi784MNwQbFd3GBAcFNP
         5CCxbU32zvkPFQqKeeZ1olPAd8CO7LrRsd3gVXGmf9ui1TSKbliheCTbsdqUxj0RpTDs
         Qwk0DxMyKd/CdP4/Ds1ChgmpHFNz9GRfcvcLzXqeu4rbjMQnpjVpLRwjuppeOXrB8Uuq
         xLGqGa6rINdxyObohsSywE37Vozy2tcRHd5lxrkQ7qtNjWQBn0KpC5T0wBDT62dF5giH
         ZKTxsqAvf03G3EUnqwh/qwMHXPDsGSviplz+JLtAGnx8gJkRyaYMknkMmv7thJqpZslr
         bKTg==
X-Gm-Message-State: AA+aEWZzYasMpbPbdO94GJc5M8X38oN+wAAYhAJ2AnhdjogDQOtSc90b
        Z5IaE7bvVtBkvyvhAN0LKALI6n6wc62Kxv8yH7q88trkN28=
X-Google-Smtp-Source: AFSGD/VXHc3SP0kuDYnKt82lBKut5Z4jV7sAaZyK2yVTRvCNkp+MUqOjCjP2AJnJFouPHZN0zz6S3FgAS550zlmr9Oo=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr7072435ljk.4.1542636789330;
 Mon, 19 Nov 2018 06:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20181116185853.128207-1-evgreen@chromium.org>
In-Reply-To: <20181116185853.128207-1-evgreen@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 15:12:57 +0100
Message-ID: <CACRpkdZ5OsrECHzTgEHTqt5c6UAUuu5Mjs9MaE92ahfp2w8YoQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: msm: Add sleep pinctrl state transitions
To:     evgreen@chromium.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 7:59 PM Evan Green <evgreen@chromium.org> wrote:

> Add PM suspend callbacks to the msm core driver that select the
> sleep and default pinctrl states. Then wire those callbacks up
> in the sdm845 driver, for those boards that may have GPIO hogs
> that need to change state during suspend.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes in v2:
>  - Moved dev_pm_ops structure to pinctrl-msm [Bjorn]

Patch applied with Bj=C3=B6rn's ACK.

Yours,
Linus Walleij
