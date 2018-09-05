Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF894C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5113E2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W9stpubB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5113E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeIFEX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:23:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33854 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeIFEX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:23:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w85NmZ9c134193;
        Wed, 5 Sep 2018 23:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=G6Wj43q2rIoVttU6gcAfm8BfcqI4XTJSVomeiw97jY8=;
 b=W9stpubBtwdwqIyfskg3MmwgxBhE3zsHKwsE5l+CZkJDgZ2DE6zCKMR+TAfs1xpzDQ78
 /N1N+/Uc9H0HQzy7P+vjxBho0gY8f4g/PEFwZQMH/KRo9iAzPc86o9PPTlHvGpKMthLH
 2A1tNZh0CIpboizk1+hbB+tIfyC40qgEyp2XQCujxE4rPpuebwnqzsKBCmHyPHBmB7TF
 Fw5oIvbNhLxUonrOmqeJAqXtRvUhWl8K1jC9+3eFmO25BeNmpgTntu44aHadIO3eLYK2
 t8RiKp5sJmGN5X4CMMAo7eiayXSyjLHVXhHy4I6czj3gTfJEQVF0lbuPBDllDyF3aj1R TA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m7jqppyms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 23:51:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w85Np2Ql028172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 23:51:02 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w85Np1qL028279;
        Wed, 5 Sep 2018 23:51:01 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 16:51:01 -0700
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
 <20180905134848.GB3729@bombadil.infradead.org>
 <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
 <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
 <20180905150008.59d477c1f78f966a8f9c3cc8@linux-foundation.org>
 <20180905230737.GA14977@bombadil.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c03c8851-ce18-56c6-3f37-47f585d70b19@oracle.com>
Date:   Wed, 5 Sep 2018 16:51:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905230737.GA14977@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 04:07 PM, Matthew Wilcox wrote:
> On Wed, Sep 05, 2018 at 03:00:08PM -0700, Andrew Morton wrote:
>> On Wed, 5 Sep 2018 14:35:11 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>>>>                                            so perhaps we could put some
>>>> stopgap workaround into that site and add a runtime warning into the
>>>> put_page() code somewhere to detect puttage of huge pages from hardirq
>>>> and softirq contexts.
>>>
>>> I think we would add the warning/etc at free_huge_page.  The issue would
>>> only apply to hugetlb pages, not THP.
>>>
>>> But, the more I think about it the more I think Aneesh's patch to do
>>> spin_lock/unlock_irqsave is the right way to go.  Currently, we only
>>> know of one place where a put_page of hugetlb pages is done from softirq
>>> context.  So, we could take the spin_lock/unlock_bh as Matthew suggested.
>>> When the powerpc iommu code was added, I doubt this was taken into account.
>>> I would be afraid of someone adding put_page from hardirq context.
>>
>> Me too.  If we're going to do this, surely we should make hugepages
>> behave in the same fashion as PAGE_SIZE pages.
> 
> But these aren't vanilla hugepages, they're specifically hugetlbfs pages.
> I don't believe there's any problem with calling put_page() on a normally
> allocated huge page or THP.

Right
The powerpc iommu code (at least) treated hugetlbfs pages as any other page
(huge, THP or base) and called put_page from softirq context.

It seems there are at least two ways to address this:
1) Prohibit this behavior for hugetlbfs pages
2) Try to make hugetlbfs pages behave like other pages WRT put_page

Aneesh's patch went further than allowing put_page of hugetlbfs pages
from softirq context.  It allowed them from hardirq context as well:
admittedly at a cost of disabling irqs.

This issue has probably existed since the addition of powerpc iommu code.
IMO, we should make hugetlbfs pages behave more like other pages in this
case.

BTW, free_huge_page called by put_page for hugetlbfs pages may also take
a subpool specific lock via spin_lock().  See hugepage_subpool_put_pages.
So, this would also need to take irq context into account.
-- 
Mike Kravetz
