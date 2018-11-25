Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0836B20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0836B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeKZIg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:36:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbeKZIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:36:56 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAPLi6fb139660
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 16:44:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nymueq68v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 16:44:52 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 25 Nov 2018 21:44:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 25 Nov 2018 21:44:43 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAPLihL245219980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 21:44:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC2B811C054;
        Sun, 25 Nov 2018 21:44:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EEAD11C04C;
        Sun, 25 Nov 2018 21:44:39 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 25 Nov 2018 21:44:39 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sun, 25 Nov 2018 23:44:38 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
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
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/5] memblock: simplify several early memory allocations
Date:   Sun, 25 Nov 2018 23:44:32 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18112521-0020-0000-0000-000002ED8573
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112521-0021-0000-0000-0000213CCEAF
Message-Id: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-25_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=612 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811250133
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

Mike Rapoport (5):
  powerpc: prefer memblock APIs returning virtual address
  microblaze: prefer memblock API returning virtual address
  sh: prefer memblock APIs returning virtual address
  openrisc: simplify pte_alloc_one_kernel()
  arch: simplify several early memory allocations

 arch/arm/mm/mmu.c                      |  4 +---
 arch/c6x/mm/dma-coherent.c             |  9 ++-------
 arch/microblaze/mm/init.c              |  5 +++--
 arch/nds32/mm/init.c                   | 12 ++++--------
 arch/openrisc/mm/ioremap.c             | 11 ++++-------
 arch/powerpc/kernel/paca.c             | 14 ++++++--------
 arch/powerpc/kernel/setup-common.c     |  4 ++--
 arch/powerpc/kernel/setup_64.c         | 21 ++++++++++-----------
 arch/powerpc/mm/hash_utils_64.c        |  6 +++---
 arch/powerpc/mm/pgtable-book3e.c       |  8 ++------
 arch/powerpc/mm/pgtable-book3s64.c     |  5 +----
 arch/powerpc/mm/pgtable-radix.c        | 24 +++++++++---------------
 arch/powerpc/mm/pgtable_32.c           |  4 +---
 arch/powerpc/mm/ppc_mmu_32.c           |  3 +--
 arch/powerpc/platforms/pasemi/iommu.c  |  5 +++--
 arch/powerpc/platforms/powernv/opal.c  |  3 +--
 arch/powerpc/platforms/pseries/setup.c | 11 +++++++----
 arch/powerpc/sysdev/dart_iommu.c       |  5 +++--
 arch/sh/mm/init.c                      | 18 +++++-------------
 arch/sh/mm/numa.c                      |  5 ++---
 arch/sparc/kernel/prom_64.c            |  7 ++-----
 arch/sparc/mm/init_64.c                |  9 +++------
 arch/unicore32/mm/mmu.c                |  4 +---
 23 files changed, 76 insertions(+), 121 deletions(-)

-- 
2.7.4

