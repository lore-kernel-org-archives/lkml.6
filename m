Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53115C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E32208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E32208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeKUBXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729286AbeKUBXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0ADF4ADCE;
        Tue, 20 Nov 2018 14:54:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 05/16] staging: vchiq_arm: get rid of vchi_mh.h
Date:   Tue, 20 Nov 2018 15:53:40 +0100
Message-Id: <20181120145351.30390-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concept of VCHI_MEM_HANDLE_T is introduced by this header file and
was meant to be used with bulk transfers. After a quick look in
vchiq_core.c it is pretty clear that it actually accomplishes nothing
nor alters the bulk transfers in any way.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       |  3 --
 .../vc04_services/interface/vchi/vchi_mh.h    | 42 -------------------
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  6 +--
 .../interface/vchiq_arm/vchiq_arm.c           | 27 ++++++------
 .../interface/vchiq_arm/vchiq_core.c          | 17 ++++----
 .../interface/vchiq_arm/vchiq_core.h          | 10 ++---
 .../interface/vchiq_arm/vchiq_if.h            |  8 ++--
 7 files changed, 27 insertions(+), 86 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_mh.h

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 379a16ebfd5b..e326926eac31 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -36,7 +36,6 @@
 
 #include "interface/vchi/vchi_cfg.h"
 #include "interface/vchi/vchi_common.h"
-#include "vchi_mh.h"
 
 /******************************************************************************
  Global defs
@@ -239,7 +238,6 @@ extern int32_t vchi_bulk_queue_receive(VCHI_SERVICE_HANDLE_T handle,
 
 // Prepare interface for a transfer from the other side into relocatable memory.
 int32_t vchi_bulk_queue_receive_reloc(const VCHI_SERVICE_HANDLE_T handle,
-				      VCHI_MEM_HANDLE_T h_dst,
 				      uint32_t offset,
 				      uint32_t data_size,
 				      const VCHI_FLAGS_T flags,
@@ -261,7 +259,6 @@ extern int32_t vchi_bulk_queue_transmit(VCHI_SERVICE_HANDLE_T handle,
 #endif
 
 extern int32_t vchi_bulk_queue_transmit_reloc(VCHI_SERVICE_HANDLE_T handle,
-					      VCHI_MEM_HANDLE_T h_src,
 					      uint32_t offset,
 					      uint32_t data_size,
 					      VCHI_FLAGS_T flags,
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
deleted file mode 100644
index 198bd076b666..000000000000
--- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef VCHI_MH_H_
-#define VCHI_MH_H_
-
-#include <linux/types.h>
-
-typedef int32_t VCHI_MEM_HANDLE_T;
-#define VCHI_MEM_HANDLE_INVALID 0
-
-#endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 83d740feab96..014583cdf367 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -247,13 +247,10 @@ remote_event_signal(REMOTE_EVENT_T *event)
 }
 
 VCHIQ_STATUS_T
-vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, VCHI_MEM_HANDLE_T memhandle,
-	void *offset, int size, int dir)
+vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, void *offset, int size, int dir)
 {
 	struct vchiq_pagelist_info *pagelistinfo;
 
-	WARN_ON(memhandle != VCHI_MEM_HANDLE_INVALID);
-
 	pagelistinfo = create_pagelist((char __user *)offset, size,
 				       (dir == VCHIQ_BULK_RECEIVE)
 				       ? PAGELIST_READ
@@ -262,7 +259,6 @@ vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, VCHI_MEM_HANDLE_T memhandle,
 	if (!pagelistinfo)
 		return VCHIQ_ERROR;
 
-	bulk->handle = memhandle;
 	bulk->data = (void *)(unsigned long)pagelistinfo->dma_addr;
 
 	/*
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 76de36e9e3b6..525458551a22 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -419,9 +419,9 @@ vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
 	switch (mode) {
 	case VCHIQ_BULK_MODE_NOCALLBACK:
 	case VCHIQ_BULK_MODE_CALLBACK:
-		status = vchiq_bulk_transfer(handle,
-			VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
-			mode, VCHIQ_BULK_TRANSMIT);
+		status = vchiq_bulk_transfer(handle, (void *)data, size,
+					     userdata, mode,
+					     VCHIQ_BULK_TRANSMIT);
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
 		status = vchiq_blocking_bulk_transfer(handle,
@@ -444,9 +444,8 @@ vchiq_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	switch (mode) {
 	case VCHIQ_BULK_MODE_NOCALLBACK:
 	case VCHIQ_BULK_MODE_CALLBACK:
-		status = vchiq_bulk_transfer(handle,
-			VCHI_MEM_HANDLE_INVALID, data, size, userdata,
-			mode, VCHIQ_BULK_RECEIVE);
+		status = vchiq_bulk_transfer(handle, data, size, userdata,
+					     mode, VCHIQ_BULK_RECEIVE);
 		break;
 	case VCHIQ_BULK_MODE_BLOCKING:
 		status = vchiq_blocking_bulk_transfer(handle,
@@ -513,9 +512,8 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 		}
 	}
 
-	status = vchiq_bulk_transfer(handle, VCHI_MEM_HANDLE_INVALID,
-		data, size, &waiter->bulk_waiter, VCHIQ_BULK_MODE_BLOCKING,
-		dir);
+	status = vchiq_bulk_transfer(handle, data, size, &waiter->bulk_waiter,
+				     VCHIQ_BULK_MODE_BLOCKING, dir);
 	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
 		!waiter->bulk_waiter.bulk) {
 		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
@@ -1149,14 +1147,13 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				current->pid);
 			args.userdata = &waiter->bulk_waiter;
 		}
-		status = vchiq_bulk_transfer
-			(args.handle,
-			 VCHI_MEM_HANDLE_INVALID,
-			 args.data, args.size,
-			 args.userdata, args.mode,
-			 dir);
+
+		status = vchiq_bulk_transfer(args.handle, args.data, args.size,
+					     args.userdata, args.mode, dir);
+
 		if (!waiter)
 			break;
+
 		if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
 			!waiter->bulk_waiter.bulk) {
 			if (waiter->bulk_waiter.bulk) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 89f1ccdc3b98..8c7bda2e7cb6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3313,10 +3313,10 @@ vchiq_remove_service(VCHIQ_SERVICE_HANDLE_T handle)
  * When called in blocking mode, the userdata field points to a bulk_waiter
  * structure.
  */
