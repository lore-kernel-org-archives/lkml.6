Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90B720848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90B720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJZArq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727313AbeJZArq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:47:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66F41AD1A;
        Thu, 25 Oct 2018 16:14:18 +0000 (UTC)
Date:   Thu, 25 Oct 2018 18:14:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20181025161410.GT18839@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
 <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
 <20180926141708.GX6278@dhcp22.suse.cz>
 <20180926142227.GZ6278@dhcp22.suse.cz>
 <20181018191147.33e8d5e1ebd785c06aab7b30@linux-foundation.org>
 <20181019080657.GJ18839@dhcp22.suse.cz>
 <583b20e5-4925-e175-1533-5c2d2bab9192@suse.cz>
 <20181024161754.0d174e7c22113f4f8aad1940@linux-foundation.org>
 <983e0c59-99ef-796c-bfc4-00e67782d1f1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983e0c59-99ef-796c-bfc4-00e67782d1f1@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-10-18 06:56:37, Vlastimil Babka wrote:
> On 10/25/18 1:17 AM, Andrew Morton wrote:
> > On Mon, 22 Oct 2018 15:27:54 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> >>> : Moreover the oriinal code allowed to trigger
> >>> : 	WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
> >>> : in policy_node if the requested node (e.g. cpu local one) was outside of
> >>> : the mbind nodemask. This is not possible now. We haven't heard about any
> >>> : such warning yet so it is unlikely that it happens but still a signal of
> >>> : a wrong code layering.
> >>
> >> Ah, as I said in the other mail, I think it's inaccurate, the warning
> >> was not possible to hit.
> >>
> >> There's also a slight difference wrt MPOL_BIND. The previous code would
> >> avoid using __GFP_THISNODE if the local node was outside of
> >> policy_nodemask(). After your patch __GFP_THISNODE is avoided for all
> >> MPOL_BIND policies. So there's a difference that if local node is
> >> actually allowed by the bind policy's nodemask, previously
> >> __GFP_THISNODE would be added, but now it won't be. I don't think it
> >> matters that much though, but maybe the changelog could say that
> >> (instead of the inaccurate note about warning). Note the other policy
> >> where nodemask is relevant is MPOL_INTERLEAVE, and that's unchanged by
> >> this patch.
> > 
> > So the above could go into the changelog, yes?
> 
> Yeah.

Andrew. Do you want me to repost the patch or you plan to update the
changelog yourself?
-- 
Michal Hocko
SUSE Labs
