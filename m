Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6917C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7356C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7356C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeJ2S4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:56:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729628AbeJ2S4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:56:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 657A8AEB1;
        Mon, 29 Oct 2018 10:08:35 +0000 (UTC)
Date:   Mon, 29 Oct 2018 11:08:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181029100834.GG32673@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-2-mhocko@kernel.org>
 <20181029051752.GB16399@350D>
 <20181029090035.GE32673@dhcp22.suse.cz>
 <20181029094253.GC16399@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029094253.GC16399@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 20:42:53, Balbir Singh wrote:
> On Mon, Oct 29, 2018 at 10:00:35AM +0100, Michal Hocko wrote:
[...]
> > These hugetlb allocations might be disruptive and that is an expected
> > behavior because this is an explicit requirement from an admin to
> > pre-allocate large pages for the future use. __GFP_RETRY_MAYFAIL just
> > underlines that requirement.
> 
> Yes, but in the absence of a particular node, for example via sysctl
> (as the compaction does), I don't think it is a hard requirement to get
> a page from a particular node.

Again this seems like a deliberate decision. You want your distributions
as even as possible otherwise the NUMA placement will be much less
deterministic. At least that was the case for a long time. If you
have different per-node preferences, just use NUMA aware pre-allocation.

> I agree we need __GFP_RETRY_FAIL, in any
> case the real root cause for me is should_reclaim_continue() which keeps
> the task looping without making forward progress.

This seems like a separate issue which should better be debugged. Please
open a new thread describing the problem and the state of the node.

-- 
Michal Hocko
SUSE Labs
