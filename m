Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B107C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751052184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfAYLDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:03:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36525 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfAYLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:03:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so8165833otk.3;
        Fri, 25 Jan 2019 03:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAYtSANcjPnHVnOE8j9yEak2CRFE8syD/5+aXmZ6tRc=;
        b=eGdf8rXf4aVN3qPd6wVMNtiiNsHrZqShNOs3Ih/bkQjBNpimU4r0Y9IYppuKoWu+6X
         FkufeFD+x65FYZPcsDqnve+yLE6Ypzz68d2HWpUPnoM4aJQGnHUUkT8aGZbZvPKu3L3m
         awjabKdr3yIjQG0NjRqGe8RwYWUNY9oLYmKm3AQMMXAPv5TqM7oykUtRWJrEF1lXtAZo
         gzaBRNFuTDBO6inD2pA893AVCH5rMNu+E6lYoo4SL3x2YnkyqNRbTQlRpT0gHK/yEbSL
         GuzdqkoP677zFpoRHYA7sFpMVxy0KOffDHGhXYINkQEGYwN7eG3bu2848PFwXxhVzZe7
         eIAQ==
X-Gm-Message-State: AJcUukdnWPEsaqrLEsCMCKfu04Mn8Ae4JBV7EMktEk0/D0PQEuCk09U+
        gWe3k4doyagDUWM/6jvhVhYANcg7n+ko/YqGdsg=
X-Google-Smtp-Source: ALg8bN48/W4n5/GP4unIxOVTWCvds31GVahb+lbQA+xlSb30EgIi6wR2joEf9YEV7oFm0uS/WGi31k+eYyo9w2Md8BQ=
X-Received: by 2002:a9d:6c59:: with SMTP id g25mr7623348otq.55.1548414193802;
 Fri, 25 Jan 2019 03:03:13 -0800 (PST)
MIME-Version: 1.0
References: <1548337111-31184-1-git-send-email-harini.katakam@xilinx.com> <e9c3ae69-a0cb-3862-c01d-d8d1fc3c68e8@microchip.com>
In-Reply-To: <e9c3ae69-a0cb-3862-c01d-d8d1fc3c68e8@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Fri, 25 Jan 2019 16:33:02 +0530
Message-ID: <CAFcVEC+JrSp7YxVa33tCtAm9Xcpi=sZO8sOBOh=XOAzWTvfA5A@mail.gmail.com>
Subject: Re: [PATCH] net: macb: Apply RXUBR workaround only to versions with errata
To:     Nicolas Ferre <Nicolas.Ferre@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Brandon Streiff <brandon.streiff@ni.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Fri, Jan 25, 2019 at 3:58 PM <Nicolas.Ferre@microchip.com> wrote:
>
> On 24/01/2019 at 14:38, Harini Katakam wrote:
> > The interrupt handler contains a workaround for RX hang applicable
> > to Zynq and AT91 only. Subsequent versions do not need this
>
> AT91RM9200 only. It's not the case for other AT91 SoCs (reading errata
> list for them).
>
> That being said I have to add a patch for making this perfectly clear in
> the comment just above the flag's test.
>
> > workaround. This workaround unecessarily resets RX whenever RX used
>
> Typo: unnecessarily
>
> > bit read is observed, which can be often under heavy traffic. Hence
> > introduce an CAPS mask and a check to enable this workaround.
>
> Nack for this one, see below...

Thanks for the review. I dint realize it was AT91RM9200, hence I edited
the wrong config structure. Will fix.

<snip>

> >               if (status & MACB_BIT(RXUBR)) {
> > -                     ctrl = macb_readl(bp, NCR);
> > -                     macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
> > -                     wmb();
> > -                     macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
> > +                     if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR) {
> > +                             ctrl = macb_readl(bp, NCR);
> > +                             macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
> > +                             wmb();
> > +                             macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
> > +                     }
>
> As this interrupt routine is not doing anything else than just being
> called now, what about just removing the use of this status bit for
> platforms which don't need this RX reset?

OK, sure I'll try that. I left the interrupt enabled just in case there were
other users performing an action/using this interrupt.

Regards,
Harini
