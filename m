Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC5ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D263F2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D263F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbeIREm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:42:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbeIREm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:42:29 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 945D5707;
        Mon, 17 Sep 2018 23:12:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 109/158] powerpc/mm: Dont report PUDs as memory leaks when using kmemleak
Date:   Tue, 18 Sep 2018 00:42:19 +0200
Message-Id: <20180917211716.305746233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit a984506c542e26b31cbb446438f8439fa2253b2e ]

Paul Menzel reported that kmemleak was producing reports such as:

  unreferenced object 0xc0000000f8b80000 (size 16384):
    comm "init", pid 1, jiffies 4294937416 (age 312.240s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<00000000d997deb7>] __pud_alloc+0x80/0x190
      [<0000000087f2e8a3>] move_page_tables+0xbac/0xdc0
      [<00000000091e51c2>] shift_arg_pages+0xc0/0x210
      [<00000000ab88670c>] setup_arg_pages+0x22c/0x2a0
      [<0000000060871529>] load_elf_binary+0x41c/0x1648
      [<00000000ecd9d2d4>] search_binary_handler.part.11+0xbc/0x280
      [<0000000034e0cdd7>] __do_execve_file.isra.13+0x73c/0x940
      [<000000005f953a6e>] sys_execve+0x58/0x70
      [<000000009700a858>] system_call+0x5c/0x70

Indicating that a PUD was being leaked.

However what's really happening is that kmemleak is not able to
recognise the references from the PGD to the PUD, because they are not
fully qualified pointers.

We can confirm that in xmon, eg:

Find the task struct for pid 1 "init":
  0:mon> P
       task_struct     ->thread.ksp    PID   PPID S  P CMD
  c0000001fe7c0000 c0000001fe803960      1      0 S 13 systemd

Dump virtual address 0 to find the PGD:
  0:mon> dv 0 c0000001fe7c0000
  pgd  @ 0xc0000000f8b01000

Dump the memory of the PGD:
  0:mon> d c0000000f8b01000
  c0000000f8b01000 00000000f8b90000 0000000000000000  |................|
  c0000000f8b01010 0000000000000000 0000000000000000  |................|
  c0000000f8b01020 0000000000000000 0000000000000000  |................|
  c0000000f8b01030 0000000000000000 00000000f8b80000  |................|
                                    ^^^^^^^^^^^^^^^^

There we can see the reference to our supposedly leaked PUD. But
because it's missing the leading 0xc, kmemleak won't recognise it.

We can confirm it's still in use by translating an address that is
mapped via it:
  0:mon> dv 7fff94000000 c0000001fe7c0000
  pgd  @ 0xc0000000f8b01000
  pgdp @ 0xc0000000f8b01038 = 0x00000000f8b80000 <--
  pudp @ 0xc0000000f8b81ff8 = 0x00000000037c4000
  pmdp @ 0xc0000000037c5ca0 = 0x00000000fbd89000
  ptep @ 0xc0000000fbd89000 = 0xc0800001d5ce0386
  Maps physical address = 0x00000001d5ce0000
  Flags = Accessed Dirty Read Write

The fix is fairly simple. We need to tell kmemleak to ignore PUD
allocations and never report them as leaks. We can also tell it not to
scan the PGD, because it will never find pointers in there. However it
will still notice if we allocate a PGD and then leak it.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/cpumask.h>
+#include <linux/kmemleak.h>
 #include <linux/percpu.h>
 
 struct vmemmap_backing {
@@ -83,6 +84,13 @@ static inline pgd_t *pgd_alloc(struct mm
 	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			       pgtable_gfp_flags(mm, GFP_KERNEL));
 	/*
+	 * Don't scan the PGD for pointers, it contains references to PUDs but
+	 * those references are not full pointers and so can't be recognised by
+	 * kmemleak.
+	 */
+	kmemleak_no_scan(pgd);
+
+	/*
 	 * With hugetlb, we don't clear the second half of the page table.
 	 * If we share the same slab cache with the pmd or pud level table,
 	 * we need to make sure we zero out the full table on alloc.
@@ -110,8 +118,19 @@ static inline void pgd_populate(struct m
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	pud_t *pud;
+
+	pud = kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	/*
+	 * Tell kmemleak to ignore the PUD, that means don't scan it for
+	 * pointers and don't consider it a leak. PUDs are typically only
+	 * referred to by their PGD, but kmemleak is not able to recognise those
+	 * as pointers, leading to false leak reports.
+	 */
+	kmemleak_ignore(pud);
+
+	return pud;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)


