Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF1120866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545986470;
	bh=bsGKByOD9pF+cn3wiSdefRhm5ys3EQb4J4hY0hw8iQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UxnjgtbS2aQ8Qor8kqU+Y163G1Pb2q/mqNksK7DEUaccsj6mWza77Z8EWYCKlF1HR
	 H4HOLPCMa7+PyzBz+tKqf7tR71gKbj2EvAc9JwCGf0g0dBQF/zu4ElWEGei1B8hMtn
	 mK6oDy4cC45SMlpWR53sLXCdt8zlfqRZFyqElyBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbeL1IlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:41:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:35420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbeL1IlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:41:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CCEAAB93;
        Fri, 28 Dec 2018 08:41:07 +0000 (UTC)
Date:   Fri, 28 Dec 2018 09:41:05 +0100
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
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20181228084105.GQ16738@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-12-18 13:08:06, Wu Fengguang wrote:
[...]
> Optimization: do hot/cold page tracking and migration
> =====================================================
> 
> Since PMEM is slower than DRAM, we need to make sure hot pages go to
> DRAM and cold pages stay in PMEM, to get the best out of PMEM and DRAM.
> 
> - DRAM=>PMEM cold page migration
> 
> It can be done in kernel page reclaim path, near the anonymous page
> swap out point. Instead of swapping out, we now have the option to
> migrate cold pages to PMEM NUMA nodes.

OK, this makes sense to me except I am not sure this is something that
should be pmem specific. Is there any reason why we shouldn't migrate
pages on memory pressure to other nodes in general? In other words
rather than paging out we whould migrate over to the next node that is
not under memory pressure. Swapout would be the next level when the
memory is (almost_) fully utilized. That wouldn't be pmem specific.

> User space may also do it, however cannot act on-demand, when there
> are memory pressure in DRAM nodes.
> 
> - PMEM=>DRAM hot page migration
> 
> While LRU can be good enough for identifying cold pages, frequency
> based accounting can be more suitable for identifying hot pages.
> 
> Our design choice is to create a flexible user space daemon to drive
> the accounting and migration, with necessary kernel supports by this
> patchset.

We do have numa balancing, why cannot we rely on it? This along with the
above would allow to have pmem numa nodes (cpuless nodes in fact)
without any special casing and a natural part of the MM. It would be
only the matter of the configuration to set the appropriate distance to
allow reasonable allocation fallback strategy.

I haven't looked at the implementation yet but if you are proposing a
special cased zone lists then this is something CDM (Coherent Device
Memory) was trying to do two years ago and there was quite some
skepticism in the approach.
-- 
Michal Hocko
SUSE Labs
