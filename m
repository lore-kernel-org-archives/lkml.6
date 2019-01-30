Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC58218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Iq7SIM/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfA3Wxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:53:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38243 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3Wxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 17:53:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so515617pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6GPc26DrsBK3cAtQPr8gOky96te8FJI2ChioLBE0sI=;
        b=Iq7SIM/+JXdo88ZFjkHjjbbZcqbztjnJpL5b2cb1XCFN/4soSUgzvwpxbYKgj4xXTX
         GLZm9geS9LlKKlSssMZKS0jVlIVDqPXhD00t2Pzv1Fr5/l3afWg4Oha3C+cn3xDoe1Tx
         P4EoaqVywqOwEqt7DlO9Qsai3k744OtlOb2ASI9lHWOr1N8WCcZgndUZnIZnlRujPCeE
         qGXHKJmivCZYPgtj3sv9ZV1gaUzFINh/kqHsX8GpgLnnA2prbPDP2xMSr0gCFbcsYPtY
         YANHlZVf6vSYZBOjHzbVIW5/PtEeK+nCifHOdgJaR6x5g8FHk7AqDl6qYNnQe/GNCuOH
         whkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6GPc26DrsBK3cAtQPr8gOky96te8FJI2ChioLBE0sI=;
        b=KHu+pXvkEOCNY3nEvU20NBBpGNeVHH+SGFOD2PuWYIk1Dn+kocqLmjjDqJtuxted7B
         y52xbV31bAVH+0vv4DaLesq8s7XzX9pqPFqajWlacpbPepKsK3dvyx9LZFim5sIHGWHF
         RANPCpCvOEvcq3VdMS1hzOCuUh/x8WLQZUllXpBvmagJBasAvGVAaNgkwaOTREcDqexJ
         Z7KSs2kMubclPuoldktrbNq4K9lD3bdDN9tTBlMtQok54rXcrQ+RB6tkRli4NvOpDld6
         XwYysYqbqOFeBFUNoqpc/rASabrgN0gVDqmfrub2sJZgE0OQpAcG3ANsXmsKKEoYOOo+
         TJKg==
X-Gm-Message-State: AJcUukdJaiY0HtYuXDNB94xDyzVn6mi1oy4Jtg+CxU0i7FavuBI5tNMu
        EXiL0dzJ4GnLzmlOWgO95HOaqg==
X-Google-Smtp-Source: ALg8bN54mbYHuGF7fktYvwHIK3XEB3layK5ktyZkEfH66XJwiRQFx9ptow/cgCICx6du/qRB7A+41w==
X-Received: by 2002:a63:e21:: with SMTP id d33mr29146464pgl.272.1548888435981;
        Wed, 30 Jan 2019 14:47:15 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id w136sm4219190pfd.169.2019.01.30.14.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:47:15 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 4/7] binder: avoid kernel vm_area for buffer fixups
