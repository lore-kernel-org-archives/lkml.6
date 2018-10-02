Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6344C2147C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6344C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbeJBUT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733215AbeJBUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:55 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A0FBB4A;
        Tue,  2 Oct 2018 13:36:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 20/94] ARM: hwmod: RTC: Dont assume lock/unlock will be called with irq enabled
Date:   Tue,  2 Oct 2018 06:24:34 -0700
Message-Id: <20181002132501.877163671@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Gerlach <d-gerlach@ti.com>

[ Upstream commit 6d609b35c815ba20132b7b64bcca04516bb17c56 ]

When the RTC lock and unlock functions were introduced it was likely
assumed that they would always be called from irq enabled context, hence
the use of local_irq_disable/enable. This is no longer true as the
RTC+DDR path makes a late call during the suspend path after irqs
have been disabled to enable the RTC hwmod which calls both unlock and
lock, leading to IRQs being reenabled through the local_irq_enable call
in omap_hwmod_rtc_lock call.

To avoid this change the local_irq_disable/enable to
local_irq_save/restore to ensure that from whatever context this is
called the proper IRQ configuration is maintained.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap_hwmod_reset.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -92,11 +92,13 @@ static void omap_rtc_wait_not_busy(struc
  */
 void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	omap_rtc_wait_not_busy(oh);
 	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
 	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
 /**
@@ -110,9 +112,11 @@ void omap_hwmod_rtc_unlock(struct omap_h
  */
 void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	omap_rtc_wait_not_busy(oh);
 	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
 	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
-	local_irq_enable();
+	local_irq_restore(flags);
 }


