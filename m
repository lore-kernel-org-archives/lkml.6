Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04455C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11732148C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11732148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJDAJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E365E3001759;
        Wed,  3 Oct 2018 17:20:00 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-200-24.brq.redhat.com [10.40.200.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBB1309136D;
        Wed,  3 Oct 2018 17:19:58 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 3/3] HID: debug: fix the ring buffer writer implementation
Date:   Wed,  3 Oct 2018 19:19:36 +0200
Message-Id: <20181003171936.11271-4-vdronov@redhat.com>
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
References: <20181003171936.11271-1-vdronov@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 03 Oct 2018 17:20:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ring buffer implementation hid_debug_event() is strange allowing a lost
of data. it does not move head pointer on append and uses per-byte for()
loop. fix this by introducing a new ring buffer implementation, which
overwrites the oldest data in case of the ring buffer overflow. it uses
some calculations for the buffer pointers but only 2 or less memcpy()
calls.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/hid/hid-debug.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index de640e4132c7..63247ac4a9ce 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -661,20 +661,70 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	unsigned i;
 	struct hid_debug_list *list;
-	unsigned long flags, flags2;
+	unsigned long flags1, flags2;
+	unsigned int part1, part2;
+	size_t len;
 
-	spin_lock_irqsave(&hdev->debug_list_lock, flags);
+	if (!buf || !buf[0])
+		return;
+
+	len = strlen(buf);
+
+	spin_lock_irqsave(&hdev->debug_list_lock, flags1);
 	list_for_each_entry(list, &hdev->debug_list, node) {
 		spin_lock_irqsave(&list->list_lock, flags2);
-		for (i = 0; buf[i]; i++)
-			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
-				buf[i];
-		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
+
+		/* len >= BUFSIZE, copy the last HID_DEBUG_BUFSIZE-1 bytes */
+		if (len > HID_DEBUG_BUFSIZE - 1) {
+			memcpy(list->hid_debug_buf,
+				buf + len - (HID_DEBUG_BUFSIZE - 1),
+				HID_DEBUG_BUFSIZE - 1);
+
+			list->head = 0;
+			list->tail = HID_DEBUG_BUFSIZE - 1;
+		} else {
+			/* append data to the ring buffer */
+			part1 = min_t(size_t, HID_DEBUG_BUFSIZE - list->tail,
+					len);
+			part2 = len - part1;
+
+			memcpy(list->hid_debug_buf + list->tail, buf, part1);
+
+			/* check if head must be moved as the ring is full */
+			if ((list->tail < list->head) &&
+			    (list->tail + part1 >= list->head)) {
+				list->head = list->tail + part1 + 1;
+
+				if (list->head >= HID_DEBUG_BUFSIZE)
+					list->head -= HID_DEBUG_BUFSIZE;
+			}
+
+			/* set tail after the end of appended data */
+			list->tail = list->tail + part1;
+			if (list->tail == HID_DEBUG_BUFSIZE) {
+				list->tail = 0;
+				if (list->head == 0)
+					list->head = 1;
+			}
+
+			/* append the 2nd part of data to the ring */
+			if (part2 > 0) {
+				memcpy(list->hid_debug_buf, buf + part1, part2);
+
+				/* check if head must be moved again as
+				 * the ring is full
+				 */
+				if (list->tail + part2 >= list->head)
+					list->head = list->tail + part2 + 1;
+
+				list->tail = list->tail + part2;
+			}
+		}
+
 		spin_unlock_irqrestore(&list->list_lock, flags2);
 	}
-	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
+	spin_unlock_irqrestore(&hdev->debug_list_lock, flags1);
 
 	wake_up_interruptible(&hdev->debug_wait);
 }
-- 
2.19.0

