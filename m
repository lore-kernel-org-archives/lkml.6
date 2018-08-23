Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFDBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3660C208AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3660C208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeHWG3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 02:29:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727091AbeHWG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 02:29:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N2x2hm133923
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 23:01:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1m3b12s9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 23:01:46 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 22 Aug 2018 21:01:45 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 21:01:41 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N31eSf6029748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 20:01:40 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5044EBE053;
        Wed, 22 Aug 2018 21:01:40 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4D27BE05B;
        Wed, 22 Aug 2018 21:01:36 -0600 (MDT)
Received: from [9.85.69.10] (unknown [9.85.69.10])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 21:01:36 -0600 (MDT)
Subject: Re: Infinite looping observed in __offline_pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Haren Myneni <haren@linux.vnet.ibm.com>
Cc:     n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
        mgorman@suse.de
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz> <87bm9ug34l.fsf@linux.ibm.com>
 <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 23 Aug 2018 08:31:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54c72a22-a921-fc64-460d-f66985d0df4e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082303-0016-0000-0000-0000091FA5CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009595; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077486; UDB=6.00555535; IPR=6.00857461;
 MB=3.00022878; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 03:01:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082303-0017-0000-0000-000040185E41
Message-Id: <ba980214-5189-cd9e-6775-6f619656a041@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 12:28 AM, Mike Kravetz wrote:
> On 08/22/2018 02:30 AM, Aneesh Kumar K.V wrote:
>> commit 2e9d754ac211f2af3731f15df3cd8cd070b4cc54
>> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Date:   Tue Aug 21 14:17:55 2018 +0530
>>
>>      mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
>>      
>>      When scanning for movable pages, filter out Hugetlb pages if hugepage migration
>>      is not supported. Without this we hit infinte loop in __offline pages where we
>>      do
>>              pfn = scan_movable_pages(start_pfn, end_pfn);
>>              if (pfn) { /* We have movable pages */
>>                      ret = do_migrate_range(pfn, end_pfn);
>>                      goto repeat;
>>              }
>>      
>>      We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
> 
> I thought migration at pgd level was added for POWER?  commit 94310cbcaa3c
> (mm/madvise: enable (soft|hard) offline of HugeTLB pages at PGD level).
> Only remember, because I did not fully understand the use case. :)
> 

yes. We hit the issue on older distro kernels.

>>      we just check for Kernel config. The gigantic page size check is done in
>>      page_huge_active.
>>      
>>      Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
>>      CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 4eb6e824a80c..f9bdea685cf4 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>>   				return pfn;
>>   			if (__PageMovable(page))
>>   				return pfn;
>> -			if (PageHuge(page)) {
>> +			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
>> +			    PageHuge(page)) {
> 
> How about using hugepage_migration_supported instead?  It would automatically
> catch those non-migratable huge page sizes.  Something like:
> 


Will do that.

> 			if (PageHuge(page) &&
> 			    hugepage_migration_supported(page_hstate(page))) {
> 

-aneesh

