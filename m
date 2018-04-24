Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756117AbeDXGks (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:40:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755909AbeDXGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:40:44 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/7] docs/vm: ksm: add "Design" section
Date: Tue, 24 Apr 2018 09:40:24 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0040-0000-0000-00000450C4E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0041-0000-0000-000020F530B7
Message-Id: <1524552028-7017-4-git-send-email-rppt@linux.vnet.ibm.com>
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

Include the KSM description from the source code comment, add a subsection
about reverse mapping and include kernel-doc references for KSM data
structures.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/ksm.rst | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index 786d460..0e5a085 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -206,6 +206,45 @@ stable_node "dups" with few rmap_items in them, but that may increase
 the ksmd CPU usage and possibly slowdown the readonly computations on
 the KSM pages of the applications.
 
+Design
+======
+
+Overview
+--------
+
+.. kernel-doc:: mm/ksm.c
+   :DOC: Overview
+
+Reverse mapping
+---------------
+KSM maintains reverse mapping information for KSM pages in the stable
+tree.
+
+If a KSM page is shared between less than ``max_page_sharing`` VMAs,
+the node of the stable tree that represents such KSM page points to a
+list of :c:type:`struct rmap_item` and the ``page->mapping`` of the
+KSM page points to the stable tree node.
+
+When the sharing passes this threshold, KSM adds a second dimension to
+the stable tree. The tree node becomes a "chain" that links one or
+more "dups". Each "dup" keeps reverse mapping information for a KSM
+page with ``page->mapping`` pointing to that "dup".
+
+Every "chain" and all "dups" linked into a "chain" enforce the
+invariant that they represent the same write protected memory content,
+even if each "dup" will be pointed by a different KSM page copy of
+that content.
+
+This way the stable tree lookup computational complexity is unaffected
+if compared to an unlimited list of reverse mappings. It is still
+enforced that there cannot be KSM page content duplicates in the
+stable tree itself.
+
+Reference
+---------
+.. kernel-doc:: mm/ksm.c
+   :functions: mm_slot ksm_scan stable_node rmap_item
+
 --
 Izik Eidus,
 Hugh Dickins, 17 Nov 2009
-- 
2.7.4
