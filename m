Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED1CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59462133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544041970;
	bh=PVAnEGet64n4u3t7QD46sm28iU0R+c1+jKhUZiQRxlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5ydsSjvYLb2yLIKZqHFDiwleh8gYpJdal/LjILanDBgJxSLI19+Q0FPW8/xbSBYU
	 gaHjrd7lBKBVpU19DYfG07o+ipw5zGMmjdpJ8gaJsnM7RmqNXTYCF4uw04YCdQyXQ5
	 HePMh/IJ0Iim2H78UuZvRKtqg+ydWW3dtEwF9C9s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59462133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeLEUcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:32:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:54326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbeLEUcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:32:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBC3EAEFC;
        Wed,  5 Dec 2018 20:32:45 +0000 (UTC)
Date:   Wed, 5 Dec 2018 21:32:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <20181205203243.GX1286@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
 <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com>
 <20181205090554.GX1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 11:49:26, David Rientjes wrote:
> On Wed, 5 Dec 2018, Michal Hocko wrote:
> 
> > > The revert is certainly needed to prevent the regression, yes, but I 
> > > anticipate that Andrea will report back that patch 2 at least improves the 
> > > situation for the problem that he was addressing, specifically that it is 
> > > pointless to thrash any node or reclaim unnecessarily when compaction has 
> > > already failed.  This is what setting __GFP_NORETRY for all thp fault 
> > > allocations fixes.
> > 
> > Yes but earlier numbers from Mel and repeated again [1] simply show
> > that the swap storms are only handled in favor of an absolute drop of
> > THP success rate.
> >  
> 
> As we've been over countless times, this is the desired effect for 
> workloads that fit on a single node.  We want local pages of the native 
> page size because they (1) are accessed faster than remote hugepages and 
> (2) are candidates for collapse by khugepaged.
> 
> For applications that do not fit in a single node, we have discussed 
> possible ways to extend the API to allow remote faulting of hugepages, 
> absent remote fragmentation as well, then the long-standing behavior is 
> preserved and large applications can use the API to increase their thp 
> success rate.

OK, I just give up. This doesn't lead anywhere. You keep repeating the
same stuff over and over, neglect other usecases and actually force them
to do something special just to keep your very specific usecase which
you clearly refuse to abstract into a form other people can experiment
with or at least provide more detailed broken down numbers for a more
serious analyses. Fault latency is only a part of the picture which is
much more complex. Look at Mel's report to get an impression of what
might be really useful for a _productive_ discussion.
-- 
Michal Hocko
SUSE Labs
