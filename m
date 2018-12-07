Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F52120882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544168090;
	bh=AINiga10lCX9heQmUuVJ5pxYc1jlg5of94yTZU2zNf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ty5qH+2LDucjlmiZuwoQP0n86obfq+NnIvld0bcNCYdq+POSmYAIvD/FjUf+Fmg11
	 6jpFPpI3pfss6xg//HekgZgaYAvVwYGpTnPGhQI0R26rD4Xa4eZfTzcqV3FDTIgKxB
	 P8fOx5VfFigtN/UUzXnx1/I1jx4n76D/1jpPPAvc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F52120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGHes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:34:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:38766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbeLGHes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:34:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53689AD5C;
        Fri,  7 Dec 2018 07:34:46 +0000 (UTC)
Date:   Fri, 7 Dec 2018 08:34:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: MADV_HUGEPAGE vs. NUMA semantic (was: Re: [LKP] [mm] ac5b2c1891:
 vm-scalability.throughput -61.3% regression)
Message-ID: <20181207073444.GQ1286@dhcp22.suse.cz>
References: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <20181206091405.GD1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812061544360.162675@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812061544360.162675@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 15:49:04, David Rientjes wrote:
> On Thu, 6 Dec 2018, Michal Hocko wrote:
> 
> > MADV_HUGEPAGE changes the picture because the caller expressed a need
> > for THP and is willing to go extra mile to get it. That involves
> > allocation latency and as of now also a potential remote access. We do
> > not have complete agreement on the later but the prevailing argument is
> > that any strong NUMA locality is just reinventing node-reclaim story
> > again or makes THP success rate down the toilet (to quote Mel). I agree
> > that we do not want to fallback to a remote node overeagerly. I believe
> > that something like the below would be sensible
> > 	1) THP on a local node with compaction not giving up too early
> > 	2) THP on a remote node in NOWAIT mode - so no direct
> > 	   compaction/reclaim (trigger kswapd/kcompactd only for
> > 	   defrag=defer+madvise)
> > 	3) fallback to the base page allocation
> > 
> 
> I disagree that MADV_HUGEPAGE should take on any new semantic that 
> overrides the preference of node local memory for a hugepage, which is the 
> nearly four year behavior.  The order of MADV_HUGEPAGE preferences listed 
> above would cause current users to regress who rely on local small page 
> fallback rather than remote hugepages because the access latency is much 
> better.  I think the preference of remote hugepages over local small pages 
> needs to be expressed differently to prevent regression.

Such a model would be broken. It doesn't provide consistent semantic and
leads to surprising results. MADV_HUGEPAGE with local node binding will
not prevent remote base pages to be used and you are back to square one.

It has been a huge mistake to merge your __GFP_THISNODE patch back then
in 4.1. Especially with an absolute lack of numbers for a variety of
workloads. I still believe we can do better, offer a sane mem policy to
help workloads with higher locality demands but it is outright wrong
to confalte demand for THP with the locality semantic.

If this is absolutely no go then we need a MADV_HUGEPAGE_SANE...

-- 
Michal Hocko
SUSE Labs
