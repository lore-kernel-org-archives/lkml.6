Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA83C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D099C2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D099C2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeH2Nkp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:40:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46393 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbeH2Nkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:40:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF688207B1; Wed, 29 Aug 2018 11:44:40 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id A15A7206EE;
        Wed, 29 Aug 2018 11:44:40 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829163021.70ce99ab@xhacker.debian>
Date:   Wed, 29 Aug 2018 11:44:39 +0200
In-Reply-To: <20180829163021.70ce99ab@xhacker.debian> (Jisheng Zhang's message
        of "Wed, 29 Aug 2018 16:30:21 +0800")
Message-ID: <87wos9ik1k.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,
 
 On mer., août 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> In the loop of mvneta_tx_done_gbe(), we call the smp_processor_id()
> each time, move the call out of the loop to optimize the code a bit.
>
> Before the patch, the loop looks like(under arm64):
>
>         ldr     x1, [x29,#120]
>         ...
>         ldr     w24, [x1,#36]
>         ...
>         bl      0 <_raw_spin_lock>
>         str     w24, [x27,#132]
>         ...
>
> After the patch, the loop looks like(under arm64):
>
>         ...
>         bl      0 <_raw_spin_lock>
>         str     w23, [x28,#132]
>         ...
> where w23 is loaded so be ready before the loop.
>
> From another side, mvneta_tx_done_gbe() is called from mvneta_poll()
> which is in non-preemptible context, so it's safe to call the
> smp_processor_id() function once.

This improvement should go to net-next. Besides this patch looks nice:

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 7d98f7828a30..62e81e267e13 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2507,12 +2507,13 @@ static void mvneta_tx_done_gbe(struct mvneta_port *pp, u32 cause_tx_done)
>  {
>  	struct mvneta_tx_queue *txq;
>  	struct netdev_queue *nq;
> +	int cpu = smp_processor_id();
>  
>  	while (cause_tx_done) {
>  		txq = mvneta_tx_done_policy(pp, cause_tx_done);
>  
>  		nq = netdev_get_tx_queue(pp->dev, txq->id);
> -		__netif_tx_lock(nq, smp_processor_id());
> +		__netif_tx_lock(nq, cpu);
>  
>  		if (txq->count)
>  			mvneta_txq_done(pp, txq);
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
