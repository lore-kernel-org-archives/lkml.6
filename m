Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeCPJLW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:11:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeCPJLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:11:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52AA860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH] phy: core: Allow phy_pm_runtime_xxx API calls with NULL phy
Date: Fri, 16 Mar 2018 14:40:51 +0530
Message-Id: <1521191452-30089-1-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_init() and phy_exit() calls, and phy_power_on() and
phy_power_off() already accept NULL as valid PHY refernece
and act as NOP. Extend same concept to phy runtime_pm APIs
to keep drivers (e.g. dwc3) code simple while dealing with
optional PHYs.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/phy-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 09ac8af..48b9615 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -153,6 +153,9 @@ int phy_pm_runtime_get(struct phy *phy)
 {
 	int ret;
 
+	if (!phy)
+		return 0;
+
 	if (!pm_runtime_enabled(&phy->dev))
 		return -ENOTSUPP;
 
@@ -168,6 +171,9 @@ int phy_pm_runtime_get_sync(struct phy *phy)
 {
 	int ret;
 
+	if (!phy)
+		return 0;
+
 	if (!pm_runtime_enabled(&phy->dev))
 		return -ENOTSUPP;
 
@@ -181,6 +187,9 @@ int phy_pm_runtime_get_sync(struct phy *phy)
 
 int phy_pm_runtime_put(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	if (!pm_runtime_enabled(&phy->dev))
 		return -ENOTSUPP;
 
@@ -190,6 +199,9 @@ int phy_pm_runtime_put(struct phy *phy)
 
 int phy_pm_runtime_put_sync(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	if (!pm_runtime_enabled(&phy->dev))
 		return -ENOTSUPP;
 
@@ -199,6 +211,9 @@ int phy_pm_runtime_put_sync(struct phy *phy)
 
 void phy_pm_runtime_allow(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	if (!pm_runtime_enabled(&phy->dev))
 		return;
 
@@ -208,6 +223,9 @@ void phy_pm_runtime_allow(struct phy *phy)
 
 void phy_pm_runtime_forbid(struct phy *phy)
 {
+	if (!phy)
+		return 0;
+
 	if (!pm_runtime_enabled(&phy->dev))
 		return;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
