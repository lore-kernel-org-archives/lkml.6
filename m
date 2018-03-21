Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeCUTXh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:23:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753153AbeCUTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:23:30 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 05/32] docs/vm: highmem.txt: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:21 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0040-0000-0000-00000443E0A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0041-0000-0000-000020E705C1
Message-Id: <1521660168-14372-6-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/highmem.txt | 87 ++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/Documentation/vm/highmem.txt b/Documentation/vm/highmem.txt
index 4324d24..0f69a9f 100644
--- a/Documentation/vm/highmem.txt
+++ b/Documentation/vm/highmem.txt
@@ -1,25 +1,14 @@
+.. _highmem:
 
-			     ====================
-			     HIGH MEMORY HANDLING
-			     ====================
+====================
+High Memory Handling
+====================
 
 By: Peter Zijlstra <a.p.zijlstra@chello.nl>
 
-Contents:
-
- (*) What is high memory?
-
- (*) Temporary virtual mappings.
-
- (*) Using kmap_atomic.
-
- (*) Cost of temporary mappings.
-
- (*) i386 PAE.
+.. contents:: :local:
 
-
-====================
-WHAT IS HIGH MEMORY?
+What Is High Memory?
 ====================
 
 High memory (highmem) is used when the size of physical memory approaches or
@@ -38,7 +27,7 @@ kernel entry/exit.  This means the available virtual memory space (4GiB on
 i386) has to be divided between user and kernel space.
 
 The traditional split for architectures using this approach is 3:1, 3GiB for
-userspace and the top 1GiB for kernel space:
+userspace and the top 1GiB for kernel space::
 
 		+--------+ 0xffffffff
 		| Kernel |
@@ -58,40 +47,38 @@ and user maps.  Some hardware (like some ARMs), however, have limited virtual
 space when they use mm context tags.
 
 
-==========================
-TEMPORARY VIRTUAL MAPPINGS
+Temporary Virtual Mappings
 ==========================
 
 The kernel contains several ways of creating temporary mappings:
 
- (*) vmap().  This can be used to make a long duration mapping of multiple
-     physical pages into a contiguous virtual space.  It needs global
-     synchronization to unmap.
+* vmap().  This can be used to make a long duration mapping of multiple
+  physical pages into a contiguous virtual space.  It needs global
+  synchronization to unmap.
 
- (*) kmap().  This permits a short duration mapping of a single page.  It needs
-     global synchronization, but is amortized somewhat.  It is also prone to
-     deadlocks when using in a nested fashion, and so it is not recommended for
-     new code.
+* kmap().  This permits a short duration mapping of a single page.  It needs
+  global synchronization, but is amortized somewhat.  It is also prone to
+  deadlocks when using in a nested fashion, and so it is not recommended for
+  new code.
 
- (*) kmap_atomic().  This permits a very short duration mapping of a single
-     page.  Since the mapping is restricted to the CPU that issued it, it
-     performs well, but the issuing task is therefore required to stay on that
-     CPU until it has finished, lest some other task displace its mappings.
+* kmap_atomic().  This permits a very short duration mapping of a single
+  page.  Since the mapping is restricted to the CPU that issued it, it
+  performs well, but the issuing task is therefore required to stay on that
+  CPU until it has finished, lest some other task displace its mappings.
 
-     kmap_atomic() may also be used by interrupt contexts, since it is does not
-     sleep and the caller may not sleep until after kunmap_atomic() is called.
+  kmap_atomic() may also be used by interrupt contexts, since it is does not
+  sleep and the caller may not sleep until after kunmap_atomic() is called.
 
-     It may be assumed that k[un]map_atomic() won't fail.
+  It may be assumed that k[un]map_atomic() won't fail.
 
 
-=================
-USING KMAP_ATOMIC
+Using kmap_atomic
 =================
 
 When and where to use kmap_atomic() is straightforward.  It is used when code
 wants to access the contents of a page that might be allocated from high memory
 (see __GFP_HIGHMEM), for example a page in the pagecache.  The API has two
-functions, and they can be used in a manner similar to the following:
+functions, and they can be used in a manner similar to the following::
 
 	/* Find the page of interest. */
 	struct page *page = find_get_page(mapping, offset);
@@ -109,7 +96,7 @@ Note that the kunmap_atomic() call takes the result of the kmap_atomic() call
 not the argument.
 
 If you need to map two pages because you want to copy from one page to
-another you need to keep the kmap_atomic calls strictly nested, like:
+another you need to keep the kmap_atomic calls strictly nested, like::
 
 	vaddr1 = kmap_atomic(page1);
 	vaddr2 = kmap_atomic(page2);
@@ -120,8 +107,7 @@ another you need to keep the kmap_atomic calls strictly nested, like:
 	kunmap_atomic(vaddr1);
 
 
-==========================
-COST OF TEMPORARY MAPPINGS
+Cost of Temporary Mappings
 ==========================
 
 The cost of creating temporary mappings can be quite high.  The arch has to
@@ -136,25 +122,24 @@ If CONFIG_MMU is not set, then there can be no temporary mappings and no
 highmem.  In such a case, the arithmetic approach will also be used.
 
 
-========
 i386 PAE
 ========
 
 The i386 arch, under some circumstances, will permit you to stick up to 64GiB
 of RAM into your 32-bit machine.  This has a number of consequences:
 
- (*) Linux needs a page-frame structure for each page in the system and the
-     pageframes need to live in the permanent mapping, which means:
+* Linux needs a page-frame structure for each page in the system and the
+  pageframes need to live in the permanent mapping, which means:
 
- (*) you can have 896M/sizeof(struct page) page-frames at most; with struct
-     page being 32-bytes that would end up being something in the order of 112G
-     worth of pages; the kernel, however, needs to store more than just
-     page-frames in that memory...
+* you can have 896M/sizeof(struct page) page-frames at most; with struct
+  page being 32-bytes that would end up being something in the order of 112G
+  worth of pages; the kernel, however, needs to store more than just
+  page-frames in that memory...
 
- (*) PAE makes your page tables larger - which slows the system down as more
-     data has to be accessed to traverse in TLB fills and the like.  One
-     advantage is that PAE has more PTE bits and can provide advanced features
-     like NX and PAT.
+* PAE makes your page tables larger - which slows the system down as more
+  data has to be accessed to traverse in TLB fills and the like.  One
+  advantage is that PAE has more PTE bits and can provide advanced features
+  like NX and PAT.
 
 The general recommendation is that you don't use more than 8GiB on a 32-bit
 machine - although more might work for you and your workload, you're pretty
-- 
2.7.4
