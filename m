Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1XtEEWxZGVuMCAAAmS7hNA
	; Thu, 07 Jun 2018 16:13:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 718D7607E7; Thu,  7 Jun 2018 16:13:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0A53605A2;
	Thu,  7 Jun 2018 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0A53605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeFGQMm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:12:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39158 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932962AbeFGOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zr-9s; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002gk-9F; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Miao Xie" <miaoxie@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "David Rientjes" <rientjes@google.com>,
        "Carsten Otte" <cotte@de.ibm.com>, "Shaohua Li" <shli@fb.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Anshuman Khandual" <khandual@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rik van Riel" <riel@redhat.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "guoxuenan" <guoxuenan@huawei.com>,
        "Minchan Kim" <minchan@kernel.org>, "chenjie" <chenjie6@huawei.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.948186959@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 009/410] mm/madvise.c: fix madvise() infinite loop
 under special circumstances
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: chenjie <chenjie6@huawei.com>

commit 6ea8d958a2c95a1d514015d4e29ba21a8c0a1a91 upstream.

MADVISE_WILLNEED has always been a noop for DAX (formerly XIP) mappings.
Unfortunately madvise_willneed() doesn't communicate this information
properly to the generic madvise syscall implementation.  The calling
convention is quite subtle there.  madvise_vma() is supposed to either
return an error or update &prev otherwise the main loop will never
advance to the next vma and it will keep looping for ever without a way
to get out of the kernel.

It seems this has been broken since introduction.  Nobody has noticed
because nobody seems to be using MADVISE_WILLNEED on these DAX mappings.

[mhocko@suse.com: rewrite changelog]
Link: http://lkml.kernel.org/r/20171127115318.911-1-guoxuenan@huawei.com
Fixes: fe77ba6f4f97 ("[PATCH] xip: madvice/fadvice: execute in place")
Signed-off-by: chenjie <chenjie6@huawei.com>
Signed-off-by: guoxuenan <guoxuenan@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: zhangyi (F) <yi.zhang@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Shaohua Li <shli@fb.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -221,9 +221,9 @@ static long madvise_willneed(struct vm_a
 {
 	struct file *file = vma->vm_file;
 
+	*prev = vma;
 #ifdef CONFIG_SWAP
 	if (!file || mapping_cap_swap_backed(file->f_mapping)) {
-		*prev = vma;
 		if (!file)
 			force_swapin_readahead(vma, start, end);
 		else
@@ -241,7 +241,6 @@ static long madvise_willneed(struct vm_a
 		return 0;
 	}
 
-	*prev = vma;
 	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	if (end > vma->vm_end)
 		end = vma->vm_end;
