Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBCEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588C214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789862;
	bh=WnDfGkV0S8nQb7W0WIZkwK8GVvIHIuT81j08quzfS90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CQwVuGZ1Ye/WllFVk5GuDBOwNpsK762nIW7PEd19sCB0BXnZj0swf0bcC1QnjO9P
	 DaqmaopFvLYSXnEJtgsG8Vz5jzxDXuDZrfpc9bbEgav3k9JUGko2NsK0pPQjUChzmn
	 +4mLpOiylGXj7yZPZqL9g94TQ4dzSnsPvpGgQB7g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6588C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbeLNMRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732082AbeLNMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342C421486;
        Fri, 14 Dec 2018 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789824;
        bh=WnDfGkV0S8nQb7W0WIZkwK8GVvIHIuT81j08quzfS90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcppGSVLxcho5KDJrhhj/ymBTLruSGZEJk7uN77+aFOhULL/ltozmvl/ngEIUYfnT
         1/4DeCoG2rH304mAOcZCSKs00G5UHG31Y2kmi5a0OqK4boD+CfFXr9YJ7J6OSwBLQW
         4hsL2Zc4ZCsfwqvYesoiciRqYn+yRCV6IkDbYB4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qualys Security Advisory <qsa@qualys.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 83/88] proc: do not access cmdline nor environ from file-backed areas
Date:   Fri, 14 Dec 2018 13:00:57 +0100
Message-Id: <20181214115709.121444634@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willy Tarreau <w@1wt.eu>

commit 7f7ccc2ccc2e70c6054685f5e3522efa81556830 upstream.

proc_pid_cmdline_read() and environ_read() directly access the target
process' VM to retrieve the command line and environment. If this
process remaps these areas onto a file via mmap(), the requesting
process may experience various issues such as extra delays if the
underlying device is slow to respond.

Let's simply refuse to access file-backed areas in these functions.
For this we add a new FOLL_ANON gup flag that is passed to all calls
to access_remote_vm(). The code already takes care of such failures
(including unmapped areas). Accesses via /proc/pid/mem were not
changed though.

This was assigned CVE-2018-1120.

Note for stable backports: the patch may apply to kernels prior to 4.11
but silently miss one location; it must be checked that no call to
access_remote_vm() keeps zero as the last argument.

Reported-by: Qualys Security Advisory <qsa@qualys.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4:
 - Update the extra call to access_remote_vm() from proc_pid_cmdline_read()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c     |   10 +++++-----
 include/linux/mm.h |    1 +
 mm/gup.c           |    3 +++
 3 files changed, 9 insertions(+), 5 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -254,7 +254,7 @@ static ssize_t proc_pid_cmdline_read(str
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_ANON);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -272,7 +272,7 @@ static ssize_t proc_pid_cmdline_read(str
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -307,7 +307,7 @@ static ssize_t proc_pid_cmdline_read(str
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -356,7 +356,7 @@ skip_argv:
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -1006,7 +1006,7 @@ static ssize_t environ_read(struct file
 		max_len = min_t(size_t, PAGE_SIZE, count);
 		this_len = min(max_len, this_len);
 
-		retval = access_remote_vm(mm, (env_start + src), page, this_len, 0);
+		retval = access_remote_vm(mm, (env_start + src), page, this_len, FOLL_ANON);
 
 		if (retval <= 0) {
 			ret = retval;
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2120,6 +2120,7 @@ static inline struct page *follow_page(s
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #define FOLL_MLOCK	0x1000	/* lock present pages */
 #define FOLL_COW	0x4000	/* internal GUP flag */
+#define FOLL_ANON	0x8000	/* don't do file mappings */
 
 typedef int (*pte_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
 			void *data);
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -368,6 +368,9 @@ static int check_vma_flags(struct vm_are
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
+	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
+		return -EFAULT;
+
 	if (gup_flags & FOLL_WRITE) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))


