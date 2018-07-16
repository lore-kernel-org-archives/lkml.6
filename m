Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D102EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3DD206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3DD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbeGPIHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:07:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeGPIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:07:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 58DBBCA4;
        Mon, 16 Jul 2018 07:40:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 34/54] fs/proc/task_mmu.c: fix Locked field in /proc/pid/smaps*
Date:   Mon, 16 Jul 2018 09:35:31 +0200
Message-Id: <20180716073457.175756492@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit e70cc2bd579e8a9d6d153762f0fe294d0e652ff0 upstream.

Thomas reports:
 "While looking around in /proc on my v4.14.52 system I noticed that all
  processes got a lot of "Locked" memory in /proc/*/smaps. A lot more
  memory than a regular user can usually lock with mlock().

  Commit 493b0e9d945f (in v4.14-rc1) seems to have changed the behavior
  of "Locked".

  Before that commit the code was like this. Notice the VM_LOCKED check.

           (vma->vm_flags & VM_LOCKED) ?
                (unsigned long)(mss.pss >> (10 + PSS_SHIFT)) : 0);

  After that commit Locked is now the same as Pss:

	  (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));

  This looks like a mistake."

Indeed, the commit has added mss->pss_locked with the correct value that
depends on VM_LOCKED, but forgot to actually use it.  Fix it.

Link: http://lkml.kernel.org/r/ebf6c7fb-fec3-6a26-544f-710ed193c154@suse.cz
Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/task_mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -850,7 +850,7 @@ static int show_smap(struct seq_file *m,
 			   mss->private_hugetlb >> 10,
 			   mss->swap >> 10,
 			   (unsigned long)(mss->swap_pss >> (10 + PSS_SHIFT)),
-			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
+			   (unsigned long)(mss->pss_locked >> (10 + PSS_SHIFT)));
 
 	if (!rollup_mode) {
 		arch_show_smap(m, vma);


