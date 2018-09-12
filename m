Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696DC07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5EA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P1lIUvk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5EA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeIMBbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:31:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeIMBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:31:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKO6LB084494;
        Wed, 12 Sep 2018 20:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=jv2gOdozZBt8RfOmySF/IIWmh2gd+llfLCyQhB8Gt2w=;
 b=P1lIUvk9b+Z/DAZVGAy2Zf58rJ1fc5O1bxJqkp5l86Uc0CM5X4v21jIKSNLipOGBqshd
 biWb7mlxkIwrHdorzdJBioUjaNaKIU+21qiMGcdEl65xwyLSnq39HU8G/KKEy2AYcM7B
 6mJAhGjUrZdm4YVp06HHbidHBWta8hiFrJad2lfAAMMDtjYpWTtIWEYxoVqLYp3Zkqi5
 1e7JKJZeO6aXNPdbpuSo1WZCEopRzF+SN1Kozre9TrqpOgCHdeA6/dM9quUG8DqwDWoK
 Fl6DD2zsDapfAuBX4FeWVt0yIJSxiaU+mcIQ4hkDVQ4cMnF7y3M1R0WBFiBiiEqjonKT 6A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mc6cpvd7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOxuQ010208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:00 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8CKOxhK032107;
        Wed, 12 Sep 2018 20:24:59 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:24:59 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 4/6] Add support to lseek /proc/<pid>/numa_vamaps file
Date:   Wed, 12 Sep 2018 13:24:02 -0700
Message-Id: <1536783844-4145-5-git-send-email-prakash.sangappa@oracle.com>
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

Allow lseeking to a process virtual address(VA), starting from where
the address range to numa node information can be read. The lseek offset
will be the process virtual address.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 fs/proc/task_mmu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1371e379..93dce46 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1866,6 +1866,27 @@ static int gather_hole_info_vamap(unsigned long start, unsigned long end,
 	return 0;
 }
 
+static loff_t numa_vamaps_llseek(struct file *file, loff_t offset, int orig)
+{
+	struct numa_vamaps_private *nvm = file->private_data;
+
+	if (orig == SEEK_CUR && offset < 0 && nvm->vm_start < -offset)
+		return -EINVAL;
+
+	switch (orig) {
+	case SEEK_SET:
+		nvm->vm_start = offset & PAGE_MASK;
+		break;
+	case SEEK_CUR:
+		nvm->vm_start += offset;
+		nvm->vm_start = nvm->vm_start & PAGE_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return nvm->vm_start;
+}
+
 static int vamap_vprintf(struct numa_vamaps_private *nvm, const char *f, ...)
 {
 	va_list args;
@@ -2052,7 +2073,7 @@ const struct file_operations proc_pid_numa_maps_operations = {
 const struct file_operations proc_numa_vamaps_operations = {
 	.open		= numa_vamaps_open,
 	.read		= numa_vamaps_read,
-	.llseek		= noop_llseek,
+	.llseek		= numa_vamaps_llseek,
 	.release	= numa_vamaps_release,
 };
 #endif /* CONFIG_NUMA */
-- 
2.7.4

