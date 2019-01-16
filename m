Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC437C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18BD20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfAPGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:34:50 -0500
Received: from nautica.notk.org ([91.121.71.147]:57622 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730938AbfAPGeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:34:50 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B9270C009; Wed, 16 Jan 2019 07:34:45 +0100 (CET)
Date:   Wed, 16 Jan 2019 07:34:30 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190116063430.GA22938@nautica>
References: <20190110070355.GJ27534@dastard>
 <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica>
 <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com>
 <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
 <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica>
 <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Linus Torvalds wrote on Wed, Jan 16, 2019:
> Anybody willing to test the above patch instead? And replace the
> 
>    || capable(CAP_SYS_ADMIN)
> 
> check with something like
> 
>    || inode_permission(inode, MAY_WRITE) == 0
> 
> instead?
> 
> (This is obviously after you've reverted the "only check mmap
> residency" patch..)

That seems to work on an x86_64 vm.

I've tested with the attached patch:
 - root can lookup pages on any file I tried;
 - user can lookup page on file it owns, assuming it can write to it
(e.g. it won't work on a 0400 file you own)
 - user cannot lookup pages on e.g. /lib64/libc-2.28.so

There is a difference with your previous patch though, that used to list
no page in core when it didn't know; this patch lists pages as in core
when it refuses to tell. I don't think that's very important, though.

If anything, the 0400 user-owner file might be a problem in some edge
case (e.g. if you're preloading git directories, many objects are 0444);
should we *also* check ownership?...

-- 
Dominique

--BOKacYhQ+x31HxR3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="mincore.diff"

 mm/mincore.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 218099b5ed31..11ed7064f4eb 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -169,6 +169,13 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
+static inline bool can_do_mincore(struct vm_area_struct *vma)
+{
+	return vma_is_anonymous(vma)
+		|| (vma->vm_file && (vma->vm_file->f_mode & FMODE_WRITE))
+		|| inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+}
+
 /*
  * Do a chunk of "sys_mincore()". We've already checked
  * all the arguments, we hold the mmap semaphore: we should
@@ -189,8 +196,13 @@ static long do_mincore(unsigned long addr, unsigned long pages, unsigned char *v
 	vma = find_vma(current->mm, addr);
 	if (!vma || addr < vma->vm_start)
 		return -ENOMEM;
-	mincore_walk.mm = vma->vm_mm;
 	end = min(vma->vm_end, addr + (pages << PAGE_SHIFT));
+	if (!can_do_mincore(vma)) {
+		unsigned long pages = (end - addr) >> PAGE_SHIFT;
+		memset(vec, 1, pages);
+		return pages;
+	}
+	mincore_walk.mm = vma->vm_mm;
 	err = walk_page_range(addr, end, &mincore_walk);
 	if (err < 0)
 		return err;

--BOKacYhQ+x31HxR3--
