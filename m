Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YSnCOWGTHls8JwAAmS7hNA
	; Mon, 11 Jun 2018 15:21:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D1302607A4; Mon, 11 Jun 2018 15:21:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="R1N+2vlh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 387C86074D;
	Mon, 11 Jun 2018 15:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 387C86074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbeFKPU7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:20:59 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:48795 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932567AbeFKPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:20:57 -0400
X-Greylist: delayed 1727 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2018 11:20:57 EDT
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w5BElaGm020569;
        Mon, 11 Jun 2018 15:51:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=TmbutyefCnuzvu1GDsVGxq1/EQAklVHF0pXXbNLGzCc=;
 b=R1N+2vlhyCYDUJt9eSeFvvsEjEtU2Fm04DXqkEhjWrhaPrwk3Pqxzw5Gk94ngVQ9gplD
 QlemMtgF4OFX2AWCDA8UMijWCvO5sjuNRx7Tu/7A5q+PTtWEfkFjKMDFjkKE8QltBRpY
 bn+i05/VFgrSCEh44RFBjSwslOV0xGTxfSx4BffyI5O+6Mh0wJbmevwoCs61FHWHdl9Z
 IFXWhMxNKFvf+7PP5KnAdeIQZYujhgop/fmjGE2pfNANAhycv9y0t8t6Gk8+NcaDMuUO
 R12A+7aqfOiu3OMbZpZ2WNAINpDR2U8esf31cI6iu6pAG0S0sCZlMROzMhQS+LuknVZe XQ==
Received: from prod-mail-ppoint4 (a96-6-114-87.deploy.static.akamaitechnologies.com [96.6.114.87] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2jg3ycxwue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jun 2018 15:51:46 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w5BEolj7031939;
        Mon, 11 Jun 2018 10:51:45 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2jga7vdwnh-1;
        Mon, 11 Jun 2018 10:51:45 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id C46B3811D9;
        Mon, 11 Jun 2018 14:51:44 +0000 (GMT)
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-api@vger.kernel.org, emunson@mgebm.net
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180611072005.GC13364@dhcp22.suse.cz>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <4c4de46d-c55a-99a8-469f-e1e634fb8525@akamai.com>
Date: Mon, 11 Jun 2018 10:51:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180611072005.GC13364@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806110172
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806110171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 03:20 AM, Michal Hocko wrote:
> [CCing linux-api - please make sure to CC this mailing list anytime you
>  are touching user visible apis]
> 
> On Fri 08-06-18 14:56:52, Jason Baron wrote:
>> In order to free memory that is marked MLOCK_ONFAULT, the memory region
>> needs to be first unlocked, before calling MADV_DONTNEED. And if the region
>> is to be reused as MLOCK_ONFAULT, we require another call to mlock2() with
>> the MLOCK_ONFAULT flag.
>>
>> Let's simplify freeing memory that is set MLOCK_ONFAULT, by allowing
>> MADV_DONTNEED to work directly for memory that is set MLOCK_ONFAULT.
> 
> I do not understand the point here. How is MLOCK_ONFAULT any different
> from the regular mlock here? If you want to free mlocked memory then
> fine but the behavior should be consistent. MLOCK_ONFAULT is just a way
> to say that we do not want to pre-populate the mlocked area and do that
> lazily on the page fault time. madvise should make any difference here.
>

The difference for me is after the page has been freed, MLOCK_ONFAULT
will re-populate the range if its accessed again. Whereas with regular
mlock I don't think it will because its normally done at mlock() or
mmap() time. In any case, the state of a region being locked with
regular mlock and pages not present does not currently exist, whereas it
does for MLOCK_ONFAULT, so it seems more natural to do it only for
MLOCK_ONFAULT. Finally, the use-case we had for this, didn't need
regular mlock().

> That being said we do not allow MADV_DONTNEED on VM_LOCKED since ever. I
> do not really see why but this would be a user visible change. Can we do
> that? What was the original motivation for exclusion?
> 

I'm not sure precisely for regular mlock. But for MLOCK_ONFAULT I did
ask the original author, Eric Munson (added to the 'cc) about allowing
MADV_DONTNEED, and iirc, he thought it made sense for MLOCK_ONFAULT.

Thanks,

-Jason


> [keeping the rest of email for linux-api]
> 
>> The
>> locked memory limits, tracked by mm->locked_vm do not need to be adjusted
>> in this case, since they were charged to the entire region when
>> MLOCK_ONFAULT was initially set.
>>
>> Further, I don't think allowing MADV_FREE for MLOCK_ONFAULT regions makes
>> sense, since the point of MLOCK_ONFAULT is for userspace to know when pages
>> are locked in memory and thus to know when page faults will occur.
>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> ---
>>  mm/internal.h | 18 ++++++++++++++++++
>>  mm/madvise.c  |  4 ++--
>>  mm/oom_kill.c |  2 +-
>>  3 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9e3654d..16c0041 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -15,6 +15,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/pagemap.h>
>>  #include <linux/tracepoint-defs.h>
>> +#include <uapi/asm-generic/mman-common.h>
>>  
>>  /*
>>   * The set of flags that only affect watermark checking and reclaim
>> @@ -45,9 +46,26 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>>  
>>  static inline bool can_madv_dontneed_vma(struct vm_area_struct *vma)
>>  {
>> +	return !(((vma->vm_flags & (VM_LOCKED|VM_LOCKONFAULT)) == VM_LOCKED) ||
>> +		 (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP)));
>> +}
>> +
>> +static inline bool can_madv_free_vma(struct vm_area_struct *vma)
>> +{
>>  	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
>>  }
>>  
>> +static inline bool can_madv_dontneed_or_free_vma(struct vm_area_struct *vma,
>> +						 int behavior)
>> +{
>> +	if (behavior == MADV_DONTNEED)
>> +		return can_madv_dontneed_vma(vma);
>> +	else if (behavior == MADV_FREE)
>> +		return can_madv_free_vma(vma);
>> +	else
>> +		return 0;
>> +}
>> +
>>  void unmap_page_range(struct mmu_gather *tlb,
>>  			     struct vm_area_struct *vma,
>>  			     unsigned long addr, unsigned long end,
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 4d3c922..61ff306 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -517,7 +517,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>>  				  int behavior)
>>  {
>>  	*prev = vma;
>> -	if (!can_madv_dontneed_vma(vma))
>> +	if (!can_madv_dontneed_or_free_vma(vma, behavior))
>>  		return -EINVAL;
>>  
>>  	if (!userfaultfd_remove(vma, start, end)) {
>> @@ -539,7 +539,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>>  			 */
>>  			return -ENOMEM;
>>  		}
>> -		if (!can_madv_dontneed_vma(vma))
>> +		if (!can_madv_dontneed_or_free_vma(vma, behavior))
>>  			return -EINVAL;
>>  		if (end > vma->vm_end) {
>>  			/*
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 8ba6cb8..9817d15 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -492,7 +492,7 @@ void __oom_reap_task_mm(struct mm_struct *mm)
>>  	set_bit(MMF_UNSTABLE, &mm->flags);
>>  
>>  	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
>> -		if (!can_madv_dontneed_vma(vma))
>> +		if (!can_madv_free_vma(vma))
>>  			continue;
>>  
>>  		/*
>> -- 
>> 2.7.4
>>
> 
