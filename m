Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0A5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01BD2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01BD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeK2QRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:17:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36714 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2QRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:17:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so651499otk.3;
        Wed, 28 Nov 2018 21:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mvUoBjvZmdv/xRkkS/F74/xuNUcXIOfpcGJAkJEMt8=;
        b=NJZe8CWEbfSsMjXkH9VOWs6pOxdfWzS6HBnGPZwOBE/iKXy7Zxxgj1y3eKCP2DbKMj
         U8pjiqac3HI0zdDFUEENY6NFkb9vs12SqaXrOK2cZhe12myEXkUlC0aNxN+RNlcaYtDP
         dAdYpsZTlV3S/ciLmzn5fL3fr5CwTpvHj1YrYdQC2JO8pTQTiSvEmfeyEOvhrz6A8nMJ
         yQjffstorNVSgSkqAH2ySwBjEKnkMwXzDf5EaCrDw/us8FxB+iKUu0MaqCGUGI/U9Gn8
         xWjBeZvMtFeNONCNCYuJtnf2PeDu5g/1pYp1YPX/ggtYLQGSyr8/Ea6yd/RAeHwWKgA8
         oa3w==
X-Gm-Message-State: AA+aEWax9BGBPwb63IXaT2907P5anYNU68YylvKzbkBBswF6jEWrW412
        Q03MEDXEio+kW7TAAWYIRGC5pQeiEfoaHVT+kHQ=
X-Google-Smtp-Source: AFSGD/Wr1n8oe9JLsIjFO7RxJsNKfExOpBDoVKzOXt4A3twCc1P6EDILsZ3iD3nMPZ8i/w7hiWhHVeqF5j+bacyA3/8=
X-Received: by 2002:a9d:46b:: with SMTP id 98mr41844otc.339.1543468392452;
 Wed, 28 Nov 2018 21:13:12 -0800 (PST)
MIME-Version: 1.0
References: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com> <5b550305-ff96-fdf6-883e-b6ae69ad3124@ni.com>
In-Reply-To: <5b550305-ff96-fdf6-883e-b6ae69ad3124@ni.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Thu, 29 Nov 2018 10:43:01 +0530
Message-ID: <CAFcVECL=6J4EPetP1g+f5KNxg6V=RZrvbCRL9fOHJpVczE0Rtg@mail.gmail.com>
Subject: Re: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
To:     Brandon Streiff <brandon.streiff@ni.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brandon,

On Thu, Nov 29, 2018 at 2:39 AM Brandon Streiff <brandon.streiff@ni.com> wrote:
>
> On 11/23/2018 3:59 AM, Harini Katakam wrote:
> > +/* Errata mask bits */
> > +#define MACB_ERRATA_RXLOCKUP                 0x00000001
> > +
> >  /* LSO settings */
> >  #define MACB_LSO_UFO_ENABLE                  0x01
> >  #define MACB_LSO_TSO_ENABLE                  0x02
> > @@ -1085,6 +1088,7 @@ struct macb_config {
> >                           struct clk **rx_clk);
> >       int     (*init)(struct platform_device *pdev);
> >       int     jumbo_max_len;
> > +     u32     errata;
> >  };
> >
> >  struct tsu_incr {
> > @@ -1214,6 +1218,8 @@ struct macb {
> >
> >       int     rx_bd_rd_prefetch;
> >       int     tx_bd_rd_prefetch;
> > +
> > +     u32 errata;
> >  };
>
> Hi Harini,
>
> Could this be made into simpler by instead adding a caps bit, named
> (perhaps) MACB_CAPS_BUGGY_RXUBR or MACB_CAPS_NEEDS_RXUBR_RESETS or
> something?
>
> That would save needing to add a new u32 field into the macb_config and
> macb structs (both of which already have this caps field).

Thanks for the review. Yes, the caps field already has all that.
The only reason I separated it was that CAPS generally referred to a feature and
this is a workaround for an errata. There's no functional need, of course and
I'm ok to integrate it as well.

Regards,
Harini
