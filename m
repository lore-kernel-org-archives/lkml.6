Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF540C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75FC21736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLXSIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:08:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35074 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:08:38 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9999E13407FA1;
        Mon, 24 Dec 2018 10:08:37 -0800 (PST)
Date:   Mon, 24 Dec 2018 10:08:36 -0800 (PST)
Message-Id: <20181224.100836.117884501889550887.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net: appletalk/cops: remove redundant if
 statement and mask
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181222165841.18288-1-colin.king@canonical.com>
References: <20181222165841.18288-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 10:08:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sat, 22 Dec 2018 16:58:41 +0000

> @@ -777,10 +777,7 @@ static void cops_rx(struct net_device *dev)
>          }
>  
>          /* Get response length. */
> -	if(lp->board==DAYNA)
> -        	pkt_len = inb(ioaddr) & 0xFF;
> -	else
> -		pkt_len = inb(ioaddr) & 0x00FF;
> +	pkt_len = inb(ioaddr);

There are other instances of similar weird identical statements guarded
by the test on the board type being DAYNA.

For example, in cops_send_packet():

	if(lp->board == DAYNA)
               	outb(skb->len >> 8, ioaddr);
	else
		outb((skb->len >> 8)&0x0FF, ioaddr);

Could you scan the rest of the driver and deal with all of these
instances in one go?

Thank you!
