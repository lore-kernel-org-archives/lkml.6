Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934460AbeD0OxK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:53:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934199AbeD0OxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:53:08 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org
Subject: [PATCH v2] mm: sections are not offlined during memory hotremove
Date: Fri, 27 Apr 2018 10:52:57 -0400
Message-Id: <20180427145257.15222-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=815
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory hotplug, and hotremove operate with per-block granularity. If
machine has large amount of memory (more than 64G), the size of memory
block can span multiple sections. By mistake, during hotremove we set
only the first section to offline state.

The bug was discovered because kernel selftest started to fail:
https://lkml.kernel.org/r/20180423011247.GK5563@yexl-desktop

After commit, "mm/memory_hotplug: optimize probe routine". But, the bug is
older than this commit. In this optimization we also added a check for
sections to be in a proper state during hotplug operation.

Fixes: 2d070eab2e82 ("mm: consider zone which is not fully populated to have holes")

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable@vger.kernel.org

---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 62eef264a7bd..73dc2fcc0eab 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -629,7 +629,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned long pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		unsigned long section_nr = pfn_to_section_nr(start_pfn);
+		unsigned long section_nr = pfn_to_section_nr(pfn);
 		struct mem_section *ms;
 
 		/*
-- 
2.17.0
