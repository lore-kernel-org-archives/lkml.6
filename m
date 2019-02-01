Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD44C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C687218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549005482;
	bh=MIv678OTG1PGfkpTgQG0cHJc02WbSbOqaCBsswh6NwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vc0db0dldsl67JcMOsfY7CTdD+V415oTXQljeWbt5x8VskfVtxRxNqE/ZHOAfIqyf
	 QRsY5VghEiKxocELAxq33LZJsqbeW4rqORVXhOl/rPGQ0z6SuVo7wNpy2w8rpQmQ0U
	 1zLb3YEbbujldO+bxGS9nNAdqvN14R7d27Hi7vJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfBAHSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:18:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:60848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbfBAHSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:18:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AE8EADC1;
        Fri,  1 Feb 2019 07:17:58 +0000 (UTC)
Date:   Fri, 1 Feb 2019 08:17:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Throttle allocators when failing reclaim over
 memory.high
Message-ID: <20190201071757.GE11599@dhcp22.suse.cz>
References: <20190201011352.GA14370@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201011352.GA14370@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 20:13:52, Chris Down wrote:
[...]
> The current situation goes against both the expectations of users of
> memory.high, and our intentions as cgroup v2 developers. In
> cgroup-v2.txt, we claim that we will throttle and only under "extreme
> conditions" will memory.high protection be breached. Likewise, cgroup v2
> users generally also expect that memory.high should throttle workloads
> as they exceed their high threshold. However, as seen above, this isn't
> always how it works in practice -- even on banal setups like those with
> no swap, or where swap has become exhausted, we can end up with
> memory.high being breached and us having no weapons left in our arsenal
> to combat runaway growth with, since reclaim is futile.
> 
> It's also hard for system monitoring software or users to tell how bad
> the situation is, as "high" events for the memcg may in some cases be
> benign, and in others be catastrophic. The current status quo is that we
> fail containment in a way that doesn't provide any advance warning that
> things are about to go horribly wrong (for example, we are about to
> invoke the kernel OOM killer).
> 
> This patch introduces explicit throttling when reclaim is failing to
> keep memcg size contained at the memory.high setting. It does so by
> applying an exponential delay curve derived from the memcg's overage
> compared to memory.high.  In the normal case where the memcg is either
> below or only marginally over its memory.high setting, no throttling
> will be performed.

How does this play wit the actual OOM when the user expects oom to
resolve the situation because the reclaim is futile and there is nothing
reclaimable except for killing a process?
-- 
Michal Hocko
SUSE Labs
