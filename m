Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B731C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D1320823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dKqPdoPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D1320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeJ3VB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:01:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46048 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeJ3VB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Bkql3OanxwRX/WQ4VqurxgcX/dmjrBLqATGz8Np2/9s=;
        b=dKqPdoPuaIhaivsRUHGcYPWAgHev4aqlrUHHHZXg/hC5vy2UBmU82KjhO4g+FUEcBLF1HjLWNCyKnkQEF78h55dJsLHUp//YUyE0ydVAEz4U0Z/wU6qixxxRLzDhvsX8y8X4p3gFtku40IQUu7/loKDHbdx9WZSODevVJPr6bJ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHSox-0007R8-FQ; Tue, 30 Oct 2018 13:08:31 +0100
Date:   Tue, 30 Oct 2018 13:08:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: xlinx: mdio: recheck condition after timeout
Message-ID: <20181030120831.GC27873@lunn.ch>
References: <20181030093139.10226-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030093139.10226-1-kurt@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:31:37AM +0100, Kurt Kanzenbach wrote:
> Hi,
> 
> the Xilinx mdio wait functions may return false positives under certain
> circumstances: If the functions get preempted between reading the corresponding
> mdio register and checking for the timeout, they could falsely indicate a
> timeout.

Hi Kurt

I wonder if it would be possible to add a readx_poll_timeout() which
passes two parameters to op()?

I keep seeing this basic problem in various drivers, and try to point
people towards readx_poll_timeout(), but it is not the best of fit.

Otherwise, could you add a axienet_ior_read_mcr(lp), and use
readx_poll_timeout() as is?

       Andrew
