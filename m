Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D021D08
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6UxyO0hJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021D021D08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeHIOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:37:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59684 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbeHIOhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=j+jIsr8SylJrzkdrD5baKVPDQAT/wnrVIUFNaQ2FDQE=;
        b=6UxyO0hJXS3Bnp7beOpnQw3xzckQPoQPdBlYIb0WnbUmUNXlO/z5HDmHDa96+QXmhAtM0YVhkq7k59XqNwiypa2wcH69rhI6bzV8jHlSPDY3azOv1ugG19HJZHWvaVR5OV98wNcdaXGr1rYiVnOtGsdEZg/FCVzB8c1E/RdXpzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fnjoT-0004VA-03; Thu, 09 Aug 2018 14:13:09 +0200
Date:   Thu, 9 Aug 2018 14:13:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomas Hlavacek <tomas.hlavacek@nic.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: mvneta: use the correct napi pointer
Message-ID: <20180809121308.GC16359@lunn.ch>
References: <20180809200242.1166f86c@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809200242.1166f86c@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 08:02:42PM +0800, Jisheng Zhang wrote:
> if neta_armada3700 is true, the mvneta_pcpu_port's napi is invalid, we
> should use pp->napi instead. Fix mvneta_config_rss() with this method.
> Although we can fix mvneta_rx_hwbm() and mvneta_rx_swbm() in the same
> manner, the napi parm of mvneta_poll() is always correct, so we can
> pass the correct napi param to mvneta_rx_hwbm() and mvneta_rx_swbm()
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Hi Jisheng

How does this differ from

commit 7a86f05faf112463cfbbdfd222012e247de461a1
Author: Andrew Lunn <andrew@lunn.ch>
Date:   Wed Jul 18 18:10:50 2018 +0200

    net: ethernet: mvneta: Fix napi structure mixup on armada 3700
    
    The mvneta Ethernet driver is used on a few different Marvell SoCs.
    Some SoCs have per cpu interrupts for Ethernet events. Some SoCs have
    a single interrupt, independent of the CPU. The driver handles this by
    having a per CPU napi structure when there are per CPU interrupts, and
    a global napi structure when there is a single interrupt.
    
    When the napi core calls mvneta_poll(), it passes the napi
    instance. This was not being propagated through the call chain, and
    instead the per-cpu napi instance was passed to napi_gro_receive()
    call. This breaks when there is a single global napi instance.
    
    Signed-off-by: Andrew Lunn <andrew@lunn.ch>
    Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
    Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

which is already in net-next, and i hope net?

      Andrew
