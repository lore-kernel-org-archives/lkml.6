Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE24C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB492075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB492075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeIFSG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:06:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728776AbeIFSG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:06:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86DUSqq007921
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 09:30:55 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mb31bpbkt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:30:53 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 6 Sep 2018 07:30:52 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 07:30:49 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86DUmbG38142124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 06:30:48 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5EC87805C;
        Thu,  6 Sep 2018 07:30:48 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A2B27805E;
        Thu,  6 Sep 2018 07:30:45 -0600 (MDT)
Received: from [9.102.0.183] (unknown [9.102.0.183])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 07:30:45 -0600 (MDT)
Subject: Re: [RFC PATCH V2 4/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
 <20180906125356.GX14951@dhcp22.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 6 Sep 2018 19:00:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906125356.GX14951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090613-8235-0000-0000-00000DF9D812
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084382; UDB=6.00559689; IPR=6.00864382;
 MB=3.00023143; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 13:30:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090613-8236-0000-0000-0000428BBFBF
Message-Id: <50d355bf-17d0-ee01-ec35-7f04e79ca277@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 06:23 PM, Michal Hocko wrote:
> On Thu 06-09-18 11:13:42, Aneesh Kumar K.V wrote:
>> Current code doesn't do page migration if the page allocated is a compound page.
>> With HugeTLB migration support, we can end up allocating hugetlb pages from
>> CMA region. Also THP pages can be allocated from CMA region. This patch updates
>> the code to handle compound pages correctly.
>>
>> This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
>> with right count, instead of doing one get_user_pages per page. That avoids
>> reading page table multiple times.
>>
>> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
>> We use the same storage location to store pointers to struct page. We cannot
>> update alll the code path use struct page *, because we access hpas in real mode
>> and we can't do that struct page * to pfn conversion in real mode.
> 
> I am not fmailiar with this code so bear with me. I am completely
> missing the purpose of this patch. The changelog doesn't really explain
> that AFAICS. I can only guess that you do not want to establish long
> pins on CMA pages, right? So whenever you are about to pin a page that
> is in CMA you migrate it away to a different !__GFP_MOVABLE page, right?

That is right.

> If that is the case then how do you handle pins which are already in
> zone_movable? I do not see any specific check for those.


> 
> Btw. why is this a proper thing to do? Problems with longterm pins are
> not only for CMA/ZONE_MOVABLE pages. Pinned pages are not reclaimable as
> well so there is a risk of OOMs if there are too many of them. We have
> discussed approaches that would allow to force pin invalidation/revocation
> at LSF/MM. Isn't that a more appropriate solution to the problem you are
> seeing?
> 

The CMA area is used on powerpc platforms to allocate guest specific 
page table (hash page table). If we don't have sufficient free pages we 
fail to allocate hash page table that result in failure to start guest.

Now with vfio, we end up pinning the entire guest RAM. There is a 
possibility that these guest RAM  pages got allocated from CMA region. 
We already do supporting migrating those pages out except for compound 
pages. What this patch does is to start supporting compound page 
migration that got allocated out of CMA region (ie, THP pages and 
hugetlb pages if platform supported hugetlb migration).

Now to do that I added a helper get_user_pages_cma_migrate().

I agree that long term pinned pages do have other issues. The patchset 
is not solving that issue.

-aneesh

