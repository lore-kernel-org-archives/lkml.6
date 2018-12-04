Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B579CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C96920851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Lgk1Gm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C96920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeLDLBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeLDLBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2248A2087F;
        Tue,  4 Dec 2018 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921259;
        bh=VsoaOVQnW1YnJtYXX3R/mG+wg5NjMFAxPo7/AUscGNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Lgk1Gm73xfF5BMW/gS9XEruSIZRsFzGBQuySgrf/VlHb0gye5+lH/6O0WnIVYxQU
         KvNHzmgAlXQhvtWzhK2cf7jmjFrnGgViFHYAJ8J4IE03INZcUojVlr26JPNMxtJv7z
         F7NTgrAdLAOffct7Qcqf0o5e/wTiWpNAxxIaD4Oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 4.19 116/139] binder: fix race that allows malicious free of live buffer
Date:   Tue,  4 Dec 2018 11:49:57 +0100
Message-Id: <20181204103655.392475051@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit 7bada55ab50697861eee6bb7d60b41e68a961a9c upstream.

Malicious code can attempt to free buffers using the BC_FREE_BUFFER
ioctl to binder. There are protections against a user freeing a buffer
while in use by the kernel, however there was a window where
BC_FREE_BUFFER could be used to free a recently allocated buffer that
was not completely initialized. This resulted in a use-after-free
detected by KASAN with a malicious test program.

This window is closed by setting the buffer's allow_user_free attribute
to 0 when the buffer is allocated or when the user has previously freed
it instead of waiting for the caller to set it. The problem was that
when the struct buffer was recycled, allow_user_free was stale and set
to 1 allowing a free to go through.

Signed-off-by: Todd Kjos <tkjos@google.com>
Acked-by: Arve Hjønnevåg <arve@android.com>
Cc: stable <stable@vger.kernel.org> # 4.14
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c       |   21 ++++++++++++---------
 drivers/android/binder_alloc.c |   16 ++++++----------
 drivers/android/binder_alloc.h |    3 +--
 3 files changed, 19 insertions(+), 21 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2971,7 +2971,6 @@ static void binder_transaction(struct bi
 		t->buffer = NULL;
 		goto err_binder_alloc_buf_failed;
 	}
-	t->buffer->allow_user_free = 0;
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
 	t->buffer->target_node = target_node;
@@ -3465,14 +3464,18 @@ static int binder_thread_write(struct bi
 
 			buffer = binder_alloc_prepare_to_free(&proc->alloc,
 							      data_ptr);
-			if (buffer == NULL) {
-				binder_user_error("%d:%d BC_FREE_BUFFER u%016llx no match\n",
-					proc->pid, thread->pid, (u64)data_ptr);
-				break;
-			}
-			if (!buffer->allow_user_free) {
-				binder_user_error("%d:%d BC_FREE_BUFFER u%016llx matched unreturned buffer\n",
-					proc->pid, thread->pid, (u64)data_ptr);
+			if (IS_ERR_OR_NULL(buffer)) {
+				if (PTR_ERR(buffer) == -EPERM) {
+					binder_user_error(
+						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
+						proc->pid, thread->pid,
+						(u64)data_ptr);
+				} else {
+					binder_user_error(
+						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
+						proc->pid, thread->pid,
+						(u64)data_ptr);
+				}
 				break;
 			}
 			binder_debug(BINDER_DEBUG_FREE_BUFFER,
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -151,16 +151,12 @@ static struct binder_buffer *binder_allo
 		else {
 			/*
 			 * Guard against user threads attempting to
-			 * free the buffer twice
+			 * free the buffer when in use by kernel or
+			 * after it's already been freed.
 			 */
-			if (buffer->free_in_progress) {
-				binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
-						   "%d:%d FREE_BUFFER u%016llx user freed buffer twice\n",
-						   alloc->pid, current->pid,
-						   (u64)user_ptr);
-				return NULL;
-			}
-			buffer->free_in_progress = 1;
+			if (!buffer->allow_user_free)
+				return ERR_PTR(-EPERM);
+			buffer->allow_user_free = 0;
 			return buffer;
 		}
 	}
@@ -500,7 +496,7 @@ static struct binder_buffer *binder_allo
 
 	rb_erase(best_fit, &alloc->free_buffers);
 	buffer->free = 0;
-	buffer->free_in_progress = 0;
+	buffer->allow_user_free = 0;
 	binder_insert_allocated_buffer_locked(alloc, buffer);
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 		     "%d: binder_alloc_buf size %zd got %pK\n",
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -50,8 +50,7 @@ struct binder_buffer {
 	unsigned free:1;
 	unsigned allow_user_free:1;
 	unsigned async_transaction:1;
-	unsigned free_in_progress:1;
-	unsigned debug_id:28;
+	unsigned debug_id:29;
 
 	struct binder_transaction *transaction;
 


