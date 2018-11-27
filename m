Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209ECC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0DE20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0DE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbeK0VrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:47:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44677 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeK0VrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:47:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so7181287oig.11;
        Tue, 27 Nov 2018 02:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y08LsoIPBnrDcbGcz3cWKb7D9hVOHDZAlTkgiibhUg4=;
        b=uheck62QOf7NC9e0vwIFdIunrA2wQegR3QfJ7qHXevmZTwku9IqImTuXapGK53XBR8
         drXcjlAtrFCMrsnS+yA33pJLtuQHyNJ7Qdb2g2rAXh0tlXPNs5lXxfaZb/roLMHecUiT
         pD/e1eQ3qhFalNudWg2R5y3o8/NNZxWrBOwxfnyJ1KExI0CcG99wCLoVSvcNzT1l8Iuv
         n5YvuyB0zamhfJRN/o8hmzIPPFCtJG6nu8yKWP5DIVRIctIPb7vzJwNHWoQBmLDdrc50
         0B6c1Whvcnb3YiinDchdEuN+Vh0rHJoZgxzAwhZ8goS5fuV2xHg8k2FDk4U9YRcWYuBb
         ucdg==
X-Gm-Message-State: AGRZ1gKqG+Qe1bascLCeE7z1DZUpiKIBGXDthsgIMrZ62wnaATEaVduI
        wzAZc4qDv25ku2VJKm3Dg8nxXhjOLuiFjSPqeX4=
X-Google-Smtp-Source: AJdET5fcNjJkzug7J0cC02hTuNfX0fVikBJBOUWPwgKz79SRZewABQlUFHKDJi2i1S1hSv4joLMjcEuNUxZQiVLTxk4=
X-Received: by 2002:aca:7581:: with SMTP id q123mr18526913oic.176.1543315779234;
 Tue, 27 Nov 2018 02:49:39 -0800 (PST)
MIME-Version: 1.0
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
 <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com> <20181126145210.GD12116@lunn.ch>
 <CAFcVECK=4e-+1u3X+OuLoAEicUtrkTX3C0wzAugMRcJSP0N-Vg@mail.gmail.com> <74937246-dc7d-db1c-df00-5db856192eac@microchip.com>
In-Reply-To: <74937246-dc7d-db1c-df00-5db856192eac@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 27 Nov 2018 16:19:28 +0530
Message-ID: <CAFcVECLSBb3nQcQa3+W6jVq8cubgLA=-vBvwrX-yLWUKdP50EA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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

<snip>
> >>>>
> >>>> Replace the while loop in MDIO read/write functions with a timeout.
> >>>> In addition, add a check for MDIO bus busy before initiating a new
> >>>> operation as well to make sure there is no ongoing MDIO operation.
> >>>
> >>> Is this MDIO bus busy check necessary? The caller of
> >>> macb_mdio_read/macb_mdio_write locks the mdio bus mutex before calling it
> >>> (e.g. mdiobus_read).
> >>
> >> Hi Claudiu
> >>
> >> It depends on the implementation. A write operation you could just
> >> launch, but not wait for it to complete, allowing you to do other
> >> stuff while the hardware is busy. For the next operation you then do
> >> need to check the previous operation has completed.
> >>
> >> I've not checked it is actually implemented this way.
> >
> > Yes, as Andrew mentioned, a previous MDIO bus operation cannot
> > be assumed to be complete always - for ex., in case of a timeout.
> > There is a chance that the MDIO bus bit is busy when mdio_read/write
> > is called.
>
> Thank you for your responses. I see it now.
>
> Then, do you think it would be better to have a new API part of struct
> mii_bus that drivers should register so that, the mii core to check if the
> bus is idle before lunching a new request?

Sure, let me explore this option.

Regards,
Harini
