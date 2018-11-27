Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E01720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E01720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeK0Qd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:33:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40562 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeK0Qd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:33:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so18230277oie.7;
        Mon, 26 Nov 2018 21:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CP37VBRo9cA/6pU/vvEmlSlENMaQ1d1t5TqQL1UZU88=;
        b=XrOrx9MlImpj1VWAY4CukC63ts7+fK3Ceoo1ThXTQRlavjkkqT3qVttPi7OT/k9YqS
         CHxhR+Ez7XMiTeM8VJfxdCIq4ephe+ck6mlkyVT/fdkxtbsoCVOEdTbg+mqfubXsv9Ws
         z6433QJki2t7yNieaLaBWtMfm+MgP9VGg4v+i4vwgYvL71hb/J906iAHm6dXGB0SktrZ
         vd05ggEU/EyGyhkLo22Q+die6gPeq5aghNF7mrYxwRbeHWg/I9chYc5FlTFWg/nL1o5n
         MMkWpdHslcEV/XQqe0otvAI0epTz2BqcCJEJhRpG053P6wv76JOk106XdJkCSxq7A9El
         APJQ==
X-Gm-Message-State: AA+aEWYt6s7+KZ4FsO0D6BGNXR6NiB8zIkSUVPtm3juPiRPqV/hF+4E8
        tHWbMhSNLHDWtSoeGVTnfrxbrfdbo4LHr5lE4UQ=
X-Google-Smtp-Source: AFSGD/V543qRLR+dTBUsr6ESQ1f5KBZmVzGYteAAeS9o0idqFwJux+mc1feSPl1C02cy0RCOHswaAMGk2eYRehBRz9k=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr206847oib.41.1543297006842;
 Mon, 26 Nov 2018 21:36:46 -0800 (PST)
MIME-Version: 1.0
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
 <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com> <20181126145210.GD12116@lunn.ch>
In-Reply-To: <20181126145210.GD12116@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 27 Nov 2018 11:06:36 +0530
Message-ID: <CAFcVECK=4e-+1u3X+OuLoAEicUtrkTX3C0wzAugMRcJSP0N-Vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sai.pavan.boddu@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,
On Mon, Nov 26, 2018 at 8:22 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Nov 26, 2018 at 02:46:01PM +0000, Claudiu.Beznea@microchip.com wrote:
> > Hi Harini,
> >
> > On 26.11.2018 09:07, Harini Katakam wrote:
> > > From: Harini Katakam <harinik@xilinx.com>
> > >
> > > Replace the while loop in MDIO read/write functions with a timeout.
> > > In addition, add a check for MDIO bus busy before initiating a new
> > > operation as well to make sure there is no ongoing MDIO operation.
> >
> > Is this MDIO bus busy check necessary? The caller of
> > macb_mdio_read/macb_mdio_write locks the mdio bus mutex before calling it
> > (e.g. mdiobus_read).
>
> Hi Claudiu
>
> It depends on the implementation. A write operation you could just
> launch, but not wait for it to complete, allowing you to do other
> stuff while the hardware is busy. For the next operation you then do
> need to check the previous operation has completed.
>
> I've not checked it is actually implemented this way.

Yes, as Andrew mentioned, a previous MDIO bus operation cannot
be assumed to be complete always - for ex., in case of a timeout.
There is a chance that the MDIO bus bit is busy when mdio_read/write
is called.

Regards,
Harini
