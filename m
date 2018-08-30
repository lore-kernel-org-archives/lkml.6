Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B109AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409F1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409F1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeH3FDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:03:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeH3FDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:03:25 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 72D78108F4388;
        Wed, 29 Aug 2018 18:03:52 -0700 (PDT)
Date:   Wed, 29 Aug 2018 18:03:51 -0700 (PDT)
Message-Id: <20180829.180351.2286550022392793882.davem@davemloft.net>
To:     jbrunet@baylibre.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        jpinto@synopsys.com, soares@synopsys.com, clabbe@baylibre.com
Subject: Re: [PATCH] Revert "net: stmmac: Do not keep rearming the coalesce
 timer in stmmac_xmit"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180824090440.13411-1-jbrunet@baylibre.com>
References: <20180824090440.13411-1-jbrunet@baylibre.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Aug 2018 18:03:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 24 Aug 2018 11:04:40 +0200

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ff1ffb46198a..9f458bb16f2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3147,16 +3147,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 * element in case of no SG.
>  	 */
>  	priv->tx_count_frames += nfrags + 1;
> -	if (likely(priv->tx_coal_frames > priv->tx_count_frames) &&
> -	    !priv->tx_timer_armed) {
> +	if (likely(priv->tx_coal_frames > priv->tx_count_frames)) {
>  		mod_timer(&priv->txtimer,
>  			  STMMAC_COAL_TIMER(priv->tx_coal_timer));
> -		priv->tx_timer_armed = true;
>  	} else {
>  		priv->tx_count_frames = 0;
>  		stmmac_set_tx_ic(priv, desc);
>  		priv->xstats.tx_set_ic_bit++;
> -		priv->tx_timer_armed = false;
>  	}
>  

I think we should definitely revert this because it is racey on so many
different levels.

Yes, the scheduling of the timer only occurs here and it thus protected
by the ->xmit lock.

However, the timer itself runs and ends asynchronously to this piece
of code here.  This kind of logic only works if you tightly synchronize
the full execution of the timer with the same long, _AND_ you make the
timer resample the parameters to see if there is work still to do.

The TSO xmit code doesn't have the tx_timer_armed logic.

And finally, yes, this thing locks assuming a single queue.  This code
is seriously faulty on multi-queue and will access the TX ring of an
arbitrary queue only holding netif_tx_lock().

This stuff is really broken, so I'm reverting.  Someone has to fix the
per-queue locking in stmmac_tx_timer() too.
