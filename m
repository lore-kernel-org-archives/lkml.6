Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965241AbeEITTB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:19:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEITTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:19:00 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mhocko@suse.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, fengguang.wu@intel.com, dennisszhou@gmail.com
Subject: [PATCH] mm: allow deferred page init for vmemmap only
Date: Wed,  9 May 2018 15:17:13 -0400
Message-Id: <20180509191713.23794-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unsafe to do virtual to physical translations before mm_init() is
called if struct page is needed in order to determine the memory section
number (see SECTION_IN_PAGE_FLAGS). This is because only in mm_init() we
initialize struct pages for all the allocated memory when deferred struct
pages are used.

My recent fix exposed this problem, because it greatly reduced number of
pages that are initialized before mm_init(), but the problem existed even
before my fix, as Fengguang Wu found.

Since FLATMEM is already disallowed for deferred struct pages, it makes
sense to allow deferred struct pages only on systems with
SPARSEMEM_VMEMMAP.

The problems are discussed in these threads:
http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com
http://lkml.kernel.org/r/20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com
http://lkml.kernel.org/r/20180426202619.2768-1-pasha.tatashin@oracle.com

Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index d5004d82a1d6..1cd32d67ca30 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -635,7 +635,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	bool "Defer initialisation of struct pages to kthreads"
 	default n
 	depends on NO_BOOTMEM
-	depends on !FLATMEM
+	depends on SPARSEMEM_VMEMMAP
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
 	  single thread. On very large machines this can take a considerable
-- 
2.17.0
