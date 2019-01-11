Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC35820878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D1jkrOtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfAKX2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:28:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37358 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAKX2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:28:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0BNOFD2184137;
        Fri, 11 Jan 2019 23:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=n01d6VUlJ9jEVXWK367IjHyskrycNVR8C/q60qAtzy0=;
 b=D1jkrOtV1DboPm7M5T5e6brCcaw7qeQz5NZHD0dPrSfQ5w4DemLVZmC/m0FMg7Ocr2nY
 ChFIghdvO7l+p4VTf6vYV8IEiFy8A/G7H6bPj7Dwu3yvhcUj8qDLLxeLxTIagkXa7fSD
 gJWCTZQQh3KbribJU3PyozQ1PGrwiCZvotBsgM9rSCnwJdAb/XrpHIFvEMxbjXHRPORV
 0ENB4EGhEBqzr2lxCPRyD44QUnsA7wSz7HSvEJhzmvCKRkmPz8TT0x7+QAbQyyq/xBOM
 4em058hwuxYKQAA5Zkhr5vQlfxczyjkbf4cFxNv6mFKBpqfQts3+7E2ErWrLwOw1x51E fQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ptn7rfayw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 23:28:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0BNSdKw024397
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 23:28:39 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0BNScCK005834;
        Fri, 11 Jan 2019 23:28:38 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 15:28:38 -0800
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
Date:   Fri, 11 Jan 2019 15:28:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 1:55 PM, Kirill A. Shutemov wrote:
> On Fri, Jan 11, 2019 at 08:10:03PM +0000, Mike Kravetz wrote:
>> At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
>> to get an address returned by mmap() suitably aligned for THP.  It seems
>> that if mmap is asking for a mapping length greater than huge page
>> size, it should align the returned address to huge page size.
>>
>> THP alignment has already been added for DAX, shm and tmpfs.  However,
>> simple anon mappings does not take THP alignment into account.
> 
> In general case, when no hint address provided, all anonymous memory
> requests have tendency to clamp into a single bigger VMA and get you
> better chance having THP, even if a single allocation is too small.
> This patch will *reduce* the effect and I guess the net result will be
> net negative.

Ah!  I forgot about combining like mappings into a single vma.  Increasing
alignment could/would prevent this.

> The patch also effectively reduces bit available for ASLR and increases
> address space fragmentation (increases number of VMA and therefore page
> fault cost).
> 
> I think any change in this direction has to be way more data driven.

Ok, I just wanted to ask the question.  I've seen application code doing
the 'mmap sufficiently large area' then unmap to get desired alignment
trick.  Was wondering if there was something we could do to help.

Thanks
-- 
Mike Kravetz
