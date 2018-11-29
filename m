Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F666C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E5220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E5220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeK2R1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:27:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727416AbeK2R1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:27:30 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAT6Jt2j070635
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:23:14 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p27mrep2j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:23:13 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 29 Nov 2018 06:23:13 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Nov 2018 06:23:11 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAT6NAX813566060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 06:23:10 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 793DDAC05F;
        Thu, 29 Nov 2018 06:23:10 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04D31AC065;
        Thu, 29 Nov 2018 06:23:07 +0000 (GMT)
Received: from [9.85.85.107] (unknown [9.85.85.107])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Nov 2018 06:23:07 +0000 (GMT)
Subject: Re: [PATCH V2 4/5] mm/hugetlb: Add prot_modify_start/commit sequence
 for hugetlb update
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
 <20181128143438.29458-5-aneesh.kumar@linux.ibm.com>
 <20181128141051.ff38f23023f652759b06f828@linux-foundation.org>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 29 Nov 2018 11:53:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181128141051.ff38f23023f652759b06f828@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112906-0060-0000-0000-000002DB389C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010141; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124324; UDB=6.00583735; IPR=6.00904451;
 MB=3.00024378; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-29 06:23:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112906-0061-0000-0000-0000475BB2C7
Message-Id: <d7ee1b8c-2f45-f430-b413-9d511e7d78c4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 3:40 AM, Andrew Morton wrote:
> On Wed, 28 Nov 2018 20:04:37 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> Some explanation of the motivation would be useful.

I will update the commit message.


> 
>>   include/linux/hugetlb.h | 18 ++++++++++++++++++
>>   mm/hugetlb.c            |  8 +++++---
>>   2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 087fd5f48c91..e2a3b0c854eb 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -543,6 +543,24 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>>   	set_huge_pte_at(mm, addr, ptep, pte);
>>   }
>>   #endif
>> +
>> +#ifndef huge_ptep_modify_prot_start
>> +static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
>> +						unsigned long addr, pte_t *ptep)
>> +{
>> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>> +}
>> +#endif
> 
> #define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
> 
>> +#ifndef huge_ptep_modify_prot_commit
>> +static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>> +						unsigned long addr, pte_t *ptep,
>> +						pte_t old_pte, pte_t pte)
>> +{
>> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +}
>> +#endif
> 
> #define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
> 
> 

Will update.

-aneesh

