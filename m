Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55572C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230042087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230042087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeI3ESi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51929 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728704AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H1-NQ; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006t8-Vw; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Grazvydas Ignotas" <notasas@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.64662704@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 053/131] mm: fix regression in remap_file_pages()
 emulation
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit 48f7df329474b49d83d0dffec1b6186647f11976 upstream.

Grazvydas Ignotas has reported a regression in remap_file_pages()
emulation.

Testcase:
	#define _GNU_SOURCE
	#include <assert.h>
	#include <stdlib.h>
	#include <stdio.h>
	#include <sys/mman.h>

	#define SIZE    (4096 * 3)

	int main(int argc, char **argv)
	{
		unsigned long *p;
		long i;

		p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
		if (p == MAP_FAILED) {
			perror("mmap");
			return -1;
		}

		for (i = 0; i < SIZE / 4096; i++)
			p[i * 4096 / sizeof(*p)] = i;

		if (remap_file_pages(p, 4096, 0, 1, 0)) {
			perror("remap_file_pages");
			return -1;
		}

		if (remap_file_pages(p, 4096 * 2, 0, 1, 0)) {
			perror("remap_file_pages");
			return -1;
		}

		assert(p[0] == 1);

		munmap(p, SIZE);

		return 0;
	}

The second remap_file_pages() fails with -EINVAL.

The reason is that remap_file_pages() emulation assumes that the target
vma covers whole area we want to over map.  That assumption is broken by
first remap_file_pages() call: it split the area into two vma.

The solution is to check next adjacent vmas, if they map the same file
with the same flags.

Fixes: c8d78c1823f4 ("mm: replace remap_file_pages() syscall with emulation")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Grazvydas Ignotas <notasas@gmail.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mmap.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2656,12 +2656,29 @@ SYSCALL_DEFINE5(remap_file_pages, unsign
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
 
-	if (start < vma->vm_start || start + size > vma->vm_end)
+	if (start < vma->vm_start)
 		goto out;
 
-	if (pgoff == linear_page_index(vma, start)) {
-		ret = 0;
-		goto out;
+	if (start + size > vma->vm_end) {
+		struct vm_area_struct *next;
+
+		for (next = vma->vm_next; next; next = next->vm_next) {
+			/* hole between vmas ? */
+			if (next->vm_start != next->vm_prev->vm_end)
+				goto out;
+
+			if (next->vm_file != vma->vm_file)
+				goto out;
+
+			if (next->vm_flags != vma->vm_flags)
+				goto out;
+
+			if (start + size <= next->vm_end)
+				break;
+		}
+
+		if (!next)
+			goto out;
 	}
 
 	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
@@ -2671,9 +2688,16 @@ SYSCALL_DEFINE5(remap_file_pages, unsign
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
 	if (vma->vm_flags & VM_LOCKED) {
+		struct vm_area_struct *tmp;
 		flags |= MAP_LOCKED;
+
 		/* drop PG_Mlocked flag for over-mapped range */
-		munlock_vma_pages_range(vma, start, start + size);
+		for (tmp = vma; tmp->vm_start >= start + size;
+				tmp = tmp->vm_next) {
+			munlock_vma_pages_range(tmp,
+					max(tmp->vm_start, start),
+					min(tmp->vm_end, start + size));
+		}
 	}
 
 	file = get_file(vma->vm_file);

