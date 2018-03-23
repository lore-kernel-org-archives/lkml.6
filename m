Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCWQUj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:20:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43296 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:20:37 -0400
Date: Fri, 23 Mar 2018 12:20:35 -0400 (EDT)
Message-Id: <20180323.122035.1380806748695640531.davem@davemloft.net>
To: okaya@codeaurora.org
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
References: <1521738603-23596-1-git-send-email-okaya@codeaurora.org>
        <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 22 Mar 2018 13:10:00 -0400

> Code includes wmb() followed by writel(). writel() already has a
> barrier on some architectures like arm64.
 ...
> @@ -4155,7 +4155,7 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	txdata->tx_db.data.prod += nbd;
>  	barrier();
>  
> -	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
> +	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);
>  
>  	mmiowb();
 ...
> @@ -2592,7 +2592,7 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
>  
>  	txdata->tx_db.data.prod += 2;
>  	barrier();
> -	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
> +	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);

These are compiler barriers being used here, not wmb().

Look, if I can't see a clear:

	wmb()
	writel()

sequence in the patch hunks, I am going to keep pushing back on
these changes.

Thank you.
