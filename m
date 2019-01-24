Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8928AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4953B21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548318176;
	bh=GKtscrhwgZwFqpJxB95gDikExqvZQe/REF96cj8HGME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C5j2hO1JgeEcG+qhTq46YpHrLQ5W8x2wLyLZLf9I6h21sPAkK526hIz2xQgYc+h4t
	 H4S4WL6jBZlHDMjPBMMrQyHCcDoXllBOXK9xn4b3JVV/OQ3QoMmWBmtNwcLcqbztWx
	 bRWYQCzHZuxCThQGDrfDEYopt6EOSWUhBoPFc/uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAXIWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:22:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:59346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfAXIWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:22:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E258FB011;
        Thu, 24 Jan 2019 08:22:52 +0000 (UTC)
Date:   Thu, 24 Jan 2019 09:22:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124082252.GD4087@dhcp22.suse.cz>
References: <20190123223144.GA10798@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123223144.GA10798@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 17:31:44, Chris Down wrote:
> memory.stat and other files already consider subtrees in their output,
> and we should too in order to not present an inconsistent interface.
> 
> The current situation is fairly confusing, because people interacting
> with cgroups expect hierarchical behaviour in the vein of memory.stat,
> cgroup.events, and other files. For example, this causes confusion when
> debugging reclaim events under low, as currently these always read "0"
> at non-leaf memcg nodes, which frequently causes people to misdiagnose
> breach behaviour. The same confusion applies to other counters in this
> file when debugging issues.
> 
> Aggregation is done at write time instead of at read-time since these
> counters aren't hot (unlike memory.stat which is per-page, so it does it
> at read time), and it makes sense to bundle this with the file
> notifications.

I do not think we can do that for two reasons. It breaks the existing
semantic userspace might depend on and more importantly this is not a
correct behavior IMO.

You have to realize that stats are hierarchical because that is how we
account. Events represent a way to inform that something has happened at
the specific level of the tree though. If you do not setup low/high/max
limit then you simply cannot expect to be informed those get hit because
they cannot by definition. Or put it other way, if you are waiting for
those events you really want to know the (sub)tree they happened and if
you propagate the event up the hierarchy you have hard time to tell that
(you would basically have to exclude all but the lowest one and that is
an awkward semantic at best.

Maybe we want to document this better but I do not see we are going to
change the behavior.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

btw. I do not see this patch posted anywhere yet it already comes with
an ack. Have I just missed a previous version?
-- 
Michal Hocko
SUSE Labs
