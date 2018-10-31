Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30935ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58242081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58242081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeKAAJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:09:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36454 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeKAAJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:09:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id r127-v6so12159306oie.3;
        Wed, 31 Oct 2018 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y7oVs92NHV9Bxku2kYiguSBO3ZrYPcqTR8aIVbst+8=;
        b=uEiBN8hChEGpnlXQ7OPrjOyVCIMa4jb5dieIv4tBnIrDviGURO27BlsOECarWOVfwW
         8Kn2IPoFG1j0quCaTvBGmGRBWx0+ZrX3gNGLgKR7R0MmtKH+Qel+6Ss8FMq89VvGWZ1/
         pDs65RpiOXgx+gxpooc0rZiqUTKBYYQD9VaSkP51ytfi3aGEPknlwxsu4YshCz7jLciK
         RQlCQqHZxlFqjakTYrImug/xS5GOJRLafHMNx/6hhWvcPHvoBGGXE8JxnQ/MGp9sogvQ
         +z+55yfMFo0U5pRa4JVDM1ar6u7ct3xGnp17uh6IgbUTeIwTy/4kDLypwuO6tte8deoo
         N5mA==
X-Gm-Message-State: AGRZ1gLHhCPW3HnZgNDUdhmwyqso0iput+cZ6o/fjCYyJyRYlhj2+wBS
        hB6QYJIX8gUT7xK4LUF+VLqO2bYKhFE82pmNUS0=
X-Google-Smtp-Source: AJdET5duqyYYZ23S5ycJZS6H+QOzSUuyZ/mGRbBcXv4SbsxO1cFdXZryu5Gapq9m+TDnQElpayO/Flqp2tuwKKHvUGc=
X-Received: by 2002:aca:6854:: with SMTP id d81-v6mr2069710oic.18.1540998636150;
 Wed, 31 Oct 2018 08:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-4-git-send-email-harini.katakam@xilinx.com> <20181031145400.GH20889@lunn.ch>
In-Reply-To: <20181031145400.GH20889@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 31 Oct 2018 20:40:25 +0530
Message-ID: <CAFcVECKg4u5t9=TOJ1omVJ=8ves_yvzcDZZA_-bE4OAv96cymg@mail.gmail.com>
Subject: Re: [PATCH 3/4] net: macb: Add pm runtime support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
On Wed, Oct 31, 2018 at 8:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 31, 2018 at 09:10:22AM +0530, Harini Katakam wrote:
> > From: Harini Katakam <harinik@xilinx.com>
> >
> > Add runtime pm functions and move clock handling there.
> > If device is suspended and not a wake device, then return from
> > mdio read/write functions without performing any action because
> > the clocks are not active.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Harini Katakam <harinik@xilinx.com>
> > ---
> > Changes from RFC:
> > Updated pm get sync/put sync calls.
> > Removed unecessary clk up in mdio helpers.
>
> This last bit has me worried.
>
> The MDIO bus is a shared bus with a life of its own.  You can have
> multiple PHYs and switches on it. The PHYs can for a different
> Ethernet MAC. Switch drivers will expect to be able to address the
> switch when the interface is down.
>
> The FEC driver did something similar for a while. I had to make MDIO
> read/write runtime PM aware, otherwise i could not access the Ethernet
> switch hanging of its MDIO bus.

Yes, I understand. But I thought I'd handle it when we have a separate
MDIO bus driver. As of now, with macb, I do not see a way, for ex.,
for MAC1 to access MDIO0 when MAC0 is suspended.
However, I will work a bit more on this solution.

With the clk up, I've noticed that there is atleast one PHY status poll
that ends up bringing the clock up after the MAC has been suspended.
Of course phy is supended immediately after that but it just delays
this full power down process.

Regards,
Harini
