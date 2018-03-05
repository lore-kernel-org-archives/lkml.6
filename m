Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeCEVT0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:19:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60958 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeCEVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:19:24 -0500
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
 <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
 <0709b55b-3b77-ba43-efbc-6f767714a0b7@linux.intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <b55a493a-3401-b493-d9fe-b873878e02e0@oracle.com>
Date: Mon, 5 Mar 2018 14:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <0709b55b-3b77-ba43-efbc-6f767714a0b7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050243
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 02:04 PM, Dave Hansen wrote:
> On 03/05/2018 12:28 PM, Khalid Aziz wrote:
>>> Do you have a way to tell that data is not being thrown away?  Like if
>>> the ADI metadata is different for two different cachelines within a
>>> single page?
>>
>> Yes, since access to tagged data is made using pointers with ADI tag
>> embedded in the top bits, any mismatch between what app thinks the ADI
>> tags should be and what is stored in the RAM for corresponding page will
>> result in exception. If ADI data gets thrown away, we will get an ADI
>> tag mismatch exception. If ADI tags for two different ADI blocks on a
>> page are different when app expected them to be the same, we will see an
>> exception on access to the block with wrong ADI data.
> 
> So, when an app has two different ADI tags on two parts of a page, the
> page gets swapped, and the ADI block size is under PAGE_SIZE, the app
> will get an ADI exception after swap-in through no fault of its own?
> 

Only if the kernel fails to re-establish ADI tags on the swapped in page 
which is why I added infrastructure to save the ADI tags for a page 
before it is swapped out and then re-establish those tags when the page 
is swapped back in. Kernel needs to save as many as ADI TAGS as may 
exist on each page, not just one tag per page. On sparc M7 8K pages, 
there are 128 ADI tags for the page, so kernel will store and restore 
128 ADI tags for each page on swap-out and swap-in. If kernel restores 
only one ADI tag for the page on swap in, app will get an exception and 
it will be kernel's fault.

--
Khalid
