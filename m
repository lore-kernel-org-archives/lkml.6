Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78085C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFE920652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwKpCmay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFE920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeJFDpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeJFDpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:45:08 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA9321479;
        Fri,  5 Oct 2018 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538772284;
        bh=WgYlrG8hsMysKrQL7wi+5KrUGOyEcBPRh5lkQOS2CM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EwKpCmay0er4e9MgcaOxLNPHhLh6IlAiXDLc1Bg8ehSU0oVm/zPfejDaXZg2iYFLn
         duxPRDWEnSNLw7DebxKS4rwy8+Ln9ITZTV32HXv1DJJP8pvmZ/pZrBQRNUwjARzDV7
         1pX10FOUvJ6CXdhJ2Im7uLnLntJdQKgiB36hzdw8=
Received: by mail-ot1-f46.google.com with SMTP id k5so1191778ote.3;
        Fri, 05 Oct 2018 13:44:44 -0700 (PDT)
X-Gm-Message-State: ABuFfog5NHl1PSn/q+GtxtpfijqQe1582dQDtdypVh0TP13ZzD0up6kH
        W3OfldMBzsnf+oKjbxtCyJBxb29+nCR2mU+PCgY=
X-Google-Smtp-Source: ACcGV637OhNaX10Wtivz8HBitdYdcAzfRYFeIkmsvccx5wLcjv7Z7gmuzOEWwloUXuA27c8Xpq4xIla3mhbsU30Xw40=
X-Received: by 2002:a9d:28d4:: with SMTP id s78mr7011887ota.38.1538772283747;
 Fri, 05 Oct 2018 13:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com> <8d10f9b4-7ea9-7d27-478a-39982ba49587@codeaurora.org>
 <CAOZdJXU=p0kz0PNhP8KwCQ0o7TuM=z2SvEz4b60_KveCrT7zPA@mail.gmail.com>
In-Reply-To: <CAOZdJXU=p0kz0PNhP8KwCQ0o7TuM=z2SvEz4b60_KveCrT7zPA@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Fri, 5 Oct 2018 15:44:06 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUgFS+f6P5TFfh2s==fT3jEi8tAnJLX+uQJvFpzfOpDjA@mail.gmail.com>
Message-ID: <CAOZdJXUgFS+f6P5TFfh2s==fT3jEi8tAnJLX+uQJvFpzfOpDjA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
To:     Timur Tabi <timur@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 11:54 AM Timur Tabi <timur@kernel.org> wrote:
> If you want, just put a printk(... offset) in msm_gpio_get() and read
> from a GPIO that you know you have access to, and make sure the
> 'offset' is correct.
>
> Then try reading from a GPIO that you don't have access to, and make
> sure you get a failure before msm_gpio_get() is called.

Just FYI, if you use sysfs to write to the GPIO, based on the kernel
log you pasted, GPIO 362 in sysfs is actually pin 0 in the TLMM.

If you use gpio-test, it uses gpiolib which figures this all out for
you.  There should still be the gpio-test wiki page I wrote that tells
you how to use it.
