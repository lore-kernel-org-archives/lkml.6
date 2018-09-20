Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3665C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706452152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706452152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeITQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:55:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeITQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:55:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KB5SSH110212
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 07:12:08 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mm7tgpx0n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 07:12:08 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 20 Sep 2018 05:12:07 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 05:12:04 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8KBC3ae39911658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 04:12:03 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC8F7136051;
        Thu, 20 Sep 2018 05:12:03 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86C8E13605D;
        Thu, 20 Sep 2018 05:12:01 -0600 (MDT)
Received: from [9.85.86.4] (unknown [9.85.86.4])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 05:12:01 -0600 (MDT)
Subject: Re: [PATCH] mm: Recheck page table entry with page table lock held
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180920092408.9128-1-aneesh.kumar@linux.ibm.com>
 <20180920110538.rlcpw75eabkqudkl@kshutemo-mobl1>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 20 Sep 2018 16:41:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180920110538.rlcpw75eabkqudkl@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092011-0036-0000-0000-00000A3B0B1D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009739; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091018; UDB=6.00563684; IPR=6.00871042;
 MB=3.00023409; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 11:12:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092011-0037-0000-0000-000049012C56
Message-Id: <a22a21d6-c872-63e9-77ec-8071bac9bfc9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 4:35 PM, Kirill A. Shutemov wrote:
> On Thu, Sep 20, 2018 at 02:54:08PM +0530, Aneesh Kumar K.V wrote:
>> We clear the pte temporarily during read/modify/write update of the pte. If we
>> take a page fault while the pte is cleared, the application can get SIGBUS. One
>> such case is with remap_pfn_range without a backing vm_ops->fault callback.
>> do_fault will return SIGBUS in that case.
> 
> It would be nice to show the path that clears pte temporarily.
> 
>> Fix this by taking page table lock and rechecking for pte_none.


we do that in the ptep_modify_prot_start/ptep_modify_prot_commit. Also 
in hugetlb_change_protection. The hugetlb case many not be relevant 
because that cannot be backed by a vma without vma->vm_ops.

What will hit this will be mprotect of a remap_pfn_range address?

>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/memory.c | 31 +++++++++++++++++++++++++++----
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c467102a5cbc..c2f933184303 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3745,10 +3745,33 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	vm_fault_t ret;
>>   
>> -	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
>> -	if (!vma->vm_ops->fault)
>> -		ret = VM_FAULT_SIGBUS;
>> -	else if (!(vmf->flags & FAULT_FLAG_WRITE))
>> +	/*
>> +	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
>> +	 */
>> +	if (!vma->vm_ops->fault) {
>> +
>> +		/*
>> +		 * pmd entries won't be marked none during a R/M/W cycle.
>> +		 */
>> +		if (unlikely(pmd_none(*vmf->pmd)))
>> +			ret = VM_FAULT_SIGBUS;
>> +		else {
>> +			vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>> +			/*
>> +			 * Make sure this is not a temporary clearing of pte
>> +			 * by holding ptl and checking again. A R/M/W update
>> +			 * of pte involves: take ptl, clearing the pte so that
>> +			 * we don't have concurrent modification by hardware
>> +			 * followed by an update.
>> +			 */
>> +			spin_lock(vmf->ptl);
>> +			if (unlikely(pte_none(*vmf->pte)))
>> +				ret = VM_FAULT_SIGBUS;
>> +			else
>> +				ret = VM_FAULT_NOPAGE;
> 
> We return 0 if we did nothing in fault path.
> 

I didn't get that. If we find the pte not none, we return so that we 
retry the access. Are you suggesting VM_FAULT_NOPAGE is not the right 
return for that?

-aneesh

