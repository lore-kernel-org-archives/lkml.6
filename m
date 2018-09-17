Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B4A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeIQUZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:25:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeIQUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:25:23 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6120E1449F968;
        Mon, 17 Sep 2018 07:57:41 -0700 (PDT)
Date:   Mon, 17 Sep 2018 07:57:40 -0700 (PDT)
Message-Id: <20180917.075740.785419710659934511.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: let phylink manage the carrier state
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180914145635.21813-1-antoine.tenart@bootlin.com>
References: <20180914145635.21813-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 07:57:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri, 14 Sep 2018 16:56:35 +0200

> Net drivers using phylink shouldn't mess with the link carrier
> themselves and should let phylink manage it. The mvpp2 driver wasn't
> following this best practice as the mac_config() function made calls to
> change the link carrier state. This led to wrongly reported carrier link
> state which then triggered other issues. This patch fixes this
> behaviour.
> 
> But the PPv2 driver relied on this misbehaviour in two cases: for fixed
> links and when not using phylink (ACPI mode). The later was fixed by
> adding an explicit call to link_up(), which when the ACPI mode will use
> phylink should be removed.
> 
> The fixed link case was relying on the mac_config() function to set the
> link up, as we found an issue in phylink_start() which assumes the
> carrier is off. If not, the link_up() function is never called. To fix
> this, a call to netif_carrier_off() is added just before phylink_start()
> so that we do not introduce a regression in the driver.
> 
> Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied.
