Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14181C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC9521581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC9521581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeHONTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:19:33 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:50792 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeHONTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:19:33 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 8A0E5CD5D;
        Wed, 15 Aug 2018 13:27:55 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v3] media: camss: add missing includes
Date:   Wed, 15 Aug 2018 13:27:28 +0300
Message-Id: <1534328848-12914-1-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Multiple files in this driver fail to build because of missing
header inclusions:

drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c: In function 'csiphy_hw_version_read':
drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c:31:18: error: implicit declaration of function 'readl_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-declaration]
drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c: In function 'csiphy_hw_version_read':
drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:52:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]

Add linux/io.h there and in all other files that call
readl/writel and related interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
v3: Remove include linux/slab.h because kcalloc is replaced with
devm_kcalloc by another patch and that include is not needed
anymore.
---
 drivers/media/platform/qcom/camss/camss-csid.c           | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy.c         | 1 +
 drivers/media/platform/qcom/camss/camss-ispif.c          | 1 +
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c        | 1 +
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c        | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 729b318..a5ae856 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
index c832539..12bce39 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
 #define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
 #define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index bcd0dfd..2e65caf 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
 #define CSIPHY_3PH_LNn_CFG1(n)			(0x000 + 0x100 * (n))
 #define CSIPHY_3PH_LNn_CFG1_SWI_REC_DLY_PRG	(BIT(7) | BIT(6))
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 4559f3b..008afb8 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index ca7b091..1f33b4e 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index da3a9fe..174a36b 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 
 #include "camss-vfe.h"
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 4c584bf..0dca8bf 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 
 #include "camss-vfe.h"
-- 
2.7.4

