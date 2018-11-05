Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC543C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C0F20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEDXi9JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C0F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbeKFCTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:19:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43552 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbeKFCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5Gs4bK052321;
        Mon, 5 Nov 2018 16:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=pFJTplxowb9ZeUGTgNoJLdHdBNDs48jVBVOWfuQrUbk=;
 b=UEDXi9JQkI61IrVjTEL9K2GK2kUyKmRXKt4ss+WNs6+EK0pNVLSyhLeGQntyiJM5cEIY
 1QTs2L+45uBq0NzchVRwPJe6uRKAwuGgqm6hOlQix9uyUSXu592okWo3iSWYTsl/qaw3
 8mNuLrR1FcUPpxeOoXm4mDjSV9FxagWh8aPyOdKt8PLonHdEZfXgPE4AltLy3UCoTOeK
 jUog8/C/ZgDbE8JAsDhSMmGritc7Bt190iR/MqdkBatkrFyrFLNaYl5BAZlh0Py/U64X
 SJ8E5YAvEUlYnM8jGUjYCG6xNTBhW9MI0wXB7jXzKedma3SvDo9hFnWSZZv5KHpQC47Q JQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqg2e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 16:56:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuKSY024985
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 16:56:20 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5GuJFq008435;
        Mon, 5 Nov 2018 16:56:19 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 08:56:19 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        daniel.m.jordan@oracle.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: [RFC PATCH v4 08/13] vfio: remove unnecessary mmap_sem writer acquisition around locked_vm
Date:   Mon,  5 Nov 2018 11:55:53 -0500
Message-Id: <20181105165558.11698-9-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that mmap_sem is no longer required for modifying locked_vm, remove
it in the VFIO code.

[XXX Can be sent separately, along with similar conversions in the other
places mmap_sem was taken for locked_vm.  While at it, could make
similar changes to pinned_vm.]

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/vfio/vfio_iommu_type1.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f307dc9d5e19..9e52a24eb45b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -258,7 +258,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
 static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 {
 	struct mm_struct *mm;
-	int ret;
+	long locked_vm;
+	int ret = 0;
 
 	if (!npage)
 		return 0;
@@ -267,24 +268,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 	if (!mm)
 		return -ESRCH; /* process exited */
 
-	ret = down_write_killable(&mm->mmap_sem);
-	if (!ret) {
-		if (npage > 0) {
-			if (!dma->lock_cap) {
-				unsigned long limit;
-
-				limit = task_rlimit(dma->task,
-						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	locked_vm = atomic_long_add_return(npage, &mm->locked_vm);
 
-				if (atomic_long_read(&mm->locked_vm) + npage > limit)
-					ret = -ENOMEM;
-			}
+	if (npage > 0 && !dma->lock_cap) {
+		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
+					  PAGE_SHIFT;
+		if (locked_vm > limit) {
+			atomic_long_sub(npage, &mm->locked_vm);
+			ret = -ENOMEM;
 		}
-
-		if (!ret)
-			atomic_long_add(npage, &mm->locked_vm);
-
-		up_write(&mm->mmap_sem);
 	}
 
 	if (async)
-- 
2.19.1

