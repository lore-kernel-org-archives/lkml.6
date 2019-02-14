Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A4218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCAqLcPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391428AbfBNADO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:03:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48296 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbfBNADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:03:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwwaN100588;
        Thu, 14 Feb 2019 00:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=CbjD5NDLq08Mo7eN2Um4+q6m8m467CwhonU9E1EJKW8=;
 b=LCAqLcPTz5XRHmMnRpSbgL2BZb4hao/My/4GHpRplmahOtSwpi0LB3FuKKuXxPMo6h42
 jK0JzSwmGhM1wwzNGbKUlxBpu3FR72+3UIyQ02vuswK6oKZrEI61VDlo/lopV/7EY82S
 GHfwpyurLuoViuGHQuc5yL2N11TxzFApEz5TpU2ushVqr0Szviq5iTMT+D86kxlstpMp
 ILKZMMg6/NJ/c+qpu66MJBxget1gp5GrFVS3DnAxtqp+RYbfi4GFUvcQmBDf3an735dQ
 pV6+SUDDOBkqnQoZRxF2w/M5p4oKUrAsz99AIg2vrBeOt5bAm+WhBwdXIqb2Egi2Ckbi yw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qhre5n3u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:01:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E01tQp031732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:01:55 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E01rBR018412;
        Thu, 14 Feb 2019 00:01:53 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 16:01:52 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v8 00/14] Add support for eXclusive Page Frame Ownership
Date:   Wed, 13 Feb 2019 17:01:23 -0700
Message-Id: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am continuing to build on the work Juerg, Tycho and Julian have
done on XPFO. After the last round of updates, we were seeing very
significant performance penalties when stale TLB entries were
flushed actively after an XPFO TLB update.  Benchmark for measuring
performance is kernel build using parallel make. To get full
protection from ret2dir attackes, we must flush stale TLB entries.
Performance penalty from flushing stale TLB entries goes up as the
number of cores goes up. On a desktop class machine with only 4
cores, enabling TLB flush for stale entries causes system time for
"make -j4" to go up by a factor of 2.61x but on a larger machine
with 96 cores, system time with "make -j60" goes up by a factor of
26.37x!  I have been working on reducing this performance penalty.

I implemented two solutions to reduce performance penalty and that
has had large impact. XPFO code flushes TLB every time a page is
allocated to userspace. It does so by sending IPIs to all processors
to flush TLB. Back to back allocations of pages to userspace on
multiple processors results in a storm of IPIs.  Each one of these
incoming IPIs is handled by a processor by flushing its TLB. To
reduce this IPI storm, I have added a per CPU flag that can be set
to tell a processor to flush its TLB. A processor checks this flag
on every context switch. If the flag is set, it flushes its TLB and
clears the flag. This allows for multiple TLB flush requests to a
single CPU to be combined into a single request. A kernel TLB entry
for a page that has been allocated to userspace is flushed on all
processors unlike the previous version of this patch. A processor
could hold a stale kernel TLB entry that was removed on another
processor until the next context switch. A local userspace page
allocation by the currently running process could force the TLB
flush earlier for such entries.

The other solution reduces the number of TLB flushes required, by
performing TLB flush for multiple pages at one time when pages are
refilled on the per-cpu freelist. If the pages being addedd to
per-cpu freelist are marked for userspace allocation, TLB entries
for these pages can be flushed upfront and pages tagged as currently
unmapped. When any such page is allocated to userspace, there is no
need to performa a TLB flush at that time any more. This batching of
TLB flushes reduces performance imapct further.

I measured system time for parallel make with unmodified 4.20
kernel, 4.20 with XPFO patches before these patches and then again
after applying each of these patches. Here are the results:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

4.20					950.966s
4.20+XPFO				25073.169s	26.37x
4.20+XPFO+Deferred flush		1372.874s	1.44x
4.20+XPFO+Deferred flush+Batch update	1255.021s	1.32x


Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

4.20					607.671s
4.20+XPFO				1588.646s	2.61x
4.20+XPFO+Deferred flush		803.989s	1.32x
4.20+XPFO+Deferred flush+Batch update	795.728s	1.31x

30+% overhead is still very high and there is room for improvement.

Performance with this patch set is good enough to use these as
starting point for further refinement before we merge it into main
kernel, hence RFC.

I have dropped the patch "mm, x86: omit TLB flushing by default for
XPFO page table modifications" since not flushing TLB leaves kernel
wide open to attack and there is no point in enabling XPFO without
flushing TLB every time kernel TLB entries for pages are removed. I
also dropped the patch "EXPERIMENTAL: xpfo, mm: optimize spin lock
usage in xpfo_kmap". There was not a measurable improvement in
performance with this patch and it introduced a possibility for
deadlock that Laura found.

What remains to be done beyond this patch series:

1. Performance improvements: Ideas to explore - (1) Add a freshly
   freed page to per cpu freelist and not make a kernel TLB entry
   for it, (2) kernel mappings private to an mm, (3) Any others??
2. Re-evaluate the patch "arm64/mm: Add support for XPFO to swiotlb"
   from Juerg. I dropped it for now since swiotlb code for ARM has
   changed a lot in 4.20.
3. Extend the patch "xpfo, mm: Defer TLB flushes for non-current
   CPUs" to other architectures besides x86.


---------------------------------------------------------

Juerg Haefliger (5):
  mm, x86: Add support for eXclusive Page Frame Ownership (XPFO)
  swiotlb: Map the buffer if it was unmapped by XPFO
  arm64/mm: Add support for XPFO
  arm64/mm, xpfo: temporarily map dcache regions
  lkdtm: Add test for XPFO

Julian Stecklina (2):
  xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION
  xpfo, mm: optimize spinlock usage in xpfo_kunmap

Khalid Aziz (2):
  xpfo, mm: Defer TLB flushes for non-current CPUs (x86 only)
  xpfo, mm: Optimize XPFO TLB flushes by batching them together

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
 arch/arm64/mm/xpfo.c                          |  64 +++++
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/pgtable.h                |  26 ++
 arch/x86/include/asm/tlbflush.h               |   1 +
 arch/x86/mm/Makefile                          |   2 +
 arch/x86/mm/fault.c                           |   6 +
 arch/x86/mm/pageattr.c                        |  23 +-
 arch/x86/mm/tlb.c                             |  38 +++
 arch/x86/mm/xpfo.c                            | 181 ++++++++++++++
 drivers/misc/lkdtm/Makefile                   |   1 +
 drivers/misc/lkdtm/core.c                     |   3 +
 drivers/misc/lkdtm/lkdtm.h                    |   5 +
 drivers/misc/lkdtm/xpfo.c                     | 194 +++++++++++++++
 include/linux/highmem.h                       |  15 +-
 include/linux/mm.h                            |   2 +
 include/linux/mm_types.h                      |   8 +
 include/linux/page-flags.h                    |  18 +-
 include/linux/xpfo.h                          |  95 ++++++++
 include/trace/events/mmflags.h                |  10 +-
 kernel/dma/swiotlb.c                          |   3 +-
 mm/Makefile                                   |   1 +
 mm/mmap.c                                     |  19 +-
 mm/page_alloc.c                               |   7 +
 mm/util.c                                     |  32 +++
 mm/xpfo.c                                     | 223 ++++++++++++++++++
 security/Kconfig                              |  29 +++
 31 files changed, 977 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm64/mm/xpfo.c
 create mode 100644 arch/x86/mm/xpfo.c
 create mode 100644 drivers/misc/lkdtm/xpfo.c
 create mode 100644 include/linux/xpfo.h
 create mode 100644 mm/xpfo.c

-- 
2.17.1

