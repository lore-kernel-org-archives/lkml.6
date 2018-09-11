Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67512C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AA920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeIKQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeIKQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C02A9AE41;
        Tue, 11 Sep 2018 11:56:16 +0000 (UTC)
Date:   Tue, 11 Sep 2018 13:56:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Message-ID: <20180911115613.GR10951@dhcp22.suse.cz>
References: <20180907130550.11885-1-mhocko@kernel.org>
 <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-09-18 13:08:34, David Rientjes wrote:
> On Fri, 7 Sep 2018, Michal Hocko wrote:
[...]
> > Fix this by removing __GFP_THISNODE handling from alloc_pages_vma where
> > it doesn't belong and move it to alloc_hugepage_direct_gfpmask where we
> > juggle gfp flags for different allocation modes. The rationale is that
> > __GFP_THISNODE is helpful in relaxed defrag modes because falling back
> > to a different node might be more harmful than the benefit of a large page.
> > If the user really requires THP (e.g. by MADV_HUGEPAGE) then the THP has
> > a higher priority than local NUMA placement.
> > 
> 
> That's not entirely true, the remote access latency for remote thp on all 
> of our platforms is greater than local small pages, this is especially 
> true for remote thp that is allocated intersocket and must be accessed 
> through the interconnect.
> 
> Our users of MADV_HUGEPAGE are ok with assuming the burden of increased 
> allocation latency, but certainly not remote access latency.  There are 
> users who remap their text segment onto transparent hugepages are fine 
> with startup delay if they are access all of their text from local thp.  
> Remote thp would be a significant performance degradation.

Well, it seems that expectations differ for users. It seems that kvm
users do not really agree with your interpretation.

> When Andrea brought this up, I suggested that the full solution would be a 
> MPOL_F_HUGEPAGE flag that could define thp allocation policy -- the added 
> benefit is that we could replace the thp "defrag" mode default by setting 
> this as part of default_policy.  Right now, MADV_HUGEPAGE users are 
> concerned about (1) getting thp when system-wide it is not default and (2) 
> additional fault latency when direct compaction is not default.  They are 
> not anticipating the degradation of remote access latency, so overloading 
> the meaning of the mode is probably not a good idea.

hugepage specific MPOL flags sounds like yet another step into even more
cluttered API and semantic, I am afraid. Why should this be any
different from regular page allocations? You are getting off-node memory
once your local node is full. You have to use an explicit binding to
disallow that. THP should be similar in that regards. Once you have said
that you _really_ want THP then you are closer to what we do for regular
pages IMHO.

I do realize that this is a gray zone because nobody bothered to define
the semantic since the MADV_HUGEPAGE has been introduced (a826e422420b4
is exceptionaly short of information). So we are left with more or less
undefined behavior and define it properly now. As we can see this might
regress in some workloads but I strongly suspect that an explicit
binding sounds more logical approach than a thp specific mpol mode. If
anything this should be a more generic memory policy basically saying
that a zone/node reclaim mode should be enabled for the particular
allocation.
-- 
Michal Hocko
SUSE Labs
