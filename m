Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB88C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B7F2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B7F2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbeHPMWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:22:31 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:60508 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbeHPMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:22:30 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 60C2DB8B28
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 10:25:14 +0100 (IST)
Received: (qmail 533 invoked from network); 16 Aug 2018 09:25:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Aug 2018 09:25:14 -0000
Date:   Thu, 16 Aug 2018 10:25:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm, page_alloc: actually ignore mempolicies for high
 priority allocations
Message-ID: <20180816092507.GA1719@techsingularity.net>
References: <20180612122624.8045-1-vbabka@suse.cz>
 <20180815151652.05d4c4684b7dff2282b5c046@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180815151652.05d4c4684b7dff2282b5c046@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:16:52PM -0700, Andrew Morton wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> Subject: mm, page_alloc: actually ignore mempolicies for high priority allocations
> 
> The __alloc_pages_slowpath() function has for a long time contained code
> to ignore node restrictions from memory policies for high priority
> allocations.  The current code that resets the zonelist iterator however
> does effectively nothing after commit 7810e6781e0f ("mm, page_alloc: do
> not break __GFP_THISNODE by zonelist reset") removed a buggy zonelist
> reset.  Even before that commit, mempolicy restrictions were still not
> ignored, as they are passed in ac->nodemask which is untouched by the
> code.
> 
> We can either remove the code, or make it work as intended.  Since
> ac->nodemask can be set from task's mempolicy via alloc_pages_current()
> and thus also alloc_pages(), it may indeed affect kernel allocations, and
> it makes sense to ignore it to allow progress for high priority
> allocations.
> 
> Thus, this patch resets ac->nodemask to NULL in such cases.  This assumes
> all callers can handle it (i.e.  there are no guarantees as in the case of
> __GFP_THISNODE) which seems to be the case.  The same assumption is
> already present in check_retry_cpuset() for some time.
> 
> The expected effect is that high priority kernel allocations in the
> context of userspace tasks (e.g.  OOM victims) restricted by mempolicies
> will have higher chance to succeed if they are restricted to nodes with
> depleted memory, while there are other nodes with free memory left.
> 
> 
> Ot's not a new intention, but for the first time the code will match the
> intention, AFAICS.  It was intended by commit 183f6371aac2 ("mm: ignore
> mempolicies when using ALLOC_NO_WATERMARK") in v3.6 but I think it never
> really worked, as mempolicy restriction was already encoded in nodemask,
> not zonelist, at that time.
> 
> So originally that was for ALLOC_NO_WATERMARK only.  Then it was adjusted
> by e46e7b77c909 ("mm, page_alloc: recalculate the preferred zoneref if the
> context can ignore memory policies") and cd04ae1e2dc8 ("mm, oom: do not
> rely on TIF_MEMDIE for memory reserves access") to the current state.  So
> even GFP_ATOMIC would now ignore mempolicies after the initial attempts
> fail - if the code worked as people thought it does.
> 
> Link: http://lkml.kernel.org/r/20180612122624.8045-1-vbabka@suse.cz
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

FWIW, I thought I acked this already.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
