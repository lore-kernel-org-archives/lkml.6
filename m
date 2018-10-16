Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0259C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954421476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y4GM5KnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6954421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeJQBHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbeJQBHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0252098A;
        Tue, 16 Oct 2018 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710181;
        bh=I6yh94OYvd/CMuYVsHRNL4AqJQd1oEL4rEN7zryP3MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4GM5KnAR6cNfUoeg71maapYQFl3LEGsYdlH4xJQIwSVxxCWrzEc+IWrIIz2hLpIu
         yDZMExQAE0T9HT3sY5Z4PSgk3uUQJp/cE2ZFVIWcn21W4vnZhLjcVQJcxlbqRZfVYR
         8CSXd5XF7IVBvs8yL1IHIsunTqYj4UTvaGWmjmgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.18 131/135] mm/mmap.c: dont clobber partially overlapping VMA with MAP_FIXED_NOREPLACE
Date:   Tue, 16 Oct 2018 19:06:01 +0200
Message-Id: <20181016170524.323282659@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 7aa867dd89526e9cfd9714d8b9b587c016eaea34 upstream.

Daniel Micay reports that attempting to use MAP_FIXED_NOREPLACE in an
application causes that application to randomly crash.  The existing check
for handling MAP_FIXED_NOREPLACE looks up the first VMA that either
overlaps or follows the requested region, and then bails out if that VMA
overlaps *the start* of the requested region.  It does not bail out if the
VMA only overlaps another part of the requested region.

Fix it by checking that the found VMA only starts at or after the end of
the requested region, in which case there is no overlap.

Test case:

user@debian:~$ cat mmap_fixed_simple.c
#include <sys/mman.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifndef MAP_FIXED_NOREPLACE
#define MAP_FIXED_NOREPLACE 0x100000
#endif

int main(void) {
  char *p;

  errno = 0;
  p = mmap((void*)0x10001000, 0x4000, PROT_NONE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
  printf("p1=%p err=%m\n", p);

  errno = 0;
  p = mmap((void*)0x10000000, 0x2000, PROT_READ,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
  printf("p2=%p err=%m\n", p);

  char cmd[100];
  sprintf(cmd, "cat /proc/%d/maps", getpid());
  system(cmd);

  return 0;
}
user@debian:~$ gcc -o mmap_fixed_simple mmap_fixed_simple.c
user@debian:~$ ./mmap_fixed_simple
p1=0x10001000 err=Success
p2=0x10000000 err=Success
10000000-10002000 r--p 00000000 00:00 0
10002000-10005000 ---p 00000000 00:00 0
564a9a06f000-564a9a070000 r-xp 00000000 fe:01 264004
  /home/user/mmap_fixed_simple
564a9a26f000-564a9a270000 r--p 00000000 fe:01 264004
  /home/user/mmap_fixed_simple
564a9a270000-564a9a271000 rw-p 00001000 fe:01 264004
  /home/user/mmap_fixed_simple
564a9a54a000-564a9a56b000 rw-p 00000000 00:00 0                          [heap]
7f8eba447000-7f8eba5dc000 r-xp 00000000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba5dc000-7f8eba7dc000 ---p 00195000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba7dc000-7f8eba7e0000 r--p 00195000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba7e0000-7f8eba7e2000 rw-p 00199000 fe:01 405885
  /lib/x86_64-linux-gnu/libc-2.24.so
7f8eba7e2000-7f8eba7e6000 rw-p 00000000 00:00 0
7f8eba7e6000-7f8eba809000 r-xp 00000000 fe:01 405876
  /lib/x86_64-linux-gnu/ld-2.24.so
7f8eba9e9000-7f8eba9eb000 rw-p 00000000 00:00 0
7f8ebaa06000-7f8ebaa09000 rw-p 00000000 00:00 0
7f8ebaa09000-7f8ebaa0a000 r--p 00023000 fe:01 405876
  /lib/x86_64-linux-gnu/ld-2.24.so
7f8ebaa0a000-7f8ebaa0b000 rw-p 00024000 fe:01 405876
  /lib/x86_64-linux-gnu/ld-2.24.so
7f8ebaa0b000-7f8ebaa0c000 rw-p 00000000 00:00 0
7ffcc99fa000-7ffcc9a1b000 rw-p 00000000 00:00 0                          [stack]
7ffcc9b44000-7ffcc9b47000 r--p 00000000 00:00 0                          [vvar]
7ffcc9b47000-7ffcc9b49000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
  [vsyscall]
user@debian:~$ uname -a
Linux debian 4.19.0-rc6+ #181 SMP Wed Oct 3 23:43:42 CEST 2018 x86_64 GNU/Linux
user@debian:~$

As you can see, the first page of the mapping at 0x10001000 was clobbered.

Link: http://lkml.kernel.org/r/20181010152736.99475-1-jannh@google.com
Fixes: a4ff8e8620d3 ("mm: introduce MAP_FIXED_NOREPLACE")
Signed-off-by: Jann Horn <jannh@google.com>
Reported-by: Daniel Micay <danielmicay@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1410,7 +1410,7 @@ unsigned long do_mmap(struct file *file,
 	if (flags & MAP_FIXED_NOREPLACE) {
 		struct vm_area_struct *vma = find_vma(mm, addr);
 
-		if (vma && vma->vm_start <= addr)
+		if (vma && vma->vm_start < addr + len)
 			return -EEXIST;
 	}
 


