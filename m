Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C03218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeL2F1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:27:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeL2F1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:27:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC5A61451513B;
        Fri, 28 Dec 2018 21:27:51 -0800 (PST)
Date:   Fri, 28 Dec 2018 21:27:51 -0800 (PST)
Message-Id: <20181228.212751.1498034981468762216.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     isdn@linux-pingi.de, natechancellor@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: hisax: hfc_pci: Fix a possible concurrency
 use-after-free bug in HFCPCI_l1hw()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181226140934.12903-1-baijiaju1990@gmail.com>
References: <20181226140934.12903-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 21:27:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 26 Dec 2018 22:09:34 +0800

> In drivers/isdn/hisax/hfc_pci.c, the functions hfcpci_interrupt() and
> HFCPCI_l1hw() may be concurrently executed.
> 
> HFCPCI_l1hw()
>   line 1173: if (!cs->tx_skb)
> 
> hfcpci_interrupt()
>   line 942: spin_lock_irqsave();
>   line 1066: dev_kfree_skb_irq(cs->tx_skb);
> 
> Thus, a possible concurrency use-after-free bug may occur 
> in HFCPCI_l1hw().
> 
> To fix these bugs, the calls to spin_lock_irqsave() and
> spin_unlock_irqrestore() are added in HFCPCI_l1hw(), to protect the
> access to cs->tx_skb.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.
