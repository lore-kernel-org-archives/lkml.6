Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeCTV0h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:26:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCTV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:26:33 -0400
Subject: Re: [PATCH] mm/hugetlb: prevent hugetlb VMA to be misaligned
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, mhocko@kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <1521566754-30390-1-git-send-email-ldufour@linux.vnet.ibm.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <86240c1a-d1f1-0f03-855e-c5196762ec0a@oracle.com>
Date: Tue, 20 Mar 2018 14:26:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1521566754-30390-1-git-send-email-ldufour@linux.vnet.ibm.com>
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

On 03/20/2018 10:25 AM, Laurent Dufour wrote:
> When running the sampler detailed below, the kernel, if built with the VM
> debug option turned on (as many distro do), is panicing with the following
> message :
> kernel BUG at /build/linux-jWa1Fv/linux-4.15.0/mm/hugetlb.c:3310!
> Oops: Exception in kernel mode, sig: 5 [#1]
> LE SMP NR_CPUS=2048 NUMA PowerNV
> Modules linked in: kcm nfc af_alg caif_socket caif phonet fcrypt
> 		8<--8<--8<--8< snip 8<--8<--8<--8<
> CPU: 18 PID: 43243 Comm: trinity-subchil Tainted: G         C  E
> 4.15.0-10-generic #11-Ubuntu
> NIP:  c00000000036e764 LR: c00000000036ee48 CTR: 0000000000000009
> REGS: c000003fbcdcf810 TRAP: 0700   Tainted: G         C  E
> (4.15.0-10-generic)
> MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER:
> 20040000
> CFAR: c00000000036ee44 SOFTE: 1
> GPR00: c00000000036ee48 c000003fbcdcfa90 c0000000016ea600 c000003fbcdcfc40
> GPR04: c000003fd9858950 00007115e4e00000 00007115e4e10000 0000000000000000
> GPR08: 0000000000000010 0000000000010000 0000000000000000 0000000000000000
> GPR12: 0000000000002000 c000000007a2c600 00000fe3985954d0 00007115e4e00000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 00000fe398595a94 000000000000a6fc c000003fd9858950 0000000000018554
> GPR24: c000003fdcd84500 c0000000019acd00 00007115e4e10000 c000003fbcdcfc40
> GPR28: 0000000000200000 00007115e4e00000 c000003fbc9ac600 c000003fd9858950
> NIP [c00000000036e764] __unmap_hugepage_range+0xa4/0x760
> LR [c00000000036ee48] __unmap_hugepage_range_final+0x28/0x50
> Call Trace:
> [c000003fbcdcfa90] [00007115e4e00000] 0x7115e4e00000 (unreliable)
> [c000003fbcdcfb50] [c00000000036ee48]
> __unmap_hugepage_range_final+0x28/0x50
> [c000003fbcdcfb80] [c00000000033497c] unmap_single_vma+0x11c/0x190
> [c000003fbcdcfbd0] [c000000000334e14] unmap_vmas+0x94/0x140
> [c000003fbcdcfc20] [c00000000034265c] exit_mmap+0x9c/0x1d0
> [c000003fbcdcfce0] [c000000000105448] mmput+0xa8/0x1d0
> [c000003fbcdcfd10] [c00000000010fad0] do_exit+0x360/0xc80
> [c000003fbcdcfdd0] [c0000000001104c0] do_group_exit+0x60/0x100
> [c000003fbcdcfe10] [c000000000110584] SyS_exit_group+0x24/0x30
> [c000003fbcdcfe30] [c00000000000b184] system_call+0x58/0x6c
> Instruction dump:
> 552907fe e94a0028 e94a0408 eb2a0018 81590008 7f9c5036 0b090000 e9390010
> 7d2948f8 7d2a2838 0b0a0000 7d293038 <0b090000> e9230086 2fa90000 419e0468
> ---[ end trace ee88f958a1c62605 ]---
> 
> The panic is due to a VMA pointing to a hugetlb area while the
> vma->vm_start or vma->vm_end field are not aligned to the huge page
> boundaries. The sampler is just unmapping a part of the hugetlb area,
> leading to 2 VMAs which are not well aligned.  The same could be achieved
> by calling madvise() situation, as it is when running:
> stress-ng --shm-sysv 1
> 
> The hugetlb code is assuming that the VMA will be well aligned when it is
> unmapped, so we must prevent such a VMA to be split or shrink to a
> misaligned address.
> 
> This patch is preventing this by checking the new VMA's boundaries when a
> VMA is modified by calling vma_adjust().
> 
> If this patch is applied, stable should be Cced.

Thanks Laurent!

This bug was introduced by 31383c6865a5.  Dan's changes for 31383c6865a5
seem pretty straight forward.  It simply replaces an explicit check when
splitting a vma to a new vm_ops split callout.  Unfortunately, mappings
created via shmget/shmat have their vm_ops replaced.  Therefore, this
split callout is never made.

The shm vm_ops do indirectly call the original vm_ops routines as needed.
Therefore, I would suggest a patch something like the following instead.
If we move forward with the patch, we should include Laurent's BUG output
and perhaps test program in the commit message.

-- 
Mike Kravetz

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
