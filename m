Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF062C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9A720645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544040935;
	bh=NZnSMlwBg6i7YvR2M4DxLhwKgdBp3bAnZCeOYkeJncA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RXKcTemQsngGa7m+RVW1tb7lThdjmJTtwWeF2PfgZcR3wG4oZHE5+v/2r9Gdov8sk
	 ykZ4xRpkf4VXTP4abB1EuOfK78mNQIkMtwRh8uWsrUAppQ4uYRo6uFstwFtSieSAmS
	 6dFyPP87QS720KU9mY5mJ+L0o5ceXzP9ke5yHKR4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9A720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeLEUPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:15:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeLEUPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:15:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8923ACAB;
        Wed,  5 Dec 2018 20:15:31 +0000 (UTC)
Date:   Wed, 5 Dec 2018 21:15:28 +0100
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
Message-ID: <20181205201528.GW1286@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812031545560.161134@chino.kir.corp.google.com>
 <20181204073535.GV31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812041355100.157466@chino.kir.corp.google.com>
 <20181205073434.GT1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051120550.240991@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812051120550.240991@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 11:24:53, David Rientjes wrote:
> On Wed, 5 Dec 2018, Michal Hocko wrote:
> 
> > > > At minimum do not remove the cleanup part which consolidates the gfp
> > > > hadnling to a single place. There is no real reason to have the
> > > > __GFP_THISNODE ugliness outside of alloc_hugepage_direct_gfpmask.
> > > > 
> > > 
> > > The __GFP_THISNODE usage is still confined to 
> > > alloc_hugepage_direct_gfpmask() for the thp fault path, we no longer set 
> > > it in alloc_pages_vma() as done before the cleanup.
> > 
> > Why should be new_page any different?
> > 
> 
> To match alloc_new_node_page() which does it correctly and does not change 
> the behavior of mbind() that the cleanup did, which used 
> alloc_hugepage_vma() to get the __GFP_THISNODE behavior.  If there is a 
> reason mbind() is somehow different wrt allocating hugepages locally, I 
> think that should be a separate patch, but the goal of this patch is to 
> revert all the behavioral change that caused hugepages to be allocated 
> remotely.

If the __GFP_THISNODE should be really used then it should be applied to
all other types of pages. Not only THP. And as such done in a separate
patch. Not a part of the revert. The cleanup was meant to unify THP
allocations and that is why I object to reverting it as a part of this
work.

-- 
Michal Hocko
SUSE Labs