-VCHIQ_STATUS_T
-vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
-	VCHI_MEM_HANDLE_T memhandle, void *offset, int size, void *userdata,
-	VCHIQ_BULK_MODE_T mode, VCHIQ_BULK_DIR_T dir)
+VCHIQ_STATUS_T vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
+				   void *offset, int size, void *userdata,
+				   VCHIQ_BULK_MODE_T mode,
+				   VCHIQ_BULK_DIR_T dir)
 {
 	VCHIQ_SERVICE_T *service = find_service_by_handle(handle);
 	VCHIQ_BULK_QUEUE_T *queue;
@@ -3328,10 +3328,8 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 		VCHIQ_MSG_BULK_TX : VCHIQ_MSG_BULK_RX;
 	VCHIQ_STATUS_T status = VCHIQ_ERROR;
 
-	if (!service ||
-		 (service->srvstate != VCHIQ_SRVSTATE_OPEN) ||
-		 ((memhandle == VCHI_MEM_HANDLE_INVALID) && (offset == NULL)) ||
-		 (vchiq_check_service(service) != VCHIQ_SUCCESS))
+	if (!service || service->srvstate != VCHIQ_SRVSTATE_OPEN ||
+	    !offset || vchiq_check_service(service) != VCHIQ_SUCCESS)
 		goto error_exit;
 
 	switch (mode) {
@@ -3388,8 +3386,7 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 	bulk->size = size;
 	bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
 
-	if (vchiq_prepare_bulk_data(bulk, memhandle, offset, size, dir) !=
-		VCHIQ_SUCCESS)
+	if (vchiq_prepare_bulk_data(bulk, offset, size, dir) != VCHIQ_SUCCESS)
 		goto unlock_error_exit;
 
 	wmb();
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 10deb5745dda..daada568f400 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -242,7 +242,6 @@ typedef struct vchiq_bulk_struct {
 	short mode;
 	short dir;
 	void *userdata;
-	VCHI_MEM_HANDLE_T handle;
 	void *data;
 	int size;
 	void *remote_data;
@@ -566,9 +565,9 @@ extern void
 remote_event_pollall(VCHIQ_STATE_T *state);
 
 extern VCHIQ_STATUS_T
-vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
-	VCHI_MEM_HANDLE_T memhandle, void *offset, int size, void *userdata,
-	VCHIQ_BULK_MODE_T mode, VCHIQ_BULK_DIR_T dir);
+vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *offset, int size,
+		    void *userdata, VCHIQ_BULK_MODE_T mode,
+		    VCHIQ_BULK_DIR_T dir);
 
 extern void
 vchiq_dump_state(void *dump_context, VCHIQ_STATE_T *state);
@@ -624,8 +623,7 @@ unlock_service(VCHIQ_SERVICE_T *service);
 ** implementations must be provided. */
 
 extern VCHIQ_STATUS_T
-vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk,
-	VCHI_MEM_HANDLE_T memhandle, void *offset, int size, int dir);
+vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, void *offset, int size, int dir);
 
 extern void
 vchiq_transfer_bulk(VCHIQ_BULK_T *bulk);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 87829a244465..7b948a173e29 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -34,8 +34,6 @@
 #ifndef VCHIQ_IF_H
 #define VCHIQ_IF_H
 
-#include "interface/vchi/vchi_mh.h"
-
 #define VCHIQ_SERVICE_HANDLE_INVALID 0
 
 #define VCHIQ_SLOT_SIZE     4096
@@ -156,11 +154,11 @@ extern VCHIQ_STATUS_T vchiq_bulk_receive(VCHIQ_SERVICE_HANDLE_T service,
 	void *data, unsigned int size, void *userdata,
 	VCHIQ_BULK_MODE_T mode);
 extern VCHIQ_STATUS_T vchiq_bulk_transmit_handle(VCHIQ_SERVICE_HANDLE_T service,
-	VCHI_MEM_HANDLE_T handle, const void *offset, unsigned int size,
+	const void *offset, unsigned int size,
 	void *userdata,	VCHIQ_BULK_MODE_T mode);
 extern VCHIQ_STATUS_T vchiq_bulk_receive_handle(VCHIQ_SERVICE_HANDLE_T service,
-	VCHI_MEM_HANDLE_T handle, void *offset, unsigned int size,
-	void *userdata, VCHIQ_BULK_MODE_T mode);
+	void *offset, unsigned int size, void *userdata,
+	VCHIQ_BULK_MODE_T mode);
 extern int   vchiq_get_client_id(VCHIQ_SERVICE_HANDLE_T service);
 extern void *vchiq_get_service_userdata(VCHIQ_SERVICE_HANDLE_T service);
 extern int   vchiq_get_service_fourcc(VCHIQ_SERVICE_HANDLE_T service);
-- 
2.19.1

