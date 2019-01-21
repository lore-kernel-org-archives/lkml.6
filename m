Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D52BC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A30A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfAUUPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:55614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728315AbfAUUPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A31AAFFE;
        Mon, 21 Jan 2019 20:15:17 +0000 (UTC)
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
Subject: [RFC PATCH v2 12/13] epoll: support mapping for epfd when polled from userspace
Date:   Mon, 21 Jan 2019 21:14:55 +0100
Message-Id: <20190121201456.28338-13-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121201456.28338-1-rpenyaev@suse.de>
References: <20190121201456.28338-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User has to mmap user_header and user_index vmalloce'd pointers in order
to consume events from userspace.  Also we do not let any copies of vma
on fork().

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
 fs/eventpoll.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e70d1ab64ec1..cceeff77bdaf 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1276,11 +1276,47 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static int ep_eventpoll_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct eventpoll *ep = vma->vm_file->private_data;
+	size_t size;
+	int rc;
+
+	if (!ep_polled_by_user(ep))
+		return -ENOTSUPP;
+
+	size = vma->vm_end - vma->vm_start;
+	if (!vma->vm_pgoff && size > ep->header_length)
+		return -ENXIO;
+	if (vma->vm_pgoff && ep->header_length != (vma->vm_pgoff << PAGE_SHIFT))
+		/* Index ring starts exactly after the header */
+		return -ENXIO;
+	if (vma->vm_pgoff && size > ep->index_length)
+		return -ENXIO;
+
+	/*
+	 * vm_pgoff is used *only* for indication, what is mapped: user header
+	 * or user index ring.  Sizes are checked above.
+	 */
+	if (!vma->vm_pgoff)
+		rc = remap_vmalloc_range_partial(vma, vma->vm_start,
+						 ep->user_header, size);
+	else
+		rc = remap_vmalloc_range_partial(vma, vma->vm_start,
+						 ep->user_index, size);
+	if (likely(!rc))
+		/* No copies for forks(), please */
+		vma->vm_flags |= VM_DONTCOPY;
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

