Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4937C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BCD205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LRKAdqMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BCD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbeG1CE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:04:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60754 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbeG1CE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:04:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6S0eFXx167108;
        Sat, 28 Jul 2018 00:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=emJ1te2Zr11ThXkXHMZd9C0CzgVsKzB0FnEJw1KXVxw=;
 b=LRKAdqMOfcCfLxR2gv1GjRutLC/H44uoXf9kV86n0NLY6cg61c7rOJWdQ0pWWygcM6rp
 GKlLRfZwl5rBvh7rD6pMfWG3sd8pLQf+SdQYlOxu+o5BtOmf9GA3KUceuUWzH9WU8I9f
 +fDpLehOEf2jqdP0XbzzfyRwrqvWmE6Kz+5uqgsPuS1xlFsZjXq7DkH9rK7AOUATK5TL
 MyrIjHjCttHpD0cyXI5OAgRyGZO4dIGqiIGPZYGQ/IMSstyzaHja5IoGFVORY6qL98Vv
 8636tSFElnx3TREAKjFveqTv4XGbjFCfIvFacA/uw3kFYKsuY1N9u6cf/FMcwmkXp0OK Mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kge0cr08v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jul 2018 00:40:22 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6S0eJ7B005309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jul 2018 00:40:20 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6S0eIUd018633;
        Sat, 28 Jul 2018 00:40:18 GMT
Received: from [10.154.103.88] (/10.154.103.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Jul 2018 17:40:18 -0700
Subject: Re: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dan.j.williams@intel.com, mhocko@suse.com, jack@suse.cz,
        jglisse@redhat.com, mike.kravetz@oracle.com, dave@stgolabs.net,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Jane Chu <jane.chu@oracle.com>
References: <20180727211727.5020-1-jane.chu@oracle.com>
 <20180727145009.5dde68fb680ec148a7504f37@linux-foundation.org>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <6ea01f10-066a-6fe6-bf82-3a3b4ddf1175@oracle.com>
Date:   Fri, 27 Jul 2018 17:40:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727145009.5dde68fb680ec148a7504f37@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8967 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807280006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

On 7/27/2018 2:50 PM, Andrew Morton wrote:

> On Fri, 27 Jul 2018 15:17:27 -0600 Jane Chu <jane.chu@oracle.com> wrote:
>
>> Commit 05ea88608d4e13 (mm, hugetlbfs: introduce ->pagesize() to
>> vm_operations_struct) adds a new ->pagesize() function to
>> hugetlb_vm_ops, intended to cover all hugetlbfs backed files.
> That was merged three months ago.  Can you suggest why this was only
> noticed now?

The issue was recently reported by a QA engineer running Oracle database
test in Oracle Linux. He first noticed the issue in upstream 4.17, then 4.18,
but because the issue wasn't in Oracle product, it wasn't reported, not
until I cherry picked the patch into Oracle Linux recently.

> What workload triggered this?  I see no cc:stable, but 4.17 is affected?

It's Oracle database workload. Large shared memory segments(SGAs) were created
and shared among dozens to hundreds of processes. The crash occurs when the
test stops the database workload.  I do not have access to the test source.
Yes, 4.17 is affected.

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
> OK, help me out here.  How does an incorrect return value from
> vma_kernel_pagesize() result in remove_inode_hugepages() deciding that
> it's truncating a mapped page?

To be honest, I don't have a satisfactory answer to how the wrong
pagesize causes a page that's about to be truncated remain mapped.
I relied on the hind sight of BUG_ON(truncate_op).

At a time I inserted dump_stack() into vma_kernel_pagesize() as Mike
suggested to try to dig out more,

unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
{
-       if (vma->vm_ops && vma->vm_ops->pagesize)
+       if (vma->vm_ops && vma->vm_ops->pagesize) {
                 return vma->vm_ops->pagesize(vma);
+        } else if (is_vm_hugetlb_page(vma)) {
+               struct hstate *hstate;
+               dump_stack();
+               hstate = hstate_vma(vma);
+               return 1UL << huge_page_shift(hstate);
+       }
         return PAGE_SIZE;
}

There were too many stack traces that clogged the console, I didn't
capture the entire output, perhaps I should go back to capture them.

Any other ideas?

Regards,
-jane


