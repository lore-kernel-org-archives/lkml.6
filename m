Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FAC282CF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E902C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DpSWVVmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfA2Auj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:50:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfA2AuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:50:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so8800531pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpTugb3jCvjIxf5mDgNZyCFDaqZgvFWuBAmbnL13FnI=;
        b=DpSWVVmLtXwFECc/oiwimMqEz6aJbMGjbry55VcV2wDmTs0HwzI3lu9EPBTxxTwjth
         /pG3AGAha2MllLk2Cmp36h+tclF35Y6VNQXry2u5UJZT0Z2LF83lXg+fMASzLboJ3d8w
         GfUuQqS0TbYUv46BscbnrLRTip/v/REuZ6UN3xi0It8fdNrjXwcY3IbykfTBic/abudK
         7PJ+q5VhkdQxCuhcD6MaTrglNM43jC3QFRitiL3Yv2dH3BHajq4cZGoy8ukIU9HtkoCg
         qdsrQwVw6DYYxjm/NGJrei8lC+FQf6NU887eFdU+84P8S+4VTnJGuE7X3s8o3pGqsnKe
         0QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpTugb3jCvjIxf5mDgNZyCFDaqZgvFWuBAmbnL13FnI=;
        b=o94rRqeNnVY4ujWKikjMjEhp5j5eyrQ/znG00eK1Q5xA/ijD6YxWbx3QuoimVXlDta
         FHX0aam5hhw/ImecgmqweeDHHj4XO26t0UeQobQrUoujwi6/eel3gOjF3Z6uzIMKcYMd
         jcgDb9KBm4d66wxp+5G/Swgp2ctmtSMl13fAft8Udb286bKL8jCmjkFyWcAoci3hBzhA
         K3ny4O2hbCz8tsDc7Hfwm2mY31zMbGUnrAlQ5F2TOIB2FJClERPBtn0t3gP5tUxdAGb7
         CmxHx1PhebYN1nOnK/mVm6wt1usi5dbSEwPwlui1LlKVGq0QPAFGnGIx4ZlmUSz5Z6I3
         jjKA==
X-Gm-Message-State: AJcUukdbjB9AUHhffQ3m/XF+eLhm6ZjTXhxuGikVBehp26YeHXCzF9is
        NLwEd4bMthnGT/19vTjBHP1Ubg==
X-Google-Smtp-Source: ALg8bN64gDRX3Wc1dT5tEGZ8Wc7MF/hKb53Xe30+v9HWUFDG0trSS8eWYwGY5oLy6zoK6Q79cBI9EQ==
X-Received: by 2002:a63:fe48:: with SMTP id x8mr22092561pgj.261.1548723011029;
        Mon, 28 Jan 2019 16:50:11 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id g3sm52090792pfe.37.2019.01.28.16.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:50:10 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH 3/7] binder: add function to copy binder object from buffer
Date:   Mon, 28 Jan 2019 16:49:30 -0800
Message-Id: <20190129004934.85885-4-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129004934.85885-1-tkjos@google.com>
References: <20190129004934.85885-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating or tearing down a transaction, the binder driver
examines objects in the buffer and takes appropriate action.
To do this without needing to dereference pointers into the
buffer, the local copies of the objects are needed. This patch
introduces a function to validate and copy binder objects
from the buffer to a local structure.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 75 +++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 74d0c1ff874e2..1563b9b60a0a3 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -628,6 +628,26 @@ struct binder_transaction {
 	spinlock_t lock;
 };
 
+/**
+ * struct binder_object - union of flat binder object types
+ * @hdr:   generic object header
+ * @fbo:   binder object (nodes and refs)
+ * @fdo:   file descriptor object
+ * @bbo:   binder buffer pointer
+ * @fdao:  file descriptor array
+ *
+ * Used for type-independent object copies
+ */
+struct binder_object {
+	union {
+		struct binder_object_header hdr;
+		struct flat_binder_object fbo;
+		struct binder_fd_object fdo;
+		struct binder_buffer_object bbo;
+		struct binder_fd_array_object fdao;
+	};
+};
+
 /**
  * binder_proc_lock() - Acquire outer lock for given binder_proc
  * @proc:         struct binder_proc to acquire
@@ -2017,26 +2037,33 @@ static void binder_cleanup_transaction(struct binder_transaction *t,
 }
 
 /**
- * binder_validate_object() - checks for a valid metadata object in a buffer.
+ * binder_get_object() - gets object and checks for valid metadata
+ * @proc:	binder_proc owning the buffer
  * @buffer:	binder_buffer that we're parsing.
- * @offset:	offset in the buffer at which to validate an object.
+ * @offset:	offset in the @buffer at which to validate an object.
+ * @object:	struct binder_object to read into
  *
  * Return:	If there's a valid metadata object at @offset in @buffer, the
- *		size of that object. Otherwise, it returns zero.
+ *		size of that object. Otherwise, it returns zero. The object
+ *		is read into the struct binder_object pointed to by @object.
  */
