Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C0AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9720831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s7ZAakij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E9720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJ3VDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:03:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46056 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbeJ3VDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=DA0W34KdCdXK/M1/fLBkxMH1gHDRPC+AUNQWiO2+iN0=;
        b=s7ZAakijiwU/THh9P3rH0x0//N+a8O59YT1lpdqG/Y7to0auMvCnFbIvLiabkYjg0gTQj0PO2Tw6G5J31dHRbk+w1y/uSuhRpHYQxUP9peFSAXJOlzeEG/nPy0QKE2RCJiNlmvc/MZM6kpUY5S0Ua/CvUvfaDDtSueMWX7kZbfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHSqs-0007U1-3i; Tue, 30 Oct 2018 13:10:30 +0100
Date:   Tue, 30 Oct 2018 13:10:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: xilinx_emaclite: recheck condition after
 timeout in mdio_wait()
Message-ID: <20181030121030.GD27873@lunn.ch>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-3-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030093139.10226-3-kurt@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:31:39AM +0100, Kurt Kanzenbach wrote:
> The function could report a false positive if it gets preempted between reading
> the XEL_MDIOCTRL_OFFSET register and checking for the timeout.  In such a case,
> the condition has to be rechecked to avoid false positives.
> 
> Therefore, check for expected condition even after the timeout occurred.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index 639e3e99af46..957d03085bd0 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -714,19 +714,29 @@ static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
>  static int xemaclite_mdio_wait(struct net_local *lp)
>  {
>  	unsigned long end = jiffies + 2;
> +	u32 val;
>  
>  	/* wait for the MDIO interface to not be busy or timeout
>  	 * after some time.
>  	 */
> -	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
> -			XEL_MDIOCTRL_MDIOSTS_MASK) {
> +	while (1) {
> +		val = xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET);

Hi Kurt

It looks like readx_poll_timeout() should work here.

   Andrew