Date:   Wed, 30 Jan 2019 14:46:52 -0800
Message-Id: <20190130224655.255149-5-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190130224655.255149-1-tkjos@google.com>
References: <20190130224655.255149-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the functions to validate and fixup struct
binder_buffer pointer objects to avoid using vm_area
pointers. Instead copy to/from kernel space using
binder_alloc_copy_to_buffer() and
binder_alloc_copy_from_buffer(). The following
functions were refactored:

	binder_validate_ptr()
	binder_validate_fixup()
	binder_fixup_parent()

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 146 ++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 49 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8063b405e4fa..98163bf5f35c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2092,10 +2092,13 @@ static size_t binder_get_object(struct binder_proc *proc,
 
 /**
  * binder_validate_ptr() - validates binder_buffer_object in a binder_buffer.
+ * @proc:	binder_proc owning the buffer
  * @b:		binder_buffer containing the object
+ * @object:	struct binder_object to read into
  * @index:	index in offset array at which the binder_buffer_object is
  *		located
- * @start:	points to the start of the offset array
+ * @start_offset: points to the start of the offset array
+ * @object_offsetp: offset of @object read from @b
  * @num_valid:	the number of valid offsets in the offset array
  *
  * Return:	If @index is within the valid range of the offset array
@@ -2106,34 +2109,46 @@ static size_t binder_get_object(struct binder_proc *proc,
  *		Note that the offset found in index @index itself is not
  *		verified; this function assumes that @num_valid elements
  *		from @start were previously verified to have valid offsets.
+ *		If @object_offsetp is non-NULL, then the offset within
+ *		@b is written to it.
  */
-static struct binder_buffer_object *binder_validate_ptr(struct binder_buffer *b,
-							binder_size_t index,
-							binder_size_t *start,
-							binder_size_t num_valid)
+static struct binder_buffer_object *binder_validate_ptr(
+						struct binder_proc *proc,
+						struct binder_buffer *b,
+						struct binder_object *object,
+						binder_size_t index,
+						binder_size_t start_offset,
+						binder_size_t *object_offsetp,
+						binder_size_t num_valid)
 {
-	struct binder_buffer_object *buffer_obj;
-	binder_size_t *offp;
+	size_t object_size;
+	binder_size_t object_offset;
+	unsigned long buffer_offset;
 
 	if (index >= num_valid)
 		return NULL;
 
-	offp = start + index;
-	buffer_obj = (struct binder_buffer_object *)(b->data + *offp);
-	if (buffer_obj->hdr.type != BINDER_TYPE_PTR)
+	buffer_offset = start_offset + sizeof(binder_size_t) * index;
+	binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
+				      b, buffer_offset, sizeof(object_offset));
+	object_size = binder_get_object(proc, b, object_offset, object);
+	if (!object_size || object->hdr.type != BINDER_TYPE_PTR)
 		return NULL;
+	if (object_offsetp)
+		*object_offsetp = object_offset;
 
-	return buffer_obj;
+	return &object->bbo;
 }
 
 /**
  * binder_validate_fixup() - validates pointer/fd fixups happen in order.
+ * @proc:		binder_proc owning the buffer
  * @b:			transaction buffer
- * @objects_start	start of objects buffer
- * @buffer:		binder_buffer_object in which to fix up
- * @offset:		start offset in @buffer to fix up
- * @last_obj:		last binder_buffer_object that we fixed up in
- * @last_min_offset:	minimum fixup offset in @last_obj
+ * @objects_start_offset: offset to start of objects buffer
+ * @buffer_obj_offset:	offset to binder_buffer_object in which to fix up
+ * @fixup_offset:	start offset in @buffer to fix up
+ * @last_obj_offset:	offset to last binder_buffer_object that we fixed
+ * @last_min_offset:	minimum fixup offset in object at @last_obj_offset
  *
  * Return:		%true if a fixup in buffer @buffer at offset @offset is
  *			allowed.
@@ -2164,28 +2179,41 @@ static struct binder_buffer_object *binder_validate_ptr(struct binder_buffer *b,
  *   C (parent = A, offset = 16)
  *     D (parent = B, offset = 0) // B is not A or any of A's parents
  */
