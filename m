Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B996AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA8420881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA8420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ele0n.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbeGIOG6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:06:58 -0400
Received: from br3ak3r.de ([5.9.139.165]:33596 "EHLO Br3ak3r.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932508AbeGIOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:06:57 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 10:06:56 EDT
Received: by Br3ak3r.de (Postfix, from userid 1006)
        id E4AD3957490; Mon,  9 Jul 2018 15:58:30 +0200 (CEST)
From:   Daniel Klamt <eleon@ele0n.de>
To:     benh@kernel.crashing.org
Cc:     paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Daniel Klamt <eleon@ele0n.de>,
        Bjoern Noetel <bjoern@br3ak3r.de>
Subject: [PATCH] powerpc: Replaced msleep with usleep_range
Date:   Mon,  9 Jul 2018 15:57:59 +0200
Message-Id: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced msleep for less than 10ms with usleep_range because will
often sleep longer than intended.
For original explanation see:
Documentation/timers/timers-howto.txt

Signed-off-by: Daniel Klamt <eleon@ele0n.de>
Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>
---
 arch/powerpc/sysdev/xive/native.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 311185b9960a..b164b1cdf4d6 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -109,7 +109,7 @@ int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
 		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100)
 	}
 	return rc == 0 ? 0 : -ENXIO;
 }
@@ -163,7 +163,7 @@ int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
 		rc = opal_xive_set_queue_info(vp_id, prio, qpage_phys, order, flags);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 	if (rc) {
 		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
@@ -190,7 +190,7 @@ static void __xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
 		rc = opal_xive_set_queue_info(vp_id, prio, 0, 0, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 	if (rc)
 		pr_err("Error %lld disabling queue for prio %d\n", rc, prio);
@@ -253,7 +253,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 	for (;;) {
 		irq = opal_xive_allocate_irq(chip_id);
 		if (irq == OPAL_BUSY) {
-			msleep(1);
+			usleep_range(1000, 1100);
 			continue;
 		}
 		if (irq < 0) {
@@ -275,7 +275,7 @@ u32 xive_native_alloc_irq(void)
 		rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 	if (rc < 0)
 		return 0;
@@ -289,7 +289,7 @@ void xive_native_free_irq(u32 irq)
 		s64 rc = opal_xive_free_irq(irq);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 }
 EXPORT_SYMBOL_GPL(xive_native_free_irq);
@@ -305,7 +305,7 @@ static void xive_native_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 	for (;;) {
 		rc = opal_xive_free_irq(xc->hw_ipi);
 		if (rc == OPAL_BUSY) {
-			msleep(1);
+			usleep_range(1000, 1100);
 			continue;
 		}
 		xc->hw_ipi = 0;
@@ -400,7 +400,7 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 		rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 	if (rc) {
 		pr_err("Failed to enable pool VP on CPU %d\n", cpu);
@@ -444,7 +444,7 @@ static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
 		rc = opal_xive_set_vp_info(vp, 0, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 }
 
@@ -645,7 +645,7 @@ u32 xive_native_alloc_vp_block(u32 max_vcpus)
 		rc = opal_xive_alloc_vp_block(order);
 		switch (rc) {
 		case OPAL_BUSY:
-			msleep(1);
+			usleep_range(1000, 1100);
 			break;
 		case OPAL_XIVE_PROVISIONING:
 			if (!xive_native_provision_pages())
@@ -687,7 +687,7 @@ int xive_native_enable_vp(u32 vp_id, bool single_escalation)
 		rc = opal_xive_set_vp_info(vp_id, flags, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 	return rc ? -EIO : 0;
 }
@@ -701,7 +701,7 @@ int xive_native_disable_vp(u32 vp_id)
 		rc = opal_xive_set_vp_info(vp_id, 0, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 	return rc ? -EIO : 0;
 }
-- 
2.11.0

