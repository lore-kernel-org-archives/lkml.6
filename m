Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB596C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B615218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896748;
	bh=VHls39528lPNSjTGB1q3GbJWUC/UCWbBliZaStHtNrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=viiQLRUzN/K3IGUiXI9QcE6WRU2xCvBItRTpdfU6rwbpdwXdjLDHimL+ZJykSlSyT
	 lE4MOA+NkNRobR8E9UwHU6MvPZbWBHABPjEFGATTpvmXywB259LlPK2mQ+GjsbTGzk
	 w5oEeTcZj7DejlTxbfW6nRXggUniG65RcFqJct3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfBKOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:60894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387786AbfBKOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBADFAE67;
        Mon, 11 Feb 2019 14:52:18 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:52:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
Message-ID: <20190211145217.GE15609@dhcp22.suse.cz>
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <3a7a3cf2-b7d9-719e-85b0-352be49a6d0f@intel.com>
 <20190125105008.GJ3560@dhcp22.suse.cz>
 <20190211134909.GA107845@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211134909.GA107845@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-02-19 14:49:09, Ingo Molnar wrote:
> 
> * Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Thu 24-01-19 11:10:50, Dave Hansen wrote:
> > > On 1/24/19 6:17 AM, Michal Hocko wrote:
> > > > and nr_cpus set to 4. The underlying reason is tha the device is bound
> > > > to node 2 which doesn't have any memory and init_cpu_to_node only
> > > > initializes memory-less nodes for possible cpus which nr_cpus restrics.
> > > > This in turn means that proper zonelists are not allocated and the page
> > > > allocator blows up.
> > > 
> > > This looks OK to me.
> > > 
> > > Could we add a few DEBUG_VM checks that *look* for these invalid
> > > zonelists?  Or, would our existing list debugging have caught this?
> > 
> > Currently we simply blow up because those zonelists are NULL. I do not
> > think we have a way to check whether an existing zonelist is actually 
> > _correct_ other thatn check it for NULL. But what would we do in the
> > later case?
> > 
> > > Basically, is this bug also a sign that we need better debugging around
> > > this?
> > 
> > My earlier patch had a debugging printk to display the zonelists and
> > that might be worthwhile I guess. Basically something like this
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2e097f336126..c30d59f803fb 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
> >  
> >  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
> >  	build_thisnode_zonelists(pgdat);
> > +
> > +	pr_info("node[%d] zonelist: ", pgdat->node_id);
> > +	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
> > +		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
> > +	pr_cont("\n");
> >  }
> 
> Looks like this patch fell through the cracks - any update on this?

I was waiting for some feedback. As there were no complains about the
above debugging output I will make it a separate patch and post both
patches later this week. I just have to go through my backlog pile after
vacation.
-- 
Michal Hocko
SUSE Labs
