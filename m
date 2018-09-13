Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28124C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D946C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeIMSnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeIMSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC782D10;
        Thu, 13 Sep 2018 13:33:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 4.4 46/60] irqchip/gicv3-its: Avoid cache flush beyond ITS_BASERn memory size
Date:   Thu, 13 Sep 2018 15:30:53 +0200
Message-Id: <20180913131747.607156056@linuxfoundation.org>
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

commit 2eca0d6ceea1f108b2d3ac81fb34698c4fd41006 upstream.

Function its_alloc_tables() maintains two local variables, "order" and
and "alloc_size", to hold memory size that has been allocated to
ITS_BASEn. We don't always refresh the variable alloc_size whenever
value of the variable order changes, causing the following two
problems.

  - Cache flush operation with size more than required.
  - Information reported by pr_info is not correct.

Use a helper macro that converts page order to size in bytes instead of
variable "alloc_size" to fix both the problems.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -80,6 +80,9 @@ struct its_node {
 
 #define ITS_ITT_ALIGN		SZ_256
 
+/* Convert page order to size in bytes */
+#define PAGE_ORDER_TO_SIZE(o)	(PAGE_SIZE << (o))
+
 struct event_lpi_map {
 	unsigned long		*lpi_map;
 	u16			*col_map;
@@ -855,7 +858,6 @@ static int its_alloc_tables(const char *
 		u64 type = GITS_BASER_TYPE(val);
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
 		int order = get_order(psz);
-		int alloc_size;
 		int alloc_pages;
 		u64 tmp;
 		void *base;
@@ -887,9 +889,8 @@ static int its_alloc_tables(const char *
 			}
 		}
 
-		alloc_size = (1 << order) * PAGE_SIZE;
 retry_alloc_baser:
-		alloc_pages = (alloc_size / psz);
+		alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
 			order = get_order(GITS_BASER_PAGES_MAX * psz);
@@ -942,7 +943,7 @@ retry_baser:
 			shr = tmp & GITS_BASER_SHAREABILITY_MASK;
 			if (!shr) {
 				cache = GITS_BASER_nC;
-				__flush_dcache_area(base, alloc_size);
+				__flush_dcache_area(base, PAGE_ORDER_TO_SIZE(order));
 			}
 			goto retry_baser;
 		}
@@ -975,7 +976,7 @@ retry_baser:
 		}
 
 		pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)\n",
-			(int)(alloc_size / entry_size),
+			(int)(PAGE_ORDER_TO_SIZE(order) / entry_size),
 			its_base_type_string[type],
 			(unsigned long)virt_to_phys(base),
 			psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);


