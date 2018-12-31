Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD73C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452AF2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeLaJ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:29:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbeLaJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 04:29:43 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBV9Skn7105747
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:29:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pqcmuyh37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:29:42 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 31 Dec 2018 09:29:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 31 Dec 2018 09:29:33 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBV9TWYT26017906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 09:29:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 154B84C040;
        Mon, 31 Dec 2018 09:29:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83CC14C04A;
        Mon, 31 Dec 2018 09:29:28 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.181])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 31 Dec 2018 09:29:28 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 31 Dec 2018 11:29:27 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 0/6] memblock: simplify several early memory allocation
Date:   Mon, 31 Dec 2018 11:29:20 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18123109-0028-0000-0000-00000331258E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123109-0029-0000-0000-000023EE69C7
Message-Id: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches simplify some of the early memory allocations by replacing
usage of older memblock APIs with newer and shinier ones.

Quite a few places in the arch/ code allocated memory using a memblock API
that returns a physical address of the allocated area, then converted this
physical address to a virtual one and then used memset(0) to clear the
allocated range.

More recent memblock APIs do all the three steps in one call and their
usage simplifies the code.

It's important to note that regardless of API used, the core allocation is
nearly identical for any set of memblock allocators: first it tries to find
a free memory with all the constraints specified by the caller and then
falls back to the allocation with some or all constraints disabled.

The first three patches perform the conversion of call sites that have
exact requirements for the node and the possible memory range.

The fourth patch is a bit one-off as it simplifies openrisc's
implementation of pte_alloc_one_kernel(), and not only the memblock usage.

The fifth patch takes care of simpler cases when the allocation can be
satisfied with a simple call to memblock_alloc().

The sixth patch removes one-liner wrappers for memblock_alloc on arm and
unicore32, as suggested by Christoph.

v4:
* rebased on the current upstream
* added conversion of s390 node data allocation

v3:
* added Tested-by from Michal Simek for microblaze changes
* updated powerpc changes as per Michael Ellerman comments:
  - use allocations that clear memory in alloc_paca_data() and alloc_stack()
  - ensure the replacement is equivalent to old API

v2:
* added Ack from Stafford Horne for openrisc changes
* entirely drop early_alloc wrappers on arm and unicore32, as per Christoph
Hellwig

Mike Rapoport (6):
  powerpc: prefer memblock APIs returning virtual address
  microblaze: prefer memblock API returning virtual address
  sh: prefer memblock APIs returning virtual address
  openrisc: simplify pte_alloc_one_kernel()
  arch: simplify several early memory allocations
  arm, s390, unicore32: remove oneliner wrappers for memblock_alloc()

 arch/arm/mm/mmu.c                      | 13 +++----------
 arch/c6x/mm/dma-coherent.c             |  9 ++-------
 arch/microblaze/mm/init.c              |  5 +++--
 arch/nds32/mm/init.c                   | 12 ++++--------
 arch/openrisc/mm/ioremap.c             | 11 ++++-------
 arch/powerpc/kernel/paca.c             | 16 ++++++----------
 arch/powerpc/kernel/setup-common.c     |  4 ++--
 arch/powerpc/kernel/setup_64.c         | 24 ++++++++++--------------
 arch/powerpc/mm/hash_utils_64.c        |  6 +++---
 arch/powerpc/mm/pgtable-book3e.c       |  8 ++------
 arch/powerpc/mm/pgtable-book3s64.c     |  5 +----
 arch/powerpc/mm/pgtable-radix.c        | 25 +++++++------------------
 arch/powerpc/mm/ppc_mmu_32.c           |  3 +--
 arch/powerpc/platforms/pasemi/iommu.c  |  5 +++--
 arch/powerpc/platforms/powernv/opal.c  |  3 +--
 arch/powerpc/platforms/pseries/setup.c | 18 ++++++++++++++----
 arch/powerpc/sysdev/dart_iommu.c       |  7 +++++--
 arch/s390/numa/numa.c                  | 14 +-------------
 arch/sh/mm/init.c                      | 18 +++++-------------
 arch/sh/mm/numa.c                      |  5 ++---
 arch/sparc/kernel/prom_64.c            |  7 ++-----
 arch/sparc/mm/init_64.c                |  9 +++------
 arch/unicore32/mm/mmu.c                | 14 ++++----------
 23 files changed, 88 insertions(+), 153 deletions(-)

-- 
2.7.4

