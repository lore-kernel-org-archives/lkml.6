Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875462064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875462064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeI0B3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:29:47 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:2656 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727760AbeI0B3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:46 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:01 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 20388B0E7B;
        Wed, 26 Sep 2018 15:15:10 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 18/20] vmw_balloon: support 64-bit memory limit
Date:   Wed, 26 Sep 2018 12:13:34 -0700
Message-ID: <20180926191336.101885-19-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xavier Deguillard <xdeguillard@vmware.com>

Currently, the balloon driver would fail to run if memory is greater
than 16TB of vRAM. Previous patches have already converted the balloon
target and size to 64-bit, so all that is left to do add is to avoid
asserting memory is smaller than 16TB if the hypervisor supports 64-bits
target.

The driver advertises a new capability VMW_BALLOON_64_BITS_TARGET.
Hypervisors that support 16TB of memory or more will report that this
capability is enabled.

Signed-off-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index d3921a1334ec..4c9c171325c3 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -61,15 +61,26 @@ enum vmwballoon_capabilities {
 	VMW_BALLOON_BATCHED_CMDS		= (1 << 2),
 	VMW_BALLOON_BATCHED_2M_CMDS		= (1 << 3),
 	VMW_BALLOON_SIGNALLED_WAKEUP_CMD	= (1 << 4),
+	VMW_BALLOON_64_BIT_TARGET		= (1 << 5)
 };
 
-#define VMW_BALLOON_CAPABILITIES	(VMW_BALLOON_BASIC_CMDS \
+#define VMW_BALLOON_CAPABILITIES_COMMON	(VMW_BALLOON_BASIC_CMDS \
 					| VMW_BALLOON_BATCHED_CMDS \
 					| VMW_BALLOON_BATCHED_2M_CMDS \
 					| VMW_BALLOON_SIGNALLED_WAKEUP_CMD)
 
 #define VMW_BALLOON_2M_ORDER		(PMD_SHIFT - PAGE_SHIFT)
 
+/*
+ * 64-bit targets are only supported in 64-bit
+ */
+#ifdef CONFIG_64BIT
+#define VMW_BALLOON_CAPABILITIES	(VMW_BALLOON_CAPABILITIES_COMMON \
+					| VMW_BALLOON_64_BIT_TARGET)
+#else
+#define VMW_BALLOON_CAPABILITIES	VMW_BALLOON_CAPABILITIES_COMMON
+#endif
+
 enum vmballoon_page_size_type {
 	VMW_BALLOON_4K_PAGE,
 	VMW_BALLOON_2M_PAGE,
@@ -565,8 +576,9 @@ static int vmballoon_send_get_target(struct vmballoon *b)
 
 	limit = totalram_pages;
 
-	/* Ensure limit fits in 32-bits */
-	if (limit != (u32)limit)
+	/* Ensure limit fits in 32-bits if 64-bit targets are not supported */
+	if (!(b->capabilities & VMW_BALLOON_64_BIT_TARGET) &&
+	    limit != (u32)limit)
 		return -EINVAL;
 
 	status = vmballoon_cmd(b, VMW_BALLOON_CMD_GET_TARGET, limit, 0);
-- 
2.17.1

