Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D12C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EF0N+A4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeIMBcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:32:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbeIMBcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:32:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKP1MO064847;
        Wed, 12 Sep 2018 20:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=0PPy+WGxUyuEgizIqbyTH5ifjbGa9WJweV7bgCsDBug=;
 b=EF0N+A4YJRcUxPipp2vRvo2gwhlmbHJpTj8LaoxsZFB5IJMBO9n93+z7ddpvJKazTLtv
 jc0n3dJE2uXgGk+ytuLfJ0NBAPCaQSiqmK6Vk5a2wEN50BnrHDVSP4a23fJOWnUKCqRO
 pdiBge+VzkFi33yl7oC/3kA19Cjls/oV4swVcOMo0dBl33Y87Dx/NeqrS4hThkmwDJMa
 tjzczViABB5J+lAJYFP8XJ8pbgBA1cpKws7AAcD0TPKEaQTXEF/zgXs4RToUAYpnwkFy
 xtFsfundptHw3LFXv2pvYicb+EL2r+qoNthNYLEDRyPzvUQEUbSDpUZmpwMVO6EijvuD cQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5utmeur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKOxsK015237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:25:00 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8CKOxIf024309;
        Wed, 12 Sep 2018 20:24:59 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:24:58 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     dave.hansen@intel.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com,
        prakash.sangappa@oracle.com
Subject: [PATCH V2 3/6] Provide process address range to numa node id mapping
Date:   Wed, 12 Sep 2018 13:24:01 -0700
Message-Id: <1536783844-4145-4-git-send-email-prakash.sangappa@oracle.com>
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

This patch provides process address range to numa node information
thru /proc/<pid>/numa_vamaps file. For address ranges not having
any pages mapped, a '-' is printed instead of the numa node id.

Following is the sample of the file format

00400000-00410000 N1
00410000-0047f000 N0
0047f000-00480000 N2
00480000-00481000 -
00481000-004a0000 N0
004a0000-004a2000 -
004a2000-004aa000 N2
004aa000-004ad000 N0
004ad000-004ae000 -
..

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 fs/proc/task_mmu.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 02b553c..1371e379 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1845,6 +1845,162 @@ static int show_numa_map(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int gather_hole_info_vamap(unsigned long start, unsigned long end,
+			struct mm_walk *walk)
+{
+       struct numa_maps *md = walk->private;
+       struct vm_area_struct *vma = walk->vma;
+
+       /*
+	* If in a nid, end walk at hole start.
+	* If no nid and vma changes, end walk at next vma start.
+	*/
+	if (md->nid >= 0 || vma != find_vma(walk->mm, start)) {
+		md->nextaddr = start;
+		return 1;
+	}
+
+	if (md->nid == NUMA_VAMAPS_NID_NONE)
+		md->nid = NUMA_VAMAPS_NID_NOPAGES;
+
+	return 0;
+}
+
+static int vamap_vprintf(struct numa_vamaps_private *nvm, const char *f, ...)
+{
+	va_list args;
+	int len, space;
+
+	space = NUMA_VAMAPS_BUFSZ - nvm->count;
+	va_start(args, f);
+	len = vsnprintf(nvm->buf + nvm->count, space, f, args);
+	va_end(args);
+	if (len < space) {
+		nvm->count += len;
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Display va-range to numa node info via /proc
+ */
+static ssize_t numa_vamaps_read(struct file *file, char __user *buf,
+	size_t count, loff_t *ppos)
+{
+	struct numa_vamaps_private *nvm = file->private_data;
+	struct vm_area_struct *vma, *tailvma;
+	struct numa_maps *md = &nvm->md;
+	struct mm_struct *mm = nvm->mm;
+	u64 vm_start = nvm->vm_start;
+	size_t ucount;
+	struct mm_walk walk = {
+		.hugetlb_entry = gather_hugetlb_stats,
+		.pmd_entry = gather_pte_stats,
+		.pte_hole = gather_hole_info_vamap,
+		.private = md,
+		.mm = mm,
+	};
+	int ret = 0, copied = 0, done = 0;
+
+	if (!mm || !mmget_not_zero(mm))
+		return 0;
+
+	if (count <= 0)
+		goto out_mm;
+
+	/* First copy leftover contents in buffer */
+	if (nvm->from)
+		goto docopy;
+
+repeat:
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, vm_start);
+	if (!vma) {
+		done = 1;
+		goto out;
+	}
+
+	if (vma->vm_start > vm_start)
+		vm_start = vma->vm_start;
+
+	while (nvm->count < count) {
+		u64 vm_end;
+
+		/* Ensure we start with an empty numa_maps statistics */
+		memset(md, 0, sizeof(*md));
+		md->nid = NUMA_VAMAPS_NID_NONE; /* invalid nodeid at start */
+		md->nextaddr = 0;
+		md->isvamaps = 1;
+
+		 if (walk_page_range(vm_start, vma->vm_end, &walk) < 0)
+			break;
+
+		/* nextaddr ends the range. if 0, reached the vma end */
+		vm_end = (md->nextaddr ? md->nextaddr : vma->vm_end);
+
+		 /* break if buffer full */
+		if (md->nid >= 0 && md->node[md->nid]) {
+		   if (vamap_vprintf(nvm, "%08lx-%08lx N%ld\n", vm_start,
+			vm_end, md->nid))
+			break;
+		} else if (vamap_vprintf(nvm, "%08lx-%08lx - \n", vm_start,
+			vm_end)) {
+			break;
+		}
+
+		/* advance to next VA */
+		vm_start = vm_end;
+		if (vm_end == vma->vm_end) {
+			vma = vma->vm_next;
+			if (!vma) {
+				done = 1;
+				break;
+			}
+			vm_start = vma->vm_start;
+		}
+	}
+out:
+	/* last, add gate vma details */
+	if (!vma && (tailvma = get_gate_vma(mm)) != NULL &&
+		vm_start < tailvma->vm_end) {
+		done = 0;
+		if (!vamap_vprintf(nvm, "%08lx-%08lx - \n",
+		   tailvma->vm_start, tailvma->vm_end)) {
+			done = 1;
+			vm_start = tailvma->vm_end;
+		}
+	}
+
+	up_read(&mm->mmap_sem);
+docopy:
+	ucount = min(count, nvm->count);
+	if (ucount && copy_to_user(buf, nvm->buf + nvm->from, ucount)) {
+		ret = -EFAULT;
+		goto out_mm;;
+	}
+	copied += ucount;
+	count -= ucount;
+	nvm->count -= ucount;
+	buf += ucount;
+	if (!done && count) {
+		nvm->from = 0;
+		goto repeat;
+	}
+	/* somthing left in the buffer */
+	if (nvm->count)
+		nvm->from += ucount;
+	else
+		nvm->from = 0;
+
+	nvm->vm_start = vm_start;
+	ret = copied;
+	*ppos +=  copied;
+out_mm:
+	mmput(mm);
+	return ret;
+}
+
 static const struct seq_operations proc_pid_numa_maps_op = {
 	.start  = m_start,
 	.next   = m_next,
@@ -1895,6 +2051,8 @@ const struct file_operations proc_pid_numa_maps_operations = {
 
 const struct file_operations proc_numa_vamaps_operations = {
 	.open		= numa_vamaps_open,
+	.read		= numa_vamaps_read,
+	.llseek		= noop_llseek,
 	.release	= numa_vamaps_release,
 };
 #endif /* CONFIG_NUMA */
-- 
2.7.4

