Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054862054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3VWElvvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054862054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbeJaXw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:52:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47260 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbeJaXw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nTaMe4Ijrb/hWbV8eZwRWwAayNCVKm8ZNUHkV4/eQzk=;
        b=3VWElvvJPoO7Dvbjim5iP3SctJunpopQqQYEqG9KtdWWr4I16S3o2VoVe0doeGzZB7z9unH1GnguNTlEa7v3xEWvPL1NqjhMKpuCA4MyTdQrx52ch6cET2Xeb+yaPIG7huIRTlDpzzj2ZzuOhbwkZ1ebrZM3gRQgZeKQRsR5Vfo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHrse-0006Jh-Uk; Wed, 31 Oct 2018 15:54:00 +0100
Date:   Wed, 31 Oct 2018 15:54:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH 3/4] net: macb: Add pm runtime support
Message-ID: <20181031145400.GH20889@lunn.ch>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-4-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540957223-30984-4-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:10:22AM +0530, Harini Katakam wrote:
> From: Harini Katakam <harinik@xilinx.com>
> 
> Add runtime pm functions and move clock handling there.
> If device is suspended and not a wake device, then return from
> mdio read/write functions without performing any action because
> the clocks are not active.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
> Changes from RFC:
> Updated pm get sync/put sync calls.
> Removed unecessary clk up in mdio helpers.

This last bit has me worried.

The MDIO bus is a shared bus with a life of its own.  You can have
multiple PHYs and switches on it. The PHYs can for a different
Ethernet MAC. Switch drivers will expect to be able to address the
switch when the interface is down.

The FEC driver did something similar for a while. I had to make MDIO
read/write runtime PM aware, otherwise i could not access the Ethernet
switch hanging of its MDIO bus.

	Andrew
