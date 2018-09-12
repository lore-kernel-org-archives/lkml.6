Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEFC61CF0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B83206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxS0rfKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B83206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIMBbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:31:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeIMBbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:31:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKO66A084516;
        Wed, 12 Sep 2018 20:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Y0l/v4ChhDfpmg8ZWlOjGIPE6pA9rPqMOnxUCcNtxuw=;
 b=dxS0rfKsKju22sqRkmq90rgMGeyxuu1cTGZIOpxJ2B3J6toBGsH8zY/kGZawq97J3b+G
 G486sbMzF0ut7DamaOi+wktauKqCHHCyZF854y/TTfJoGiGRdX6L8GylmJK3ib2ax5O1
 w8btCMGGGM7G28SPXmt0cAuWWrbSKQKX+tXv6WfFYg4tvaWUM6fTGsEVptsneAQVwr6g
 P4bSlsaVPjfVzM6Mo/FTliefXwMHioYEqEm0yRtoFcgx1mrzLKl+jKqyvOw64TDhS+Su
 SoSkoplefjux75VAUQxW+vawv4su/MwTGwc7H7sldR+p+viW375BmEFiJ/6cN40rCylk lA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mc6cpvd7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKP0W1010267
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:01 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8CKP08W024321;
        Wed, 12 Sep 2018 20:25:00 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:25:00 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 5/6] File /proc/<pid>/numa_vamaps access needs PTRACE_MODE_READ_REALCREDS check
Date:   Wed, 12 Sep 2018 13:24:03 -0700
Message-Id: <1536783844-4145-6-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=968
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permission to access /proc/<pid>/numa_vamaps file should be governed by
PTRACE_READ_REALCREADS check to restrict getting specific VA range to numa
node mapping information.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 fs/proc/base.c     | 4 +++-
 fs/proc/task_mmu.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1af99ae..3c19a55 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -745,7 +745,9 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 	struct mm_struct *mm = ERR_PTR(-ESRCH);
 
 	if (task) {
-		mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
+		if (!(mode & PTRACE_MODE_REALCREDS))
+			mode |= PTRACE_MODE_FSCREDS;
+		mm = mm_access(task, mode);
 		put_task_struct(task);
 
 		if (!IS_ERR_OR_NULL(mm)) {
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 93dce46..30b29d2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2043,7 +2043,7 @@ static int numa_vamaps_open(struct inode *inode, struct file *file)
 	if (!nvm)
 		return -ENOMEM;
 
-	mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	mm = proc_mem_open(inode, PTRACE_MODE_READ | PTRACE_MODE_REALCREDS);
 	if (IS_ERR(mm)) {
 		kfree(nvm);
 		return PTR_ERR(mm);
-- 
2.7.4

