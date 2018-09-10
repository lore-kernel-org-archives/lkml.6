Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E790C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77D12087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77D12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeIJRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:23:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbeIJRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED64640216E7;
        Mon, 10 Sep 2018 12:29:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3289963F32;
        Mon, 10 Sep 2018 12:29:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Sep 2018 14:29:10 +0200 (CEST)
Date:   Mon, 10 Sep 2018 14:29:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: get_arg_page() && ptr_size accounting
Message-ID: <20180910122907.GA23963@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 12:29:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 12:29:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I was thinking about backporting the commit 98da7d08850fb8bde
("fs/exec.c: account for argv/envp pointers"), but I am not sure
I understand it...

So get_arg_page() does

		/*
		 * Since the stack will hold pointers to the strings, we
		 * must account for them as well.
		 *
		 * The size calculation is the entire vma while each arg page is
		 * built, so each time we get here it's calculating how far it
		 * is currently (rather than each call being just the newly
		 * added size from the arg page).  As a result, we need to
		 * always add the entire size of the pointers, so that on the
		 * last call to get_arg_page() we'll actually have the entire
		 * correct size.
		 */
		ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
		if (ptr_size > ULONG_MAX - size)
			goto fail;
		size += ptr_size;

OK, but
		acct_arg_size(bprm, size / PAGE_SIZE);

after that doesn't look exactly right. This additional space will be used later
when the process already uses bprm->mm, right? so it shouldn't be accounted by
acct_arg_size().

Not to mention that ptr_size/PAGE_SIZE doesn't look right in any case...

In short. Am I totally confused or the patch below makes sense? This way we do
not need the fat comment.

Oleg.

--- x/fs/exec.c
+++ x/fs/exec.c
@@ -222,25 +222,17 @@ static struct page *get_arg_page(struct
 		unsigned long size = bprm->vma->vm_end - bprm->vma->vm_start;
 		unsigned long ptr_size, limit;
 
+		acct_arg_size(bprm, size / PAGE_SIZE);
+
 		/*
 		 * Since the stack will hold pointers to the strings, we
 		 * must account for them as well.
-		 *
-		 * The size calculation is the entire vma while each arg page is
-		 * built, so each time we get here it's calculating how far it
-		 * is currently (rather than each call being just the newly
-		 * added size from the arg page).  As a result, we need to
-		 * always add the entire size of the pointers, so that on the
-		 * last call to get_arg_page() we'll actually have the entire
-		 * correct size.
 		 */
 		ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
 		if (ptr_size > ULONG_MAX - size)
 			goto fail;
 		size += ptr_size;
 
-		acct_arg_size(bprm, size / PAGE_SIZE);
-
 		/*
 		 * We've historically supported up to 32 pages (ARG_MAX)
 		 * of argument strings even with small stacks

