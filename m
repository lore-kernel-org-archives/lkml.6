Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C642E217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897580;
	bh=MJgE5UFtV5jnf2c1HYYeYXRrIPsolmPJWjgpsqcYm9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BVkna3rZgpPUQxrhVN7jMpTjDE237Dd8zKsXguMb70PI/lzGrWHYmmiye8kwF0MuN
	 s/xr0H3pddYw2lQN628vBNEmsp1NSgiunWXw12HT9Ikqzwqjaj4ezDQY8J4lLtVjW3
	 4Y9ZfutoVT9N7UXpT0412IEK86t9MhAQAqWEEKbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbfBKPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390501AbfBKPGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:06:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B51222A7;
        Mon, 11 Feb 2019 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897575;
        bh=MJgE5UFtV5jnf2c1HYYeYXRrIPsolmPJWjgpsqcYm9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbeqUyvFSrZO2piEWrY7YGdih6TK3qaiLG2KtJaaraTa6LuDw6CL4TQPJA21xgZE7
         4qtuO7ngaRfrE9l2S+P8nRjwzwPC9BqT1aTkfsvwIeQZh49H43RZwMgT/VDLUZCjp7
         LDGSFcdtRQ1lRL5vvPx6eOimvfUqxoIiC6ny/98o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 042/137] ARM: dts: Fix OMAP4430 SDP Ethernet startup
Date:   Mon, 11 Feb 2019 15:18:43 +0100
Message-Id: <20190211141815.869684151@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 84fb6c7feb1494ebb7d1ec8b95cfb7ada0264465 ]

It was noticed that unbinding and rebinding the KSZ8851 ethernet
resulted in the driver reporting "failed to read device ID" at probe.
Probing the reset line with a 'scope while repeatedly attempting to
bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
constantly held at zero, meaning the device is held in reset, and
does not respond on the SPI bus.

Experimentation with the startup delay on the regulator set to 50ms
shows that the reset is positively released after 20ms.

Schematics for this board are not available, and the traces are buried
in the inner layers of the board which makes tracing where the RSTN pin
extremely difficult.  We can only guess that the RSTN pin is wired to a
reset generator chip driven off the ethernet supply, which fits the
observed behaviour.

Include this delay in the regulator startup delay - effectively
treating the reset as a "supply stable" indicator.

This can not be modelled as a delay in the KSZ8851 driver since the
reset generation is board specific - if the RSTN pin had been wired to
a GPIO, reset could be released earlier via the already provided support
in the KSZ8851 driver.

This also got confirmed by Peter Ujfalusi <peter.ujfalusi@ti.com> based
on Blaze schematics that should be very close to SDP4430:

TPS22902YFPR is used as the regulator switch (gpio48 controlled):
Convert arm boot_lock to raw The VOUT is routed to TPS3808G01DBV.
(SCH Note: Threshold set at 90%. Vsense: 0.405V).

According to the TPS3808 data sheet the RESET delay time when Ct is
open (this is the case in the schema): MIN/TYP/MAX: 12/20/28 ms.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
[tony@atomide.com: updated with notes from schematics from Peter]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4-sdp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index d728ec963111..891ba75fd459 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -33,6 +33,7 @@
 		gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;  /* gpio line 48 */
 		enable-active-high;
 		regulator-boot-on;
+		startup-delay-us = <25000>;
 	};
 
 	vbat: fixedregulator-vbat {
-- 
2.19.1



