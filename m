Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE2ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E4E214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E4E214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeIRHdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:33:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54096 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbeIRHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:33:18 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0817D1462227F;
        Mon, 17 Sep 2018 19:03:09 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:03:08 -0700 (PDT)
Message-Id: <20180917.190308.350168193472877492.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com,
        robh@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: socionext: Fix two sleep-in-atomic-context bugs
 in ave_rxfifo_reset()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180915040246.22703-1-baijiaju1990@gmail.com>
References: <20180915040246.22703-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 19:03:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Sat, 15 Sep 2018 12:02:46 +0800

> The driver may sleep with holding a spinlock.
> The function call paths (from bottom to top) in Linux-4.17 are:
> 
> [FUNC] usleep_range
> drivers/net/ethernet/socionext/sni_ave.c, 892: 
> 	usleep_range in ave_rxfifo_reset
> drivers/net/ethernet/socionext/sni_ave.c, 932: 
> 	ave_rxfifo_reset in ave_irq_handler
> 
> [FUNC] usleep_range
> drivers/net/ethernet/socionext/sni_ave.c, 888: 
> 	usleep_range in ave_rxfifo_reset
> drivers/net/ethernet/socionext/sni_ave.c, 932: 
> 	ave_rxfifo_reset in ave_irq_handler
> 
> To fix these bugs, usleep_range() is replaced with udelay().
> 
> These bugs are found by my static analysis tool DSAC.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied to net-next.
