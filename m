Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeENIOF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752196AbeENIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:13:59 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/3] docs/vm: transhuge: minor updates
Date: Mon, 14 May 2018 11:13:39 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526285620-453-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1526285620-453-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051408-0008-0000-0000-000004F639B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051408-0009-0000-0000-00001E8A96F8
Message-Id: <1526285620-453-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some formatting changes and addition of a sentence introducing khugepaged

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/transhuge.rst | 47 ++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/transhuge.rst b/Documentation/vm/transhuge.rst
index 56d04cbb..47c7e47 100644
--- a/Documentation/vm/transhuge.rst
+++ b/Documentation/vm/transhuge.rst
@@ -9,14 +9,19 @@ Objective
 
 Performance critical computing applications dealing with large memory
 working sets are already running on top of libhugetlbfs and in turn
-hugetlbfs. Transparent Hugepage Support is an alternative means of
+hugetlbfs. Transparent HugePage Support (THP) is an alternative mean of
 using huge pages for the backing of virtual memory with huge pages
 that supports the automatic promotion and demotion of page sizes and
 without the shortcomings of hugetlbfs.
 
-Currently it only works for anonymous memory mappings and tmpfs/shmem.
+Currently THP only works for anonymous memory mappings and tmpfs/shmem.
 But in the future it can expand to other filesystems.
 
+.. note::
+   in the examples below we presume that the basic page size is 4K and
+   the huge page size is 2M, although the actual numbers may vary
+   depending on the CPU architecture.
+
 The reason applications are running faster is because of two
 factors. The first factor is almost completely irrelevant and it's not
 of significant interest because it'll also have the downside of
@@ -28,15 +33,27 @@ only matters the first time the memory is accessed for the lifetime of
 a memory mapping. The second long lasting and much more important
 factor will affect all subsequent accesses to the memory for the whole
 runtime of the application. The second factor consist of two
-components: 1) the TLB miss will run faster (especially with
-virtualization using nested pagetables but almost always also on bare
-metal without virtualization) and 2) a single TLB entry will be
-mapping a much larger amount of virtual memory in turn reducing the
-number of TLB misses. With virtualization and nested pagetables the
-TLB can be mapped of larger size only if both KVM and the Linux guest
-are using hugepages but a significant speedup already happens if only
-one of the two is using hugepages just because of the fact the TLB
-miss is going to run faster.
+components:
+
+1) the TLB miss will run faster (especially with virtualization using
+   nested pagetables but almost always also on bare metal without
+   virtualization)
+
+2) a single TLB entry will be mapping a much larger amount of virtual
+   memory in turn reducing the number of TLB misses. With
+   virtualization and nested pagetables the TLB can be mapped of
+   larger size only if both KVM and the Linux guest are using
+   hugepages but a significant speedup already happens if only one of
+   the two is using hugepages just because of the fact the TLB miss is
+   going to run faster.
+
+THP can be enabled system wide or restricted to certain tasks or even
+memory ranges inside task's address space. Unless THP is completely
+disabled, there is ``khugepaged`` daemon that scans memory and
+collapses sequences of basic pages into huge pages.
+
+The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
+interface and using madivse(2) and prctl(2) system calls.
 
 Transparent Hugepage Support maximizes the usefulness of free memory
 if compared to the reservation approach of hugetlbfs by allowing all
@@ -69,9 +86,14 @@ Applications that gets a lot of benefit from hugepages and that don't
 risk to lose memory by using hugepages, should use
 madvise(MADV_HUGEPAGE) on their critical mmapped regions.
 
+.. _thp_sysfs:
+
 sysfs
 =====
 
+Global THP controls
+-------------------
+
 Transparent Hugepage Support for anonymous memory can be entirely disabled
 (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
 regions (to avoid the risk of consuming more memory resources) or enabled
@@ -142,6 +164,9 @@ khugepaged will be automatically started when
 transparent_hugepage/enabled is set to "always" or "madvise, and it'll
 be automatically shutdown if it's set to "never".
 
+Khugepaged controls
+-------------------
+
 khugepaged runs usually at low frequency so while one may not want to
 invoke defrag algorithms synchronously during the page faults, it
 should be worth invoking defrag at least in khugepaged. However it's
-- 
2.7.4
