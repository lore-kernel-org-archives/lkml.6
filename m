Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA369C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4F820869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4F820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJPQit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:38:49 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:44082 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbeJPQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:38:49 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id A0BEDB87C8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 09:49:23 +0100 (IST)
Received: (qmail 26529 invoked from network); 16 Oct 2018 08:49:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Oct 2018 08:49:25 -0000
Date:   Tue, 16 Oct 2018 09:49:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] mm: workingset: add vmstat counter for shadow nodes
Message-ID: <20181016084923.GH5819@techsingularity.net>
References: <20181009184732.762-1-hannes@cmpxchg.org>
 <20181009184732.762-4-hannes@cmpxchg.org>
 <20181009150845.8656eb8ede045ca5f4cc4b21@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181009150845.8656eb8ede045ca5f4cc4b21@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:08:45PM -0700, Andrew Morton wrote:
> On Tue,  9 Oct 2018 14:47:32 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -378,11 +378,17 @@ void workingset_update_node(struct xa_node *node)
> >  	 * as node->private_list is protected by the i_pages lock.
> >  	 */
> >  	if (node->count && node->count == node->nr_values) {
> > -		if (list_empty(&node->private_list))
> > +		if (list_empty(&node->private_list)) {
> >  			list_lru_add(&shadow_nodes, &node->private_list);
> > +			__inc_lruvec_page_state(virt_to_page(node),
> > +						WORKINGSET_NODES);
> > +		}
> >  	} else {
> > -		if (!list_empty(&node->private_list))
> > +		if (!list_empty(&node->private_list)) {
> >  			list_lru_del(&shadow_nodes, &node->private_list);
> > +			__dec_lruvec_page_state(virt_to_page(node),
> > +						WORKINGSET_NODES);
> > +		}
> >  	}
> >  }
> 
> A bit worried that we're depending on the caller's caller to have
> disabled interrupts to avoid subtle and rare errors.
> 
> Can we do this?
> 
> --- a/mm/workingset.c~mm-workingset-add-vmstat-counter-for-shadow-nodes-fix
> +++ a/mm/workingset.c
> @@ -377,6 +377,8 @@ void workingset_update_node(struct radix
>  	 * already where they should be. The list_empty() test is safe
>  	 * as node->private_list is protected by the i_pages lock.
>  	 */
> +	WARN_ON_ONCE(!irqs_disabled());	/* For __inc_lruvec_page_state */
> +
>  	if (node->count && node->count == node->exceptional) {
>  		if (list_empty(&node->private_list)) {
>  			list_lru_add(&shadow_nodes, &node->private_list);

Note that for whatever reason, I've observed that irqs_disabled() is
actually quite an expensive call. I'm not saying the warning is a bad
idea but it should not be sprinkled around unnecessary and may be more
suitable as a debug option.

-- 
Mel Gorman
SUSE Labs
