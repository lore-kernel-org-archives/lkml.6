Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C91C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1266E2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1266E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeJLAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:49:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59156 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeJLAtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:49:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B630B12DE580E;
        Thu, 11 Oct 2018 10:21:30 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:21:30 -0700 (PDT)
Message-Id: <20181011.102130.1732595117003004122.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     ganeshgr@chelsio.com, rahul.lakkireddy@chelsio.com,
        kumaras@chelsio.com, rajur@chelsio.com, leedom@chelsio.com,
        arjun@chelsio.com, atul.gupta@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] cxgb4: fix thermal configuration dependencies
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181011085835.2567446-1-arnd@arndb.de>
References: <20181011085835.2567446-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Oct 2018 10:21:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Oct 2018 10:57:57 +0200

> With CONFIG_THERMAL=m, we get a build error:
> 
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c: In function 'cxgb4_thermal_get_trip_type':
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c:48:11: error: 'struct adapter' has no member named 'ch_thermal'
> 
> Once that is fixed by using IS_ENABLED() checks, we get a link error
> against the thermal subsystem when cxgb4 is built-in:
> 
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_init':
> cxgb4_thermal.c:(.text+0x180): undefined reference to `thermal_zone_device_register'
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_remove':
> cxgb4_thermal.c:(.text+0x1e0): undefined reference to `thermal_zone_device_unregister'
> 
> Finally, since CONFIG_THERMAL can be =m, the Makefile fails to pick up the
> extra file into built-in.a, and we get another link failure against the
> cxgb4_thermal_init/cxgb4_thermal_remove files, so the Makefile has to
> be adapted as well to work for both CONFIG_THERMAL=y and =m.
> 
> Fixes: b18719157762 ("cxgb4: Add thermal zone support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
