Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23651C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C041C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3CC3vR6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C041C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeJaX40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:56:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47266 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbeJaX40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PHtXs5RrCdqdohthCGtPhzGQ5zxPl+YDYwFG1xdprL0=;
        b=3CC3vR6vzwVQ+Syyo/8+9SJY7pVc1r6c+jxUW7Ejy7mI1qhBWWGKC8wlGV01G5Y3GjlBCO6t/tQHlaJjWDg1c4DYxvLpjrG8aKrLdn9aI28yVNjFOY1mjjNHsENtaBzlUmgXjywM240QyZkLPLRVewlSvy91OY+lwqYS7dXmUEs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHrwW-0006M7-KT; Wed, 31 Oct 2018 15:58:00 +0100
Date:   Wed, 31 Oct 2018 15:58:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com,
        Kedareswara rao Appana <appanad@xilinx.com>
Subject: Re: [PATCH 4/4] net: macb: Add support for suspend/resume with full
 power down
Message-ID: <20181031145800.GI20889@lunn.ch>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:10:23AM +0530, Harini Katakam wrote:
> When macb device is suspended and system is powered down, the clocks
> are removed and hence macb should be closed gracefully and restored
> upon resume. This patch does the same by switching off the net device,
> suspending phy and performing necessary cleanup of interrupts and BDs.
> Upon resume, all these are reinitialized again.
> 
> Reset of macb device is done only when GEM is not a wake device.
> Even when gem is a wake device, tx queues can be stopped and ptp device
> can be closed (tsu clock will be disabled in pm_runtime_suspend) as
> wake event detection has no dependency on this.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> ---
> Notes:
> I was unable to do a full macb_close/open in this patch as suggested
> because it was freeing and allocating the full RX/TX buffers and
> this time consuming, also leading to a crash when done continuously
> in stress tests. 

Hi Harini

Did you try stress testing just plain up/down, which will call
macb_open/macb_close? It could be it is broken already, and
suspend/resume just makes it more obvious it is broken.

	       Andrew
