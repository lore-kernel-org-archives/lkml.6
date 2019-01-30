Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2386C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A9C20833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="TRtCIBA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfA3XNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:13:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42385 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfA3XNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:13:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so529211pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5q9MP8aEdsF2eqIUETFnsk9zVL0Sgw73fHck+wGAHc=;
        b=TRtCIBA3kTRFM+2FCebio/w5ala0QCM90WjZijH+pqX7kSV7enL1atVN4S1lalMQgK
         Fxm4prkUdaqmJgh/zPHp2++fyQtzI5ZM90hHdo83ByaDh4IrGfBKusZs6tMaefLqPSAD
         ie0Bzy9wNkNTmy1cqSMYFD4hqLjuJTLTqeWOGRJ9BD/Ra25AkRjhJUG+Ze70GROFBptN
         NWKG16iftOed2EQPCqYk/A1VLkdo79eGKuUpDAX3nd6QGtbys8SRSE9fOB/Oj3ybLOR7
         2yxecgZ0YAehhQt9dlGkqKawrZMN8GDE7+fTQ71NWeOOidcXrllqsbLX/eACrVIsuxGA
         0JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5q9MP8aEdsF2eqIUETFnsk9zVL0Sgw73fHck+wGAHc=;
        b=SrnWS86daAfI0Sz5QEGQCegJuQKy3VpnzVfwgy7vsX4EImlEbfUwgAdtfo+QESBvcp
         yoYHrUT0FNKOjXTVR86Nlsbhb59i1RQOI95ViSCZu/d98pJQl9BOLuD//OEZLndwB3b5
         WkIgN4iCLMNP6iej7YZUcR9t2Ze8mRGc2i7TFqbxNIWSMs8ofVVJCKfyCl70gQXSeSKN
         LOCYIM8JZv4BhUXv5R7Mkrspnfznk6Z0Ad12HTH/TmklYV4ZRuV5dDb2GDAbAbITmK7o
         /xie8ok8Ta0UlzYUrWpvl1OC6lfpXj9yXXdFIL2Rk+gCUoJ68DWEefclPJuZM3TRuHbl
         y39A==
X-Gm-Message-State: AJcUukf3UscgcpqJt4SRwxmV49De+2U5BC6IIJk1aVumXAGG1lJmdRib
        0/3gF2KVhGZFy5sfti3rZRHzJg==
X-Google-Smtp-Source: ALg8bN7RrypW45CwAP3msjgBYfwUUoKdM55hzjsCFkMobW9mj32jdI2Vm3fV5rJfX6OD4l2XTprNcA==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr29030995pgl.186.1548888439767;
        Wed, 30 Jan 2019 14:47:19 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id w136sm4219190pfd.169.2019.01.30.14.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:47:19 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 7/7] binder: use userspace pointer as base of buffer space
