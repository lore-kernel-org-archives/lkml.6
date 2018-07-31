Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16730C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B478E20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afmMqyZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B478E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeGaEqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:46:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeGaEqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:46:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V33mv5181654;
        Tue, 31 Jul 2018 03:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5oZ3qc8A4Y2LVSE++YahwIeG+gmQZPUmf8qyeRLUknY=;
 b=afmMqyZAn6ozUwS4UuUD1bYUMsFfETTHULsZEWoFuGDcPGJOEpEhww7tVjpBpnc1e5+1
 81T4IUGXZ3zOZhpzoL404PKKKHlvyvge16CxBM4oYcnm1K8QI6vRNPhcoqas0skMmRIh
 0qrhbiZ5s41NQwzpsdt1jTWyrCxYw5AjEn4e+1ctRvXaPgV0MJBbQTvq34hWsLMoEU93
 2U+yEXUyrUnVjFnCum4dDfUyXD8m0Vk6ByLozrYKduozrLeJje5LSZqYYVYW5apmxhpu
 wzVC1mHBgvGzfEpTWMml+BahzkmGBZ4I5Fls3fWjlFCShLXOqtW5DdAskQyW4yczfcwK Kw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kggeny0c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 03:08:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V380wQ011147
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 03:08:00 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6V37xV5013811;
        Tue, 31 Jul 2018 03:07:59 GMT
Received: from [10.154.104.120] (/10.154.104.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 20:07:59 -0700
Subject: Re: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, mike.kravetz@oracle.com, dave@stgolabs.net,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20180727211727.5020-1-jane.chu@oracle.com>
 <20180730085851.GB24267@dhcp22.suse.cz>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <025ae23a-8821-9a55-9e62-54be4c422c5a@oracle.com>
Date:   Mon, 30 Jul 2018 20:07:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730085851.GB24267@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal,


On 7/30/2018 1:58 AM, Michal Hocko wrote:
> On Fri 27-07-18 15:17:27, Jane Chu wrote:
>> Commit 05ea88608d4e13 (mm, hugetlbfs: introduce ->pagesize() to
>> vm_operations_struct) adds a new ->pagesize() function to
>> hugetlb_vm_ops, intended to cover all hugetlbfs backed files.
>>
>> With System V shared memory model, if "huge page" is specified,
>> the "shared memory" is backed by hugetlbfs files, but the mappings
>> initiated via shmget/shmat have their original vm_ops overwritten
>> with shm_vm_ops, so we need to add a ->pagesize function to shm_vm_ops.
>> Otherwise, vma_kernel_pagesize() returns PAGE_SIZE given a hugetlbfs
>> backed vma, result in below BUG:
>>
>> fs/hugetlbfs/inode.c
>>          443             if (unlikely(page_mapped(page))) {
>>          444                     BUG_ON(truncate_op);
>>
>> [  242.268342] hugetlbfs: oracle (4592): Using mlock ulimits for SHM_HUGETLB is deprecated
>> [  282.653208] ------------[ cut here ]------------
>> [  282.708447] kernel BUG at fs/hugetlbfs/inode.c:444!
>> [  282.818957] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 ...
>> [  284.025873] CPU: 35 PID: 5583 Comm: oracle_5583_sbt Not tainted 4.14.35-1829.el7uek.x86_64 #2
>> [  284.246609] task: ffff9bf0507aaf80 task.stack: ffffa9e625628000
>> [  284.317455] RIP: 0010:remove_inode_hugepages+0x3db/0x3e2
>> ....
>> [  285.292389] Call Trace:
>> [  285.321630]  hugetlbfs_evict_inode+0x1e/0x3e
>> [  285.372707]  evict+0xdb/0x1af
>> [  285.408185]  iput+0x1a2/0x1f7
>> [  285.443661]  dentry_unlink_inode+0xc6/0xf0
>> [  285.492661]  __dentry_kill+0xd8/0x18d
>> [  285.536459]  dput+0x1b5/0x1ed
>> [  285.571939]  __fput+0x18b/0x216
>> [  285.609495]  ____fput+0xe/0x10
>> [  285.646030]  task_work_run+0x90/0xa7
>> [  285.688788]  exit_to_usermode_loop+0xdd/0x116
>> [  285.740905]  do_syscall_64+0x187/0x1ae
>> [  285.785740]  entry_SYSCALL_64_after_hwframe+0x150/0x0
>>
>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> with Cc: stable and Fixes: tag as suggested by Mike.
>
> I also agree with Matthew that the comment should be associated with
> hugetlb_vm_ops/shm_vm_ops.

Indeed, will make the above changes.
Thanks for reviewing!

-jane

>
> Thanks!
>
>> ---
>>   include/linux/mm.h |  7 +++++++
>>   ipc/shm.c          | 12 ++++++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index a0fbb9ffe380..0c759379f2d9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -387,6 +387,13 @@ enum page_entry_size {
>>    * These are the virtual MM functions - opening of an area, closing and
>>    * unmapping it (needed to keep files on disk up-to-date etc), pointer
>>    * to the functions called when a no-page or a wp-page exception occurs.
>> + *
>> + * Note, when a new function is introduced to vm_operations_struct and
>> + * added to hugetlb_vm_ops, please consider adding the function to
>> + * shm_vm_ops. This is because under System V memory model, though
>> + * mappings created via shmget/shmat with "huge page" specified are
>> + * backed by hugetlbfs files, their original vm_ops are overwritten with
>> + * shm_vm_ops.
>>    */
>>   struct vm_operations_struct {
>>   	void (*open)(struct vm_area_struct * area);
>> diff --git a/ipc/shm.c b/ipc/shm.c
>> index 051a3e1fb8df..fefa00d310fb 100644
>> --- a/ipc/shm.c
>> +++ b/ipc/shm.c
>> @@ -427,6 +427,17 @@ static int shm_split(struct vm_area_struct *vma, unsigned long addr)
>>   	return 0;
>>   }
>>   
>> +static unsigned long shm_pagesize(struct vm_area_struct *vma)
>> +{
>> +	struct file *file = vma->vm_file;
>> +	struct shm_file_data *sfd = shm_file_data(file);
>> +
>> +	if (sfd->vm_ops->pagesize)
>> +		return sfd->vm_ops->pagesize(vma);
>> +
>> +	return PAGE_SIZE;
>> +}
>> +
>>   #ifdef CONFIG_NUMA
>>   static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
>>   {
>> @@ -554,6 +565,7 @@ static const struct vm_operations_struct shm_vm_ops = {
>>   	.close	= shm_close,	/* callback for when the vm-area is released */
>>   	.fault	= shm_fault,
>>   	.split	= shm_split,
>> +	.pagesize = shm_pagesize,
>>   #if defined(CONFIG_NUMA)
>>   	.set_policy = shm_set_policy,
>>   	.get_policy = shm_get_policy,
>> -- 
>> 2.15.GIT
>>

