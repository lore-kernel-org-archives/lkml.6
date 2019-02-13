Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ABD222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKXNBPgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbfBMNLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:11:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBMNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aYXYOSh02VrgFOoAtWZsG3dC6gl0mwh0qQIVsd6b6/U=; b=iKXNBPgJ/QWjwdq9K/ZA6v+x9
        5Y3A54QPC72zkNBsg4SgL6/FXbuEbgxUjjZMyeOumCtxt6+KjXuW94vOx+tdr0Gap/U+fRhOEtRcR
        5umJ2pljfWs+9TCLUZoW5tO+8wKmpCeVreqbVS3UrJJH3d/tjN89mOiAU7uvZW8wTYr9WHgQy5zDm
        NlQvX8XP71crgRCjSTVZ4xgb5A10DKgP/Ige657/16+t5l5sZqa8VLkfWNIoXpYC0j+4VHiWaunun
        GY4ABcJ6XUZPFXm+zW79mgTBCCmQ4rmjPQQIYcDIBl+KJxJVmcd+eCoRvIark50+94JSFMGLSPZJa
        N6Oe6fM9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtuK4-0003qU-Na; Wed, 13 Feb 2019 13:11:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3668222BBEBE5; Wed, 13 Feb 2019 14:11:31 +0100 (CET)
Date:   Wed, 13 Feb 2019 14:11:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v3 2/2] mm: be more verbose about zonelist initialization
Message-ID: <20190213131131.GS32494@hirez.programming.kicks-ass.net>
References: <20190212095343.23315-3-mhocko@kernel.org>
 <20190213094315.3504-1-mhocko@kernel.org>
 <20190213103231.GN32494@hirez.programming.kicks-ass.net>
 <20190213115014.GC4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213115014.GC4525@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:50:14PM +0100, Michal Hocko wrote:
> On Wed 13-02-19 11:32:31, Peter Zijlstra wrote:
> > On Wed, Feb 13, 2019 at 10:43:15AM +0100, Michal Hocko wrote:
> > > @@ -5259,6 +5261,11 @@ static void build_zonelists(pg_data_t *pgdat)
> > >  
> > >  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
> > >  	build_thisnode_zonelists(pgdat);
> > > +
> > > +	pr_info("node[%d] zonelist: ", pgdat->node_id);
> > > +	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
> > > +		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
> > > +	pr_cont("\n");
> > >  }
> > 
> > Have you ran this by the SGI and other stupid large machine vendors?
> 
> I do not have such a large machine handy. The biggest I have has
> handfull (say dozen) of NUMA nodes.
> 
> > Traditionally they tend to want to remove such things instead of adding
> > them.
> 
> I do not insist on this patch but I find it handy. If there is an
> opposition I will not miss it much.

Well, I don't have machines like that either and don't mind the patch.
Just raising the issue; I've had the big iron boys complain about
similar things (typically printing something for every CPU, which gets
out of hand much faster than zones, but still).