Date:   Wed, 30 Jan 2019 14:46:55 -0800
Message-Id: <20190130224655.255149-8-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190130224655.255149-1-tkjos@google.com>
References: <20190130224655.255149-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that alloc->buffer points to the userspace vm_area
rename buffer->data to buffer->user_data and rename
local pointers that hold user addresses. Also use the
"__user" tag to annotate all user pointers so sparse
can flag cases where user pointer vaues  are copied to
kernel pointers. Refactor code to use offsets instead
of user pointers.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: removed casts as suggested by Dan Carpenter

 drivers/android/binder.c       | 118 +++++++++++++++++++--------------
 drivers/android/binder_alloc.c |  87 ++++++++++++------------
 drivers/android/binder_alloc.h |   6 +-
 drivers/android/binder_trace.h |   2 +-
 4 files changed, 116 insertions(+), 97 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b3d609b5935a..25491eceb750 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2278,33 +2278,30 @@ static void binder_deferred_fd_close(int fd)
 
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_buffer *buffer,
-					      binder_size_t *failed_at)
+					      binder_size_t failed_at,
+					      bool is_failure)
 {
-	binder_size_t *offp, *off_start, *off_end;
 	int debug_id = buffer->debug_id;
-	binder_size_t off_start_offset;
+	binder_size_t off_start_offset, buffer_offset, off_end_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
-		     "%d buffer release %d, size %zd-%zd, failed at %pK\n",
+		     "%d buffer release %d, size %zd-%zd, failed at %llx\n",
 		     proc->pid, buffer->debug_id,
-		     buffer->data_size, buffer->offsets_size, failed_at);
+		     buffer->data_size, buffer->offsets_size,
+		     (unsigned long long)failed_at);
 
 	if (buffer->target_node)
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_start = (binder_size_t *)(buffer->data + off_start_offset);
-	if (failed_at)
-		off_end = failed_at;
-	else
-		off_end = (void *)off_start + buffer->offsets_size;
-	for (offp = off_start; offp < off_end; offp++) {
+	off_end_offset = is_failure ? failed_at :
+				off_start_offset + buffer->offsets_size;
+	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
+	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
 		size_t object_size;
 		struct binder_object object;
 		binder_size_t object_offset;
-		binder_size_t buffer_offset = (uintptr_t)offp -
-			(uintptr_t)buffer->data;
 
 		binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
 					      buffer, buffer_offset,
@@ -2380,9 +2377,10 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			struct binder_fd_array_object *fda;
 			struct binder_buffer_object *parent;
 			struct binder_object ptr_object;
-			u32 *fd_array;
+			binder_size_t fda_offset;
 			size_t fd_index;
 			binder_size_t fd_buf_size;
+			binder_size_t num_valid;
 
 			if (proc->tsk != current->group_leader) {
 				/*
@@ -2393,12 +2391,14 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 				continue;
 			}
 
+			num_valid = (buffer_offset - off_start_offset) /
+						sizeof(binder_size_t);
 			fda = to_binder_fd_array_object(hdr);
 			parent = binder_validate_ptr(proc, buffer, &ptr_object,
 						     fda->parent,
 						     off_start_offset,
 						     NULL,
-						     offp - off_start);
+						     num_valid);
 			if (!parent) {
 				pr_err("transaction release %d bad parent offset\n",
 				       debug_id);
@@ -2417,14 +2417,21 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 				       debug_id, (u64)fda->num_fds);
 				continue;
 			}
-			fd_array = (u32 *)(uintptr_t)
-				(parent->buffer + fda->parent_offset);
+			/*
+			 * the source data for binder_buffer_object is visible
+			 * to user-space and the @buffer element is the user
+			 * pointer to the buffer_object containing the fd_array.
+			 * Convert the address to an offset relative to
+			 * the base of the transaction buffer.
+			 */
+			fda_offset =
+			    (parent->buffer - (uintptr_t)buffer->user_data) +
+			    fda->parent_offset;
 			for (fd_index = 0; fd_index < fda->num_fds;
 			     fd_index++) {
 				u32 fd;
-				binder_size_t offset =
-					(uintptr_t)&fd_array[fd_index] -
-					(uintptr_t)buffer->data;
+				binder_size_t offset = fda_offset +
+					fd_index * sizeof(fd);
 
 				binder_alloc_copy_from_buffer(&proc->alloc,
 							      &fd,
@@ -2638,7 +2645,7 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 				     struct binder_transaction *in_reply_to)
 {
 	binder_size_t fdi, fd_buf_size;
-	u32 *fd_array;
+	binder_size_t fda_offset;
 	struct binder_proc *proc = thread->proc;
 	struct binder_proc *target_proc = t->to_proc;
 
@@ -2655,8 +2662,16 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 				  proc->pid, thread->pid, (u64)fda->num_fds);
 		return -EINVAL;
 	}
-	fd_array = (u32 *)(uintptr_t)(parent->buffer + fda->parent_offset);
-	if (!IS_ALIGNED((unsigned long)fd_array, sizeof(u32))) {
+	/*
+	 * the source data for binder_buffer_object is visible
+	 * to user-space and the @buffer element is the user
+	 * pointer to the buffer_object containing the fd_array.
+	 * Convert the address to an offset relative to
+	 * the base of the transaction buffer.
+	 */
+	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
+		fda->parent_offset;
+	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32))) {
 		binder_user_error("%d:%d parent offset not aligned correctly.\n",
 				  proc->pid, thread->pid);
 		return -EINVAL;
@@ -2664,9 +2679,7 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 	for (fdi = 0; fdi < fda->num_fds; fdi++) {
 		u32 fd;
 		int ret;
-		binder_size_t offset =
-			(uintptr_t)&fd_array[fdi] -
-			(uintptr_t)t->buffer->data;
+		binder_size_t offset = fda_offset + fdi * sizeof(fd);
 
 		binder_alloc_copy_from_buffer(&target_proc->alloc,
 					      &fd, t->buffer,
@@ -2724,7 +2737,7 @@ static int binder_fixup_parent(struct binder_transaction *t,
 		return -EINVAL;
 	}
 	buffer_offset = bp->parent_offset +
-			(uintptr_t)parent->buffer - (uintptr_t)b->data;
+			(uintptr_t)parent->buffer - (uintptr_t)b->user_data;
 	binder_alloc_copy_to_buffer(&target_proc->alloc, b, buffer_offset,
 				    &bp->buffer, sizeof(bp->buffer));
 
@@ -2845,10 +2858,10 @@ static void binder_transaction(struct binder_proc *proc,
 	struct binder_transaction *t;
 	struct binder_work *w;
 	struct binder_work *tcomplete;
-	binder_size_t *offp, *off_end, *off_start;
-	binder_size_t off_start_offset;
+	binder_size_t buffer_offset = 0;
+	binder_size_t off_start_offset, off_end_offset;
 	binder_size_t off_min;
-	u8 *sg_bufp, *sg_buf_end;
+	binder_size_t sg_buf_offset, sg_buf_end_offset;
 	struct binder_proc *target_proc = NULL;
 	struct binder_thread *target_thread = NULL;
 	struct binder_node *target_node = NULL;
@@ -3141,7 +3154,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(secctx_sz, sizeof(u64));
 
-		t->security_ctx = (uintptr_t)t->buffer->data + buf_offset;
+		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		binder_alloc_copy_to_buffer(&target_proc->alloc,
 					    t->buffer, buf_offset,
 					    secctx, secctx_sz);
@@ -3152,9 +3165,6 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->transaction = t;
 	t->buffer->target_node = target_node;
 	trace_binder_transaction_alloc_buf(t->buffer);
-	off_start_offset = ALIGN(tr->data_size, sizeof(void *));
-	off_start = (binder_size_t *)(t->buffer->data + off_start_offset);
-	offp = off_start;
 
 	if (binder_alloc_copy_user_to_buffer(
 				&target_proc->alloc,
@@ -3200,17 +3210,18 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_bad_offset;
 	}
-	off_end = (void *)off_start + tr->offsets_size;
-	sg_bufp = (u8 *)(PTR_ALIGN(off_end, sizeof(void *)));
-	sg_buf_end = sg_bufp + extra_buffers_size;
+	off_start_offset = ALIGN(tr->data_size, sizeof(void *));
+	buffer_offset = off_start_offset;
+	off_end_offset = off_start_offset + tr->offsets_size;
+	sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
+	sg_buf_end_offset = sg_buf_offset + extra_buffers_size;
 	off_min = 0;
-	for (; offp < off_end; offp++) {
+	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
+	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
 		size_t object_size;
 		struct binder_object object;
 		binder_size_t object_offset;
-		binder_size_t buffer_offset =
-			(uintptr_t)offp - (uintptr_t)t->buffer->data;
 
 		binder_alloc_copy_from_buffer(&target_proc->alloc,
 					      &object_offset,
@@ -3290,12 +3301,14 @@ static void binder_transaction(struct binder_proc *proc,
 			binder_size_t parent_offset;
 			struct binder_fd_array_object *fda =
 				to_binder_fd_array_object(hdr);
+			size_t num_valid = (buffer_offset - off_start_offset) *
+						sizeof(binder_size_t);
 			struct binder_buffer_object *parent =
 				binder_validate_ptr(target_proc, t->buffer,
 						    &ptr_object, fda->parent,
 						    off_start_offset,
 						    &parent_offset,
-						    offp - off_start);
+						    num_valid);
 			if (!parent) {
 				binder_user_error("%d:%d got transaction with invalid parent offset or type\n",
 						  proc->pid, thread->pid);
@@ -3332,9 +3345,8 @@ static void binder_transaction(struct binder_proc *proc,
 		case BINDER_TYPE_PTR: {
 			struct binder_buffer_object *bp =
 				to_binder_buffer_object(hdr);
-			size_t buf_left = sg_buf_end - sg_bufp;
-			binder_size_t sg_buf_offset = (uintptr_t)sg_bufp -
-				(uintptr_t)t->buffer->data;
+			size_t buf_left = sg_buf_end_offset - sg_buf_offset;
+			size_t num_valid;
 
 			if (bp->length > buf_left) {
 				binder_user_error("%d:%d got transaction with too large buffer\n",
@@ -3359,12 +3371,15 @@ static void binder_transaction(struct binder_proc *proc,
 				goto err_copy_data_failed;
 			}
 			/* Fixup buffer pointer to target proc address space */
-			bp->buffer = (uintptr_t)sg_bufp;
-			sg_bufp += ALIGN(bp->length, sizeof(u64));
+			bp->buffer = (uintptr_t)
+				t->buffer->user_data + sg_buf_offset;
+			sg_buf_offset += ALIGN(bp->length, sizeof(u64));
 
+			num_valid = (buffer_offset - off_start_offset) *
+					sizeof(binder_size_t);
 			ret = binder_fixup_parent(t, thread, bp,
 						  off_start_offset,
-						  offp - off_start,
+						  num_valid,
 						  last_fixup_obj_off,
 						  last_fixup_min_off);
 			if (ret < 0) {
@@ -3456,7 +3471,8 @@ static void binder_transaction(struct binder_proc *proc,
 err_copy_data_failed:
 	binder_free_txn_fixups(t);
 	trace_binder_transaction_failed_buffer_release(t->buffer);
-	binder_transaction_buffer_release(target_proc, t->buffer, offp);
+	binder_transaction_buffer_release(target_proc, t->buffer,
+					  buffer_offset, true);
 	if (target_node)
 		binder_dec_node_tmpref(target_node);
 	target_node = NULL;
@@ -3557,7 +3573,7 @@ binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, buffer, NULL);
+	binder_transaction_buffer_release(proc, buffer, 0, false);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
@@ -4451,7 +4467,7 @@ static int binder_thread_read(struct binder_proc *proc,
 		}
 		trd->data_size = t->buffer->data_size;
 		trd->offsets_size = t->buffer->offsets_size;
-		trd->data.ptr.buffer = (uintptr_t)t->buffer->data;
+		trd->data.ptr.buffer = (uintptr_t)t->buffer->user_data;
 		trd->data.ptr.offsets = trd->data.ptr.buffer +
 					ALIGN(t->buffer->data_size,
 					    sizeof(void *));
@@ -5489,7 +5505,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd data %pK\n",
 		   buffer->data_size, buffer->offsets_size,
-		   buffer->data);
+		   buffer->user_data);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 0e7f0aa967c3..000dd4d145ba 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -69,9 +69,8 @@ static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
 				       struct binder_buffer *buffer)
 {
 	if (list_is_last(&buffer->entry, &alloc->buffers))
-		return (u8 *)alloc->buffer +
-			alloc->buffer_size - (u8 *)buffer->data;
-	return (u8 *)binder_buffer_next(buffer)->data - (u8 *)buffer->data;
+		return alloc->buffer + alloc->buffer_size - buffer->user_data;
+	return binder_buffer_next(buffer)->user_data - buffer->user_data;
 }
 
 static void binder_insert_free_buffer(struct binder_alloc *alloc,
@@ -121,9 +120,9 @@ static void binder_insert_allocated_buffer_locked(
 		buffer = rb_entry(parent, struct binder_buffer, rb_node);
 		BUG_ON(buffer->free);
 
-		if (new_buffer->data < buffer->data)
+		if (new_buffer->user_data < buffer->user_data)
 			p = &parent->rb_left;
-		else if (new_buffer->data > buffer->data)
+		else if (new_buffer->user_data > buffer->user_data)
 			p = &parent->rb_right;
 		else
 			BUG();
@@ -138,17 +137,17 @@ static struct binder_buffer *binder_alloc_prepare_to_free_locked(
 {
 	struct rb_node *n = alloc->allocated_buffers.rb_node;
 	struct binder_buffer *buffer;
-	void *uptr;
+	void __user *uptr;
 
-	uptr = (void *)user_ptr;
+	uptr = (void __user *)user_ptr;
 
 	while (n) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		BUG_ON(buffer->free);
 
-		if (uptr < buffer->data)
+		if (uptr < buffer->user_data)
 			n = n->rb_left;
-		else if (uptr > buffer->data)
+		else if (uptr > buffer->user_data)
 			n = n->rb_right;
 		else {
 			/*
@@ -188,9 +187,9 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 }
 
 static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
-				    void *start, void *end)
+				    void __user *start, void __user *end)
 {
-	void *page_addr;
+	void __user *page_addr;
 	unsigned long user_page_addr;
 	struct binder_lru_page *page;
 	struct vm_area_struct *vma = NULL;
@@ -357,8 +356,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	struct binder_buffer *buffer;
 	size_t buffer_size;
 	struct rb_node *best_fit = NULL;
-	void *has_page_addr;
-	void *end_page_addr;
+	void __user *has_page_addr;
+	void __user *end_page_addr;
 	size_t size, data_offsets_size;
 	int ret;
 
@@ -456,15 +455,15 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
 		      alloc->pid, size, buffer, buffer_size);
 
-	has_page_addr =
-		(void *)(((uintptr_t)buffer->data + buffer_size) & PAGE_MASK);
+	has_page_addr = (void __user *)
+		(((uintptr_t)buffer->user_data + buffer_size) & PAGE_MASK);
 	WARN_ON(n && buffer_size != size);
 	end_page_addr =
-		(void *)PAGE_ALIGN((uintptr_t)buffer->data + size);
+		(void __user *)PAGE_ALIGN((uintptr_t)buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
-	ret = binder_update_page_range(alloc, 1,
-	    (void *)PAGE_ALIGN((uintptr_t)buffer->data), end_page_addr);
+	ret = binder_update_page_range(alloc, 1, (void __user *)
+		PAGE_ALIGN((uintptr_t)buffer->user_data), end_page_addr);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -477,7 +476,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 			       __func__, alloc->pid);
 			goto err_alloc_buf_struct_failed;
 		}
-		new_buffer->data = (u8 *)buffer->data + size;
+		new_buffer->user_data = (u8 __user *)buffer->user_data + size;
 		list_add(&new_buffer->entry, &buffer->entry);
 		new_buffer->free = 1;
 		binder_insert_free_buffer(alloc, new_buffer);
@@ -503,8 +502,8 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	return buffer;
 
 err_alloc_buf_struct_failed:
-	binder_update_page_range(alloc, 0,
-				 (void *)PAGE_ALIGN((uintptr_t)buffer->data),
+	binder_update_page_range(alloc, 0, (void __user *)
+				 PAGE_ALIGN((uintptr_t)buffer->user_data),
 				 end_page_addr);
 	return ERR_PTR(-ENOMEM);
 }
@@ -539,14 +538,15 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	return buffer;
 }
 
-static void *buffer_start_page(struct binder_buffer *buffer)
+static void __user *buffer_start_page(struct binder_buffer *buffer)
 {
-	return (void *)((uintptr_t)buffer->data & PAGE_MASK);
+	return (void __user *)((uintptr_t)buffer->user_data & PAGE_MASK);
 }
 
-static void *prev_buffer_end_page(struct binder_buffer *buffer)
+static void __user *prev_buffer_end_page(struct binder_buffer *buffer)
 {
-	return (void *)(((uintptr_t)(buffer->data) - 1) & PAGE_MASK);
+	return (void __user *)
+		(((uintptr_t)(buffer->user_data) - 1) & PAGE_MASK);
 }
 
 static void binder_delete_free_buffer(struct binder_alloc *alloc,
@@ -561,7 +561,8 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 		to_free = false;
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				   "%d: merge free, buffer %pK share page with %pK\n",
-				   alloc->pid, buffer->data, prev->data);
+				   alloc->pid, buffer->user_data,
+				   prev->user_data);
 	}
 
 	if (!list_is_last(&buffer->entry, &alloc->buffers)) {
@@ -571,23 +572,24 @@ static void binder_delete_free_buffer(struct binder_alloc *alloc,
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 					   "%d: merge free, buffer %pK share page with %pK\n",
 					   alloc->pid,
-					   buffer->data,
-					   next->data);
+					   buffer->user_data,
+					   next->user_data);
 		}
 	}
 
-	if (PAGE_ALIGNED(buffer->data)) {
+	if (PAGE_ALIGNED(buffer->user_data)) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				   "%d: merge free, buffer start %pK is page aligned\n",
-				   alloc->pid, buffer->data);
+				   alloc->pid, buffer->user_data);
 		to_free = false;
 	}
 
 	if (to_free) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				   "%d: merge free, buffer %pK do not share page with %pK or %pK\n",
-				   alloc->pid, buffer->data,
-				   prev->data, next ? next->data : NULL);
+				   alloc->pid, buffer->user_data,
+				   prev->user_data,
+				   next ? next->user_data : NULL);
 		binder_update_page_range(alloc, 0, buffer_start_page(buffer),
 					 buffer_start_page(buffer) + PAGE_SIZE);
 	}
@@ -613,8 +615,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->free);
 	BUG_ON(size > buffer_size);
 	BUG_ON(buffer->transaction != NULL);
-	BUG_ON(buffer->data < alloc->buffer);
-	BUG_ON(buffer->data > alloc->buffer + alloc->buffer_size);
+	BUG_ON(buffer->user_data < alloc->buffer);
+	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
 		alloc->free_async_space += size + sizeof(struct binder_buffer);
@@ -625,8 +627,9 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	}
 
 	binder_update_page_range(alloc, 0,
-		(void *)PAGE_ALIGN((uintptr_t)buffer->data),
-		(void *)(((uintptr_t)buffer->data + buffer_size) & PAGE_MASK));
+		(void __user *)PAGE_ALIGN((uintptr_t)buffer->user_data),
+		(void __user *)(((uintptr_t)
+			  buffer->user_data + buffer_size) & PAGE_MASK));
 
 	rb_erase(&buffer->rb_node, &alloc->allocated_buffers);
 	buffer->free = 1;
@@ -692,7 +695,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_already_mapped;
 	}
 
-	alloc->buffer = (void *)vma->vm_start;
+	alloc->buffer = (void __user *)vma->vm_start;
 	mutex_unlock(&binder_alloc_mmap_lock);
 
 	alloc->pages = kcalloc((vma->vm_end - vma->vm_start) / PAGE_SIZE,
@@ -712,7 +715,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_buf_struct_failed;
 	}
 
-	buffer->data = alloc->buffer;
+	buffer->user_data = alloc->buffer;
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
@@ -773,7 +776,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		int i;
 
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			void *page_addr;
+			void __user *page_addr;
 			bool on_lru;
 
 			if (!alloc->pages[i].page_ptr)
@@ -804,7 +807,7 @@ static void print_binder_buffer(struct seq_file *m, const char *prefix,
 				struct binder_buffer *buffer)
 {
 	seq_printf(m, "%s %d: %pK size %zd:%zd:%zd %s\n",
-		   prefix, buffer->debug_id, buffer->data,
+		   prefix, buffer->debug_id, buffer->user_data,
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->extra_buffers_size,
 		   buffer->transaction ? "active" : "delivered");
@@ -1056,7 +1059,7 @@ static inline bool check_buffer(struct binder_alloc *alloc,
  * @pgoffp: address to copy final page offset to
  *
  * Lookup the struct page corresponding to the address
- * at @buffer_offset into @buffer->data. If @pgoffp is not
+ * at @buffer_offset into @buffer->user_data. If @pgoffp is not
  * NULL, the byte-offset into the page is written there.
  *
  * The caller is responsible to ensure that the offset points
@@ -1073,7 +1076,7 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 					  pgoff_t *pgoffp)
 {
 	binder_size_t buffer_space_offset = buffer_offset +
-		(buffer->data - alloc->buffer);
+		(buffer->user_data - alloc->buffer);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
 	struct binder_lru_page *lru_page;
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 1026e9fb20db..b60d161b7a7a 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -40,7 +40,7 @@ struct binder_transaction;
  * @data_size:          size of @transaction data
  * @offsets_size:       size of array of offsets
  * @extra_buffers_size: size of space for other objects (like sg lists)
- * @data:               pointer to base of buffer space
+ * @user_data:          user pointer to base of buffer space
  *
  * Bookkeeping structure for binder transaction buffers
  */
@@ -59,7 +59,7 @@ struct binder_buffer {
 	size_t data_size;
 	size_t offsets_size;
 	size_t extra_buffers_size;
-	void *data;
+	void __user *user_data;
 };
 
 /**
@@ -102,7 +102,7 @@ struct binder_alloc {
 	struct mutex mutex;
 	struct vm_area_struct *vma;
 	struct mm_struct *vma_vm_mm;
-	void *buffer;
+	void __user *buffer;
 	struct list_head buffers;
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 14de7ac57a34..83cc254d2335 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -293,7 +293,7 @@ DEFINE_EVENT(binder_buffer_class, binder_transaction_failed_buffer_release,
 
 TRACE_EVENT(binder_update_page_range,
 	TP_PROTO(struct binder_alloc *alloc, bool allocate,
-		 void *start, void *end),
+		 void __user *start, void __user *end),
 	TP_ARGS(alloc, allocate, start, end),
 	TP_STRUCT__entry(
 		__field(int, proc)
-- 
2.20.1.495.gaa96b0ce6b-goog

