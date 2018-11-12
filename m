Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D0522419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D0522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeKMCDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:03:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeKMCDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:03:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A2D1C049588;
        Mon, 12 Nov 2018 16:09:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9776600D6;
        Mon, 12 Nov 2018 16:09:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 12 Nov 2018 17:09:11 +0100 (CET)
Date:   Mon, 12 Nov 2018 17:09:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
Message-ID: <20181112160910.GA28440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 12 Nov 2018 16:09:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_arg_page() checks bprm->rlim_stack.rlim_cur and re-calculates the
"extra" size for argv/envp pointers every time, this is a bit ugly and
even not strictly correct: acct_arg_size() must not account this size.

Remove all the rlimit code in get_arg_page(). Instead, add bprm->argmin
calculated once at the start of __do_execve_file() and change copy_strings
to check bprm->p >= bprm->argmin.

The patch adds the new helper, prepare_arg_pages() which initializes
bprm->argc/envc and bprm->argmin.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c               | 103 +++++++++++++++++++++++-------------------------
 include/linux/binfmts.h |   1 +
 2 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fc281b7..61a5460 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -218,55 +218,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	if (ret <= 0)
 		return NULL;
 
-	if (write) {
-		unsigned long size = bprm->vma->vm_end - bprm->vma->vm_start;
-		unsigned long ptr_size, limit;
-
-		/*
-		 * Since the stack will hold pointers to the strings, we
-		 * must account for them as well.
-		 *
-		 * The size calculation is the entire vma while each arg page is
-		 * built, so each time we get here it's calculating how far it
-		 * is currently (rather than each call being just the newly
-		 * added size from the arg page).  As a result, we need to
-		 * always add the entire size of the pointers, so that on the
-		 * last call to get_arg_page() we'll actually have the entire
-		 * correct size.
-		 */
-		ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
-		if (ptr_size > ULONG_MAX - size)
-			goto fail;
-		size += ptr_size;
-
-		acct_arg_size(bprm, size / PAGE_SIZE);
-
-		/*
-		 * We've historically supported up to 32 pages (ARG_MAX)
-		 * of argument strings even with small stacks
-		 */
-		if (size <= ARG_MAX)
-			return page;
-
-		/*
-		 * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
-		 * (whichever is smaller) for the argv+env strings.
-		 * This ensures that:
-		 *  - the remaining binfmt code will not run out of stack space,
-		 *  - the program will have a reasonable amount of stack left
-		 *    to work from.
-		 */
-		limit = _STK_LIM / 4 * 3;
-		limit = min(limit, bprm->rlim_stack.rlim_cur / 4);
-		if (size > limit)
-			goto fail;
-	}
+	if (write)
+		acct_arg_size(bprm, vma_pages(bprm->vma));
 
 	return page;
-
-fail:
-	put_page(page);
-	return NULL;
 }
 
 static void put_arg_page(struct page *page)
@@ -492,6 +447,50 @@ static int count(struct user_arg_ptr argv, int max)
 	return i;
 }
 
+static int prepare_arg_pages(struct linux_binprm *bprm,
+			struct user_arg_ptr argv, struct user_arg_ptr envp)
+{
+	unsigned long limit, ptr_size;
+
+	bprm->argc = count(argv, MAX_ARG_STRINGS);
+	if (bprm->argc < 0)
+		return bprm->argc;
+
+	bprm->envc = count(envp, MAX_ARG_STRINGS);
+	if (bprm->envc < 0)
+		return bprm->envc;
+
+	/*
+	 * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
+	 * (whichever is smaller) for the argv+env strings.
+	 * This ensures that:
+	 *  - the remaining binfmt code will not run out of stack space,
+	 *  - the program will have a reasonable amount of stack left
+	 *    to work from.
+	 */
+	limit = _STK_LIM / 4 * 3;
+	limit = min(limit, bprm->rlim_stack.rlim_cur / 4);
+	/*
+	 * We've historically supported up to 32 pages (ARG_MAX)
+	 * of argument strings even with small stacks
+	 */
+	limit = max(limit, (unsigned long)ARG_MAX);
+	/*
+	 * We must account for the size of all the argv and envp pointers to
+	 * the argv and envp strings, since they will also take up space in
+	 * the stack. They aren't stored until much later when we can't
+	 * signal to the parent that the child has run out of stack space.
+	 * Instead, calculate it here so it's possible to fail gracefully.
+	 */
+	ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
+	if (limit <= ptr_size)
+		return -E2BIG;
+	limit -= ptr_size;
+
+	bprm->argmin = bprm->p - limit;
+	return 0;
+}
+
 /*
  * 'copy_strings()' copies argument/environment strings from the old
  * processes's memory to the new process's stack.  The call to get_user_pages()
@@ -527,6 +526,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
+		if (bprm->p < bprm->argmin)
+			goto out;
 
 		while (len > 0) {
 			int offset, bytes_to_copy;
@@ -1789,12 +1790,8 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval)
 		goto out_unmark;
 
-	bprm->argc = count(argv, MAX_ARG_STRINGS);
-	if ((retval = bprm->argc) < 0)
-		goto out;
-
-	bprm->envc = count(envp, MAX_ARG_STRINGS);
-	if ((retval = bprm->envc) < 0)
+	retval = prepare_arg_pages(bprm, argv, envp);
+	if (retval < 0)
 		goto out;
 
 	retval = prepare_binprm(bprm);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index e9f5fe6..03200a8 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -25,6 +25,7 @@ struct linux_binprm {
 #endif
 	struct mm_struct *mm;
 	unsigned long p; /* current top of mem */
+	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
 		/*
 		 * True after the bprm_set_creds hook has been called once
-- 
2.5.0


