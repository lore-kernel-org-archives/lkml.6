Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7221AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430EA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EIk35YtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:36:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfANPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:36:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0EFSx49011678;
        Mon, 14 Jan 2019 15:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wAbku0n0ZmnKcGbXvkVv10iFzXXgTeSrZJjX6nGCyc8=;
 b=EIk35YtVk8irMk4hsG89g1ZIM20NLKjuN6nCgHT1QM/i1vgAct3TpckB1iU7VR4MTwij
 ZjX/KnVVt+tFVY5qvlPImti8jcQo4xiVy1zn/7xNgO8McDoaSFxh/Dc7zIQxQfADV0am
 zuqz9cdwYVRDlWMgNBMAHXSm58AAw/cAUBh+ezc1hSxhid8r+AgOzCp725R3O12rF4CS
 vHswtCSV1/0KURlkh+U2iF0UfqiwY9ruk6ZvkRB+gjjLV6dbXGwmLAKLUeuxbEUyed6A
 w8736AnRkbRkCBtDtdHfKrQSAo4Apl5S6bS4pvxC3XDPJyQplOSsdCM6NjJ+50iMVOFj yg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pybkc65a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 15:35:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0EFZshU010907
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 15:35:54 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0EFZr3G015840;
        Mon, 14 Jan 2019 15:35:53 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jan 2019 07:35:52 -0800
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux_lkml_grp@oracle.com
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
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <ad3a53ba-82e2-2dc7-1cd2-feef7def0bc3@oracle.com>
Date:   Mon, 14 Jan 2019 10:35:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9136 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 6:28 PM, Mike Kravetz wrote:
> On 1/11/19 1:55 PM, Kirill A. Shutemov wrote:
>> On Fri, Jan 11, 2019 at 08:10:03PM +0000, Mike Kravetz wrote:
>>> At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
>>> to get an address returned by mmap() suitably aligned for THP.  It seems
>>> that if mmap is asking for a mapping length greater than huge page
>>> size, it should align the returned address to huge page size.

A better heuristic would be to return an aligned address if the length
is a multiple of the huge page size.  The gap (if any) between the end of
the previous VMA and the start of this VMA would be filled by subsequent
smaller mmap requests.  The new behavior would need to become part of the
mmap interface definition so apps can rely on it and omit their hoop-jumping
code.

Personally I would like to see a new MAP_ALIGN flag and treat the addr
argument as the alignment (like Solaris), but I am told that adding flags
is problematic because old kernels accept undefined flag bits from userland
without complaint, so their behavior would change.

- Steve

>>> THP alignment has already been added for DAX, shm and tmpfs.  However,
>>> simple anon mappings does not take THP alignment into account.
>>
>> In general case, when no hint address provided, all anonymous memory
>> requests have tendency to clamp into a single bigger VMA and get you
>> better chance having THP, even if a single allocation is too small.
>> This patch will *reduce* the effect and I guess the net result will be
>> net negative.
> 
> Ah!  I forgot about combining like mappings into a single vma.  Increasing
> alignment could/would prevent this.
> 
>> The patch also effectively reduces bit available for ASLR and increases
>> address space fragmentation (increases number of VMA and therefore page
>> fault cost).
>>
>> I think any change in this direction has to be way more data driven.
> 
> Ok, I just wanted to ask the question.  I've seen application code doing
> the 'mmap sufficiently large area' then unmap to get desired alignment
> trick.  Was wondering if there was something we could do to help.
> 
> Thanks
> 
