Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B73C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB41206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfBWB2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:28:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfBWB2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:28:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65643B54346CD7FBC138;
        Sat, 23 Feb 2019 09:28:12 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 09:28:04 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <mike.kravetz@oracle.com>, <mhocko@kernel.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-mm@kvack.org>, <n-horiguchi@ah.jp.nec.com>,
        <aarcange@redhat.com>, <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Jing Xiangfeng" <jingxiangfeng@huawei.com>
Subject: [PATCH v4] mm/hugetlb: Fix unsigned overflow in  __nr_hugepages_store_common()
Date:   Sat, 23 Feb 2019 09:32:09 +0800
Message-ID: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User can change a node specific hugetlb count. i.e.
/sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
the calculated value of count is a total number of huge pages. It could
be overflow when a user entering a crazy high value. If so, the total
number of huge pages could be a small value which is not user expect.
We can simply fix it by setting count to ULONG_MAX, then it goes on. This
may be more in line with user's intention of allocating as many huge pages
as possible.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index afef616..6688894 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2423,7 +2423,14 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 		 * per node hstate attribute: adjust count to global,
 		 * but restrict alloc/free to the specified node.
 		 */
+		unsigned long old_count = count;
 		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		/*
+		 * If user specified count causes overflow, set to
+		 * largest possible value.
+		 */
+		if (count < old_count)
+			count = ULONG_MAX;
 		init_nodemask_of_node(nodes_allowed, nid);
 	} else
 		nodes_allowed = &node_states[N_MEMORY];
-- 
2.7.4

