Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CFC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2CE218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548413413;
	bh=jazM6oR33ngenV5DZ0H/tBWD67e2xbmtS7ReC7dn6nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vWvxloZ7uFOUfYA0ZU97unGiyvZafLIWeCsMn407vJUJw/3U3jiORdtZd8vbMmxI5
	 SYa8FiwB4E4P7s1f3FubpO495F5X37WES6970kJe0axYok+2AcT0sCJm872RRkCZUs
	 fs23GJl6BbL2Z4Bhy9Og8As8QWQNYk5INH+BzsnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfAYKuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:50:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfAYKuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:50:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38D2AB027;
        Fri, 25 Jan 2019 10:50:09 +0000 (UTC)
Date:   Fri, 25 Jan 2019 11:50:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
Message-ID: <20190125105008.GJ3560@dhcp22.suse.cz>
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <3a7a3cf2-b7d9-719e-85b0-352be49a6d0f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7a3cf2-b7d9-719e-85b0-352be49a6d0f@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-01-19 11:10:50, Dave Hansen wrote:
> On 1/24/19 6:17 AM, Michal Hocko wrote:
> > and nr_cpus set to 4. The underlying reason is tha the device is bound
> > to node 2 which doesn't have any memory and init_cpu_to_node only
> > initializes memory-less nodes for possible cpus which nr_cpus restrics.
> > This in turn means that proper zonelists are not allocated and the page
> > allocator blows up.
> 
> This looks OK to me.
> 
> Could we add a few DEBUG_VM checks that *look* for these invalid
> zonelists?  Or, would our existing list debugging have caught this?

Currently we simply blow up because those zonelists are NULL. I do not
think we have a way to check whether an existing zonelist is actually 
_correct_ other thatn check it for NULL. But what would we do in the
later case?

> Basically, is this bug also a sign that we need better debugging around
> this?

My earlier patch had a debugging printk to display the zonelists and
that might be worthwhile I guess. Basically something like this

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..c30d59f803fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
+
+	pr_info("node[%d] zonelist: ", pgdat->node_id);
+	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
+		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
+	pr_cont("\n");
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
Michal Hocko
SUSE Labs
