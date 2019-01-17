Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AEFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E15920859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfAQWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:50:17 -0500
Received: from www.sr71.net ([198.145.64.142]:58060 "EHLO blackbird.sr71.net"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfAQWuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:50:17 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2019 17:50:17 EST
Received: from [0.0.0.0] (50-39-110-205.bvtn.or.frontiernet.net [50.39.110.205])
        (Authenticated sender: dave)
        by blackbird.sr71.net (Postfix) with ESMTPSA id 6C3E3FA866;
        Thu, 17 Jan 2019 14:43:57 -0800 (PST)
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
To:     Jeff Moyer <jmoyer@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     thomas.lendacky@amd.com, mhocko@suse.com,
        linux-nvdimm@lists.01.org, tiwai@suse.de, ying.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, bp@suse.de,
        baiyaowei@cmss.chinamobile.com, zwisler@kernel.org,
        bhelgaas@google.com, fengguang.wu@intel.com,
        akpm@linux-foundation.org
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
From:   Dave Hansen <dave@sr71.net>
Message-ID: <360f77dc-fe8e-c7c4-84a0-852ef3c4a152@sr71.net>
Date:   Thu, 17 Jan 2019 14:43:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 8:29 AM, Jeff Moyer wrote:
>> Persistent memory is cool.  But, currently, you have to rewrite
>> your applications to use it.  Wouldn't it be cool if you could
>> just have it show up in your system like normal RAM and get to
>> it like a slow blob of memory?  Well... have I got the patch
>> series for you!
> So, isn't that what memory mode is for?
>   https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
> 
> Why do we need this code in the kernel?

So, my bad for not mentioning memory mode.  This patch set existed
before we could talk about it publicly, so it simply ignores its
existence.  It's a pretty glaring omissions at this point, sorry.

I'll add this to the patches, but here are a few reasons you might want
this instead of memory mode:
1. Memory mode is all-or-nothing.  Either 100% of your persistent memory
   is used for memory mode, or nothing is.  With this set, you can
   (theoretically) have very granular (128MB) assignment of PMEM to
   either volatile or persistent uses.  We have a few practical matters
   to fix to get us down to that 128MB value, but we can get there.
2. The capacity of memory mode is the size of your persistent memory.
   DRAM capacity is "lost" because it is used for cache.  With this,
   you get PMEM+DRAM capacity for memory.
3. DRAM acts as a cache with memory mode, and caches can lead to
   unpredictable latencies.  Since memory mode is all-or-nothing, your
   entire memory space is exposed to these unpredictable latencies.
   This solution lets you guarantee DRAM latencies if you need them.
4. The new "tier" of memory is exposed to software.  That means that you
   can build tiered applications or infrastructure.  A cloud provider
   could sell cheaper VMs that use more PMEM and more expensive ones
   that use DRAM.  That's impossible with memory mode.

Don't take this as criticism of memory mode.  Memory mode is awesome,
and doesn't strictly require *any* software changes (we have software
changes proposed for optimizing it though).  It has tons of other
advantages over *this* approach.  Basically, they are complementary
enough that we think both can live side-by-side.
