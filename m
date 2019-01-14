Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B173C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E86320651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3BVlzjTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfANT0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:26:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:26:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0EJNU7f024088;
        Mon, 14 Jan 2019 19:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LRxXWiyehqYbBuW7O6LgTqYIsTc7dhOgAUatOAhhu4E=;
 b=3BVlzjTykqS4UCw/Q0TvJR6awo5C0DlBqkRAp4zrrEWhSwy8WcV0I0rsCQI3Ue4XcGLB
 9NUG2qzWzjp8+CO0rHwk+O4zIOpkovIU+p+DfvYWbwCmO8rNGuunrGgxPb/qxeD+9VbT
 X4y9vQVEwcpO8EpQwBE45KKcj2RKrXNjKBW9550Fkp44ObKPXb7yI068nr4i4JcBeiEs
 CHQB3szYOLEe67COPcjT/NXN44zFq3O/4pmr5kRGSPQa4aTQqxb9+BxBzAaZfCwOTVge
 tbx5Lud47rWvrVjDa54fqV8+zcdYjqdBFoAt32BeGgc4mPKq0m2hEiag0yGjIwezgCNT sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pybkc7kvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 19:26:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0EJQVnR029436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 19:26:31 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0EJQU8n006387;
        Mon, 14 Jan 2019 19:26:30 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jan 2019 11:26:29 -0800
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
 <ad3a53ba-82e2-2dc7-1cd2-feef7def0bc3@oracle.com>
 <50c6abdc-b906-d16a-2f8f-8647b3d129aa@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <7d1ccbc3-7dad-99de-1b15-77bb1196f9a3@oracle.com>
Date:   Mon, 14 Jan 2019 14:26:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <50c6abdc-b906-d16a-2f8f-8647b3d129aa@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9136 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/2019 1:54 PM, Mike Kravetz wrote:
> On 1/14/19 7:35 AM, Steven Sistare wrote:
>> On 1/11/2019 6:28 PM, Mike Kravetz wrote:
>>> On 1/11/19 1:55 PM, Kirill A. Shutemov wrote:
>>>> On Fri, Jan 11, 2019 at 08:10:03PM +0000, Mike Kravetz wrote:
>>>>> At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
>>>>> to get an address returned by mmap() suitably aligned for THP.  It seems
>>>>> that if mmap is asking for a mapping length greater than huge page
>>>>> size, it should align the returned address to huge page size.
>>
>> A better heuristic would be to return an aligned address if the length
>> is a multiple of the huge page size.  The gap (if any) between the end of
>> the previous VMA and the start of this VMA would be filled by subsequent
>> smaller mmap requests.  The new behavior would need to become part of the
>> mmap interface definition so apps can rely on it and omit their hoop-jumping
>> code.
> 
> Yes, the heuristic really should be 'length is a multiple of the huge page
> size'.  As you mention, this would still leave gaps.  I need to look closer
> but this may not be any worse than the trick of mapping an area with rounded
> up length and then unmapping pages at the beginning.
> 
> When I sent this out, the thought in the back of my mind was that this doesn't
> really matter unless there is some type of alignment guarantee.  Otherwise,
> user space code needs continue employing their code to check/force alignment.
> Making matters somewhat worse is that I do not believe there is C interface to
> query huge page size.  I thought there was discussion about adding one, but I
> can not find it.

Right. Solaris provides getpagesizes().

>> Personally I would like to see a new MAP_ALIGN flag and treat the addr
>> argument as the alignment (like Solaris), but I am told that adding flags
>> is problematic because old kernels accept undefined flag bits from userland
>> without complaint, so their behavior would change.
> 
> Well, a flag would clearly define desired behavior.
> 
> As others have been mentioned, there are mechanisms in place that allow user
> space code to get the alignment it wants.  However, it is at the expense of
> an additional system call or two.  Perhaps the question is, "Is it worth
> defining new behavior to eliminate this overhead?".
> 
> One other thing to consider is that at mmap time, we likely do not know if
> the vma will/can use THP.  We would know if system wide THP configuration
> is set to never or always.  However, I 'think' the default for most distros
> is madvize.  Therefore, it is not until a subsequent madvise call that we
> know THP will be employed.  If the application code will need to make this
> separate madvise call, then perhaps it is not too much to expect that it
> take explicit action to optimally align the mapping.

True.  It is annoying to write the extra code, but the power user will do it.

The heuristic alignment would primarily benefit applications that are not as
carefully optimized.

- Steve

