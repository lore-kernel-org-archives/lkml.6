Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FEC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307FE279FA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe9qD+gU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307FE279FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeF2V27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:28:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46937 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeF2V25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:28:57 -0400
Received: by mail-lf0-f67.google.com with SMTP id l16-v6so5475084lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X8NTS5csKwONzhNhz1OZywt2+bb8xp0c2iEwII+fm7w=;
        b=fe9qD+gU1a4M5NHww+blfdARLy1u101h6N7TJ9s4QaoABDDzUs/1acgsctXS8NDKMe
         fSp1AywYf2mJgrlWrxJZxaDaH/6WfT1w50/ET2333Y8O5YUUG4vaIfySsfl6DbjO+XJt
         EJ0I8Qcb8c34lHT/m3XnTnugCK/oazHHbMhgK32JG7dYXyTK2X/LcOVtqfrnCLjehNWn
         BP4KUNO+czkS4WDXVmKQ39q+AoJyUb9W3Ye+Uq8Y/s3D7ydT/ID9X+MMVcGKJ4UILJ0l
         4sluDE6iYGvxPIZutIKN+S+mZynubSv/7G46RbMcXTmherq1IeIsabObIbXZSo1wzzSt
         /zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X8NTS5csKwONzhNhz1OZywt2+bb8xp0c2iEwII+fm7w=;
        b=KQvhJLwV2dQKv6ZnWOqlrMw1B2ANdZXc6z1J6aDfj5dAcE7giVhE5oAomtzJNsXPFc
         oDAS8/Wd3yHMQAWEHVlRr1lNOhvjjOaItmH4o9VqKUICb2s5tfL8GX9FqdgNSqkFlrjY
         wM0ku3HV1xnh6SYe5z6nubLoEtvrK2ma3TILG7O/rA04Er9yKcrRAO7nJV93CDOJMaAT
         af2PSAppjdkOWUNzCsKvY6OfIQ1WASGNID6R0H4+Ohuy2H1TIymJc2dmds7wXDSiucIS
         Xr1yPXozEPijKKpe+SMC9iJMTxmkshl1ZsRN5/63kMfb8BTR7NmuAgztysOJ7DK2WzYV
         +ytQ==
X-Gm-Message-State: APt69E1E8LZKzhYICjfSIS9O0GHyxQe/uUI28IMPNMI8rphO/siHqpl4
        5LleofGP0nSECyTlLn4itYNUnfngwUX3C/+ubQiypc0p
X-Google-Smtp-Source: AAOMgpeK6Qf9hDdFup/VdTm8o4sxl/0vJznRn5XHkn+X20QXKj3o5EHMaYJ4CNthQ/fBDJw0BoZQ/xvi2i1PJvEhLtQ=
X-Received: by 2002:a19:dd5c:: with SMTP id u89-v6mr10517390lfg.83.1530307736270;
 Fri, 29 Jun 2018 14:28:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:28:55
 -0700 (PDT)
In-Reply-To: <20180629185212.GA37517@beast>
References: <20180629185212.GA37517@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 23:28:55 +0200
X-Google-Sender-Auth: XggBrVhpCSFgCbMQzR7ADMTMQwE
Message-ID: <CAK8P3a31AzEdfzzRxNn=upBjt9F6szczZT=Mj5n354fg3LCcsA@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:52 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a maximum size and adds a sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
