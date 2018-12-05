Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DEE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DEE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLEHel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:34:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:55258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEHek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:34:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45BF0ACC7;
        Wed,  5 Dec 2018 07:34:38 +0000 (UTC)
Date:   Wed, 5 Dec 2018 08:34:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 1/2 for-4.20] mm, thp: restore node-local hugepage
 allocations
Message-ID: <20181205073434.GT1286@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812031545560.161134@chino.kir.corp.google.com>
 <20181204073535.GV31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812041355100.157466@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041355100.157466@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 13:56:30, David Rientjes wrote:
> On Tue, 4 Dec 2018, Michal Hocko wrote:
> 
> > > This is a full revert of ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
> > > MADV_HUGEPAGE mappings") and a partial revert of 89c83fb539f9 ("mm, thp:
> > > consolidate THP gfp handling into alloc_hugepage_direct_gfpmask").
> > > 
> > > By not setting __GFP_THISNODE, applications can allocate remote hugepages
> > > when the local node is fragmented or low on memory when either the thp
> > > defrag setting is "always" or the vma has been madvised with
> > > MADV_HUGEPAGE.
> > > 
> > > Remote access to hugepages often has much higher latency than local pages
> > > of the native page size.  On Haswell, ac5b2c18911f was shown to have a
> > > 13.9% access regression after this commit for binaries that remap their
> > > text segment to be backed by transparent hugepages.
> > > 
> > > The intent of ac5b2c18911f is to address an issue where a local node is
> > > low on memory or fragmented such that a hugepage cannot be allocated.  In
> > > every scenario where this was described as a fix, there is abundant and
> > > unfragmented remote memory available to allocate from, even with a greater
> > > access latency.
> > > 
> > > If remote memory is also low or fragmented, not setting __GFP_THISNODE was
> > > also measured on Haswell to have a 40% regression in allocation latency.
> > > 
> > > Restore __GFP_THISNODE for thp allocations.
> > > 
> > > Fixes: ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings")
> > > Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")
> > 
> > At minimum do not remove the cleanup part which consolidates the gfp
> > hadnling to a single place. There is no real reason to have the
> > __GFP_THISNODE ugliness outside of alloc_hugepage_direct_gfpmask.
> > 
> 
> The __GFP_THISNODE usage is still confined to 
> alloc_hugepage_direct_gfpmask() for the thp fault path, we no longer set 
> it in alloc_pages_vma() as done before the cleanup.

Why should be new_page any different?

-- 
Michal Hocko
SUSE Labs
