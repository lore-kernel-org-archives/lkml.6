Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76DD23D82
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76DD23D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeFVFr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:47:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751151AbeFVFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:47:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5M5iGTL002344
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:47:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jrpg5regp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:47:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 06:47:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 06:47:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5M5lLWn31785086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 05:47:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 143085204E;
        Fri, 22 Jun 2018 06:47:19 +0100 (BST)
Received: from skywalker (unknown [9.124.31.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id B79205204F;
        Fri, 22 Jun 2018 06:47:17 +0100 (BST)
Received: (nullmailer pid 3216 invoked by uid 1000);
        Fri, 22 Jun 2018 05:47:19 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA API
In-Reply-To: <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
References: <20180621212835.5636-1-willy@infradead.org> <20180621212835.5636-14-willy@infradead.org> <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
Date:   Fri, 22 Jun 2018 11:17:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18062205-4275-0000-0000-000002908EDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062205-4276-0000-0000-00003797DFA5
Message-Id: <87wourbcew.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 21 Jun 2018 14:28:22 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
>
>> ida_alloc_range is the perfect fit for this use case.  Eliminates
>> a custom spinlock, a call to ida_pre_get and a local check for the
>> allocated ID exceeding a maximum.
>> 
>> Signed-off-by: Matthew Wilcox <willy@infradead.org>
>> ---
>>  arch/powerpc/mm/mmu_context_book3s64.c | 44 +++-----------------------
>>  1 file changed, 4 insertions(+), 40 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
>> index f3d4b4a0e561..5a0cf2cc8ba0 100644
>> --- a/arch/powerpc/mm/mmu_context_book3s64.c
>> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
>> @@ -26,48 +26,16 @@
>>  #include <asm/mmu_context.h>
>>  #include <asm/pgalloc.h>
>>  
>> -static DEFINE_SPINLOCK(mmu_context_lock);
>>  static DEFINE_IDA(mmu_context_ida);
>>  
>>  static int alloc_context_id(int min_id, int max_id)
>>  {
>> -	int index, err;
>> -
>> -again:
>> -	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
>> -		return -ENOMEM;
>> -
>> -	spin_lock(&mmu_context_lock);
>> -	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
>> -	spin_unlock(&mmu_context_lock);
>> -
>> -	if (err == -EAGAIN)
>> -		goto again;
>> -	else if (err)
>> -		return err;
>> -
>> -	if (index > max_id) {
>> -		spin_lock(&mmu_context_lock);
>> -		ida_remove(&mmu_context_ida, index);
>> -		spin_unlock(&mmu_context_lock);
>> -		return -ENOMEM;
>> -	}
>> -
>> -	return index;
>> +	return ida_alloc_range(&mmu_context_ida, min_id, max_id, GFP_KERNEL);
>>  }
>>  
>>  void hash__reserve_context_id(int id)
>>  {
>> -	int rc, result = 0;
>> -
>> -	do {
>> -		if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
>> -			break;
>> -
>> -		spin_lock(&mmu_context_lock);
>> -		rc = ida_get_new_above(&mmu_context_ida, id, &result);
>> -		spin_unlock(&mmu_context_lock);
>> -	} while (rc == -EAGAIN);
>> +	int result = ida_alloc_range(&mmu_context_ida, id, id, GFP_KERNEL);
>>  
>>  	WARN(result != id, "mmu: Failed to reserve context id %d (rc %d)\n", id, result);
>>  }
>> @@ -172,9 +140,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>  
>>  void __destroy_context(int context_id)
>>  {
>> -	spin_lock(&mmu_context_lock);
>> -	ida_remove(&mmu_context_ida, context_id);
>> -	spin_unlock(&mmu_context_lock);
>> +	ida_free(&mmu_context_ida, context_id);
>>  }
>>  EXPORT_SYMBOL_GPL(__destroy_context);
>>  
>> @@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
>>  {
>>  	int index, context_id;
>>  
>> -	spin_lock(&mmu_context_lock);
>>  	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
>>  		context_id = ctx->extended_id[index];
>>  		if (context_id)
>> -			ida_remove(&mmu_context_ida, context_id);
>> +			ida_free(&mmu_context_ida, context_id);
>>  	}
>> -	spin_unlock(&mmu_context_lock);
>>  }
>>  
>>  static void pte_frag_destroy(void *pte_frag)
>
> This hunk should be okay because the mmu_context_lock does not protect
> the extended_id array, right Aneesh?

Yes. This is called at process exit, so we should not find parallel
calls. On the allocation side, we are protected by mmap_sem. We do
allocate extended_id when doing mmap.

-aneesh

