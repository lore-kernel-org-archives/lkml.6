Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBHSvQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:51:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33624 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbeBHSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:51:15 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@oracle.com, m.mizuma@jp.fujitsu.com,
        akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/1] initialize pages on demand during boot
Date: Thu,  8 Feb 2018 13:45:54 -0500
Message-Id: <20180208184555.5855-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change log:
	v1 - v2: Added Tested-by: Masayoshi Mizuma

Answering Andrew Morton's questions:

> Presumably this fixes some real-world problem which someone has observed?

Yes, linked below.

> Please describe that problem for us in lavish detail.

This change helps for three reasons:

1. Insufficient amount of reserved memory due to arguments provided by
user. User may request some buffers, increased hash tables sizes etc.
Currently, machine panics during boot if it can't allocate memory due
to insufficient amount of reserved memory. With this change, it will
be able to grow zone before deferred pages are initialized.

One observed example is described in the linked discussion [1] Mel
Gorman writes:

"
Yasuaki Ishimatsu reported a premature OOM when trace_buf_size=100m was
specified on a machine with many CPUs. The kernel tried to allocate 38.4GB
but only 16GB was available due to deferred memory initialisation.
"

The allocations in the above scenario happen per-cpu in smp_init(),
and before deferred pages are initialized. So, there is no way to
predict how much memory we should put aside to boot successfully with
deferred page initialization feature compiled in.

2. The second reason is future proof. The kernel memory requirements
may change, and we do not want to constantly update
reset_deferred_meminit() to satisfy the new requirements. In addition,
this function is currently in common code, but potentially would need
to be split into arch specific variants, as more arches will start
taking advantage of deferred page initialization feature.

3. On demand initialization of reserved pages guarantees that we will
initialize only as many pages early in boot using only one thread as
needed, the rest are going to be efficiently initialized in parallel.

[1] https://www.spinics.net/lists/linux-mm/msg139087.html

Pavel Tatashin (1):
  mm: initialize pages on demand during boot

 include/linux/memblock.h |  10 ---
 mm/memblock.c            |  23 -------
 mm/page_alloc.c          | 164 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 125 insertions(+), 72 deletions(-)

-- 
2.16.1
