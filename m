Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B896C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AEE233F2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AEE233F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbeKFDhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:37:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbeKFDhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:37:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CCBB144A04B9;
        Mon,  5 Nov 2018 10:16:11 -0800 (PST)
Date:   Mon, 05 Nov 2018 10:16:10 -0800 (PST)
Message-Id: <20181105.101610.1437737564548154497.davem@davemloft.net>
To:     starnight@g.ncu.edu.tw
Cc:     afaerber@suse.de, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, dollar.chen@wtmec.com, ken.yu@rakwireless.com,
        linux-wpan@vger.kernel.org, stefan@datenfreihafen.org
Subject: Re: [PATCH V2 2/7] net: lorawan: Add LoRaWAN socket module
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105165544.5215-3-starnight@g.ncu.edu.tw>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
        <20181105165544.5215-3-starnight@g.ncu.edu.tw>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 10:16:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue,  6 Nov 2018 00:55:40 +0800

> +static inline struct lrw_mac_cb * mac_cb(struct sk_buff *skb)

"mac_cb()" is pretty generic for a name, and leads to namespace pollution,
please use lrw_mac_cb() or similar.

> +static inline struct dgram_sock *
> +dgram_sk(const struct sock *sk)
> +{
> +	return container_of(sk, struct dgram_sock, sk);
> +}
> +
> +static inline struct net_device *
> +lrw_get_dev_by_addr(struct net *net, u32 devaddr)

Never use inline for functions in a foo.c file, let the compiler decide.

> +{
> +	struct net_device *ndev = NULL;
> +	__be32 be_addr = cpu_to_be32(devaddr);

Always order local variables from longest to shortest line.

> +static int
> +dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> +	      int noblock, int flags, int *addr_len)
> +{
> +	struct sk_buff *skb;
> +	size_t copied = 0;
> +	DECLARE_SOCKADDR(struct sockaddr_lorawan *, saddr, msg->msg_name);
> +	int err;

Likewise.

I'm not going to point out every single place where you have made these
two errors.

Please audit your entire submission and fix the problems wherever they
occur.

Thank you.
