Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4C3C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DDD20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DDD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeIMSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeIMSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FF96D18;
        Thu, 13 Sep 2018 13:33:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 4.4 44/60] irqchip/gic-v3-its: Recompute the number of pages on page size change
Date:   Thu, 13 Sep 2018 15:30:51 +0200
Message-Id: <20180913131747.512837981@linuxfoundation.org>
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 18aa60ce2751c95d3412ed06a58b8b6cfb6f88f2 upstream.

When the programming of a GITS_BASERn register fails because of
an unsupported ITS page size, we retry it with a smaller page size.
Unfortunately, we don't recompute the number of allocated ITS pages,
indicating the wrong value computed in the original allocation.

A convenient fix is to free the pages we allocated, update the
page size, and restart the allocation. This will ensure that
we always allocate the right amount in the case of a device
table, specially if we have to reduce the allocation order
to stay within the boundaries of the ITS maximum allocation.

Reported-and-tested-by: Ma Jun <majun258@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>
Link: http://lkml.kernel.org/r/1453818255-1289-1-git-send-email-marc.zyngier@arm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -884,6 +884,7 @@ static int its_alloc_tables(const char *
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
+retry_alloc_baser:
 		alloc_pages = (alloc_size / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
@@ -947,13 +948,16 @@ retry_baser:
 			 * size and retry. If we reach 4K, then
 			 * something is horribly wrong...
 			 */
+			free_pages((unsigned long)base, order);
+			its->tables[i] = NULL;
+
 			switch (psz) {
 			case SZ_16K:
 				psz = SZ_4K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			case SZ_64K:
 				psz = SZ_16K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			}
 		}
 


