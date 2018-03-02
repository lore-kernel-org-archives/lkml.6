Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936146AbeCBHbs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:31:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:46928 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935717AbeCBHbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:31:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="22274212"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Matthew Wilcox" <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 2/3] mm/free_pcppages_bulk: do not hold lock when picking pages to free
References: <20180301062845.26038-1-aaron.lu@intel.com>
        <20180301062845.26038-3-aaron.lu@intel.com>
        <20180301135518.GJ15057@dhcp22.suse.cz>
Date: Fri, 02 Mar 2018 15:31:40 +0800
In-Reply-To: <20180301135518.GJ15057@dhcp22.suse.cz> (Michal Hocko's message
        of "Thu, 1 Mar 2018 14:55:18 +0100")
Message-ID: <87r2p3c4rn.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Thu 01-03-18 14:28:44, Aaron Lu wrote:
>> When freeing a batch of pages from Per-CPU-Pages(PCP) back to buddy,
>> the zone->lock is held and then pages are chosen from PCP's migratetype
>> list. While there is actually no need to do this 'choose part' under
>> lock since it's PCP pages, the only CPU that can touch them is us and
>> irq is also disabled.
>> 
>> Moving this part outside could reduce lock held time and improve
>> performance. Test with will-it-scale/page_fault1 full load:
>> 
>> kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
>> v4.16-rc2+  9034215        7971818       13667135       15677465
>> this patch  9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%
>> 
>> What the test does is: starts $nr_cpu processes and each will repeatedly
>> do the following for 5 minutes:
>> 1 mmap 128M anonymouse space;
>> 2 write access to that space;
>> 3 munmap.
>> The score is the aggregated iteration.
>
> Iteration count I assume. I am still quite surprised that this would
> have such a large impact.

The test is run with full load, this means near or more than 100
processes will allocate memory in parallel.  According to Amdahl's law,
the performance of a parallel program will be dominated by the serial
part.  For this case, the part protected by zone->lock.  So small
changes to code under zone->lock could make bigger changes to overall
score.

Best Regards,
Huang, Ying
