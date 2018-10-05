Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C11C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1923C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1wGc/3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1923C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJEXyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:54:14 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614AE2098A;
        Fri,  5 Oct 2018 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538758481;
        bh=YKij32Qs7N10hpTTQO/qICFK6FswWYMCh1aT+XaWnFI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P1wGc/3Oy1ZdY8jdX1lnaFLHmduwO2CjVC/WXC6++Qk5XhMXm+hx460d4QizDpj/+
         Bfx7tw65Bt4Q9VXEWX8HkUa8pDyy4KM/37GeMZ/cBFtDv7VdSoXNiR2DTQG+mwjkOT
         rI205RRpPbJIqcIwTEvgrouCRRyoTaYOHcYntT4k=
Received: by mail-oi1-f170.google.com with SMTP id w81-v6so10919509oiw.9;
        Fri, 05 Oct 2018 09:54:41 -0700 (PDT)
X-Gm-Message-State: ABuFfojV5/5XAJkSSuT+2fpvHG5YrZR02jIJrp4alifYecYN6hJIYTFl
        1Gf5tnc0RpC0RwyHLl3WeXJWH3mDD45MmstYym0=
X-Google-Smtp-Source: ACcGV60KLIdmfRumpoCVszqp+wimUZ5T0Yw5MeVywgPwMEfy4luHTv1eN+Yjq5RwJyMDCc/i+OM/lcAn2ebyGe84r7M=
X-Received: by 2002:aca:e804:: with SMTP id f4-v6mr6145023oih.38.1538758480634;
 Fri, 05 Oct 2018 09:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com> <8d10f9b4-7ea9-7d27-478a-39982ba49587@codeaurora.org>
In-Reply-To: <8d10f9b4-7ea9-7d27-478a-39982ba49587@codeaurora.org>
From:   Timur Tabi <timur@kernel.org>
Date:   Fri, 5 Oct 2018 11:54:03 -0500
X-Gmail-Original-Message-ID: <CAOZdJXU=p0kz0PNhP8KwCQ0o7TuM=z2SvEz4b60_KveCrT7zPA@mail.gmail.com>
Message-ID: <CAOZdJXU=p0kz0PNhP8KwCQ0o7TuM=z2SvEz4b60_KveCrT7zPA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus <linus.walleij@linaro.org>, Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 11:17 AM, Jeffrey Hugo wrote:>
> Looks like the driver is initing just fine to me.  Is setting up the
> jumpers and running gpio-test warranted?

Well, that test only makes sure that input/output is actually working
on the hardware level, but it also makes sure that the GPIOs are
numbered correctly.

If you want, just put a printk(... offset) in msm_gpio_get() and read
from a GPIO that you know you have access to, and make sure the
'offset' is correct.

Then try reading from a GPIO that you don't have access to, and make
sure you get a failure before msm_gpio_get() is called.
