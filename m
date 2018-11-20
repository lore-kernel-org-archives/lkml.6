Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99766C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4520870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE4520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeKUBXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:39166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727466AbeKUBXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA94AAD12;
        Tue, 20 Nov 2018 14:54:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 03/16] staging: vchiq_shim: delete vchi_service_create
Date:   Tue, 20 Nov 2018 15:53:38 +0100
Message-Id: <20181120145351.30390-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one is using the API neither in the actual staging tree nor in the
downstream tree (https://github.com/raspberrypi/linux).

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       |  5 ---
 .../interface/vchiq_arm/vchiq_shim.c          | 32 -------------------
 2 files changed, 37 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 01381904775d..379a16ebfd5b 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -113,11 +113,6 @@ extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
 /******************************************************************************
  Global service API
  *****************************************************************************/
-// Routine to create a named service
-extern int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
-				   SERVICE_CREATION_T *setup,
-				   VCHI_SERVICE_HANDLE_T *handle);
-
 // Routine to destroy a service
 extern int32_t vchi_service_destroy(const VCHI_SERVICE_HANDLE_T handle);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index c3223fcdaf87..81cac68f4b78 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -660,38 +660,6 @@ int32_t vchi_service_open(VCHI_INSTANCE_T instance_handle,
 }
 EXPORT_SYMBOL(vchi_service_open);
 
-int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
-	SERVICE_CREATION_T *setup,
-	VCHI_SERVICE_HANDLE_T *handle)
-{
-	VCHIQ_INSTANCE_T instance = (VCHIQ_INSTANCE_T)instance_handle;
-	struct shim_service *service = service_alloc(instance, setup);
-
-	*handle = (VCHI_SERVICE_HANDLE_T)service;
-
-	if (service) {
-		VCHIQ_SERVICE_PARAMS_T params;
-		VCHIQ_STATUS_T status;
-
-		memset(&params, 0, sizeof(params));
-		params.fourcc = setup->service_id;
-		params.callback = shim_callback;
-		params.userdata = service;
-		params.version = setup->version.version;
-		params.version_min = setup->version.version_min;
-		status = vchiq_add_service(instance, &params, &service->handle);
-
-		if (status != VCHIQ_SUCCESS) {
-			service_free(service);
-			service = NULL;
-			*handle = NULL;
-		}
-	}
-
-	return (service != NULL) ? 0 : -1;
-}
-EXPORT_SYMBOL(vchi_service_create);
-
 int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle)
 {
 	int32_t ret = -1;
-- 
2.19.1