-static bool binder_validate_fixup(struct binder_buffer *b,
-				  binder_size_t *objects_start,
-				  struct binder_buffer_object *buffer,
+static bool binder_validate_fixup(struct binder_proc *proc,
+				  struct binder_buffer *b,
+				  binder_size_t objects_start_offset,
+				  binder_size_t buffer_obj_offset,
 				  binder_size_t fixup_offset,
-				  struct binder_buffer_object *last_obj,
+				  binder_size_t last_obj_offset,
 				  binder_size_t last_min_offset)
 {
-	if (!last_obj) {
+	if (!last_obj_offset) {
 		/* Nothing to fix up in */
 		return false;
 	}
 
-	while (last_obj != buffer) {
+	while (last_obj_offset != buffer_obj_offset) {
+		unsigned long buffer_offset;
+		struct binder_object last_object;
+		struct binder_buffer_object *last_bbo;
+		size_t object_size = binder_get_object(proc, b, last_obj_offset,
+						       &last_object);
+		if (object_size != sizeof(*last_bbo))
+			return false;
+
+		last_bbo = &last_object.bbo;
 		/*
 		 * Safe to retrieve the parent of last_obj, since it
 		 * was already previously verified by the driver.
 		 */
-		if ((last_obj->flags & BINDER_BUFFER_FLAG_HAS_PARENT) == 0)
+		if ((last_bbo->flags & BINDER_BUFFER_FLAG_HAS_PARENT) == 0)
 			return false;
-		last_min_offset = last_obj->parent_offset + sizeof(uintptr_t);
-		last_obj = (struct binder_buffer_object *)
-			(b->data + *(objects_start + last_obj->parent));
+		last_min_offset = last_bbo->parent_offset + sizeof(uintptr_t);
+		buffer_offset = objects_start_offset +
+			sizeof(binder_size_t) * last_bbo->parent,
+		binder_alloc_copy_from_buffer(&proc->alloc, &last_obj_offset,
+					      b, buffer_offset,
+					      sizeof(last_obj_offset));
 	}
 	return (fixup_offset >= last_min_offset);
 }
@@ -2254,6 +2282,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 {
 	binder_size_t *offp, *off_start, *off_end;
 	int debug_id = buffer->debug_id;
+	binder_size_t off_start_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
 		     "%d buffer release %d, size %zd-%zd, failed at %pK\n",
@@ -2263,8 +2292,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	if (buffer->target_node)
 		binder_dec_node(buffer->target_node, 1, 0);
 
-	off_start = (binder_size_t *)(buffer->data +
-				      ALIGN(buffer->data_size, sizeof(void *)));
+	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
+	off_start = (binder_size_t *)(buffer->data + off_start_offset);
 	if (failed_at)
 		off_end = failed_at;
 	else
@@ -2350,6 +2379,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		case BINDER_TYPE_FDA: {
 			struct binder_fd_array_object *fda;
 			struct binder_buffer_object *parent;
+			struct binder_object ptr_object;
 			uintptr_t parent_buffer;
 			u32 *fd_array;
 			size_t fd_index;
@@ -2365,8 +2395,10 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			}
 
 			fda = to_binder_fd_array_object(hdr);
-			parent = binder_validate_ptr(buffer, fda->parent,
-						     off_start,
+			parent = binder_validate_ptr(proc, buffer, &ptr_object,
+						     fda->parent,
+						     off_start_offset,
+						     NULL,
 						     offp - off_start);
 			if (!parent) {
 				pr_err("transaction release %d bad parent offset\n",
@@ -2665,9 +2697,9 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 static int binder_fixup_parent(struct binder_transaction *t,
 			       struct binder_thread *thread,
 			       struct binder_buffer_object *bp,
-			       binder_size_t *off_start,
+			       binder_size_t off_start_offset,
 			       binder_size_t num_valid,
-			       struct binder_buffer_object *last_fixup_obj,
+			       binder_size_t last_fixup_obj_off,
 			       binder_size_t last_fixup_min_off)
 {
 	struct binder_buffer_object *parent;
@@ -2675,20 +2707,25 @@ static int binder_fixup_parent(struct binder_transaction *t,
 	struct binder_buffer *b = t->buffer;
 	struct binder_proc *proc = thread->proc;
 	struct binder_proc *target_proc = t->to_proc;
+	struct binder_object object;
+	binder_size_t buffer_offset;
+	binder_size_t parent_offset;
 
 	if (!(bp->flags & BINDER_BUFFER_FLAG_HAS_PARENT))
 		return 0;
 
-	parent = binder_validate_ptr(b, bp->parent, off_start, num_valid);
+	parent = binder_validate_ptr(target_proc, b, &object, bp->parent,
+				     off_start_offset, &parent_offset,
+				     num_valid);
 	if (!parent) {
 		binder_user_error("%d:%d got transaction with invalid parent offset or type\n",
 				  proc->pid, thread->pid);
 		return -EINVAL;
 	}
 
-	if (!binder_validate_fixup(b, off_start,
-				   parent, bp->parent_offset,
-				   last_fixup_obj,
+	if (!binder_validate_fixup(target_proc, b, off_start_offset,
+				   parent_offset, bp->parent_offset,
+				   last_fixup_obj_off,
 				   last_fixup_min_off)) {
 		binder_user_error("%d:%d got transaction with out-of-order buffer fixup\n",
 				  proc->pid, thread->pid);
@@ -2705,7 +2742,10 @@ static int binder_fixup_parent(struct binder_transaction *t,
 	parent_buffer = (u8 *)((uintptr_t)parent->buffer -
 			binder_alloc_get_user_buffer_offset(
 				&target_proc->alloc));
-	*(binder_uintptr_t *)(parent_buffer + bp->parent_offset) = bp->buffer;
+	buffer_offset = bp->parent_offset +
+			(uintptr_t)parent_buffer - (uintptr_t)b->data;
+	binder_alloc_copy_to_buffer(&target_proc->alloc, b, buffer_offset,
+				    &bp->buffer, sizeof(bp->buffer));
 
 	return 0;
 }
@@ -2825,6 +2865,7 @@ static void binder_transaction(struct binder_proc *proc,
 	struct binder_work *w;
 	struct binder_work *tcomplete;
 	binder_size_t *offp, *off_end, *off_start;
+	binder_size_t off_start_offset;
 	binder_size_t off_min;
 	u8 *sg_bufp, *sg_buf_end;
 	struct binder_proc *target_proc = NULL;
@@ -2835,7 +2876,7 @@ static void binder_transaction(struct binder_proc *proc,
 	uint32_t return_error = 0;
 	uint32_t return_error_param = 0;
 	uint32_t return_error_line = 0;
-	struct binder_buffer_object *last_fixup_obj = NULL;
+	binder_size_t last_fixup_obj_off = 0;
 	binder_size_t last_fixup_min_off = 0;
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
@@ -3132,8 +3173,8 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->transaction = t;
 	t->buffer->target_node = target_node;
 	trace_binder_transaction_alloc_buf(t->buffer);
-	off_start = (binder_size_t *)(t->buffer->data +
-				      ALIGN(tr->data_size, sizeof(void *)));
+	off_start_offset = ALIGN(tr->data_size, sizeof(void *));
+	off_start = (binder_size_t *)(t->buffer->data + off_start_offset);
 	offp = off_start;
 
 	if (binder_alloc_copy_user_to_buffer(
@@ -3266,11 +3307,15 @@ static void binder_transaction(struct binder_proc *proc,
 						    fp, sizeof(*fp));
 		} break;
 		case BINDER_TYPE_FDA: {
+			struct binder_object ptr_object;
+			binder_size_t parent_offset;
 			struct binder_fd_array_object *fda =
 				to_binder_fd_array_object(hdr);
 			struct binder_buffer_object *parent =
-				binder_validate_ptr(t->buffer, fda->parent,
-						    off_start,
+				binder_validate_ptr(target_proc, t->buffer,
+						    &ptr_object, fda->parent,
+						    off_start_offset,
+						    &parent_offset,
 						    offp - off_start);
 			if (!parent) {
 				binder_user_error("%d:%d got transaction with invalid parent offset or type\n",
@@ -3280,9 +3325,11 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_bad_parent;
 			}
-			if (!binder_validate_fixup(t->buffer, off_start,
-						   parent, fda->parent_offset,
-						   last_fixup_obj,
+			if (!binder_validate_fixup(target_proc, t->buffer,
+						   off_start_offset,
+						   parent_offset,
+						   fda->parent_offset,
+						   last_fixup_obj_off,
 						   last_fixup_min_off)) {
 				binder_user_error("%d:%d got transaction with out-of-order buffer fixup\n",
 						  proc->pid, thread->pid);
@@ -3299,7 +3346,7 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
-			last_fixup_obj = parent;
+			last_fixup_obj_off = parent_offset;
 			last_fixup_min_off =
 				fda->parent_offset + sizeof(u32) * fda->num_fds;
 		} break;
@@ -3338,9 +3385,10 @@ static void binder_transaction(struct binder_proc *proc,
 						&target_proc->alloc);
 			sg_bufp += ALIGN(bp->length, sizeof(u64));
 
-			ret = binder_fixup_parent(t, thread, bp, off_start,
+			ret = binder_fixup_parent(t, thread, bp,
+						  off_start_offset,
 						  offp - off_start,
-						  last_fixup_obj,
+						  last_fixup_obj_off,
 						  last_fixup_min_off);
 			if (ret < 0) {
 				return_error = BR_FAILED_REPLY;
@@ -3351,7 +3399,7 @@ static void binder_transaction(struct binder_proc *proc,
 			binder_alloc_copy_to_buffer(&target_proc->alloc,
 						    t->buffer, object_offset,
 						    bp, sizeof(*bp));
-			last_fixup_obj = t->buffer->data + object_offset;
+			last_fixup_obj_off = object_offset;
 			last_fixup_min_off = 0;
 		} break;
 		default:
-- 
2.20.1.495.gaa96b0ce6b-goog

