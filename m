Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC28A21A49
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfBPN1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 08:27:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbfBPN1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 08:27:25 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C9EF2913007CF66855F;
        Sat, 16 Feb 2019 21:27:21 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 16 Feb 2019 21:27:12 +0800
From:   Jingxiangfeng <jingxiangfeng@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mhocko@kernel.org>, <hughd@google.com>, <mike.kravetz@oracle.com>,
        <n-horiguchi@ah.jp.nec.com>, <aarcange@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        "Jing Xiangfeng" <jingxiangfeng@huawei.com>
Subject: [PATCH] mm/hugetlb: Fix unsigned overflow in __nr_hugepages_store_common()
Date:   Sat, 16 Feb 2019 21:31:12 +0800
Message-ID: <1550323872-119049-1-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Xiangfeng <jingxiangfeng@huawei.com>

We can use the following command to dynamically allocate huge pages:
	echo NR_HUGEPAGES > /proc/sys/vm/nr_hugepages
The count in  __nr_hugepages_store_common() is parsed from /proc/sys/vm/nr_hugepages,
The maximum number of count is ULONG_MAX,
the operation 'count += h->nr_huge_pages - h->nr_huge_pages_node[nid]' overflow and count will be a wrong number.
So check the overflow to fix this problem.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 mm/hugetlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index afef616..55173c3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2423,7 +2423,12 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 		 * per node hstate attribute: adjust count to global,
 		 * but restrict alloc/free to the specified node.
 		 */
+		unsigned long old_count = count;
 		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		if (count < old_count) {
+			err = -EINVAL;
+			goto out;
+		}
 		init_nodemask_of_node(nodes_allowed, nid);
 	} else
 		nodes_allowed = &node_states[N_MEMORY];
-- 
2.7.4

