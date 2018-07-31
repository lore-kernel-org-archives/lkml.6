Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C239C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BE520890
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JpEvv2UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BE520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeGaErE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:47:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeGaErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:47:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V33VL4145723;
        Tue, 31 Jul 2018 03:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3UUKynlMEH9LuuJKMrEygQO5X8CTS07bF4saSAiTZoE=;
 b=JpEvv2UZyfwn/eA9Wbjdbk6zWh6WeDN3SI3/XuAAdBdFrk8iYn6yTi9+WAfckRpoysuR
 /1HqGLb+XYgm9JE3BG1mFHw+3gkJA8YODjOoUvq0b1chjwrqGj8v4vXy9TVf+atn2avX
 SroMv1pvny0tshNMWCH9R9OVaGAsjELR/NtyYW9Xx6eNPL6nFspBJGL3+X9OuoPUxiJg
 Xet7BO77I0fQ/J0igT2WywNeqlQtqJjiebZWbguqoY2p+FPF66YRuANoZWc/I4esuh+h
 BTA4DMHJD4Mn9IY8JqnDjXJ7W5YAoLjix3BAzVyzY7CpqZYUaPo94ra1PY4J9onLYQyZ ug== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4pxx1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 03:08:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V38orR030824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 03:08:50 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6V38oas023767;
        Tue, 31 Jul 2018 03:08:50 GMT
Received: from [10.154.104.120] (/10.154.104.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 20:08:49 -0700
Subject: Re: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, jack@suse.cz, jglisse@redhat.com,
        mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <20180727211727.5020-1-jane.chu@oracle.com>
 <20180730164459.zduhnk7itoldqnom@linux-r8p5>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <a4c4bdab-b0f8-fb10-9b3d-f5740f30748c@oracle.com>
Date:   Mon, 30 Jul 2018 20:08:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730164459.zduhnk7itoldqnom@linux-r8p5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi, Davidlohr,

On 7/30/2018 9:44 AM, Davidlohr Bueso wrote:

> On Fri, 27 Jul 2018, Jane Chu wrote:
>
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
>>        443             if (unlikely(page_mapped(page))) {
>>        444                     BUG_ON(truncate_op);
>>
>> [  242.268342] hugetlbfs: oracle (4592): Using mlock ulimits for 
>> SHM_HUGETLB is deprecated
>> [  282.653208] ------------[ cut here ]------------
>> [  282.708447] kernel BUG at fs/hugetlbfs/inode.c:444!
>> [  282.818957] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 ...
>> [  284.025873] CPU: 35 PID: 5583 Comm: oracle_5583_sbt Not tainted 
>> 4.14.35-1829.el7uek.x86_64 #2
>> [  284.246609] task: ffff9bf0507aaf80 task.stack: ffffa9e625628000
>> [  284.317455] RIP: 0010:remove_inode_hugepages+0x3db/0x3e2
>> ....
>> [  285.292389] Call Trace:
>> [  285.321630]  hugetlbfs_evict_inode+0x1e/0x3e
>> [  285.372707]  evict+0xdb/0x1af
>> [  285.408185]  iput+0x1a2/0x1f7
>> [  285.443661]  dentry_unlink_inode+0xc6/0xf0
>> [  285.492661]  __dentry_kill+0xd8/0x18d
>> [  285.536459]  dput+0x1b5/0x1ed
>> [  285.571939]  __fput+0x18b/0x216
>> [  285.609495]  ____fput+0xe/0x10
>> [  285.646030]  task_work_run+0x90/0xa7
>> [  285.688788]  exit_to_usermode_loop+0xdd/0x116
>> [  285.740905]  do_syscall_64+0x187/0x1ae
>> [  285.785740]  entry_SYSCALL_64_after_hwframe+0x150/0x0
>>
>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>

Thank you!

-jane

