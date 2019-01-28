Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86073C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417572087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548688744;
	bh=y8P8bwOTH8kvOBmJ5irwyyJZdV58iQeeh8wC3JmhpXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eRNKw02hEZH8HnzBF6qLns/qgLnqr8r/ZqKK3PHzqzTZa5LWVmRQZP4YRQyoUIvVs
	 Nu6iI+6CZn9Y/ePHPnT/vUmnPDmTP8ms/iWBHRMkB0KhjSOpCfqkNkVU/KUFkLxyoR
	 svHiAfgB3cdw5RpGWky9JEYQ4O6SaiXV9snvymUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfA1PTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:19:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:33786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfA1PTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:19:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6432AE41;
        Mon, 28 Jan 2019 15:19:00 +0000 (UTC)
Date:   Mon, 28 Jan 2019 16:18:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128151859.GO18811@dhcp22.suse.cz>
References: <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128145407.GP50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 06:54:07, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jan 28, 2019 at 03:52:10PM +0100, Michal Hocko wrote:
> > > All .events files generate aggregated stateful notifications.  For
> > > anyone to do anything, they'd have to remember the previous state to
> > > identify what actually happened.  Being hierarchical, it'd of course
> > > need to walk down when an event triggers.
> > 
> > And how do you do that in a raceless fashion?
> 
> Hmm... I'm having trouble imagining why this would be a problem.  How
> would it race?

How do you make an atomic snapshot of the hierarchy state? Or you do
not need it because event counters are monotonic and you are willing to
sacrifice some lost or misinterpreted events? For example, you receive
an oom event while the two children increase the oom event counter. How
do you tell which one was the source of the event and which one is still
pending? Or is the ordering unimportant in general?

I can imagine you can live with this model, but having a hierarchical
reporting without a source of the event just sounds too clumsy from my
POV. But I guess this is getting tangent to the original patch.
-- 
Michal Hocko
SUSE Labs
