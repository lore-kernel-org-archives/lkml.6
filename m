Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE69C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07B12075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfBVNv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:51:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfBVNv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:51:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B69E12F695AAFBD9DA2A;
        Fri, 22 Feb 2019 21:51:55 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Feb 2019 21:51:46 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <mike.kravetz@oracle.com>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>
CC:     <hughd@google.com>, <linux-mm@kvack.org>,
        <n-horiguchi@ah.jp.nec.com>, <aarcange@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>
Subject: [PATCH v2] mm/hugetlb: Fix unsigned overflow in  __nr_hugepages_store_common()
Date:   Fri, 22 Feb 2019 21:55:34 +0800
Message-ID: <1550843734-21255-1-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User can change a node specific hugetlb count. i.e.
/sys/devices/system/node/node1/hugepages/hugepages-2048kB
the calculated value of count is a total number of huge pages. It could
be overflow when a user entering a crazy high value. If so，the total
number of huge pages could be a small value which is not user expect.
We can simply fix it by setting count to ULONG_MAX, then it goes on. This
may be more in line with user's intention of allocating as many huge pages
as possible.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index afef616..18fa7d7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2423,7 +2423,10 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 		 * per node hstate attribute: adjust count to global,
 		 * but restrict alloc/free to the specified node.
 		 */
+		unsigned long old_count = count;
 		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		if (count < old_count)
+			count = ULONG_MAX;
 		init_nodemask_of_node(nodes_allowed, nid);
 	} else
 		nodes_allowed = &node_states[N_MEMORY];
-- 
2.7.4

