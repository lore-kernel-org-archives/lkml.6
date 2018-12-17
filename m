Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D54206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389265AbeLQTRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:17:04 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:49514 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389145AbeLQTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:17:01 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-70-99-nat.elisa-mobile.fi [85.76.70.99])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 3CEC930084;
        Mon, 17 Dec 2018 21:16:58 +0200 (EET)
Date:   Mon, 17 Dec 2018 21:16:58 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181217191657.GB7288@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122151236.GA9611@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
> Also we can't deal with the omap_set_dma_dest_burst_mode() setting -
> DMAengine always uses a 64 byte burst, but udc wants a smaller burst
> setting.  Does this matter?

Looking at OMAP1 docs, it seems it supports only 16 bytes. Then checking
DMAengine code, I don't think these CSDP bit values are not valid
for OMAP1:

        CSDP_SRC_BURST_1        = 0 << 7,
        CSDP_SRC_BURST_16       = 1 << 7,
        CSDP_SRC_BURST_32       = 2 << 7,
        CSDP_SRC_BURST_64       = 3 << 7,

From TI SPRU674 document, pages 50-51:

	0	single access (no burst)
	1	single access (no burst)
	2	burst 4
	3	reserved (do not use this setting)

So if CSDP_SRC_BURST_64 (3) gets programmed OMAP1, I wonder what is the
end result, no burst or burst 4...

A.
