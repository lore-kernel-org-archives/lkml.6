Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C23EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ED120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ED120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeILT23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:28:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeILT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:28:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60371804BAAD;
        Wed, 12 Sep 2018 14:23:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E21F10DCF45;
        Wed, 12 Sep 2018 14:23:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Sep 2018 16:23:44 +0200 (CEST)
Date:   Wed, 12 Sep 2018 16:23:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180912142341.GA3966@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <20180910171822.GA27005@redhat.com>
 <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
 <20180911141318.GA30907@redhat.com>
 <CAGXu5jLYWUMFNFaWHTmn9qhArtw7rn376rLRjfg6cdrvYNKUTg@mail.gmail.com>
 <20180912122702.GA16972@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912122702.GA16972@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 14:23:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 14:23:44 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12, Oleg Nesterov wrote:
>
> it's pity. cause this means I will have to actually test this change and
> (worse) write the changelog ;)

Seems to work, see v2 below, I tried to address your comments.

The new helper is prepare_arg_pages(), matches setup_arg_pages/shift_arg_pages.

s/p_min/argmin/. Or please suggest a better name and/or comment.

I still think the new helper should absorb the bprm->rlim_stack inititialization,
it is called right after bprm_mm_init() and I see no reason why arch_bprm_mm_init()
should ever look at rlim_stack, but this is minor and I won't insist.

If you do not see any problems I'll try to force myself to write the changelog
tomorrow.

Oleg.


diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5..9a892ac 100644
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
index c05f24f..5ffc8da 100644
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

