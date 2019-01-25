Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6427FC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282AA218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548412830;
	bh=OyX0E/ChVJJFIyXvbA02GepoEWhCkqig44u5u/WE2oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iUrewPzm+EucB82wh8P6FdAjF0p0OTyblpcu5LfzfnMMkXBYlND/HVMph7p/839q2
	 Dj+h6HxZgeTPoTw4CHSGl9TXFgg/dM4wJryVkH0IMuiTt5ed0fe1Y7FDmwFz/bRcbb
	 9RZiRYEfGh5vQ/40wE9tkwLQ6NEnB0rw7+CBb9eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAYKk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:40:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:45344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfAYKk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B142BB027;
        Fri, 25 Jan 2019 10:40:26 +0000 (UTC)
Date:   Fri, 25 Jan 2019 11:40:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
Message-ID: <20190125104023.GI3560@dhcp22.suse.cz>
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <20190124175144.GF13790@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124175144.GF13790@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-01-19 19:51:44, Mike Rapoport wrote:
> On Thu, Jan 24, 2019 at 03:17:27PM +0100, Michal Hocko wrote:
> > a friendly ping for this. Does anybody see any problem with this
> > approach?
> 
> FWIW, it looks fine to me.
> 
> It'd just be nice to have a few more words in the changelog about *how* the
> x86 init was reworked ;-)

Heh, I thought it was there but nope... It probably just existed in my
head. Sorry about that. What about the following paragraphs added?
"
The new code relies on the arch specific initialization to allocate all
possible NUMA nodes (including memory less) - numa_register_memblks in
this case. Generic code then initializes both zonelists (__build_all_zonelists)
and allocator internals (free_area_init_nodes) for all non-null pgdats
rather than online ones.

For the x86 specific part also do not make new node online in alloc_node_data
because this is too early to know that. numa_register_memblks knows that
a node has some memory so it can make the node online appropriately.
init_memory_less_node hack can be safely removed altogether now.
"

-- 
Michal Hocko
SUSE Labs
