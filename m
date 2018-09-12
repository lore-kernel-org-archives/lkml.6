Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74F7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2CF20892
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2CF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeILS66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeILS65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D3B730001E8;
        Wed, 12 Sep 2018 13:54:20 +0000 (UTC)
Received: from sky.random (ovpn-125-12.rdu2.redhat.com [10.10.125.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99DBA60C6A;
        Wed, 12 Sep 2018 13:54:19 +0000 (UTC)
Date:   Wed, 12 Sep 2018 09:54:17 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Message-ID: <20180912135417.GA15194@redhat.com>
References: <20180907130550.11885-1-mhocko@kernel.org>
 <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com>
 <20180911115613.GR10951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911115613.GR10951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 12 Sep 2018 13:54:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 11, 2018 at 01:56:13PM +0200, Michal Hocko wrote:
> Well, it seems that expectations differ for users. It seems that kvm
> users do not really agree with your interpretation.

Like David also mentioned here:

lkml.kernel.org/r/alpine.DEB.2.21.1808211021110.258924@chino.kir.corp.google.com

depends on the hardware what is a win, so there's no one size fits
all.

For two sockets providing remote THP to KVM is likely a win, but
changing the defaults depending on boot-time NUMA topology makes
things less deterministic and it's also impossible to define an exact
break even point.

> I do realize that this is a gray zone because nobody bothered to define
> the semantic since the MADV_HUGEPAGE has been introduced (a826e422420b4
> is exceptionaly short of information). So we are left with more or less
> undefined behavior and define it properly now. As we can see this might
> regress in some workloads but I strongly suspect that an explicit
> binding sounds more logical approach than a thp specific mpol mode. If
> anything this should be a more generic memory policy basically saying
> that a zone/node reclaim mode should be enabled for the particular
> allocation.

MADV_HUGEPAGE means the allocation is long lived, so the cost of
compaction is worth it in direct reclaim. Not much else. That is not
the problem.

The problem is that even if you ignore the breakage and regression to
real life workloads, what is happening right now obviously would
require root privilege but MADV_HUEGPAGE requires no root privilege.

Swapping heavy because MADV_HUGEPAGE when there are gigabytes free on
other nodes and not even 4k would be swapped-out with THP turned off
in sysfs, is simply not possibly what MADV_HUGEPAGE could have been
about, and it's a kernel regression that never existed until that
commit that added __GFP_THISNODE to the default THP heuristic in
mempolicy.

I think we should defer the problem of what is better between 4k NUMA
local or remote THP by default for later, I provided two options
myself because it didn't matter so much which option we picked in the
short term, as long as the bug was fixed.

I wasn't particularly happy about your patch because it still swaps
with certain defrag settings which is still allowing things that
shouldn't happen without some kind of privileged capability.

If you can update the patch to prevent swapping in all cases it's a go
as far as I'm concerned. The main difference is that you're dropping
the THP logic in the mempolicy code which will make it worse for some
case and I was trying to retain it for all cases where swapping
wouldn't happen anyway and such logic would have still provided the
behavior David prefers to those cases.

Adding the new feature to create a THP specific mempolicy can be done
later. In the meanwhile the current mempolicy code can always override
whatever THP default behavior that gets out of this, just it will
require the admin to setup a mempolicy to enforce the preferred
behavior to 4k and THP allocations alike.

Thanks,
Andrea
