Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363B820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544087652;
	bh=7P78ndcyKAoH2eNDKF5nzbJfjiD3d2M/dIK0RPJxxAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iWnn7lBprQHUctPVLtos9Ff9rRYfLQEs2hP2v132izb6KyaaHTUOQiszj72J4Kmor
	 t99PCEJfOQrjZvwI/7i6y4PYde5uz7Rf0gDa+6eCzdfc+uiDp2BNME8nJdJkofMkAP
	 Xt82yoEjBwHB4i547WVEndn3wD94mvsVBb4zoGJU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363B820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeLFJOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:14:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:52524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbeLFJOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:14:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CF61AE85;
        Thu,  6 Dec 2018 09:14:08 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:14:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: MADV_HUGEPAGE vs. NUMA semantic (was: Re: [LKP] [mm] ac5b2c1891:
 vm-scalability.throughput -61.3% regression)
Message-ID: <20181206091405.GD1286@dhcp22.suse.cz>
References: <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 16:58:02, Linus Torvalds wrote:
[...]
> I realize that we probably do want to just have explicit policies that
> do not exist right now, but what are (a) sane defaults, and (b) sane
> policies?

I would focus on the current default first (which is defrag=madvise).
This means that we only try the cheapest possible THP without
MADV_HUGEPAGE. If there is none we simply fallback. We do restrict to
the local node. I guess there is a general agreement that this is a sane
default.

MADV_HUGEPAGE changes the picture because the caller expressed a need
for THP and is willing to go extra mile to get it. That involves
allocation latency and as of now also a potential remote access. We do
not have complete agreement on the later but the prevailing argument is
that any strong NUMA locality is just reinventing node-reclaim story
again or makes THP success rate down the toilet (to quote Mel). I agree
that we do not want to fallback to a remote node overeagerly. I believe
that something like the below would be sensible
	1) THP on a local node with compaction not giving up too early
	2) THP on a remote node in NOWAIT mode - so no direct
	   compaction/reclaim (trigger kswapd/kcompactd only for
	   defrag=defer+madvise)
	3) fallback to the base page allocation

This would allow both full memory utilization and try to be as local as
possible. Whoever strongly prefers NUMA locality should be using
MPOL_NODE_RECLAIM (or similar) and that would skip 2 and make 1) and 2)
use more aggressive compaction and reclaim.

This will also fit into our existing NUMA api. MPOL_NODE_RECLAIM
wouldn't be restricted to THP obviously. It would act on base pages as
well and it would basically use the same implementation as we have for
the global node_reclaim and make it usable again.

Does this sound at least remotely sane?
-- 
Michal Hocko
SUSE Labs
