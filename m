Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7FAC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B53F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B53F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbeKUBYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:24:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:39252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727466AbeKUBXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB634AD94;
        Tue, 20 Nov 2018 14:54:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 06/16] staging: vchiq_arm: rework vchiq_ioc_copy_element_data
Date:   Tue, 20 Nov 2018 15:53:41 +0100
Message-Id: <20181120145351.30390-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is passed to vchiq_core.c for it to go trough all the
transfer elements (an array of pointers to data) and copy them into the
actual transfer memory (contiguous memory).

The logic in the function was "copy an element and return, except when
the element is empty, in which case look for the next non-empty element
and copy it. The function will be called as many times as necessary until
all the elements are copied".

Now, this approach already forces the function to loop around elements
and felt convoluted, so it was changed to a more straightforward "Copy
all the elements into memory as long as they fit".

The resulting function is shorter and simpler.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 89 +++++++------------
 1 file changed, 31 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 525458551a22..7fa734991db9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -752,74 +752,48 @@ static void close_delivered(USER_SERVICE_T *user_service)
 }
 
 struct vchiq_io_copy_callback_context {
-	struct vchiq_element *current_element;
-	size_t current_element_offset;
+	struct vchiq_element *element;
+	size_t element_offset;
 	unsigned long elements_to_go;
-	size_t current_offset;
 };
 
-static ssize_t
-vchiq_ioc_copy_element_data(
-	void *context,
-	void *dest,
-	size_t offset,
-	size_t maxsize)
+static ssize_t vchiq_ioc_copy_element_data(void *context, void *dest,
+					   size_t offset, size_t maxsize)
 {
-	long res;
+	struct vchiq_io_copy_callback_context *cc = context;
+	size_t total_bytes_copied = 0;
 	size_t bytes_this_round;
-	struct vchiq_io_copy_callback_context *copy_context =
-		(struct vchiq_io_copy_callback_context *)context;
-
-	if (offset != copy_context->current_offset)
-		return 0;
-
-	if (!copy_context->elements_to_go)
-		return 0;
-
-	/*
-	 * Complex logic here to handle the case of 0 size elements
-	 * in the middle of the array of elements.
-	 *
-	 * Need to skip over these 0 size elements.
-	 */
-	while (1) {
-		bytes_this_round = min(copy_context->current_element->size -
-				       copy_context->current_element_offset,
-				       maxsize);
-
-		if (bytes_this_round)
-			break;
 
-		copy_context->elements_to_go--;
-		copy_context->current_element++;
-		copy_context->current_element_offset = 0;
+	while (total_bytes_copied < maxsize) {
+		if (!cc->elements_to_go)
+			return total_bytes_copied;
 
-		if (!copy_context->elements_to_go)
-			return 0;
-	}
+		if (!cc->element->size) {
+			cc->elements_to_go--;
+			cc->element++;
+			cc->element_offset = 0;
+			continue;
+		}
 
-	res = copy_from_user(dest,
-			     copy_context->current_element->data +
-			     copy_context->current_element_offset,
-			     bytes_this_round);
+		bytes_this_round = min(cc->element->size - cc->element_offset,
+				       maxsize - total_bytes_copied);
 
-	if (res != 0)
-		return -EFAULT;
+		if (copy_from_user(dest + total_bytes_copied,
+				  cc->element->data + cc->element_offset,
+				  bytes_this_round))
+			return -EFAULT;
 
-	copy_context->current_element_offset += bytes_this_round;
-	copy_context->current_offset += bytes_this_round;
+		cc->element_offset += bytes_this_round;
+		total_bytes_copied += bytes_this_round;
 
-	/*
-	 * Check if done with current element, and if so advance to the next.
-	 */
-	if (copy_context->current_element_offset ==
-	    copy_context->current_element->size) {
-		copy_context->elements_to_go--;
-		copy_context->current_element++;
-		copy_context->current_element_offset = 0;
+		if (cc->element_offset == cc->element->size) {
+			cc->elements_to_go--;
+			cc->element++;
+			cc->element_offset = 0;
+		}
 	}
 
-	return bytes_this_round;
+	return maxsize;
 }
 
 /**************************************************************************
@@ -836,10 +810,9 @@ vchiq_ioc_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
 	unsigned long i;
 	size_t total_size = 0;
 
-	context.current_element = elements;
-	context.current_element_offset = 0;
+	context.element = elements;
+	context.element_offset = 0;
 	context.elements_to_go = count;
-	context.current_offset = 0;
 
 	for (i = 0; i < count; i++) {
 		if (!elements[i].data && elements[i].size != 0)
-- 
2.19.1

