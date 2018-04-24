Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756246AbeDXGky (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:40:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756041AbeDXGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:40:45 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 4/7] docs/vm: ksm: reshuffle text between "sysfs" and "design" sections
Date: Tue, 24 Apr 2018 09:40:25 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0020-0000-0000-0000041527B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0021-0000-0000-000042A9885E
Message-Id: <1524552028-7017-5-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of "max_page_sharing" sysfs attribute includes lots of
implementation details that more naturally belong in the "Design"
section.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/ksm.rst | 51 ++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index 0e5a085..00961b8 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -133,31 +133,21 @@ use_zero_pages
 
 max_page_sharing
         Maximum sharing allowed for each KSM page. This enforces a
-        deduplication limit to avoid the virtual memory rmap lists to
-        grow too large. The minimum value is 2 as a newly created KSM
-        page will have at least two sharers. The rmap walk has O(N)
-        complexity where N is the number of rmap_items (i.e. virtual
-        mappings) that are sharing the page, which is in turn capped
-        by ``max_page_sharing``. So this effectively spreads the linear
-        O(N) computational complexity from rmap walk context over
-        different KSM pages. The ksmd walk over the stable_node
-        "chains" is also O(N), but N is the number of stable_node
-        "dups", not the number of rmap_items, so it has not a
-        significant impact on ksmd performance. In practice the best
-        stable_node "dup" candidate will be kept and found at the head
-        of the "dups" list. The higher this value the faster KSM will
-        merge the memory (because there will be fewer stable_node dups
-        queued into the stable_node chain->hlist to check for pruning)
-        and the higher the deduplication factor will be, but the
-        slowest the worst case rmap walk could be for any given KSM
-        page. Slowing down the rmap_walk means there will be higher
+        deduplication limit to avoid high latency for virtual memory
+        operations that involve traversal of the virtual mappings that
+        share the KSM page. The minimum value is 2 as a newly created
+        KSM page will have at least two sharers. The higher this value
+        the faster KSM will merge the memory and the higher the
+        deduplication factor will be, but the slower the worst case
+        virtual mappings traversal could be for any given KSM
+        page. Slowing down this traversal means there will be higher
         latency for certain virtual memory operations happening during
         swapping, compaction, NUMA balancing and page migration, in
         turn decreasing responsiveness for the caller of those virtual
         memory operations. The scheduler latency of other tasks not
-        involved with the VM operations doing the rmap walk is not
-        affected by this parameter as the rmap walks are always
-        schedule friendly themselves.
+        involved with the VM operations doing the virtual mappings
+        traversal is not affected by this parameter as these
+        traversals are always schedule friendly themselves.
 
 stable_node_chains_prune_millisecs
         How frequently to walk the whole list of stable_node "dups"
@@ -240,6 +230,25 @@ if compared to an unlimited list of reverse mappings. It is still
 enforced that there cannot be KSM page content duplicates in the
 stable tree itself.
 
+The deduplication limit enforced by ``max_page_sharing`` is required
+to avoid the virtual memory rmap lists to grow too large. The rmap
+walk has O(N) complexity where N is the number of rmap_items
+(i.e. virtual mappings) that are sharing the page, which is in turn
+capped by ``max_page_sharing``. So this effectively spreads the linear
+O(N) computational complexity from rmap walk context over different
+KSM pages. The ksmd walk over the stable_node "chains" is also O(N),
+but N is the number of stable_node "dups", not the number of
+rmap_items, so it has not a significant impact on ksmd performance. In
+practice the best stable_node "dup" candidate will be kept and found
+at the head of the "dups" list.
+
+High values of ``max_page_sharing`` result in faster memory merging
+(because there will be fewer stable_node dups queued into the
+stable_node chain->hlist to check for pruning) and higher
+deduplication factor at the expense of slower worst case for rmap
+walks for any KSM page which can happen during swapping, compaction,
+NUMA balancing and page migration.
+
 Reference
 ---------
 .. kernel-doc:: mm/ksm.c
-- 
2.7.4
