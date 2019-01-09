Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D36C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C18E2173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfAIQkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:40:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:57778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfAIQko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B39C1B01C;
        Wed,  9 Jan 2019 16:40:42 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/15] epoll: support mapping for epfd when polled from userspace
Date:   Wed,  9 Jan 2019 17:40:25 +0100
Message-Id: <20190109164025.24554-16-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109164025.24554-1-rpenyaev@suse.de>
References: <20190109164025.24554-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User has to mmap user_header and user_index vmalloce'd pointers in order to
consume events from userspace.  Support mapping with possibility to mremap()
in the future, i.e. vma does not have VM_DONTEXPAND flag set.

User mmaps two pointers: header and index in order to expand both calling
mremap().

Expanding is made with support of the fault callback, where page is mmaped
with all appropriate size checks.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5de640fcf28b..2849b238f80b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1388,11 +1388,96 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static vm_fault_t ep_eventpoll_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct eventpoll *ep = vma->vm_file->private_data;
+	size_t off = vmf->address - vma->vm_start;
+	vm_fault_t ret;
+	int rc;
+
+	mutex_lock(&ep->mtx);
+	ret = VM_FAULT_SIGBUS;
+	if (!vma->vm_pgoff) {
+		if (ep->header_length < (off + PAGE_SIZE))
+			goto unlock_and_out;
+
+		rc = remap_vmalloc_range_partial(vma, vmf->address,
+						 ep->user_header + off,
+						 PAGE_SIZE);
+	} else {
+		if (ep->index_length < (off + PAGE_SIZE))
+			goto unlock_and_out;
+
+		rc = remap_vmalloc_range_partial(vma, vmf->address,
+						 ep->user_index + off,
+						 PAGE_SIZE);
+	}
+	if (likely(!rc)) {
+		/* Success path */
+		vma->vm_flags &= ~VM_DONTEXPAND;
+		ret = VM_FAULT_NOPAGE;
+	}
+unlock_and_out:
+	mutex_unlock(&ep->mtx);
+
+	return ret;
+}
+
+static const struct vm_operations_struct eventpoll_vm_ops = {
+	.fault = ep_eventpoll_fault,
+};
+
+static int ep_eventpoll_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct eventpoll *ep = vma->vm_file->private_data;
+	size_t size;
+	int rc;
+
+	if (!ep_polled_by_user(ep))
+		return -ENOTSUPP;
+
+	mutex_lock(&ep->mtx);
+	rc = -ENXIO;
+	size = vma->vm_end - vma->vm_start;
+	if (!vma->vm_pgoff && size > ep->header_length)
+		goto unlock_and_out;
+	if (vma->vm_pgoff && ep->header_length != (vma->vm_pgoff << PAGE_SHIFT))
+		/*
+		 * Index ring starts exactly after header. In future vm_pgoff
+		 * is not used, only as indication what kernel ptr is mapped.
+		 */
+		goto unlock_and_out;
+	if (vma->vm_pgoff && size > ep->index_length)
+		goto unlock_and_out;
+
+	/*
+	 * vm_pgoff is used *only* for indication, what is mapped: user header
+	 * or user index ring.
+	 */
+	if (!vma->vm_pgoff)
+		rc = remap_vmalloc_range_partial(vma, vma->vm_start,
+						 ep->user_header, size);
+	else
+		rc = remap_vmalloc_range_partial(vma, vma->vm_start,
+						 ep->user_index, size);
+
+	if (likely(!rc)) {
+		vma->vm_flags &= ~VM_DONTEXPAND;
+		vma->vm_ops = &eventpoll_vm_ops;
+	}
+unlock_and_out:
+	mutex_unlock(&ep->mtx);
+
+	return rc;
+}
+
 /* File callbacks that implement the eventpoll file behaviour */
 static const struct file_operations eventpoll_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= ep_show_fdinfo,
 #endif
+	.mmap		= ep_eventpoll_mmap,
 	.release	= ep_eventpoll_release,
 	.poll		= ep_eventpoll_poll,
 	.llseek		= noop_llseek,
-- 
2.19.1

