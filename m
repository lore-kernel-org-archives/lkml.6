Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F03C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C044920837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C044920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeICDXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 23:23:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeICDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 23:23:02 -0400
Received: from localhost (168-64-212-66.spl.org [66.212.64.168])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9909E109018CF;
        Sun,  2 Sep 2018 16:05:38 -0700 (PDT)
Date:   Sun, 02 Sep 2018 16:05:38 -0700 (PDT)
Message-Id: <20180902.160538.1996490624543458172.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cadence: Fix a sleep-in-atomic-context bug in
 macb_halt_tx()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180901121105.436-1-baijiaju1990@gmail.com>
References: <20180901121105.436-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Sep 2018 16:05:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Sat,  1 Sep 2018 20:11:05 +0800

> The kernel module may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] usleep_range
> drivers/net/ethernet/cadence/macb_main.c, 648: 
> 	usleep_range in macb_halt_tx
> drivers/net/ethernet/cadence/macb_main.c, 730: 
> 	macb_halt_tx in macb_tx_error_task
> drivers/net/ethernet/cadence/macb_main.c, 721: 
> 	_raw_spin_lock_irqsave in macb_tx_error_task
> 
> To fix this bug, usleep_range() is replaced with udelay().
> 
> This bug is found by my static analysis tool DSAC.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thanks.
