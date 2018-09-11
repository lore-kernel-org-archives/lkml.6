Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B123C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FAA2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FAA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeIKTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:12:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727010AbeIKTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:12:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49D04400C3C8;
        Tue, 11 Sep 2018 14:13:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C376B5500;
        Tue, 11 Sep 2018 14:13:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Sep 2018 16:13:23 +0200 (CEST)
Date:   Tue, 11 Sep 2018 16:13:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180911141318.GA30907@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <20180910171822.GA27005@redhat.com>
 <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLWP4iKwTV3tBcV+nyZAU566qkknhODZdY_7o4p0zWVzQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 11 Sep 2018 14:13:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 11 Sep 2018 14:13:23 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Kees Cook wrote:
>
> I've looked more closely now. So, while I agree with you about
> resource limits, there's a corner case that is better handled here:
> once we've called flush_old_exec(), we can no longer send errors back
> to the parent. We just segfault. So, I think it's better to give a
> resource limit error early, since it is able to do the math early.
>
> If we move acct_arg_size() earlier, then the "immediate" resource
> utilization is checked, but it means it can just segfault later. If we
> leave it as-is, we account for later memory allocations "too early",
> but we'll still not be able to run: but we can tell the parent why.

I don't follow. Could you spell please?

AFAICS, the trivial patch I proposed changes nothing except it fixes the
bprm->pages accounting. The problem is really minor, but this looks confusing
and wrong anyway.

> I prefer leave it as-is.

After this discussion, I strongly disagree.

And now I think we should remove this rlim crap from get_arg_page() altogether
to make the things more clear.

> > Please forget. I meant that _if_ we actually wanted to account this additional
> > memory in bprm->pages, than we would probably need something like
> > acct_arg_size(size/PAGE_SIZE + DIV_ROUND_UP(ptr_size, PAGE_SIZE)).
>
> I'd need to study that more, but that change seems reasonable. :)

Please forget. Not that it matters, but we simply can't account ptr_size
100% correctly if we do this in get_arg_page().

See the patch below. Completely untested, quite possibly wrong, but I think
this is what we should do.

Oleg.


diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5..7804a5c 100644
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
@@ -410,11 +365,6 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	if (!mm)
 		goto err;
 
-	/* Save current stack limit for all calculations made during exec. */
-	task_lock(current->group_leader);
-	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
-	task_unlock(current->group_leader);
-
 	err = __bprm_mm_init(bprm);
 	if (err)
 		goto err;
@@ -492,6 +442,27 @@ static int count(struct user_arg_ptr argv, int max)
 	return i;
 }
 
+static int prepare_rlim_stack(struct linux_binprm *bprm)
+{
+	unsigned long limit, ptr_size;
+
+	task_lock(current->group_leader);
+	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
+	task_unlock(current->group_leader);
+
+	limit = _STK_LIM / 4 * 3;
+	limit = min(limit, bprm->rlim_stack.rlim_cur / 4);
+	limit = max(limit, (unsigned long)ARG_MAX);
+	/* COMMENT */
+	ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
+	if (limit <= ptr_size)
+		return -E2BIG;
+	limit -= ptr_size;
+
+	bprm->p_min = bprm->p - limit;
+	return 0;
+}
+
 /*
  * 'copy_strings()' copies argument/environment strings from the old
  * processes's memory to the new process's stack.  The call to get_user_pages()
@@ -527,6 +498,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
+		if (bprm->p <= bprm->p_min)
+			goto out;
 
 		while (len > 0) {
 			int offset, bytes_to_copy;
@@ -1801,6 +1774,10 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out;
 
+	retval = prepare_rlim_stack(bprm);
+	if (retval < 0)
+		goto out;
+
 	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0)
 		goto out;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c05f24f..423e8c1 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -24,7 +24,7 @@ struct linux_binprm {
 	struct page *page[MAX_ARG_PAGES];
 #endif
 	struct mm_struct *mm;
-	unsigned long p; /* current top of mem */
+	unsigned long p, p_min; /* current top of mem */
 	unsigned int
 		/*
 		 * True after the bprm_set_creds hook has been called once

