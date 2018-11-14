Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C060C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7E2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB7E2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbeKNXD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:03:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:44508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeKNXD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:03:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EE71B087;
        Wed, 14 Nov 2018 13:00:16 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 02/16] staging: vchiq_arm: rework close/remove_service IOCTLS
Date:   Wed, 14 Nov 2018 13:59:28 +0100
Message-Id: <20181114125942.25163-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of both IOCTLS was the same except for one function
call. This joins both implementations and updates the code to avoid
unneeded indentations.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 66 +++++++------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6d503392341e..d88dd7415e1e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1019,55 +1019,37 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	} break;
 
-	case VCHIQ_IOC_CLOSE_SERVICE: {
+	case VCHIQ_IOC_CLOSE_SERVICE:
+	case VCHIQ_IOC_REMOVE_SERVICE: {
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+		USER_SERVICE_T *user_service;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			/* close_pending is false on first entry, and when the
-			   wait in vchiq_close_service has been interrupted. */
-			if (!user_service->close_pending) {
-				status = vchiq_close_service(service->handle);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
-
-			/* close_pending is true once the underlying service
-			   has been closed until the client library calls the
-			   CLOSE_DELIVERED ioctl, signalling close_event. */
-			if (user_service->close_pending &&
-				down_interruptible(&user_service->close_event))
-				status = VCHIQ_RETRY;
-		} else
+		if (!service) {
 			ret = -EINVAL;
-	} break;
+			break;
+		}
 
-	case VCHIQ_IOC_REMOVE_SERVICE: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+		user_service = service->base.userdata;
 
-		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			/* close_pending is false on first entry, and when the
-			   wait in vchiq_close_service has been interrupted. */
-			if (!user_service->close_pending) {
-				status = vchiq_remove_service(service->handle);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
+		/* close_pending is false on first entry, and when the
+		   wait in vchiq_close_service has been interrupted. */
+		if (!user_service->close_pending) {
+			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
+				 vchiq_close_service(service->handle) :
+				 vchiq_remove_service(service->handle);
+			if (status != VCHIQ_SUCCESS)
+				break;
+		}
 
-			/* close_pending is true once the underlying service
-			   has been closed until the client library calls the
-			   CLOSE_DELIVERED ioctl, signalling close_event. */
-			if (user_service->close_pending &&
-				down_interruptible(&user_service->close_event))
-				status = VCHIQ_RETRY;
-		} else
-			ret = -EINVAL;
-	} break;
+		/* close_pending is true once the underlying service
+		   has been closed until the client library calls the
+		   CLOSE_DELIVERED ioctl, signalling close_event. */
+		if (user_service->close_pending &&
+			down_interruptible(&user_service->close_event))
+			status = VCHIQ_RETRY;
+		break;
+	}
 
 	case VCHIQ_IOC_USE_SERVICE:
 	case VCHIQ_IOC_RELEASE_SERVICE:	{
-- 
2.19.1

