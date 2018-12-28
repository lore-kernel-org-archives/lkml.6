Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8F620869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026749;
	bh=hACC3o2RWzXfBoH9c8ngcNjCjkyNHl/PMk87f5XHLAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fYKHOWghiorey2x27kpsdevnWRKZq+eol5EsYg4AdyyWw0iBjZvbmZESnELf8z0nL
	 TIb/Jj3yE97rvnctKLNffKEIlJX4GuzLS76GCbSGG3j/VMjECOX9wzpns5TizRqvVn
	 3glUM7ZVucOhxmL9H9x3+ErxthZHdLL+3nJvH0nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeL1Tw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:52:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:40386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbeL1Tw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:52:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77850AF57;
        Fri, 28 Dec 2018 19:52:25 +0000 (UTC)
Date:   Fri, 28 Dec 2018 20:52:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20181228195224.GY16738@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
 <20181228121515.GS16738@dhcp22.suse.cz>
 <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Ccing Mel and Andrea]

On Fri 28-12-18 21:31:11, Wu Fengguang wrote:
> > > > I haven't looked at the implementation yet but if you are proposing a
> > > > special cased zone lists then this is something CDM (Coherent Device
> > > > Memory) was trying to do two years ago and there was quite some
> > > > skepticism in the approach.
> > > 
> > > It looks we are pretty different than CDM. :)
> > > We creating new NUMA nodes rather than CDM's new ZONE.
> > > The zonelists modification is just to make PMEM nodes more separated.
> > 
> > Yes, this is exactly what CDM was after. Have a zone which is not
> > reachable without explicit request AFAIR. So no, I do not think you are
> > too different, you just use a different terminology ;)
> 
> Got it. OK.. The fall back zonelists patch does need more thoughts.
> 
> In long term POV, Linux should be prepared for multi-level memory.
> Then there will arise the need to "allocate from this level memory".
> So it looks good to have separated zonelists for each level of memory.

Well, I do not have a good answer for you here. We do not have good
experiences with those systems, I am afraid. NUMA is with us for more
than a decade yet our APIs are coarse to say the least and broken at so
many times as well. Starting a new API just based on PMEM sounds like a
ticket to another disaster to me.

I would like to see solid arguments why the current model of numa nodes
with fallback in distances order cannot be used for those new
technologies in the beginning and develop something better based on our
experiences that we gain on the way.

I would be especially interested about a possibility of the memory
migration idea during a memory pressure and relying on numa balancing to
resort the locality on demand rather than hiding certain NUMA nodes or
zones from the allocator and expose them only to the userspace.

> On the other hand, there will also be page allocations that don't care
> about the exact memory level. So it looks reasonable to expect
> different kind of fallback zonelists that can be selected by NUMA policy.
> 
> Thanks,
> Fengguang

-- 
Michal Hocko
SUSE Labs
