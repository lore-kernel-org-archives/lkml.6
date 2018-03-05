Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeCEUdu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:33:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58272 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeCEUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:33:47 -0500
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page
 metadata on swap
To: Dave Hansen <dave.hansen@linux.intel.com>, akpm@linux-foundation.org,
        davem@davemloft.net, arnd@arndb.de
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com,
        ross.zwisler@linux.intel.com, dave.jiang@intel.com,
        mgorman@techsingularity.net, willy@infradead.org, hughd@google.com,
        minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org,
        jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
 <0d77dc3c-1454-a689-a0fb-f07e8973c29e@linux.intel.com>
 <4a766f6d-ba96-7963-b367-7214eab7e307@oracle.com>
 <d807ba68-decd-e195-f607-ef6962e40c96@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
Date: Mon, 5 Mar 2018 13:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <d807ba68-decd-e195-f607-ef6962e40c96@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 12:35 PM, Dave Hansen wrote:
> On 03/05/2018 11:29 AM, Khalid Aziz wrote:
>> ADI data is per page data and is held in the spare bits in the RAM. It
>> is loaded into the cache when data is loaded from RAM and flushed out to
>> spare bits in the RAM when data is flushed from cache. Sparc allows one
>> tag for each ADI block size of data and ADI block size is same as
>> cacheline size.
> 
> Which does not square with your earlier assertion "ADI data is per page
> data".  It's per-cacheline data.  Right?

That is one way to look at it. Current sparc processors do implement 
same ADI block size as cacheline size but architecture does not require 
ADI block size to be same as cacheline size. If those two sizes were 
different, we wouldn't call it cacheline data.

> 
>> When a page is loaded into RAM from swap space, all of
>> the associated ADI data for the page must also be loaded into the RAM,
>> so it looks like page level data and storing it in page level software
>> data structure makes sense. I am open to other suggestions though.
> 
> Do you have a way to tell that data is not being thrown away?  Like if
> the ADI metadata is different for two different cachelines within a
> single page?

Yes, since access to tagged data is made using pointers with ADI tag 
embedded in the top bits, any mismatch between what app thinks the ADI 
tags should be and what is stored in the RAM for corresponding page will 
result in exception. If ADI data gets thrown away, we will get an ADI 
tag mismatch exception. If ADI tags for two different ADI blocks on a 
page are different when app expected them to be the same, we will see an 
exception on access to the block with wrong ADI data.

--
Khalid
