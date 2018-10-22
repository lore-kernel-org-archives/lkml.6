Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C016C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355212064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355212064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeJVWFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:05:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeJVWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:05:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0272FAE8B;
        Mon, 22 Oct 2018 13:46:57 +0000 (UTC)
Date:   Mon, 22 Oct 2018 15:46:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20181022134657.GG18839@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
 <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
 <20180926141708.GX6278@dhcp22.suse.cz>
 <20180926142227.GZ6278@dhcp22.suse.cz>
 <26cb01ff-a094-79f4-7ceb-291e5e053c58@suse.cz>
 <20181022133058.GE18839@dhcp22.suse.cz>
 <18476b0b-7300-f340-5845-9de0a019c65c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18476b0b-7300-f340-5845-9de0a019c65c@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 15:35:24, Vlastimil Babka wrote:
> On 10/22/18 3:30 PM, Michal Hocko wrote:
> > On Mon 22-10-18 15:15:38, Vlastimil Babka wrote:
> >>> Forgot to add. One notable exception would be that the previous code
> >>> would allow to hit
> >>> 	WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
> >>> in policy_node if the requested node (e.g. cpu local one) was outside of
> >>> the mbind nodemask. This is not possible now. We haven't heard about any
> >>> such warning yet so it is unlikely that it happens though.
> >>
> >> I don't think the previous code could hit the warning, as the hugepage
> >> path that would add __GFP_THISNODE didn't call policy_node() (containing
> >> the warning) at all. IIRC early of your patch did hit the warning
> >> though, which is why you added the MPOL_BIND policy check.
> > 
> > Are you sure? What prevents node_isset(node, policy_nodemask()) == F and
> > fallback to the !huge allocation path?
> 
> That can indeed happen, but then the code also skipped the "gfp |=
> __GFP_THISNODE" part, right? So the warning wouldn't trigger.

I thought I have crawled all the code paths back then but maybe there
were some phantom ones... If you are sure about then we can stick with
the original changelog.
-- 
Michal Hocko
SUSE Labs
