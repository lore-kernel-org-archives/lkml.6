Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9853ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FCC21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FCC21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJQWsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:48:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:37674 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeJQWsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:48:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 07:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="83357843"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.154]) ([10.7.198.154])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2018 07:52:16 -0700
Subject: Re: [mm PATCH v3 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Tatashin <pasha.tatashin@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, davem@davemloft.net,
        yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com,
        rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202656.2171.92963.stgit@localhost.localdomain>
 <57c559f6-4858-7a52-7fbb-979caa08f240@gmail.com>
 <20181017073045.GA20004@rapoport-lnx>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <debbf05a-5ab8-3886-f199-0bbdede7f50e@linux.intel.com>
Date:   Wed, 17 Oct 2018 07:52:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017073045.GA20004@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 12:30 AM, Mike Rapoport wrote:
> On Tue, Oct 16, 2018 at 03:01:11PM -0400, Pavel Tatashin wrote:
>>
>>
>> On 10/15/18 4:26 PM, Alexander Duyck wrote:
>>> This change makes it so that we use the same approach that was already in
>>> use on Sparc on all the archtectures that support a 64b long.
>>>
>>> This is mostly motivated by the fact that 8 to 10 store/move instructions
>>> are likely always going to be faster than having to call into a function
>>> that is not specialized for handling page init.
>>>
>>> An added advantage to doing it this way is that the compiler can get away
>>> with combining writes in the __init_single_page call. As a result the
>>> memset call will be reduced to only about 4 write operations, or at least
>>> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
>>> count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
>>> my system.
>>>
>>> One change I had to make to the function was to reduce the minimum page
>>> size to 56 to support some powerpc64 configurations.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>
>>
>> I have tested on Broadcom's Stingray cpu with 48G RAM:
>> __init_single_page() takes 19.30ns / 64-byte struct page
>> Wit the change it takes 17.33ns / 64-byte struct page
>   
> I gave it a run on an OpenPower (S812LC 8348-21C) with Power8 processor and
> with 128G of RAM. My results for 64-byte struct page were:
> 
> before: 4.6788ns
> after: 4.5882ns
> 
> My two cents :)

Thanks. I will add this and Pavel's data to the patch description.

- Alex
