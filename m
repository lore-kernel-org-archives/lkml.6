Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356DEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB62920671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOXbXRQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB62920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbeG0Wli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:41:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60920 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389659AbeG0Wli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:41:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6RLEju1016148;
        Fri, 27 Jul 2018 21:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=FeD56HSiwh1LVtS9tlX8UGgNfpreoW2uJ2w9Dzh34Pk=;
 b=VOXbXRQWfQnzsnqg85FKWMIB0Rm8WTIljg9YNjXm9cE5IsCenlgiFuDFmLeMxri5OB5L
 gUQXJviuiQ09ShAG1QsP2cddAvHO7Qn5IK3CDrg+lBQmFjISMQ6I2FrFIHhNmavSMu1D
 jD5JSi//n81ittidsz3khZAV1219DACNh5QutR+XlCPtZ7nutMsCZmVGeYnoF7Sn1T9x
 8vcd0lIDmATSzEs7lvAkhvDLZROuUV9DV5XRl2pJXZyAmG1/uBzRW60Ul56CKFzxg58h
 yD7kERQuevGyp4qjJA/SHbk7uL9QRyV5IvNghW2v3jGkT+7fv3oITbKM6r4mAjdbRu0N 1w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfq8n7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jul 2018 21:17:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6RLHXG1021808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jul 2018 21:17:34 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6RLHWvd010961;
        Fri, 27 Jul 2018 21:17:32 GMT
Received: from brm-x4600-03.us.oracle.com (/10.80.150.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Jul 2018 14:17:32 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, mhocko@suse.com, jack@suse.cz,
        jglisse@redhat.com, mike.kravetz@oracle.com, dave@stgolabs.net,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, jane.chu@oracle.com
Subject: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
Date:   Fri, 27 Jul 2018 15:17:27 -0600
Message-Id: <20180727211727.5020-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.15.GIT
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8967 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807270215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 05ea88608d4e13 (mm, hugetlbfs: introduce ->pagesize() to
vm_operations_struct) adds a new ->pagesize() function to
hugetlb_vm_ops, intended to cover all hugetlbfs backed files.

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

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 include/linux/mm.h |  7 +++++++
 ipc/shm.c          | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..0c759379f2d9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -387,6 +387,13 @@ enum page_entry_size {
  * These are the virtual MM functions - opening of an area, closing and
  * unmapping it (needed to keep files on disk up-to-date etc), pointer
  * to the functions called when a no-page or a wp-page exception occurs.
+ *
+ * Note, when a new function is introduced to vm_operations_struct and
+ * added to hugetlb_vm_ops, please consider adding the function to
+ * shm_vm_ops. This is because under System V memory model, though
+ * mappings created via shmget/shmat with "huge page" specified are
+ * backed by hugetlbfs files, their original vm_ops are overwritten with
+ * shm_vm_ops.
  */
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
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
-- 
2.15.GIT

