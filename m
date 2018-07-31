Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB230C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E289208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E289208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeGaNnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:43:10 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25891 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731272AbeGaNnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:43:10 -0400
Received: from localhost.localdomain.localdomain (115.231.19.16 [115.231.19.16]) by mx.zoho.com.cn
        with SMTPS id 1533038570784572.6676115279031; Tue, 31 Jul 2018 20:02:50 +0800 (CST)
From:   oceanhe@zoho.com.cn
To:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH] libnvdimm, bus: check if type of nd_device_driver within valid scope
Date:   Tue, 31 Jul 2018 08:02:32 -0400
Message-Id: <1533038552-6195-1-git-send-email-oceanhe@zoho.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

According to enum nd_driver_flags, the valid type of nd_device_driver
start from 0x02 and end up with 0x80. Both 0x00 and 0x01 are invalid, and
the value larger than 0x80 is invalid.

To filter valid type, ND_DRIVER_FLAGS_MASK is defined as
(((ND_DRIVER_FLAGS_MAX) << 1) - 2). For example, when ND_DRIVER_FLAGS_MAX
equals to ND_DRIVER_DAX_PMEM(0x80), then ND_DRIVER_FLAGS_MASK equals
to 0xFE.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/nvdimm/bus.c       | 2 +-
 include/uapi/linux/ndctl.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 27902a8..ec8cf4b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -546,7 +546,7 @@ int __nd_driver_register(struct nd_device_driver *nd_drv, struct module *owner,
 {
 	struct device_driver *drv = &nd_drv->drv;
 
-	if (!nd_drv->type) {
+	if (!(nd_drv->type & ND_DRIVER_FLAGS_MASK)) {
 		pr_debug("driver type bitmask not set (%pf)\n",
 				__builtin_return_address(0));
 		return -EINVAL;
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 7e27070..2a1ce06 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -207,6 +207,8 @@ enum nd_driver_flags {
 	ND_DRIVER_NAMESPACE_BLK   = 1 << ND_DEVICE_NAMESPACE_BLK,
 	ND_DRIVER_DAX_PMEM	  = 1 << ND_DEVICE_DAX_PMEM,
 };
+#define ND_DRIVER_FLAGS_MAX	ND_DRIVER_DAX_PMEM
+#define ND_DRIVER_FLAGS_MASK	(((ND_DRIVER_FLAGS_MAX) << 1) - 2)
 
 enum {
 	ND_MIN_NAMESPACE_SIZE = PAGE_SIZE,
-- 
1.8.3.1


