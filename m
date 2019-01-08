Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F07C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A9820657
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959188;
	bh=NP7tyWLNAacMLnAEU3M60ian3ZYA3o9PfN7FGaJEqIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0oe7N8/7vjTAnHIEYqaJceTWkfX9ggK7T7tFUSEctRvWjRAWW5qXf6K1rMfvrcvXh
	 x8D/zqnNK1ER1/gDQONziGTiQlKeQY5kigpZf61w5jIrRQ96jJQCu4AvPc697kuyox
	 bgsYhM7aN7fzy0+FBR6XYmzk+ViYGRCOcPB1HIzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfAHOxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:53:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:54640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728453AbfAHOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:53:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5098FB0B1;
        Tue,  8 Jan 2019 14:53:03 +0000 (UTC)
Date:   Tue, 8 Jan 2019 15:53:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20190108145302.GY31793@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <c320b754-b4b2-5b5b-1ed7-7d25ea114229@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c320b754-b4b2-5b5b-1ed7-7d25ea114229@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-01-19 10:12:04, Dave Hansen wrote:
> On 12/28/18 12:41 AM, Michal Hocko wrote:
> >>
> >> It can be done in kernel page reclaim path, near the anonymous page
> >> swap out point. Instead of swapping out, we now have the option to
> >> migrate cold pages to PMEM NUMA nodes.
> > OK, this makes sense to me except I am not sure this is something that
> > should be pmem specific. Is there any reason why we shouldn't migrate
> > pages on memory pressure to other nodes in general? In other words
> > rather than paging out we whould migrate over to the next node that is
> > not under memory pressure. Swapout would be the next level when the
> > memory is (almost_) fully utilized. That wouldn't be pmem specific.
> 
> Yeah, we don't want to make this specific to any particular kind of
> memory.  For instance, with lots of pressure on expensive, small
> high-bandwidth memory (HBM), we might want to migrate some HBM contents
> to DRAM.
> 
> We need to decide on whether we want to cause pressure on the
> destination nodes or not, though.  I think you're suggesting that we try
> to look for things under some pressure and totally avoid them.  That
> sounds sane, but I also like the idea of this being somewhat ordered.
> 
> Think of if we have three nodes, A, B, C.  A is fast, B is medium, C is
> slow.  If A and B are "full" and we want to reclaim some of A, do we:
> 
> 1. Migrate A->B, and put pressure on a later B->C migration, or
> 2. Migrate A->C directly
> 
> ?
> 
> Doing A->C is less resource intensive because there's only one migration
> involved.  But, doing A->B/B->C probably makes the app behave better
> because the "A data" is presumably more valuable and is more
> appropriately placed in B rather than being demoted all the way to C.

This is a good question and I do not have a good answer because I lack
experiences with such "many levels" systems. If we followed CPU caches
model ten you are right that the fallback should be gradual. This is
more complex implementation wise of course. Anyway, I believe that there
is a lot of room for experimentations. If this stays an internal
implementation detail without user API then there is also no promise on
future behavior so nothing gets carved into stone since the day 1 when
our experiences are limited.

-- 
Michal Hocko
SUSE Labs
