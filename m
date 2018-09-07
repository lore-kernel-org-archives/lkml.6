Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E662C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B418F2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeIGPzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:55:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbeIGPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:55:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87BEjeD048236
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 07:15:20 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mbnseedf3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:15:19 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 7 Sep 2018 05:15:18 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Sep 2018 05:15:14 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w87BFD8U52691034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Sep 2018 04:15:14 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E57B56E04E;
        Fri,  7 Sep 2018 05:15:13 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FFA6E053;
        Fri,  7 Sep 2018 05:15:11 -0600 (MDT)
Received: from [9.85.73.254] (unknown [9.85.73.254])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  7 Sep 2018 05:15:10 -0600 (MDT)
Subject: Re: [RFC PATCH V2 4/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
 <20180906125356.GX14951@dhcp22.suse.cz>
 <50d355bf-17d0-ee01-ec35-7f04e79ca277@linux.ibm.com>
 <20180907090312.GF19621@dhcp22.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Fri, 7 Sep 2018 16:45:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907090312.GF19621@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090711-0012-0000-0000-000016AEC080
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009677; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084816; UDB=6.00559948; IPR=6.00864817;
 MB=3.00023160; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-07 11:15:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090711-0013-0000-0000-000054514B51
Message-Id: <8337fdcc-3344-04dd-ddb2-68f86912f333@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:33 PM, Michal Hocko wrote:
> On Thu 06-09-18 19:00:43, Aneesh Kumar K.V wrote:
>> On 09/06/2018 06:23 PM, Michal Hocko wrote:
>>> On Thu 06-09-18 11:13:42, Aneesh Kumar K.V wrote:
>>>> Current code doesn't do page migration if the page allocated is a compound page.
>>>> With HugeTLB migration support, we can end up allocating hugetlb pages from
>>>> CMA region. Also THP pages can be allocated from CMA region. This patch updates
>>>> the code to handle compound pages correctly.
>>>>
>>>> This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
>>>> with right count, instead of doing one get_user_pages per page. That avoids
>>>> reading page table multiple times.
>>>>
>>>> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
>>>> We use the same storage location to store pointers to struct page. We cannot
>>>> update alll the code path use struct page *, because we access hpas in real mode
>>>> and we can't do that struct page * to pfn conversion in real mode.
>>>
>>> I am not fmailiar with this code so bear with me. I am completely
>>> missing the purpose of this patch. The changelog doesn't really explain
>>> that AFAICS. I can only guess that you do not want to establish long
>>> pins on CMA pages, right? So whenever you are about to pin a page that
>>> is in CMA you migrate it away to a different !__GFP_MOVABLE page, right?
>>
>> That is right.
>>
>>> If that is the case then how do you handle pins which are already in
>>> zone_movable? I do not see any specific check for those.
>>
>>
>>>
>>> Btw. why is this a proper thing to do? Problems with longterm pins are
>>> not only for CMA/ZONE_MOVABLE pages. Pinned pages are not reclaimable as
>>> well so there is a risk of OOMs if there are too many of them. We have
>>> discussed approaches that would allow to force pin invalidation/revocation
>>> at LSF/MM. Isn't that a more appropriate solution to the problem you are
>>> seeing?
>>>
>>
>> The CMA area is used on powerpc platforms to allocate guest specific page
>> table (hash page table). If we don't have sufficient free pages we fail to
>> allocate hash page table that result in failure to start guest.
>>
>> Now with vfio, we end up pinning the entire guest RAM. There is a
>> possibility that these guest RAM  pages got allocated from CMA region. We
>> already do supporting migrating those pages out except for compound pages.
>> What this patch does is to start supporting compound page migration that got
>> allocated out of CMA region (ie, THP pages and hugetlb pages if platform
>> supported hugetlb migration).
> 
> This definitely belongs to the changelog.
> 
>> Now to do that I added a helper get_user_pages_cma_migrate().
>>
>> I agree that long term pinned pages do have other issues. The patchset is
>> not solving that issue.
> 
> It would be great to note why a generic approach is not viable. I assume
> the main reason is that those pins are pretty much permanent for the
> guest lifetime so the situation has to be handled in advance. In other
> words, more information please.
> 

That is correct. I will add these details to commit message. And will 
also do a cover letter for the patch series.

-aneesh

