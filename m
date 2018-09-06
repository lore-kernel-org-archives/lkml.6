Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB71C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeIFIb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:31:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbeIFIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:31:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w863utYX031258
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 23:58:33 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2masqee4yr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 23:58:32 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 5 Sep 2018 21:58:32 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 21:58:28 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w863wRYE48627794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 20:58:27 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A294B7805F;
        Wed,  5 Sep 2018 21:58:27 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64DBB7805C;
        Wed,  5 Sep 2018 21:58:25 -0600 (MDT)
Received: from [9.102.0.183] (unknown [9.102.0.183])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 21:58:25 -0600 (MDT)
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
 <20180905134848.GB3729@bombadil.infradead.org>
 <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
 <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Thu, 6 Sep 2018 09:28:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090603-0004-0000-0000-00001484D2C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084192; UDB=6.00559575; IPR=6.00864191;
 MB=3.00023137; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 03:58:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090603-0005-0000-0000-000088B6DEB8
Message-Id: <7e8a2960-2bee-9b49-fee0-c3c4e3b61bc2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 03:05 AM, Mike Kravetz wrote:
> On 09/05/2018 12:58 PM, Andrew Morton wrote:
>> On Wed, 5 Sep 2018 06:48:48 -0700 Matthew Wilcox <willy@infradead.org> wrote:
>>
>>>> I didn't. The reason I looked at current patch is to enable the usage of
>>>> put_page() from irq context. We do allow that for non hugetlb pages. So was
>>>> not sure adding that additional restriction for hugetlb
>>>> is really needed. Further the conversion to irqsave/irqrestore was
>>>> straightforward.
>>>
>>> straightforward, sure.  but is it the right thing to do?  do we want to
>>> be able to put_page() a hugetlb page from hardirq context?
>>
>> Calling put_page() against a huge page from hardirq seems like the
>> right thing to do - even if it's rare now, it will presumably become
>> more common as the hugepage virus spreads further across the kernel.
>> And the present asymmetry is quite a wart.
>>
>> That being said, arch/powerpc/mm/mmu_context_iommu.c:mm_iommu_free() is
>> the only known site which does this (yes?)

I guess so. It is the rcu callback to release the pinned pages.

> 
> IIUC, the powerpc iommu code 'remaps' user allocated hugetlb pages.  It is
> these pages that are of issue at put_page time.  I'll admit that code is new
> to me and I may not fully understand.  However, if this is accurate then it
> makes it really difficult to track down any other similar usage patterns.
> I can not find a reference to PageHuge in the powerpc iommu code.


I don't know enough about vfio to comment about whether it is powerpc 
specific. So the usage is w.r.t pass-through of usb device using vfio. 
We do pin the entire guest ram. This pin is released later using the rcu 
callbacks. We hit the issue when we use hugetlbfs backed guest ram.

> 
>>                                             so perhaps we could put some
>> stopgap workaround into that site and add a runtime warning into the
>> put_page() code somewhere to detect puttage of huge pages from hardirq
>> and softirq contexts.
> 
> I think we would add the warning/etc at free_huge_page.  The issue would
> only apply to hugetlb pages, not THP.
> 
> But, the more I think about it the more I think Aneesh's patch to do
> spin_lock/unlock_irqsave is the right way to go.  Currently, we only
> know of one place where a put_page of hugetlb pages is done from softirq
> context.  So, we could take the spin_lock/unlock_bh as Matthew suggested.
> When the powerpc iommu code was added, I doubt this was taken into account.
> I would be afraid of someone adding put_page from hardirq context.
> 

-aneesh

