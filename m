Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88158C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5590F2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9tOmuxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBTF2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:28:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57300 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfBTF2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:28:03 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1K5Nqdn107694;
        Wed, 20 Feb 2019 05:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HEt47EOnYKZ4MXWE/vYh02pa3+mUHK/A4nFJgOZDUAM=;
 b=Z9tOmuxLWUCmkmrJFR9VF5Ybr4S4jGecXjdNM/mdvR8AHFAm53oBJicYJfPBeSZWCVLS
 /xBRM1NhX0pkAs97n4S/yYBaBy70hxhSqAhC+/yNehQ2SdXQFJCSab29/wA1DYk35hic
 ikjY3QwuuOqiNWqEtRZWITuCpqt2ewTiZWd8ZenBd6rV7pLQ/I6YaVCF9/HmV+Y0k2F8
 Ili+FDRhfmUBe1GnX3nD+FJ+UUGEr2dq7hJ+K2L3ETm7l9fI5SCrxBwFG/x9sNVCZKL9
 y3KZ/JBvj/CcbLXU4ZQKqQOalxs1WSZCWTBP2vxmpeB+5OToShcM5i3uFQcXdIkueBfa Cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81e7g12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 05:27:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1K5Rnp9026050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 05:27:49 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1K5Rm9x015235;
        Wed, 20 Feb 2019 05:27:49 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 21:27:48 -0800
Subject: Re: [RFC PATCH 00/31] Generating physically contiguous memory after
 page allocation
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <f4cf53a3-359b-8c66-ed15-112b3cf0f475@oracle.com>
 <FDDDB4C8-C5B5-46B0-9682-33AC063F7A46@nvidia.com>
 <5395a183-063f-d409-b957-51a8d02854b2@oracle.com>
 <EB22370B-C5FB-435A-A8D0-95159E403B83@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a92b785c-b6c9-146c-428b-b5b6f527d28c@oracle.com>
Date:   Tue, 19 Feb 2019 21:27:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <EB22370B-C5FB-435A-A8D0-95159E403B83@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 9:19 PM, Zi Yan wrote:
> On 19 Feb 2019, at 19:18, Mike Kravetz wrote:
>> Another high level question.  One of the benefits of this approach is
>> that exchanging pages does not require N free pages as you describe
>> above.  This assumes that the vma which we are trying to make contiguous
>> is already populated.  If it is not populated, then you also need to
>> have N free pages.  Correct?  If this is true, then is the expected use
>> case to first populate a vma, and then try to make contiguous?  I would
>> assume that if it is not populated and a request to make contiguous is
>> given, we should try to allocate/populate the vma with contiguous pages
>> at that time?
> 
> Yes, I assume the pages within the VMA are already populated but not contiguous
> yet.
> 
> My approach considers memory contiguity as an on-demand resource. In some phases
> of an application, accelerators or RDMA controllers would process/transfer data
> in one
> or more VMAs, at which time contiguous memory can help reduce address translation
> overheads or lift certain constraints. And different VMAs could be processed at
> different program phases, thus it might be hard to get contiguous memory for all
> these VMAs at the allocation time using alloc_contig_pages(). My approach can
> help get contiguous memory later, when the demand comes.
> 
> For some cases, you definitely can use alloc_contig_pages() to give users
> a contiguous area at page allocation time, if you know the user is going to use
> this
> area for accelerator data processing or as a RDMA buffer and the area size is
> fixed.
> 
> In addition, we can also use khugepaged approach, having a daemon periodically
> scan VMAs and use alloc_contig_pages() to convert non-contiguous pages in a VMA
> to contiguous pages, but it would require N free pages during the conversion.
> 
> In sum, my approach complements alloc_contig_pages() and provides more flexibility.
> It is not trying to replaces alloc_contig_pages().

Thank you for the explanation.  That makes sense.  I have mostly been
thinking about contiguous memory from an allocation perspective and did
not really consider other use cases.

-- 
Mike Kravetz
