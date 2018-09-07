Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ADEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5627206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5627206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeIHCgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:36:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53362 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIHCgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:36:00 -0400
Received: from localhost (unknown [207.32.164.225])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 40883147BB355;
        Fri,  7 Sep 2018 14:53:02 -0700 (PDT)
Date:   Fri, 07 Sep 2018 14:53:01 -0700 (PDT)
Message-Id: <20180907.145301.1015987862616643832.davem@davemloft.net>
To:     mail@maciej.szmigiero.name
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, a3at.mail@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH] r8169: set TxConfig register after TX / RX is enabled,
 just like RxConfig
From:   David Miller <davem@davemloft.net>
In-Reply-To: <fd32f0db-373a-2ee4-8a99-5fe6c5441606@maciej.szmigiero.name>
References: <fd32f0db-373a-2ee4-8a99-5fe6c5441606@maciej.szmigiero.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Sep 2018 14:53:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Fri, 7 Sep 2018 20:15:22 +0200

> Commit 3559d81e76bf ("r8169: simplify rtl_hw_start_8169") changed order of
> two register writes:
> 1) Caused RxConfig to be written before TX / RX is enabled,
> 2) Caused TxConfig to be written before TX / RX is enabled.
> 
> At least on XIDs 10000000 ("RTL8169sb/8110sb") and
> 18000000 ("RTL8169sc/8110sc") such writes are ignored by the chip, leaving
> values in these registers intact.
> 
> Change 1) was reverted by
> commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices"),
> however change 2) wasn't.
> 
> In practice, this caused TxConfig's "InterFrameGap time" and "Max DMA Burst
> Size per Tx DMA Burst" bits to be zero dramatically reducing TX performance
> (in my tests it dropped from around 500Mbps to around 50Mbps).
> 
> This patch fixes the issue by moving TxConfig register write a bit later in
> the code so it happens after TX / RX is already enabled.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> ---
> "Fixes" tag points to the RxConfig fix instead of the actual commit that
> introduced this regression to maintain patch ordering since the RxConfig fix
> partially affects the same code lines as this fix.

Applied, thanks.

Please, in the future, always put your Fixes: tag first in the set of tags.

Thank you.
