Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeCUIUd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:20:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751902AbeCUIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:20:28 -0400
Subject: Re: [PATCH] mm/hugetlb: prevent hugetlb VMA to be misaligned
To: Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, mhocko@kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <1521566754-30390-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <86240c1a-d1f1-0f03-855e-c5196762ec0a@oracle.com>
 <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 09:20:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032108-0012-0000-0000-000005C1A1D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032108-0013-0000-0000-0000193DC31F
Message-Id: <f238cd7e-3d80-7888-618c-3138cf59bbb1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210102
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2018 22:35, Mike Kravetz wrote:
> On 03/20/2018 02:26 PM, Mike Kravetz wrote:
>> Thanks Laurent!
>>
>> This bug was introduced by 31383c6865a5.  Dan's changes for 31383c6865a5
>> seem pretty straight forward.  It simply replaces an explicit check when
>> splitting a vma to a new vm_ops split callout.  Unfortunately, mappings
>> created via shmget/shmat have their vm_ops replaced.  Therefore, this
>> split callout is never made.
>>
>> The shm vm_ops do indirectly call the original vm_ops routines as needed.
>> Therefore, I would suggest a patch something like the following instead.
>> If we move forward with the patch, we should include Laurent's BUG output
>> and perhaps test program in the commit message.
> 
> Sorry, patch in previous mail was a mess
> 
> From 7a19414319c7937fd2757c27f936258f16c1f61d Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 20 Mar 2018 13:56:57 -0700
> Subject: [PATCH] shm: add split function to shm_vm_ops
> 
> The split function was added to vm_operations_struct to determine
> if a mapping can be split.  This was mostly for device-dax and
> hugetlbfs mappings which have specific alignment constraints.
> 
> mappings initiated via shmget/shmat have their original vm_ops
> overwritten with shm_vm_ops.  shm_vm_ops functions will call back
> to the original vm_ops if needed.  Add such a split function.

FWIW,
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

> Fixes: 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct)
> Reported by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  ipc/shm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 7acda23430aa..50e88fc060b1 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -386,6 +386,17 @@ static int shm_fault(struct vm_fault *vmf)
>  	return sfd->vm_ops->fault(vmf);
>  }
> 
> +static int shm_split(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct file *file = vma->vm_file;
> +	struct shm_file_data *sfd = shm_file_data(file);
> +
> +	if (sfd->vm_ops && sfd->vm_ops->split)
> +		return sfd->vm_ops->split(vma, addr);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_NUMA
>  static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
>  {
> @@ -510,6 +521,7 @@ static const struct vm_operations_struct shm_vm_ops = {
>  	.open	= shm_open,	/* callback for a new vm-area open */
>  	.close	= shm_close,	/* callback for when the vm-area is released */
>  	.fault	= shm_fault,
> +	.split	= shm_split,
>  #if defined(CONFIG_NUMA)
>  	.set_policy = shm_set_policy,
>  	.get_policy = shm_get_policy,
> 
