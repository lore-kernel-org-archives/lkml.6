Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76179C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42908222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550065281;
	bh=/hDT1oPkFJAP7Quif9+FmjFeD/kUmJkwlMs7VxFv3/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+d/yLUoeZKNj5r6ku3HifiXF8q1GmpAElvAXwYjUl0gPxHeBPQA7OC9aQVJ4A80z
	 qqGSM0VHghxHpVdjEEBeJtblyKGGbzJM+emncizwEXWPcLsP8sygS8yodQCvhms+Oy
	 Z2+9GKB1JdMw2Gyw/8HUdDq1j6a3+jnKImXfcf48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbfBMNlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:41:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731945AbfBMNlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:41:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA8E0AEBC;
        Wed, 13 Feb 2019 13:41:17 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:41:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v3 2/2] mm: be more verbose about zonelist initialization
Message-ID: <20190213134115.GO4525@dhcp22.suse.cz>
References: <20190212095343.23315-3-mhocko@kernel.org>
 <20190213094315.3504-1-mhocko@kernel.org>
 <20190213103231.GN32494@hirez.programming.kicks-ass.net>
 <20190213115014.GC4525@dhcp22.suse.cz>
 <20190213131131.GS32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213131131.GS32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 14:11:31, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 12:50:14PM +0100, Michal Hocko wrote:
> > On Wed 13-02-19 11:32:31, Peter Zijlstra wrote:
> > > On Wed, Feb 13, 2019 at 10:43:15AM +0100, Michal Hocko wrote:
> > > > @@ -5259,6 +5261,11 @@ static void build_zonelists(pg_data_t *pgdat)
> > > >  
> > > >  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
> > > >  	build_thisnode_zonelists(pgdat);
> > > > +
> > > > +	pr_info("node[%d] zonelist: ", pgdat->node_id);
> > > > +	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
> > > > +		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
> > > > +	pr_cont("\n");
> > > >  }
> > > 
> > > Have you ran this by the SGI and other stupid large machine vendors?
> > 
> > I do not have such a large machine handy. The biggest I have has
> > handfull (say dozen) of NUMA nodes.
> > 
> > > Traditionally they tend to want to remove such things instead of adding
> > > them.
> > 
> > I do not insist on this patch but I find it handy. If there is an
> > opposition I will not miss it much.
> 
> Well, I don't have machines like that either and don't mind the patch.
> Just raising the issue; I've had the big iron boys complain about
> similar things (typically printing something for every CPU, which gets
> out of hand much faster than zones, but still).

Maybe we can try to push this through and revert if somebody complains
about an excessive output.

-- 
Michal Hocko
SUSE Labs
