Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4CEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3123B2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djjKsngD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3123B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIFCHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:07:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFCHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:07:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w85LYVwW188869;
        Wed, 5 Sep 2018 21:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1rUCE0mEqyDFADgBoEFF0Bqcz+tx6BkVwbHbd9H0oCw=;
 b=djjKsngDjR/eTIRKveV+I/81rDulqz1HtoC7Ls30DPzAQ+cB01r2QPKtofYHzGwDrDyf
 TgS8xrmtGETAhioB90xAXdZztIP04mtDzySB/tcrDeK2u+RaYgQlZYVXTw9Ea87q9uoI
 Yblr6W9oiBg9gyZKRWvWA3EfPPvMvFpE2LOw/aAZS41z4CYzaFTGMuak/anNoJ73uIw7
 ID5mLHUuxcC+rRXuTce45QgJ2ThE75eHlNuQMT1nNvNyAwZlIR+fVpSD434wzxfSBKwu
 jc2OIfhwjCQJnEZWXAaYO8LEXm+aPLsp4don9Euv5bpGRKgsOxCK6sclBhUJF08e/jns pQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m7kdqpdne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 21:35:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w85LZE4j015700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 21:35:14 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w85LZDBw023253;
        Wed, 5 Sep 2018 21:35:13 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 14:35:13 -0700
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
 <20180905134848.GB3729@bombadil.infradead.org>
 <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
Date:   Wed, 5 Sep 2018 14:35:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=785
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 12:58 PM, Andrew Morton wrote:
> On Wed, 5 Sep 2018 06:48:48 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
>>> I didn't. The reason I looked at current patch is to enable the usage of
>>> put_page() from irq context. We do allow that for non hugetlb pages. So was
>>> not sure adding that additional restriction for hugetlb
>>> is really needed. Further the conversion to irqsave/irqrestore was
>>> straightforward.
>>
>> straightforward, sure.  but is it the right thing to do?  do we want to
>> be able to put_page() a hugetlb page from hardirq context?
> 
> Calling put_page() against a huge page from hardirq seems like the
> right thing to do - even if it's rare now, it will presumably become
> more common as the hugepage virus spreads further across the kernel. 
> And the present asymmetry is quite a wart.
> 
> That being said, arch/powerpc/mm/mmu_context_iommu.c:mm_iommu_free() is
> the only known site which does this (yes?)

IIUC, the powerpc iommu code 'remaps' user allocated hugetlb pages.  It is
these pages that are of issue at put_page time.  I'll admit that code is new
to me and I may not fully understand.  However, if this is accurate then it
makes it really difficult to track down any other similar usage patterns.
I can not find a reference to PageHuge in the powerpc iommu code.

>                                            so perhaps we could put some
> stopgap workaround into that site and add a runtime warning into the
> put_page() code somewhere to detect puttage of huge pages from hardirq
> and softirq contexts.

I think we would add the warning/etc at free_huge_page.  The issue would
only apply to hugetlb pages, not THP.

But, the more I think about it the more I think Aneesh's patch to do
spin_lock/unlock_irqsave is the right way to go.  Currently, we only
know of one place where a put_page of hugetlb pages is done from softirq
context.  So, we could take the spin_lock/unlock_bh as Matthew suggested.
When the powerpc iommu code was added, I doubt this was taken into account.
I would be afraid of someone adding put_page from hardirq context.

-- 
Mike Kravetz

> And attention will need to be paid to -stable backporting.  How long
> has mm_iommu_free() existed, and been doing this?
