Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30748205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30748205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeK2GBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:01:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36392 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeK2GBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:01:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EFDAE14E0ECFF;
        Wed, 28 Nov 2018 10:59:06 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:59:06 -0800 (PST)
Message-Id: <20181128.105906.2127945279482643879.davem@davemloft.net>
To:     bianpan2016@163.com
Cc:     Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dwc-xlgmac: set skb to NULL after freeing it
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1543396853-35188-1-git-send-email-bianpan2016@163.com>
References: <1543396853-35188-1-git-send-email-bianpan2016@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 10:59:07 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>
Date: Wed, 28 Nov 2018 17:20:53 +0800

> @@ -1180,6 +1180,7 @@ static int xlgmac_rx_poll(struct xlgmac_channel *channel, int budget)
>  				netif_err(pdata, rx_err, netdev,
>  					  "error in received packet\n");
>  			dev_kfree_skb(skb);
> +			skb = NULL;
>  			goto next_packet;
>  		}
>  
> @@ -1227,6 +1228,7 @@ static int xlgmac_rx_poll(struct xlgmac_channel *channel, int budget)
>  			netif_err(pdata, rx_err, netdev,
>  				  "packet length exceeds configured MTU\n");
>  			dev_kfree_skb(skb);
> +			skb = NULL;
>  			goto next_packet;
>  		}

Same problem as your amd-xgbe patch, the condition you say can occurr is
actually impossible.
