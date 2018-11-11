Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3769C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13820872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zJFkhb29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbeKLIqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403871AbeKLIWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E2F223C8;
        Sun, 11 Nov 2018 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975574;
        bh=KZjLsz0b5dGN/fSW03RPMFHtOGt73g+L+ymvp1RmhXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJFkhb29Si0pNvQWjUSQtFCbXLYOaBKVG20yIPR33Yc7I6DTYlcQXiJPfXAp4U6y/
         JmhpJ+cxl4NwT8XuoKN96517vMQPNUAr9sHO6iSbOulLTF8RMw9OwLvN7nRxCfJeg/
         i/8/Xf2KWf3CEnYpZYprL+saOugta9ad1bSIRsEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?q?Leonardo=20Soares=20M=C3=BCller?= 
        <leozinho29_eu@hotmail.com>, Daniel Colascione <dancol@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 153/222] mm: /proc/pid/smaps_rollup: fix NULL pointer deref in smaps_pte_range()
Date:   Sun, 11 Nov 2018 14:24:10 -0800
Message-Id: <20181111221701.045080094@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit fa76da461bb0be13c8339d984dcf179151167c8f upstream.

Leonardo reports an apparent regression in 4.19-rc7:

 BUG: unable to handle kernel NULL pointer dereference at 00000000000000f0
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 3 PID: 6032 Comm: python Not tainted 4.19.0-041900rc7-lowlatency #201810071631
 Hardware name: LENOVO 80UG/Toronto 4A2, BIOS 0XCN45WW 08/09/2018
 RIP: 0010:smaps_pte_range+0x32d/0x540
 Code: 80 00 00 00 00 74 a9 48 89 de 41 f6 40 52 40 0f 85 04 02 00 00 49 2b 30 48 c1 ee 0c 49 03 b0 98 00 00 00 49 8b 80 a0 00 00 00 <48> 8b b8 f0 00 00 00 e8 b7 ef ec ff 48 85 c0 0f 84 71 ff ff ff a8
 RSP: 0018:ffffb0cbc484fb88 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: 0000560ddb9e9000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000560ddb9e9 RDI: 0000000000000001
 RBP: ffffb0cbc484fbc0 R08: ffff94a5a227a578 R09: ffff94a5a227a578
 R10: 0000000000000000 R11: 0000560ddbbe7000 R12: ffffe903098ba728
 R13: ffffb0cbc484fc78 R14: ffffb0cbc484fcf8 R15: ffff94a5a2e9cf48
 FS:  00007f6dfb683740(0000) GS:ffff94a5aaf80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000000f0 CR3: 000000011c118001 CR4: 00000000003606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  __walk_page_range+0x3c2/0x6f0
  walk_page_vma+0x42/0x60
  smap_gather_stats+0x79/0xe0
  ? gather_pte_stats+0x320/0x320
  ? gather_hugetlb_stats+0x70/0x70
  show_smaps_rollup+0xcd/0x1c0
  seq_read+0x157/0x400
  __vfs_read+0x3a/0x180
  ? security_file_permission+0x93/0xc0
  ? security_file_permission+0x93/0xc0
  vfs_read+0x8f/0x140
  ksys_read+0x55/0xc0
  __x64_sys_read+0x1a/0x20
  do_syscall_64+0x5a/0x110
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Decoded code matched to local compilation+disassembly points to
smaps_pte_entry():

        } else if (unlikely(IS_ENABLED(CONFIG_SHMEM) && mss->check_shmem_swap
                                                        && pte_none(*pte))) {
                page = find_get_entry(vma->vm_file->f_mapping,
                                                linear_page_index(vma, addr));

Here, vma->vm_file is NULL.  mss->check_shmem_swap should be false in that
case, however for smaps_rollup, smap_gather_stats() can set the flag true
for one vma and leave it true for subsequent vma's where it should be
false.

To fix, reset the check_shmem_swap flag to false.  There's also related
bug which sets mss->swap to shmem_swapped, which in the context of
smaps_rollup overwrites any value accumulated from previous vma's.  Fix
that as well.

Note that the report suggests a regression between 4.17.19 and 4.19-rc7,
which makes the 4.19 series ending with commit 258f669e7e88 ("mm:
/proc/pid/smaps_rollup: convert to single value seq_file") suspicious.
But the mss was reused for rollup since 493b0e9d945f ("mm: add
/proc/pid/smaps_rollup") so let's play it safe with the stable backport.

Link: http://lkml.kernel.org/r/555fbd1f-4ac9-0b58-dcd4-5dc4380ff7ca@suse.cz
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201377
Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Leonardo Soares Müller <leozinho29_eu@hotmail.com>
Tested-by: Leonardo Soares Müller <leozinho29_eu@hotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Colascione <dancol@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/task_mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -768,6 +768,8 @@ static int show_smap(struct seq_file *m,
 	smaps_walk.private = mss;
 
 #ifdef CONFIG_SHMEM
+	/* In case of smaps_rollup, reset the value from previous vma */
+	mss->check_shmem_swap = false;
 	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
 		/*
 		 * For shared or readonly shmem mappings we know that all
@@ -783,7 +785,7 @@ static int show_smap(struct seq_file *m,
 
 		if (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
 					!(vma->vm_flags & VM_WRITE)) {
-			mss->swap = shmem_swapped;
+			mss->swap += shmem_swapped;
 		} else {
 			mss->check_shmem_swap = true;
 			smaps_walk.pte_hole = smaps_pte_hole;


