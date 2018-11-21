Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0937C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4A221104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4A221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeKURaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:30:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:56924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbeKURaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:30:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F077B037;
        Wed, 21 Nov 2018 06:56:58 +0000 (UTC)
Date:   Wed, 21 Nov 2018 07:56:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Jan Kara <jack@suse.cz>, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA
 flags in /proc/<pid>/smaps
Message-ID: <20181121065656.GA12932@dhcp22.suse.cz>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-2-mhocko@kernel.org>
 <20181120105135.GF8842@quack2.suse.cz>
 <alpine.DEB.2.21.1811201558060.89573@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811201558060.89573@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 16:01:47, David Rientjes wrote:
> On Tue, 20 Nov 2018, Jan Kara wrote:
> 
> > > Even though vma flags exported via /proc/<pid>/smaps are explicitly
> > > documented to be not guaranteed for future compatibility the warning
> > > doesn't go far enough because it doesn't mention semantic changes to
> > > those flags. And they are important as well because these flags are
> > > a deep implementation internal to the MM code and the semantic might
> > > change at any time.
> > > 
> > > Let's consider two recent examples:
> > > http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
> > > : commit e1fb4a086495 "dax: remove VM_MIXEDMAP for fsdax and device dax" has
> > > : removed VM_MIXEDMAP flag from DAX VMAs. Now our testing shows that in the
> > > : mean time certain customer of ours started poking into /proc/<pid>/smaps
> > > : and looks at VMA flags there and if VM_MIXEDMAP is missing among the VMA
> > > : flags, the application just fails to start complaining that DAX support is
> > > : missing in the kernel.
> > > 
> > > http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
> > > : Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> > > : introduced a regression in that userspace cannot always determine the set
> > > : of vmas where thp is ineligible.
> > > : Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> > > : to determine if a vma is eligible to be backed by hugepages.
> > > : Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
> > > : be disabled and emit "nh" as a flag for the corresponding vmas as part of
> > > : /proc/pid/smaps.  After the commit, thp is disabled by means of an mm
> > > : flag and "nh" is not emitted.
> > > : This causes smaps parsing libraries to assume a vma is eligible for thp
> > > : and ends up puzzling the user on why its memory is not backed by thp.
> > > 
> > > In both cases userspace was relying on a semantic of a specific VMA
> > > flag. The primary reason why that happened is a lack of a proper
> > > internface. While this has been worked on and it will be fixed properly,
> > > it seems that our wording could see some refinement and be more vocal
> > > about semantic aspect of these flags as well.
> > > 
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > Honestly, it just shows that no amount of documentation is going to stop
> > userspace from abusing API that's exposing too much if there's no better
> > alternative. But this is a good clarification regardless. So feel free to
> > add:
> > 
> > Acked-by: Jan Kara <jack@suse.cz>
> > 
> 
> I'm not sure what is expected of a userspace developer who finds they have 
> a single way to determine if something is enabled/disabled.  Should they 
> refer to the documentation and see that the flag may be unstable so they 
> write a kernel patch and have it merged upstream before using it?  What to 
> do when they don't control the kernel version they are running on?

Well, I would treat it as any standard feature request. Ask for the
feature upstream and work with the comunity to come up with a reasonable
and a stable API.

> Anyway, mentioning that the vm flags here only have meaning depending on 
> the kernel version seems like a worthwhile addition:
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
