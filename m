Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D4A2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D4A2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeI0PXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:23:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39878 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeI0PXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:23:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id c25-v6so1911533qtp.6;
        Thu, 27 Sep 2018 02:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MV3GIy0sSYL/X0zBEV9Skah3msHf3Brj728MwXuYj78=;
        b=KpEeRX1QjvkvLfR+lN/dPm0jidiYwZYQOl8W9RRNPpFDJxNT+udK3X6Ru2TCnFxWnL
         INeAp+mXx0fJSSeoHtCeKD4Tycd99L6Ux+eiBsE+7jKOboc16gKb5KijNbpb4J1W4PzI
         FKmwSu1DNqRCdkpyEkSnEMSEm1Pn2EVaj3ToXWTV7vnXKYX2XcyNoftNBTgEx3e4176t
         cMBShiuhfyO45asbblUD/Hdylg8YTI2W6dTpdTTE8T+h17DXDvOgV/dk9JlXHEY5fKmD
         BOK7Hcp0euH2recv2zs8QjSpfKxfQr3Q4xjGQal5uboy98gAg08b1T/XKzz8g1OgNpIf
         vaIQ==
X-Gm-Message-State: ABuFfoj1X+jm38cbx7mWKX/g2RAvvXpmM8KdfHLx8UMxNFo31L8bnoYa
        HVbdKygfzLWusSwiDSWF38MbObFJNJdg/rd9FDw=
X-Google-Smtp-Source: ACcGV61n0HRdfocKX4T4y+msumFXhCA5F/oGgKEXjmsD42s3f33kF89E71CCOqa4ecp2PlIfkmKKs5wfAPNNc3CPyPw=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr7416310qtf.185.1538039183186;
 Thu, 27 Sep 2018 02:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180926125127.2004280-1-arnd@arndb.de> <20180926211706.eswbm2hgbmgy2oog@kekkonen.localdomain>
In-Reply-To: <20180926211706.eswbm2hgbmgy2oog@kekkonen.localdomain>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 27 Sep 2018 11:06:06 +0200
Message-ID: <CAK8P3a0K6aX_GR+yh4MhkWkBDiHiaq5NC+TrKfqcWFXoptNHmg@mail.gmail.com>
Subject: Re: [PATCH] media: ov9650: avoid maybe-uninitialized warnings
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:17 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Arnd,
>
> On Wed, Sep 26, 2018 at 02:51:01PM +0200, Arnd Bergmann wrote:
> > The regmap change causes multiple warnings like
> >
> > drivers/media/i2c/ov9650.c: In function 'ov965x_g_volatile_ctrl':
> > drivers/media/i2c/ov9650.c:889:29: error: 'reg2' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >    exposure = ((reg2 & 0x3f) << 10) | (reg1 << 2) |
> >               ~~~~~~~~~~~~~~~^~~~~~
> >
> > It is apparently hard for the compiler to see here if ov965x_read()
> > returned successfully or not. Besides, we have a v4l2_dbg() statement
> > that prints an uninitialized value if regmap_read() fails.
> >
> > Adding an 'else' clause avoids the ambiguity.
>
> Thanks!
>
> I'm not sure what happened here but the two lines use spaces for
> indentation. I've replaced those with tabs.

Thanks a lot, that was clearly what I had intended to send.

        Arnd
