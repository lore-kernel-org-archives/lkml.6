Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063B120866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OwUiKMHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbfAOSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:09:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfAOSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:09:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0FI91lX067570;
        Tue, 15 Jan 2019 18:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=FLW84yJm9KbM1OoFE3utsganR8OPBeXYHN05HbnyItw=;
 b=OwUiKMHazbSFQHTZBm/a1dMvx2S5w4ozAqzqyTN0ST+B6lpI1QgXicZFB/KO2Gajw6jY
 lOCQcRl7/66fBIogK9TzkVUA5BvG+2Amv/hpDaYEtUDGcMm58jGaB0u2td/vonpLA8G2
 fMnI0IfXe75hFjiVBBSnEaiYwiasTUv37YW5ga42xP40uzr65+S0Jh2k+kBEVXFpCWI+
 AF0s1AqTtPpDtCj+/VGlALdEhrrou+IFLc9b+LYhPItijUUfjuM+gHZmQqZ41HngjFdf
 90nlHBzrfkZ+2ZDyMme/BHjcAZtMliImqBlspzrtuSDj5iTW/CSeYNZgWdIqPfk+yaC4 bw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pybjs5fb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 18:09:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0FI91hf020815
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 18:09:02 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0FI90f7022642;
        Tue, 15 Jan 2019 18:09:00 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jan 2019 10:09:00 -0800
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux_lkml_grp@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
 <ad3a53ba-82e2-2dc7-1cd2-feef7def0bc3@oracle.com>
 <50c6abdc-b906-d16a-2f8f-8647b3d129aa@oracle.com>
 <20190115082450.stl6vlrgbvikbwzq@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9a1c07f8-68d0-835c-6461-bb64fef977bf@oracle.com>
Date:   Tue, 15 Jan 2019 10:08:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115082450.stl6vlrgbvikbwzq@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901150148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 12:24 AM, Kirill A. Shutemov wrote:
> On Mon, Jan 14, 2019 at 10:54:45AM -0800, Mike Kravetz wrote:
>> On 1/14/19 7:35 AM, Steven Sistare wrote:
>>> On 1/11/2019 6:28 PM, Mike Kravetz wrote:
>>>> On 1/11/19 1:55 PM, Kirill A. Shutemov wrote:
>>>>> On Fri, Jan 11, 2019 at 08:10:03PM +0000, Mike Kravetz wrote:
>>>>>> At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
>>>>>> to get an address returned by mmap() suitably aligned for THP.  It seems
>>>>>> that if mmap is asking for a mapping length greater than huge page
>>>>>> size, it should align the returned address to huge page size.
>>>
>>> A better heuristic would be to return an aligned address if the length
>>> is a multiple of the huge page size.  The gap (if any) between the end of
>>> the previous VMA and the start of this VMA would be filled by subsequent
>>> smaller mmap requests.  The new behavior would need to become part of the
>>> mmap interface definition so apps can rely on it and omit their hoop-jumping
>>> code.
>>
>> Yes, the heuristic really should be 'length is a multiple of the huge page
>> size'.  As you mention, this would still leave gaps.  I need to look closer
>> but this may not be any worse than the trick of mapping an area with rounded
>> up length and then unmapping pages at the beginning.
> 
> The question why is it any better. Virtual address space is generally
> cheap, additional VMA maybe more signficiant due to find_vma() overhead.
> 
> And you don't *need* to unmap anything. Just use alinged pointer.

You are correct, it is not any better.

I know you do not need to unmap anything.  However, I believe people are
writing code which does this today.  For example, qemu's qemu_ram_mmap()
utility routine does this, but it may have other reasons for creating
the gap.

Thanks for all of the feedback.  I do not think there is anything we can
or should do in this area.  As Steve said, 'power users' who want to get
optimal THP usage will write the code to make that happen.
-- 
Mike Kravetz
