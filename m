Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41398C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120CE20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfBAOvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:51:42 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:45310 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728239AbfBAOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:51:42 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 9F9661C1CCF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 14:51:40 +0000 (GMT)
Received: (qmail 4119 invoked from network); 1 Feb 2019 14:51:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Feb 2019 14:51:40 -0000
Date:   Fri, 1 Feb 2019 14:51:39 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 11/22] mm, compaction: Use free lists to quickly locate a
 migration target
Message-ID: <20190201145139.GI9565@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-12-mgorman@techsingularity.net>
 <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:52:10PM +0100, Vlastimil Babka wrote:
> > -/* Reorder the free list to reduce repeated future searches */
> > +/*
> > + * Used when scanning for a suitable migration target which scans freelists
> > + * in reverse. Reorders the list such as the unscanned pages are scanned
> > + * first on the next iteration of the free scanner
> > + */
> > +static void
> > +move_freelist_head(struct list_head *freelist, struct page *freepage)
> > +{
> > +	LIST_HEAD(sublist);
> > +
> > +	if (!list_is_last(freelist, &freepage->lru)) {
> 
> Shouldn't there be list_is_first() for symmetry?
> 

I don't think it would help. We're reverse traversing the list when this is
called. If it's the last entry, it's moving just one page before breaking
off the search and a shuffle has minimal impact. If it's the first page
then list_cut_before moves the entire list to sublist before splicing it
back so it's a pointless operation.

-- 
Mel Gorman
SUSE Labs
