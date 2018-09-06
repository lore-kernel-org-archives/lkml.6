Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F22075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8F22075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeIFXO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:14:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbeIFXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:14:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86IarES396734
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 11:36:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86IaqtZ396731;
        Thu, 6 Sep 2018 11:36:52 -0700
Date:   Thu, 6 Sep 2018 11:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jia He <tipbot@zytor.com>
Message-ID: <tip-4cb205c0c50f613e2de91f0eb19d5247ed003e89@git.kernel.org>
Cc:     jia.he@hxt-semitech.com, mingo@kernel.org, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: jason@lakedaemon.net, marc.zyngier@arm.com,
          jia.he@hxt-semitech.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, olof@lixom.net, tglx@linutronix.de
In-Reply-To: <1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com>
References: <1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v3-its: Cap lpi_id_bits to reduce
 memory footprint
Git-Commit-ID: 4cb205c0c50f613e2de91f0eb19d5247ed003e89
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4cb205c0c50f613e2de91f0eb19d5247ed003e89
Gitweb:     https://git.kernel.org/tip/4cb205c0c50f613e2de91f0eb19d5247ed003e89
Author:     Jia He <jia.he@hxt-semitech.com>
AuthorDate: Tue, 28 Aug 2018 12:53:26 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 20:31:59 +0200

irqchip/gic-v3-its: Cap lpi_id_bits to reduce memory footprint

Commit fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs"), removes
the cap for lpi_id_bits, which causes the following warning to trigger on a
QDF2400 server:

 WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:4066  __alloc_pages_nodemask
 ... 
 Call trace:
  __alloc_pages_nodemask+0x2d8/0x1188
  alloc_pages_current+0x8c/0xd8
  its_allocate_prop_table+0x5c/0xb8
  its_init+0x220/0x3c0
  gic_init_bases+0x250/0x380
  gic_acpi_init+0x16c/0x2a4

In its_alloc_lpi_tables(), lpi_id_bits is 24 in QDF2400. The allocation in
allocate_prop_table() tries therefore to allocate 16M (order 12 if
pagesize=4k), which triggers the warning.

As said by MarcL

 Capping lpi_id_bits at 16 (which is what we had before) is plenty,
 will save a some memory, and gives some margin before we need to push
 it up again.

Bring the upper limit of lpi_id_bits back to prevent

Fixes: fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs")
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Olof Johansson <olof@lixom.net>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com

---
 drivers/irqchip/irq-gic-v3-its.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 316a57530f6d..c2df341ff6fa 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1439,6 +1439,7 @@ static struct irq_chip its_irq_chip = {
  * The consequence of the above is that allocation is cost is low, but
  * freeing is expensive. We assumes that freeing rarely occurs.
  */
+#define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static DEFINE_MUTEX(lpi_range_lock);
 static LIST_HEAD(lpi_range_list);
@@ -1625,7 +1626,8 @@ static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
 
-	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
+	lpi_id_bits = min_t(u32, GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
+				ITS_MAX_LPI_NRBITS);
 	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
