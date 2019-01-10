Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B35C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E14208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2J5Tv54q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfAJVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:10:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfAJVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:10:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8rRw187057;
        Thu, 10 Jan 2019 21:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=JDJoZD2EIKANFxPEYRygSfFIJ9iOJNE0dGwXm4NZjdk=;
 b=2J5Tv54qxbxR5QvLQqBI3iDhoLfLGdcO5W8crUhx7wlVqhiGV3K8pAkk2SPaFpx4lyUP
 +T3gNZ5GivaWCpAlVQB/O0dxfnjQAhbdSsnkCXK1QKLy3j6s7jqQnbr7xRKHa02w2HMR
 56EIJChxZYAwVPjLn+d2XK/unU+fdVvftO4adTLkjMecycFP9mSkGkw+DEyLq8zUwBPe
 ju52rBo8QJHBKacZ1hm+RUgelbX2H6JGnXYh5c79hCz4nC7nUojzTzJ7HCvEjgFoc8Fr
 5Q1AgGJDIS+kF0/IM5w+sjf32pN+C5TkzKlQaDAa7+s3PwwM+fGFLEICjSiQWNDo7txv 6Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2ptj3e9tfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALA81p010006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:08 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ALA5cV003581;
        Thu, 10 Jan 2019 21:10:05 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:04 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com, konrad.wilk@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v7 00/16] Add support for eXclusive Page Frame Ownership
Date:   Thu, 10 Jan 2019 14:09:32 -0700
Message-Id: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am continuing to build on the work Juerg, Tycho and Julian have done
on XPFO. After the last round of updates, we were seeing very
significant performance penalties when stale TLB entries were flushed
actively after an XPFO TLB update. Benchmark for measuring performance
is kernel build using parallel make. To get full protection from
ret2dir attackes, we must flush stale TLB entries. Performance
penalty from flushing stale TLB entries goes up as the number of
cores goes up. On a desktop class machine with only 4 cores,
enabling TLB flush for stale entries causes system time for "make
-j4" to go up by a factor of 2.614x but on a larger machine with 96
cores, system time with "make -j60" goes up by a factor of 26.366x!
I have been working on reducing this performance penalty.

I implemented a solution to reduce performance penalty and
that has had large impact. When XPFO code flushes stale TLB entries,
it does so for all CPUs on the system which may include CPUs that
may not have any matching TLB entries or may never be scheduled to
run the userspace task causing TLB flush. Problem is made worse by
the fact that if number of entries being flushed exceeds
tlb_single_page_flush_ceiling, it results in a full TLB flush on
every CPU. A rogue process can launch a ret2dir attack only from a
CPU that has dual mapping for its pages in physmap in its TLB. We
can hence defer TLB flush on a CPU until a process that would have
caused a TLB flush is scheduled on that CPU. I have added a cpumask
to task_struct which is then used to post pending TLB flush on CPUs
other than the one a process is running on. This cpumask is checked
when a process migrates to a new CPU and TLB is flushed at that
time. I measured system time for parallel make with unmodified 4.20
kernel, 4.20 with XPFO patches before this optimization and then
again after applying this optimization. Here are the results:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

4.20				915.183s
4.20+XPFO			24129.354s	26.366x
4.20+XPFO+Deferred flush	1216.987s	 1.330xx


Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

4.20				607.671s
4.20+XPFO			1588.646s	2.614x
4.20+XPFO+Deferred flush	794.473s	1.307xx

30+% overhead is still very high and there is room for improvement.
Dave Hansen had suggested batch updating TLB entries and Tycho had
created an initial implementation but I have not been able to get
that to work correctly. I am still working on it and I suspect we
will see a noticeable improvement in performance with that. In the
code I added, I post a pending full TLB flush to all other CPUs even
when number of TLB entries being flushed on current CPU does not
exceed tlb_single_page_flush_ceiling. There has to be a better way
to do this. I just haven't found an efficient way to implemented
delayed limited TLB flush on other CPUs.

