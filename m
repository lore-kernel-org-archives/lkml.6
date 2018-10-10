Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8062D2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8062D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJKACG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:02:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:15588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKACF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:02:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 09:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="98219516"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.156]) ([10.7.198.156])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2018 09:39:08 -0700
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        yi.z.zhang@linux.intel.com
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
 <20181010095838.GG5873@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com>
Date:   Wed, 10 Oct 2018 09:39:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181010095838.GG5873@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 2:58 AM, Michal Hocko wrote:
> On Tue 09-10-18 13:26:41, Alexander Duyck wrote:
> [...]
>> I would think with that being the case we still probably need the call to
>> __SetPageReserved to set the bit with the expectation that it will not be
>> cleared for device-pages since the pages are not onlined. Removing the call
>> to __SetPageReserved would probably introduce a number of regressions as
>> there are multiple spots that use the reserved bit to determine if a page
>> can be swapped out to disk, mapped as system memory, or migrated.
> 
> PageReserved is meant to tell any potential pfn walkers that might get
> to this struct page to back off and not touch it. Even though
> ZONE_DEVICE doesn't online pages in traditional sense it makes those
> pages available for further use so the page reserved bit should be
> cleared.

So from what I can tell that isn't necessarily the case. Specifically if 
the pagemap type is MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_PUBLIC both 
are special cases where the memory may not be accessible to the CPU or 
cannot be pinned in order to allow for eviction.

The specific case that Dan and Yi are referring to is for the type 
MEMORY_DEVICE_FS_DAX. For that type I could probably look at not setting 
the reserved bit. Part of me wants to say that we should wait and clear 
the bit later, but that would end up just adding time back to 
initialization. At this point I would consider the change more of a 
follow-up optimization rather than a fix though since this is tailoring 
things specifically for DAX versus the other ZONE_DEVICE types.

