Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeCTVfk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:35:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44864 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeCTVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:35:39 -0400
Subject: Re: [PATCH] mm/hugetlb: prevent hugetlb VMA to be misaligned
From: Mike Kravetz <mike.kravetz@oracle.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, mhocko@kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <1521566754-30390-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <86240c1a-d1f1-0f03-855e-c5196762ec0a@oracle.com>
Message-ID: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
Date: Tue, 20 Mar 2018 14:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <86240c1a-d1f1-0f03-855e-c5196762ec0a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 02:26 PM, Mike Kravetz wrote:
> Thanks Laurent!
> 
> This bug was introduced by 31383c6865a5.  Dan's changes for 31383c6865a5
> seem pretty straight forward.  It simply replaces an explicit check when
> splitting a vma to a new vm_ops split callout.  Unfortunately, mappings
> created via shmget/shmat have their vm_ops replaced.  Therefore, this
> split callout is never made.
> 
> The shm vm_ops do indirectly call the original vm_ops routines as needed.
> Therefore, I would suggest a patch something like the following instead.
> If we move forward with the patch, we should include Laurent's BUG output
> and perhaps test program in the commit message.

Sorry, patch in previous mail was a mess

>From 7a19414319c7937fd2757c27f936258f16c1f61d Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 20 Mar 2018 13:56:57 -0700
Subject: [PATCH] shm: add split function to shm_vm_ops

The split function was added to vm_operations_struct to determine
if a mapping can be split.  This was mostly for device-dax and
hugetlbfs mappings which have specific alignment constraints.

mappings initiated via shmget/shmat have their original vm_ops
overwritten with shm_vm_ops.  shm_vm_ops functions will call back
to the original vm_ops if needed.  Add such a split function.

Fixes: 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct)
Reported by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 ipc/shm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index 7acda23430aa..50e88fc060b1 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -386,6 +386,17 @@ static int shm_fault(struct vm_fault *vmf)
 	return sfd->vm_ops->fault(vmf);
 }
 
+static int shm_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+
+	if (sfd->vm_ops && sfd->vm_ops->split)
+		return sfd->vm_ops->split(vma, addr);
+
+	return 0;
+}
+
 #ifdef CONFIG_NUMA
 static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
@@ -510,6 +521,7 @@ static const struct vm_operations_struct shm_vm_ops = {
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.fault	= shm_fault,
+	.split	= shm_split,
 #if defined(CONFIG_NUMA)
 	.set_policy = shm_set_policy,
 	.get_policy = shm_get_policy,
-- 
2.13.6