I am not entirely sure if switch_mm_irqs_off() is indeed the right
place to perform the pending TLB flush for a CPU. Any feedback on
that will be very helpful. Delaying full TLB flushes on other CPUs
seems to help tremendously, so if there is a better way to implement
the same thing than what I have done in patch 16, I am open to
ideas.

Performance with this patch set is good enough to use these as
starting point for further refinement before we merge it into main
kernel, hence RFC.

Since not flushing stale TLB entries creates a false sense of
security, I would recommend making TLB flush mandatory and eliminate
the "xpfotlbflush" kernel parameter (patch "mm, x86: omit TLB
flushing by default for XPFO page table modifications").

What remains to be done beyond this patch series:

1. Performance improvements
2. Remove xpfotlbflush parameter
3. Re-evaluate the patch "arm64/mm: Add support for XPFO to swiotlb"
   from Juerg. I dropped it for now since swiotlb code for ARM has
   changed a lot in 4.20.
4. Extend the patch "xpfo, mm: Defer TLB flushes for non-current
   CPUs" to other architectures besides x86.


---------------------------------------------------------

Juerg Haefliger (5):
  mm, x86: Add support for eXclusive Page Frame Ownership (XPFO)
  swiotlb: Map the buffer if it was unmapped by XPFO
  arm64/mm: Add support for XPFO
  arm64/mm, xpfo: temporarily map dcache regions
  lkdtm: Add test for XPFO

Julian Stecklina (4):
  mm, x86: omit TLB flushing by default for XPFO page table
    modifications
  xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION
  xpfo, mm: optimize spinlock usage in xpfo_kunmap
  EXPERIMENTAL: xpfo, mm: optimize spin lock usage in xpfo_kmap

Khalid Aziz (2):
  xpfo, mm: Fix hang when booting with "xpfotlbflush"
  xpfo, mm: Defer TLB flushes for non-current CPUs (x86 only)

Tycho Andersen (5):
  mm: add MAP_HUGETLB support to vm_mmap
  x86: always set IF before oopsing from page fault
  xpfo: add primitives for mapping underlying memory
  arm64/mm: disable section/contiguous mappings if XPFO is enabled
  mm: add a user_virt_to_phys symbol

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/mm/Makefile                        |   2 +
 arch/arm64/mm/flush.c                         |   7 +
 arch/arm64/mm/mmu.c                           |   2 +-
 arch/arm64/mm/xpfo.c                          |  58 ++++
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/pgtable.h                |  26 ++
 arch/x86/include/asm/tlbflush.h               |   1 +
 arch/x86/mm/Makefile                          |   2 +
 arch/x86/mm/fault.c                           |  10 +
 arch/x86/mm/pageattr.c                        |  23 +-
 arch/x86/mm/tlb.c                             |  27 ++
 arch/x86/mm/xpfo.c                            | 171 ++++++++++++
 drivers/misc/lkdtm/Makefile                   |   1 +
 drivers/misc/lkdtm/core.c                     |   3 +
 drivers/misc/lkdtm/lkdtm.h                    |   5 +
 drivers/misc/lkdtm/xpfo.c                     | 194 ++++++++++++++
 include/linux/highmem.h                       |  15 +-
 include/linux/mm.h                            |   2 +
 include/linux/mm_types.h                      |   8 +
 include/linux/page-flags.h                    |  13 +
 include/linux/sched.h                         |   9 +
 include/linux/xpfo.h                          |  90 +++++++
 include/trace/events/mmflags.h                |  10 +-
 kernel/dma/swiotlb.c                          |   3 +-
 mm/Makefile                                   |   1 +
 mm/mmap.c                                     |  19 +-
 mm/page_alloc.c                               |   3 +
 mm/util.c                                     |  32 +++
 mm/xpfo.c                                     | 247 ++++++++++++++++++
 security/Kconfig                              |  29 ++
 32 files changed, 974 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm64/mm/xpfo.c
 create mode 100644 arch/x86/mm/xpfo.c
 create mode 100644 drivers/misc/lkdtm/xpfo.c
 create mode 100644 include/linux/xpfo.h
 create mode 100644 mm/xpfo.c

-- 
2.17.1

