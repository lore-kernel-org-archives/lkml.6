Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC7C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E44320879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E44320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeI3BKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:10:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56996 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3BKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:10:03 -0400
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D8EE41476CF80;
        Sat, 29 Sep 2018 11:40:33 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:40:23 -0700 (PDT)
Message-Id: <20180929.114023.1370133506922372520.davem@davemloft.net>
To:     vdronov@redhat.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: arp, ipv6: handle special case of tap device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926093018.6646-1-vdronov@redhat.com>
References: <20180926093018.6646-1-vdronov@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Sep 2018 11:40:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>
Date: Wed, 26 Sep 2018 11:30:18 +0200

> @@ -187,7 +187,14 @@ EXPORT_SYMBOL(arp_tbl);
>  
>  int arp_mc_map(__be32 addr, u8 *haddr, struct net_device *dev, int dir)
>  {
> -	switch (dev->type) {
> +	unsigned short type = dev->type;
> +
> +#if IS_ENABLED(CONFIG_TAP)
> +	if (dev->rtnl_link_ops && !strcmp(dev->rtnl_link_ops->kind, "tun"))
> +		type = ARPHRD_ETHER;
> +#endif /* CONFIG_TAP */

This is insanely ugly.

dev->type determines the link layer header layout and size.

You can fix the kernel, but userspace AF_PACKET applications are still
going to be broken by this behavior.  And that is just the tip of the
iceberg.

I'm not applying this, sorry.  I think tun/tap should be prevented from
allowing the dev->type to be changed, unless it will make those changes
adjust the link layer headers properly as well.

Sorry.