-static size_t binder_validate_object(struct binder_buffer *buffer, u64 offset)
+static size_t binder_get_object(struct binder_proc *proc,
+				struct binder_buffer *buffer,
+				unsigned long offset,
+				struct binder_object *object)
 {
-	/* Check if we can read a header first */
+	size_t read_size;
 	struct binder_object_header *hdr;
 	size_t object_size = 0;
 
-	if (buffer->data_size < sizeof(*hdr) ||
-	    offset > buffer->data_size - sizeof(*hdr) ||
-	    !IS_ALIGNED(offset, sizeof(u32)))
+	read_size = min(sizeof(*object), (size_t)(buffer->data_size - offset));
+	if (read_size < sizeof(*hdr))
 		return 0;
+	binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
+				      offset, read_size);
 
-	/* Ok, now see if we can read a complete object. */
-	hdr = (struct binder_object_header *)(buffer->data + offset);
+	/* Ok, now see if we read a complete object. */
+	hdr = &object->hdr;
 	switch (hdr->type) {
 	case BINDER_TYPE_BINDER:
 	case BINDER_TYPE_WEAK_BINDER:
@@ -2245,6 +2272,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	for (offp = off_start; offp < off_end; offp++) {
 		struct binder_object_header *hdr;
 		size_t object_size;
+		struct binder_object object;
 		binder_size_t object_offset;
 		binder_size_t buffer_offset = (uintptr_t)offp -
 			(uintptr_t)buffer->data;
@@ -2252,14 +2280,14 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
 					      buffer, buffer_offset,
 					      sizeof(object_offset));
-		object_size = binder_validate_object(buffer, object_offset);
+		object_size = binder_get_object(proc, buffer,
+						object_offset, &object);
 		if (object_size == 0) {
 			pr_err("transaction release %d bad object at offset %lld, size %zd\n",
 			       debug_id, (u64)object_offset, buffer->data_size);
 			continue;
 		}
-		hdr = (struct binder_object_header *)
-			(buffer->data + object_offset);
+		hdr = &object.hdr;
 		switch (hdr->type) {
 		case BINDER_TYPE_BINDER:
 		case BINDER_TYPE_WEAK_BINDER: {
@@ -3159,6 +3187,7 @@ static void binder_transaction(struct binder_proc *proc,
 	for (; offp < off_end; offp++) {
 		struct binder_object_header *hdr;
 		size_t object_size;
+		struct binder_object object;
 		binder_size_t object_offset;
 		binder_size_t buffer_offset =
 			(uintptr_t)offp - (uintptr_t)t->buffer->data;
@@ -3168,7 +3197,8 @@ static void binder_transaction(struct binder_proc *proc,
 					      t->buffer,
 					      buffer_offset,
 					      sizeof(object_offset));
-		object_size = binder_validate_object(t->buffer, object_offset);
+		object_size = binder_get_object(target_proc, t->buffer,
+						object_offset, &object);
 		if (object_size == 0 || object_offset < off_min) {
 			binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
 					  proc->pid, thread->pid,
@@ -3181,8 +3211,7 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_bad_offset;
 		}
 
-		hdr = (struct binder_object_header *)
-			(t->buffer->data + object_offset);
+		hdr = &object.hdr;
 		off_min = object_offset + object_size;
 		switch (hdr->type) {
 		case BINDER_TYPE_BINDER:
@@ -3197,6 +3226,9 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    fp, sizeof(*fp));
 		} break;
 		case BINDER_TYPE_HANDLE:
 		case BINDER_TYPE_WEAK_HANDLE: {
@@ -3210,6 +3242,9 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    fp, sizeof(*fp));
 		} break;
 
 		case BINDER_TYPE_FD: {
@@ -3226,6 +3261,9 @@ static void binder_transaction(struct binder_proc *proc,
 				goto err_translate_failed;
 			}
 			fp->pad_binder = 0;
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    fp, sizeof(*fp));
 		} break;
 		case BINDER_TYPE_FDA: {
 			struct binder_fd_array_object *fda =
@@ -3310,7 +3348,10 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
-			last_fixup_obj = bp;
+			binder_alloc_copy_to_buffer(&target_proc->alloc,
+						    t->buffer, object_offset,
+						    bp, sizeof(*bp));
+			last_fixup_obj = t->buffer->data + object_offset;
 			last_fixup_min_off = 0;
 		} break;
 		default:
-- 
2.20.1.495.gaa96b0ce6b-goog

