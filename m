Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC0C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9030520896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfARTIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:08:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46042 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfARTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:08:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7ED3514BA3511;
        Fri, 18 Jan 2019 11:08:15 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:08:14 -0800 (PST)
Message-Id: <20190118.110814.2046519039828393505.davem@davemloft.net>
To:     thomas.petazzoni@bootlin.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] net: phy: mdio_bus: add missing device_del() in
 mdiobus_register() error handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
References: <20190116095358.28354-1-thomas.petazzoni@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Jan 2019 11:08:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 16 Jan 2019 10:53:58 +0100

> The current code in __mdiobus_register() doesn't properly handle
> failures returned by the devm_gpiod_get_optional() call: it returns
> immediately, without unregistering the device that was added by the
> call to device_register() earlier in the function.
> 
> This leaves a stale device, which then causes a NULL pointer
> dereference in the code that handles deferred probing:
 ...
> The actual error that we had from devm_gpiod_get_optional() was
> -EPROBE_DEFER, due to the GPIO being provided by a driver that is
> probed later than the Ethernet controller driver.
> 
> To fix this, we simply add the missing device_del() invocation in the
> error path.
> 
> Fixes: 69226896ad636 ("mdio_bus: Issue GPIO RESET to PHYs")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Applied and queued up for -stable.
