Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AB8C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80A82146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFLdfO7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80A82146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeIMBbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:31:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49636 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:31:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKO5BD084468;
        Wed, 12 Sep 2018 20:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ELoFsMn5o98Zemi8jSkmdeZ9l+KekLYzbuwPi51dF9A=;
 b=MFLdfO7yDSZkFeIlwVCoNg04udYGoj/1O1FDBkNuLhGvg2mbFpQ0ZQsxp139E37iwGrh
 dSHfjTHGlBwtYu5xasIWYjhvVyxgLSVoHyf33HKBzhKK3iSoKOwVclhE4t1/aLhc2dIo
 36NjsT+rSIOOsKNPQEaOqetqQAsZv3cQq5g8J4YPCbd9mZNWrYrMGJJURGeBV0NPUga5
 pyUz75nz5mpKo7elvlwLPQZUah1uwE/7uuf+CUGDSps9IpeckAkMBW0boog9Vjyqxa0T
 giV8kjOpmYUVi3wair2A9nCgdoE1DgNJf31zw8LjuUtEqPVegpIG6RssJBfZh+SPFx6e Wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mc6cpvd7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:24:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOxjb015214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:24:59 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOwiN015836;
        Wed, 12 Sep 2018 20:24:58 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:24:58 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 2/6] Add /proc/<pid>/numa_vamaps file for numa node information
Date:   Wed, 12 Sep 2018 13:24:00 -0700
Message-Id: <1536783844-4145-3-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce supporting data structures and file operations. Later
patch will provide changes for generating file content.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 fs/proc/base.c     |  2 ++
 fs/proc/internal.h |  1 +
 fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ccf86f1..1af99ae 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2927,6 +2927,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("maps",       S_IRUGO, proc_pid_maps_operations),
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
+	REG("numa_vamaps",  S_IRUGO, proc_numa_vamaps_operations),
 #endif
 	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
@@ -3313,6 +3314,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_NUMA
 	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
+	REG("numa_vamaps",  S_IRUGO, proc_numa_vamaps_operations),
 #endif
 	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",       proc_cwd_link),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f..994c7fd 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -298,6 +298,7 @@ extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_numa_vamaps_operations;
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0e2095c..02b553c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1583,6 +1583,16 @@ struct numa_maps_private {
 	struct numa_maps md;
 };
 
+#define NUMA_VAMAPS_BUFSZ      1024
+struct numa_vamaps_private {
+	struct mm_struct *mm;
+	struct numa_maps md;
+	u64 vm_start;
+	size_t from;
+	size_t count; /* residual bytes in buf at offset 'from' */
+	char buf[NUMA_VAMAPS_BUFSZ]; /* buffer */
+};
+
 static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
@@ -1848,6 +1858,34 @@ static int pid_numa_maps_open(struct inode *inode, struct file *file)
 				sizeof(struct numa_maps_private));
 }
 
+static int numa_vamaps_open(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm;
+	struct numa_vamaps_private *nvm;
+	nvm = kzalloc(sizeof(struct numa_vamaps_private), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
+
+	mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	if (IS_ERR(mm)) {
+		kfree(nvm);
+		return PTR_ERR(mm);
+	}
+	nvm->mm = mm;
+	file->private_data = nvm;
+	return 0;
+}
+
+static int numa_vamaps_release(struct inode *inode, struct file *file)
+{
+	struct numa_vamaps_private *nvm = file->private_data;
+
+	if (nvm->mm)
+		mmdrop(nvm->mm);
+	kfree(nvm);
+	return 0;
+}
+
 const struct file_operations proc_pid_numa_maps_operations = {
 	.open		= pid_numa_maps_open,
 	.read		= seq_read,
@@ -1855,4 +1893,8 @@ const struct file_operations proc_pid_numa_maps_operations = {
 	.release	= proc_map_release,
 };
 
+const struct file_operations proc_numa_vamaps_operations = {
+	.open		= numa_vamaps_open,
+	.release	= numa_vamaps_release,
+};
 #endif /* CONFIG_NUMA */
-- 
2.7.4

