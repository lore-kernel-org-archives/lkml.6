Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819EE20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819EE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeKJI5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:57:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:46908 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbeKJI5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:57:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 15:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,485,1534834800"; 
   d="scan'208";a="99073548"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 09 Nov 2018 15:14:35 -0800
Message-ID: <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        daniel.m.jordan@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Date:   Fri, 09 Nov 2018 15:14:35 -0800
In-Reply-To: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
References: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-09 at 16:15 -0500, Pavel Tatashin wrote:
> On 18-11-05 13:19:25, Alexander Duyck wrote:
> > This patchset is essentially a refactor of the page initialization logic
> > that is meant to provide for better code reuse while providing a
> > significant improvement in deferred page initialization performance.
> > 
> > In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> > memory per node I have seen the following. In the case of regular memory
> > initialization the deferred init time was decreased from 3.75s to 1.06s on
> > average. For the persistent memory the initialization time dropped from
> > 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> > deferred memory initialization performance, and a 26% improvement in the
> > persistent memory initialization performance.
> 
> Hi Alex,
> 
> Please try to run your persistent memory init experiment with Daniel's
> patches:
> 
> https://lore.kernel.org/lkml/20181105165558.11698-1-daniel.m.jordan@oracle.com/

I've taken a quick look at it. It seems like a bit of a brute force way
to try and speed things up. I would be worried about it potentially
introducing performance issues if the number of CPUs thrown at it end
up exceeding the maximum throughput of the memory.

The data provided with patch 11 seems to point to issues such as that.
In the case of the E7-8895 example cited it is increasing the numbers
of CPUs used from memory initialization from 8 to 72, a 9x increase in
the number of CPUs but it is yeilding only a 3.88x speedup.

> The performance should improve by much more than 26%.

The 26% improvement, or speedup of 1.26x using the ktask approach, was
for persistent memory, not deferred memory init. The ktask patch
doesn't do anything for persistent memory since it is takes the hot-
plug path and isn't handled via the deferred memory init.

I had increased deferred memory init to about 3.53x the original speed
(3.75s to 1.06s) on the system which I was testing. I do agree the two
patches should be able to synergistically boost each other though as
this patch set was meant to make the init much more cache friendly so
as a result it should scale better as you add additional cores. I know
I had done some playing around with fake numa to split up a single node
into 8 logical nodes and I had seen a similar speedup of about 3.85x
with my test memory initializing in about 275ms.

> Overall, your works looks good, but it needs to be considered how easy it will be
> to merge with ktask. I will try to complete the review today.
> 
> Thank you,
> Pasha

Looking over the patches they are still in the RFC stage and the data
is in need of updates since it is referencing 4.15-rc kernels as its
baseline. If anything I really think the ktask patch 11 would be easier
to rebase around my patch set then the other way around. Also, this
series is in Andrew's mmots as of a few days ago, so I think it will be
in the next mmotm that comes out.

The integration with the ktask code should be pretty straight forward.
If anything I think my code would probably make it easier since it gets
rid of the need to do all this in two passes. The only new limitation
it would add is that you would probably want to split up the work along
either max order or section aligned boundaries. What it would
essentially do is make things so that each of the ktask threads would
probably look more like deferred_grow_zone which after my patch set is
actually a fairly simple function.

Thanks.

- Alex




