Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE0C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75ED206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75ED206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeKUBXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727969AbeKUBXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D435AD33;
        Tue, 20 Nov 2018 14:54:07 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 04/16] staging: vchiq_arm: use list_for_each_entry when accessing bulk_waiter_list
Date:   Tue, 20 Nov 2018 15:53:39 +0100
Message-Id: <20181120145351.30390-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resulting code is way more readeable and intuitive compared to plain
list_for_each.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 52 ++++++-------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 835152799433..76de36e9e3b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -280,16 +280,11 @@ VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 		"%s(%p): returning %d", __func__, instance, status);
 
 	if (status == VCHIQ_SUCCESS) {
-		struct list_head *pos, *next;
+		struct bulk_waiter_node *waiter, *next;
 
-		list_for_each_safe(pos, next,
-				&instance->bulk_waiter_list) {
-			struct bulk_waiter_node *waiter;
-
-			waiter = list_entry(pos,
-					struct bulk_waiter_node,
-					list);
-			list_del(pos);
+		list_for_each_entry_safe(waiter, next,
+					 &instance->bulk_waiter_list, list) {
+			list_del(&waiter->list);
 			vchiq_log_info(vchiq_arm_log_level,
 					"bulk_waiter - cleaned up %pK for pid %d",
 					waiter, waiter->pid);
@@ -473,7 +468,6 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	VCHIQ_SERVICE_T *service;
 	VCHIQ_STATUS_T status;
 	struct bulk_waiter_node *waiter = NULL;
-	struct list_head *pos;
 
 	service = find_service_by_handle(handle);
 	if (!service)
@@ -484,13 +478,9 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	unlock_service(service);
 
 	mutex_lock(&instance->bulk_waiter_list_mutex);
-	list_for_each(pos, &instance->bulk_waiter_list) {
-		if (list_entry(pos, struct bulk_waiter_node,
-				list)->pid == current->pid) {
-			waiter = list_entry(pos,
-				struct bulk_waiter_node,
-				list);
-			list_del(pos);
+	list_for_each_entry(waiter, &instance->bulk_waiter_list, list) {
+		if (waiter->pid == current->pid) {
+			list_del(&waiter->list);
 			break;
 		}
 	}
@@ -1135,21 +1125,16 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				ret = -ENOMEM;
 				break;
 			}
+
 			args.userdata = &waiter->bulk_waiter;
 		} else if (args.mode == VCHIQ_BULK_MODE_WAITING) {
-			struct list_head *pos;
-
 			mutex_lock(&instance->bulk_waiter_list_mutex);
-			list_for_each(pos, &instance->bulk_waiter_list) {
-				if (list_entry(pos, struct bulk_waiter_node,
-					list)->pid == current->pid) {
-					waiter = list_entry(pos,
-						struct bulk_waiter_node,
-						list);
-					list_del(pos);
+			list_for_each_entry(waiter, &instance->bulk_waiter_list,
+					    list) {
+				if (waiter->pid == current->pid) {
+					list_del(&waiter->list);
 					break;
 				}
-
 			}
 			mutex_unlock(&instance->bulk_waiter_list_mutex);
 			if (!waiter) {
@@ -2163,16 +2148,11 @@ vchiq_release(struct inode *inode, struct file *file)
 		vchiq_release_internal(instance->state, NULL);
 
 		{
-			struct list_head *pos, *next;
-
-			list_for_each_safe(pos, next,
-				&instance->bulk_waiter_list) {
-				struct bulk_waiter_node *waiter;
+			struct bulk_waiter_node *waiter, *next;
 
-				waiter = list_entry(pos,
-					struct bulk_waiter_node,
-					list);
-				list_del(pos);
+			list_for_each_entry_safe(waiter, next,
+					&instance->bulk_waiter_list, list) {
+				list_del(&waiter->list);
 				vchiq_log_info(vchiq_arm_log_level,
 					"bulk_waiter - cleaned up %pK for pid %d",
 					waiter, waiter->pid);
-- 
2.19.1

