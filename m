Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2B9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A5820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbvujUBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A5820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeGYT2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbeGYT2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:28:08 -0400
Received: from localhost.localdomain (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2C520844;
        Wed, 25 Jul 2018 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532542518;
        bh=uRauyaYBWk+7MwhDWR51ysz7M4nAzSvFGseMv2gE3ho=;
        h=From:To:Cc:Subject:Date:From;
        b=TbvujUBLNtkGCJxfMFYXXZ9xXSvwyPfVilXXY2EDJVH9mZvtgMFkoLqr9PHB9miMP
         ZAuNXJ+CqviSwWpuNz+dO/n1fvGt/gGMWs2jB6XggdYmxaIGiuWmf3MLy6KfkfyuNM
         9BKCK3cetI8jkyZYQ4RLUaDk+rfKC54egk/YN3JM=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alan Tull <atull@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Federico Vaga <federico.vaga@cern.ch>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 1/2] fpga: Document when fpga_blah_free functions should be used
Date:   Wed, 25 Jul 2018 13:15:13 -0500
Message-Id: <20180725181514.3501-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify when fpga_(mgr|bridge|region)_free functions should be used.
The class's dev_release will handle cleanup when the device is released
so once the mgr/brige/region has been successfully registered, it
would be a bug to call fpga_(mgr|bridge|region)_free.

Signed-off-by: Alan Tull <atull@kernel.org>
Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Suggested-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/fpga/fpga-bridge.c | 10 +++++++++-
 drivers/fpga/fpga-mgr.c    | 10 +++++++++-
 drivers/fpga/fpga-region.c | 10 +++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 24b8f98..528d2149 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -379,7 +379,11 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
 
 /**
  * fpga_bridge_free - free a fpga bridge and its id
- * @bridge:	FPGA bridge struct created by fpga_bridge_create
+ * @bridge:	FPGA bridge struct created by fpga_bridge_create()
+ *
+ * Free a FPGA bridge.  This function should only be called for
+ * freeing a bridge that has not been registered yet (such as in error
+ * paths in a probe function).
  */
 void fpga_bridge_free(struct fpga_bridge *bridge)
 {
@@ -414,6 +418,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_register);
 /**
  * fpga_bridge_unregister - unregister and free a fpga bridge
  * @bridge:	FPGA bridge struct created by fpga_bridge_create
+ *
+ * Unregister the bridge device.  The class's dev_release will handle
+ * freeing the bridge struct when the device is released so don't
+ * call fpga_bridge_free() after calling fpga_bridge_unregister().
  */
 void fpga_bridge_unregister(struct fpga_bridge *bridge)
 {
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a41b07e..9632cbd 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -619,7 +619,11 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
 
 /**
  * fpga_mgr_free - deallocate a FPGA manager
- * @mgr:	fpga manager struct created by fpga_mgr_create
+ * @mgr:	fpga manager struct created by fpga_mgr_create()
+ *
+ * Free a FPGA manager struct.  This function should only be called
+ * for freeing a manager that has not been registered yet (such as in
+ * error paths in a probe function).
  */
 void fpga_mgr_free(struct fpga_manager *mgr)
 {
@@ -663,6 +667,10 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
 /**
  * fpga_mgr_unregister - unregister and free a FPGA manager
  * @mgr:	fpga manager struct
+ *
+ * Unregister the manager device.  The class's dev_release will handle
+ * freeing the manager struct when the device is released so don't
+ * call fpga_mgr_free() after calling fpga_mgr_unregister().
  */
 void fpga_mgr_unregister(struct fpga_manager *mgr)
 {
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 0d65220..7335fa9 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -231,7 +231,11 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
 
 /**
  * fpga_region_free - free a struct fpga_region
- * @region: FPGA region created by fpga_region_create
+ * @region:  FPGA region created by fpga_region_create()
+ *
+ * Free a FPGA region struct.  This function should only be called for
+ * freeing a region that has not been registered yet (such as in error
+ * paths in a probe function).
  */
 void fpga_region_free(struct fpga_region *region)
 {
@@ -255,6 +259,10 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
 /**
  * fpga_region_unregister - unregister and free a FPGA region
  * @region: FPGA region
+ *
+ * Unregister the region device.  The class's dev_release will handle
+ * freeing the region so don't call fpga_region_free() after calling
+ * fpga_region_unregister().
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-- 
2.7.4

