Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1304C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700520854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7700520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeIMSnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeIMSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90869D19;
        Thu, 13 Sep 2018 13:33:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 4.4 45/60] irqchip/gicv3-its: Fix memory leak in its_free_tables()
Date:   Thu, 13 Sep 2018 15:30:52 +0200
Message-Id: <20180913131747.555279999@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 1a485f4d2e28efd77075b2952926683d6c245633 upstream.

The current ITS driver has a memory leak in its_free_tables(). It
happens on tear down path of the driver when its_probe() call fails.
its_free_tables() should free the exact number of pages that have
been allocated, not just a single page as current code does.

This patch records the memory size for each ITS_BASERn at the time of
page allocation and uses the same size information when freeing pages
to fix the issue.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Vikram Sethi <vikrams@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1454379584-21772-1-git-send-email-shankerd@codeaurora.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -67,7 +67,10 @@ struct its_node {
 	unsigned long		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
-	void			*tables[GITS_BASER_NR_REGS];
+	struct {
+		void		*base;
+		u32		order;
+	} tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
 	u64			flags;
@@ -816,9 +819,10 @@ static void its_free_tables(struct its_n
 	int i;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
-		if (its->tables[i]) {
-			free_page((unsigned long)its->tables[i]);
-			its->tables[i] = NULL;
+		if (its->tables[i].base) {
+			free_pages((unsigned long)its->tables[i].base,
+				   its->tables[i].order);
+			its->tables[i].base = NULL;
 		}
 	}
 }
@@ -899,7 +903,8 @@ retry_alloc_baser:
 			goto out_free;
 		}
 
-		its->tables[i] = base;
+		its->tables[i].base = base;
+		its->tables[i].order = order;
 
 retry_baser:
 		val = (virt_to_phys(base) 				 |
@@ -949,7 +954,7 @@ retry_baser:
 			 * something is horribly wrong...
 			 */
 			free_pages((unsigned long)base, order);
-			its->tables[i] = NULL;
+			its->tables[i].base = NULL;
 
 			switch (psz) {
 			case SZ_16K:


