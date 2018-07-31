Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C5208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ugtLY+8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2C5208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeGaG11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:27:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeGaG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:27:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V4jJp0041994;
        Tue, 31 Jul 2018 04:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ecWrOfJUuTTg06v8CRGavcrhDo1TfCR+siQgb9sg6n8=;
 b=ugtLY+8POU47/ZNizjWbIXQ7JBGAd0+H6U8tlUQUgANOHmiEQcYyUvfMCrPDjqY4cAYx
 NATixJ+edOUqQfcIGwTSHHAnLETlzYpWGDUYefmpDvA3MrYld+qbzmzCRz78EOyLYsA2
 NRrV0lyQd6pbL4vOQQyq1xflIo3OjqHjuj70ZE2BDhqj8fNx5UMJANedWxbeWn04XSei
 7H47Cf7QLzcy/ZEo6f6yQfnJ+M2qBrMkk89Osm6K3XUmYxCYJ68v5OcIwL33EHNk5vny
 v/A6eggxpLmDT1gK1HZmIjOM4X0WfClz7sm+hr7nhKeQsoyGyY9Df5V0wGr+rVRirl+M 5A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kge0cyady-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 04:48:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V4mcpw013969
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 04:48:40 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6V4mZ9P015349;
        Tue, 31 Jul 2018 04:48:35 GMT
Received: from brm-x4600-03.us.oracle.com (/10.80.150.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 21:48:35 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, mhocko@suse.com, jack@suse.cz,
        jglisse@redhat.com, mike.kravetz@oracle.com, dave@stgolabs.net,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        jane.chu@oracle.com
Subject: [PATCH v2] ipc/shm.c add ->pagesize function to shm_vm_ops
Date:   Mon, 30 Jul 2018 22:48:31 -0600
Message-Id: <20180731044831.26036-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05ea88608d4e13 ("mm, hugetlbfs: introduce ->pagesize() to
vm_operations_struct") adds a new ->pagesize() function to hugetlb_vm_ops,
intended to cover all hugetlbfs backed files.

With System V shared memory model, if "huge page" is specified,
the "shared memory" is backed by hugetlbfs files, but the mappings
initiated via shmget/shmat have their original vm_ops overwritten
with shm_vm_ops, so we need to add a ->pagesize function to shm_vm_ops.
Otherwise, vma_kernel_pagesize() returns PAGE_SIZE given a hugetlbfs
backed vma, result in below BUG:

fs/hugetlbfs/inode.c
        443             if (unlikely(page_mapped(page))) {
        444                     BUG_ON(truncate_op);

[  242.268342] hugetlbfs: oracle (4592): Using mlock ulimits for SHM_HUGETLB is deprecated
[  282.653208] ------------[ cut here ]------------
[  282.708447] kernel BUG at fs/hugetlbfs/inode.c:444!
[  282.818957] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 ...
[  284.025873] CPU: 35 PID: 5583 Comm: oracle_5583_sbt Not tainted 4.14.35-1829.el7uek.x86_64 #2
[  284.246609] task: ffff9bf0507aaf80 task.stack: ffffa9e625628000
[  284.317455] RIP: 0010:remove_inode_hugepages+0x3db/0x3e2
....
[  285.292389] Call Trace:
[  285.321630]  hugetlbfs_evict_inode+0x1e/0x3e
[  285.372707]  evict+0xdb/0x1af
[  285.408185]  iput+0x1a2/0x1f7
[  285.443661]  dentry_unlink_inode+0xc6/0xf0
[  285.492661]  __dentry_kill+0xd8/0x18d
[  285.536459]  dput+0x1b5/0x1ed
[  285.571939]  __fput+0x18b/0x216
[  285.609495]  ____fput+0xe/0x10
[  285.646030]  task_work_run+0x90/0xa7
[  285.688788]  exit_to_usermode_loop+0xdd/0x116
[  285.740905]  do_syscall_64+0x187/0x1ae
[  285.785740]  entry_SYSCALL_64_after_hwframe+0x150/0x0

Link: http://lkml.kernel.org/r/20180727211727.5020-1-jane.chu@oracle.com
Fixes: 05ea88608d4e13 ("mm, hugetlbfs: introduce ->pagesize() to vm_operations_struct")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jan Kara <jack@suse.cz>
Cc: JÃ©rÃ´me Glisse <jglisse@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
---
 ipc/shm.c    | 12 ++++++++++++
 mm/hugetlb.c |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index 051a3e1fb8df..fefa00d310fb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -427,6 +427,17 @@ static int shm_split(struct vm_area_struct *vma, unsigned long addr)
 	return 0;
 }
 
+static unsigned long shm_pagesize(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+
+	if (sfd->vm_ops->pagesize)
+		return sfd->vm_ops->pagesize(vma);
+
+	return PAGE_SIZE;
+}
+
 #ifdef CONFIG_NUMA
 static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
@@ -554,6 +565,7 @@ static const struct vm_operations_struct shm_vm_ops = {
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.fault	= shm_fault,
 	.split	= shm_split,
+	.pagesize = shm_pagesize,
 #if defined(CONFIG_NUMA)
 	.set_policy = shm_set_policy,
 	.get_policy = shm_get_policy,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 039ddbc574e9..3103099f64fd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3167,6 +3167,13 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+/*
+ * When a new function is introduced to vm_operations_struct and added
+ * to hugetlb_vm_ops, please consider adding the function to shm_vm_ops.
+ * This is because under System V memory model, mappings created via
+ * shmget/shmat with "huge page" specified are backed by hugetlbfs files,
+ * their original vm_ops are overwritten with shm_vm_ops.
+ */
 const struct vm_operations_struct hugetlb_vm_ops = {
 	.fault = hugetlb_vm_op_fault,
 	.open = hugetlb_vm_op_open,
-- 
2.15.GIT

