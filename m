Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E84C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B494620881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B494620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeJPWzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbeJPWyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8D33B080;
        Tue, 16 Oct 2018 15:04:00 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, tiwai@suse.de,
        nsaenzjulienne@suse.de
Subject: [PATCH 8/9] staging: vchiq_arm: add function to check if probe was successful
Date:   Tue, 16 Oct 2018 17:02:27 +0200
Message-Id: <20181016150228.16994-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016150228.16994-1-nsaenzjulienne@suse.de>
References: <20181016150228.16994-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices depending on VCHIQ need to double check it's initialization
process was successful. This patch adds a helper function to do so.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchi/vchi.h  |  3 +++
 .../interface/vchiq_arm/vchiq_2835_arm.c         |  2 ++
 .../interface/vchiq_arm/vchiq_arm.c              | 16 ++++++++++++++++
 .../interface/vchiq_arm/vchiq_arm.h              |  1 +
 .../vc04_services/interface/vchiq_arm/vchiq_if.h |  4 ++++
 .../interface/vchiq_arm/vchiq_shim.c             |  7 +++++++
 6 files changed, 33 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 01381904775d..acf01352135f 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -113,6 +113,9 @@ extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
 /******************************************************************************
  Global service API
  *****************************************************************************/
+// Routine to check if vchi is ready
+extern bool vchi_ready(struct device_node *firmware_node);
+
 // Routine to create a named service
 extern int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
 				   SERVICE_CREATION_T *setup,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 83d740feab96..31dd8a303a20 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -194,6 +194,8 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	}
 
 	g_dev = dev;
+	drvdata->ready = 1;
+
 	vchiq_log_info(vchiq_arm_log_level,
 		"vchiq_init - done (slots %pK, phys %pad)",
 		vchiq_slot_zero, &slot_phys);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index ea789376de0f..2690e751d1a5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -3682,6 +3682,22 @@ static int vchiq_remove(struct platform_device *pdev)
 	return 0;
 }
 
+bool vchiq_ready(struct device_node *firmware_node)
+{
+	struct platform_device *pdev = of_find_device_by_node(firmware_node);
+	struct vchiq_drvdata *drvdata;
+
+	if (!pdev)
+		return false;
+
+	drvdata = platform_get_drvdata(pdev);
+	if (!drvdata)
+		return false;
+
+	return drvdata->ready;
+}
+EXPORT_SYMBOL_GPL(vchiq_ready);
+
 static struct platform_driver vchiq_driver = {
 	.driver = {
 		.name = "bcm2835_vchiq",
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2f3ebc99cbcf..8215904d219b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -126,6 +126,7 @@ typedef struct vchiq_arm_state_struct {
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
 	struct rpi_firmware *fw;
+	unsigned int ready:1;
 };
 
 extern int vchiq_arm_log_level;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index e4109a83e628..54ba822f38ff 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -34,6 +34,8 @@
 #ifndef VCHIQ_IF_H
 #define VCHIQ_IF_H
 
+#include <linux/of.h>
+
 #include "interface/vchi/vchi_mh.h"
 
 #define VCHIQ_SERVICE_HANDLE_INVALID 0
@@ -179,4 +181,6 @@ extern VCHIQ_STATUS_T vchiq_dump_phys_mem(VCHIQ_SERVICE_HANDLE_T service,
 extern VCHIQ_STATUS_T vchiq_get_peer_version(VCHIQ_SERVICE_HANDLE_T handle,
       short *peer_version);
 
+extern bool vchiq_ready(struct device_node *firmware_node);
+
 #endif /* VCHIQ_IF_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index c3223fcdaf87..69fdface29fd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -32,6 +32,7 @@
  */
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 #include "interface/vchi/vchi.h"
 #include "vchiq.h"
@@ -50,6 +51,12 @@ struct shim_service {
 	void *callback_param;
 };
 
+bool vchi_ready(struct device_node *firmware_node)
+{
+	return vchiq_ready(firmware_node);
+}
+EXPORT_SYMBOL(vchi_ready);
+
 /***********************************************************
  * Name: vchi_msg_peek
  *
-- 
2.19.1

