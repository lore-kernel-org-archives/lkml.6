Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C692C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00099206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00099206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeK2FwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:52:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36200 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeK2FwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:52:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8557314E0761B;
        Wed, 28 Nov 2018 10:49:32 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:49:31 -0800 (PST)
Message-Id: <20181128.104931.1898736297454841540.davem@davemloft.net>
To:     bianpan2016@163.com
Cc:     thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amd-xgbe: set skb to NULL after freeing it
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1543392585-17962-1-git-send-email-bianpan2016@163.com>
References: <1543392585-17962-1-git-send-email-bianpan2016@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 10:49:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>
Date: Wed, 28 Nov 2018 16:09:45 +0800

> @@ -2754,6 +2754,7 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
>  				netif_err(pdata, rx_err, netdev,
>  					  "error in received packet\n");
>  			dev_kfree_skb(skb);
> +			skb = NULL;
>  			goto next_packet;
>  		}
>  
> @@ -2806,6 +2807,7 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
>  			netif_err(pdata, rx_err, netdev,
>  				  "packet length exceeds configured MTU\n");
>  			dev_kfree_skb(skb);
> +			skb = NULL;
>  			goto next_packet;
>  		}
>  
> -- 
> 2.7.4

If either of these two cases are executed, it means that it must be
the case that:

	!last || context_next

is FALSE, therefore the conditional in the tail code of this function:

	/* Check if we need to save state before leaving */
	if (received && (!last || context_next)) {
		rdata = XGBE_GET_DESC_DATA(ring, ring->cur);
		rdata->state_saved = 1;
		rdata->state.skb = skb;
		rdata->state.len = len;
		rdata->state.error = error;
	}

will not trigger, and therefore we will not record the free'd SKB.

And if we iterate the loop again, it is guaranteed that 'skb' will
be set to a new packet or NULL.

So there is no problem here.
