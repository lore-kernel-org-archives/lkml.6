Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932527AbeCEVEO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:04:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:25198 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932069AbeCEVEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:04:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32598347"
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page
 metadata on swap
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        davem@davemloft.net, arnd@arndb.de
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
 <0d77dc3c-1454-a689-a0fb-f07e8973c29e@linux.intel.com>
 <4a766f6d-ba96-7963-b367-7214eab7e307@oracle.com>
 <d807ba68-decd-e195-f607-ef6962e40c96@linux.intel.com>
 <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com,
        ross.zwisler@linux.intel.com, dave.jiang@intel.com,
        mgorman@techsingularity.net, willy@infradead.org, hughd@google.com,
        minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org,
        jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <0709b55b-3b77-ba43-efbc-6f767714a0b7@linux.intel.com>
Date: Mon, 5 Mar 2018 13:04:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <66c8ab93-f491-ad2e-5313-d03e23f73006@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 12:28 PM, Khalid Aziz wrote:
>> Do you have a way to tell that data is not being thrown away?  Like if
>> the ADI metadata is different for two different cachelines within a
>> single page?
> 
> Yes, since access to tagged data is made using pointers with ADI tag
> embedded in the top bits, any mismatch between what app thinks the ADI
> tags should be and what is stored in the RAM for corresponding page will
> result in exception. If ADI data gets thrown away, we will get an ADI
> tag mismatch exception. If ADI tags for two different ADI blocks on a
> page are different when app expected them to be the same, we will see an
> exception on access to the block with wrong ADI data.

So, when an app has two different ADI tags on two parts of a page, the
page gets swapped, and the ADI block size is under PAGE_SIZE, the app
will get an ADI exception after swap-in through no fault of its own?
