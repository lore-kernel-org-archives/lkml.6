Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59251C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4BA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4BA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeKUBXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:39178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727634AbeKUBXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABE9EAC4B;
        Tue, 20 Nov 2018 14:54:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 01/16] staging: vchiq_core: rework vchiq_get_config
Date:   Tue, 20 Nov 2018 15:53:36 +0100
Message-Id: <20181120145351.30390-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is overly complicated for what it's ultimately achieving.
It's simply filling up a structure.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 12 ++++----
 .../interface/vchiq_arm/vchiq_core.c          | 30 +++++--------------
 .../interface/vchiq_arm/vchiq_if.h            |  3 +-
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 45de21c210c1..5af3f2651bd3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1480,13 +1480,11 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			ret = -EINVAL;
 			break;
 		}
-		status = vchiq_get_config(instance, args.config_size, &config);
-		if (status == VCHIQ_SUCCESS) {
-			if (copy_to_user((void __user *)args.pconfig,
-				    &config, args.config_size) != 0) {
-				ret = -EFAULT;
-				break;
-			}
+
+		vchiq_get_config(&config);
+		if (copy_to_user(args.pconfig, &config, args.config_size)) {
+			ret = -EFAULT;
+			break;
 		}
 	} break;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7642ced31436..89f1ccdc3b98 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3583,28 +3583,14 @@ vchiq_get_peer_version(VCHIQ_SERVICE_HANDLE_T handle, short *peer_version)
 	return status;
 }
 
-VCHIQ_STATUS_T
-vchiq_get_config(VCHIQ_INSTANCE_T instance,
-	int config_size, VCHIQ_CONFIG_T *pconfig)
-{
-	VCHIQ_CONFIG_T config;
-
-	(void)instance;
-
-	config.max_msg_size           = VCHIQ_MAX_MSG_SIZE;
-	config.bulk_threshold         = VCHIQ_MAX_MSG_SIZE;
-	config.max_outstanding_bulks  = VCHIQ_NUM_SERVICE_BULKS;
-	config.max_services           = VCHIQ_MAX_SERVICES;
-	config.version                = VCHIQ_VERSION;
-	config.version_min            = VCHIQ_VERSION_MIN;
-
-	if (config_size > sizeof(VCHIQ_CONFIG_T))
-		return VCHIQ_ERROR;
-
-	memcpy(pconfig, &config,
-		min(config_size, (int)(sizeof(VCHIQ_CONFIG_T))));
-
-	return VCHIQ_SUCCESS;
+void vchiq_get_config(VCHIQ_CONFIG_T *config)
+{
+	config->max_msg_size           = VCHIQ_MAX_MSG_SIZE;
+	config->bulk_threshold         = VCHIQ_MAX_MSG_SIZE;
+	config->max_outstanding_bulks  = VCHIQ_NUM_SERVICE_BULKS;
+	config->max_services           = VCHIQ_MAX_SERVICES;
+	config->version                = VCHIQ_VERSION;
+	config->version_min            = VCHIQ_VERSION_MIN;
 }
 
 VCHIQ_STATUS_T
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index e4109a83e628..87829a244465 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -164,8 +164,7 @@ extern VCHIQ_STATUS_T vchiq_bulk_receive_handle(VCHIQ_SERVICE_HANDLE_T service,
 extern int   vchiq_get_client_id(VCHIQ_SERVICE_HANDLE_T service);
 extern void *vchiq_get_service_userdata(VCHIQ_SERVICE_HANDLE_T service);
 extern int   vchiq_get_service_fourcc(VCHIQ_SERVICE_HANDLE_T service);
-extern VCHIQ_STATUS_T vchiq_get_config(VCHIQ_INSTANCE_T instance,
-	int config_size, VCHIQ_CONFIG_T *pconfig);
+extern void vchiq_get_config(VCHIQ_CONFIG_T *config);
 extern VCHIQ_STATUS_T vchiq_set_service_option(VCHIQ_SERVICE_HANDLE_T service,
 	VCHIQ_SERVICE_OPTION_T option, int value);
 
-- 
2.19.1

