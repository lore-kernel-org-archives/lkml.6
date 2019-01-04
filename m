Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC61C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4071821872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546615061;
	bh=ywe9joJGeBVcMoPzA0ZtSCE1ggF7Ge+Wr/ZTV3rXKZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2MG1TbRSzAz5QLJRZCT7+TGkc4QCZF6LsHoCyDF0tqfiyBFv06rUaHLx0GTNRamvK
	 mynkbF8PEf1uNzmip+/k+IBmqzVOoLRcmfaeCA0UQLpaN/A5LpV09Wyuq0TYfTucvn
	 ZLeo4LqbbslBoy1X8V3TsH6jXF0gEU1HuuzopF0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfADPRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:17:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:54186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbfADPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:17:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B229FAFDA;
        Fri,  4 Jan 2019 15:17:38 +0000 (UTC)
Date:   Fri, 4 Jan 2019 16:17:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
Message-ID: <20190104151737.GT31793@dhcp22.suse.cz>
References: <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
 <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-01-19 10:01:40, Qian Cai wrote:
> On 1/4/19 8:09 AM, Michal Hocko wrote:
> >> Here is the number without DEFERRED_STRUCT_PAGE_INIT.
> >>
> >> == page_ext_init() after page_alloc_init_late() ==
> >> Node 0, zone DMA: page owner found early allocated 0 pages
> >> Node 0, zone DMA32: page owner found early allocated 7009 pages
> >> Node 0, zone Normal: page owner found early allocated 85827 pages
> >> Node 4, zone Normal: page owner found early allocated 75063 pages
> >>
> >> == page_ext_init() before kmemleak_init() ==
> >> Node 0, zone DMA: page owner found early allocated 0 pages
> >> Node 0, zone DMA32: page owner found early allocated 6654 pages
> >> Node 0, zone Normal: page owner found early allocated 41907 pages
> >> Node 4, zone Normal: page owner found early allocated 41356 pages
> >>
> >> So, it told us that it will miss tens of thousands of early page allocation call
> >> sites.
> > 
> > This is an answer for the first part of the question (how much). The
> > second is _do_we_care_?
> 
> Well, the purpose of this simple "ugly" ifdef is to avoid a regression for the
> existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected that would
> start to miss tens of thousands early page allocation call sites.

I am pretty sure we will hear about that when that happens. And act
accordingly.

> The other option I can think of to not hurt your eyes is to rewrite the whole
> page_ext_init(), init_page_owner(), init_debug_guardpage() to use all early
> functions, so it can work in both with DEFERRED_STRUCT_PAGE_INIT=y and without.
> However, I have a hard-time to convince myself it is a sensible thing to do.

Or simply make the page_owner initialization only touch the already
initialized memory. Have you explored that option as well?

Look, I am trying to push for a clean solution. Hacks I have seen so
far are not convincing. You have identified a regression and as such I
would consider the most straightforward to revert the buggy commit. If
you want to improve the situation then I would suggest to think about
something that is more robust than ifdefed hacks. It might be more work
but it also might be a better thing long term.

If you think I am asking too much then you are free to ignore my
opinion. I am not a maintainer of the page_owner code.
-- 
Michal Hocko
SUSE Labs
