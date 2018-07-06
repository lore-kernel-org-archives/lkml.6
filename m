Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C49240AA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C49240AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbeGFFjD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:39:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932199AbeGFFjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:39:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85D7AAD37;
        Fri,  6 Jul 2018 05:39:01 +0000 (UTC)
Date:   Fri, 6 Jul 2018 07:39:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
Message-ID: <20180706053900.GE32658@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
 <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-07-18 16:46:21, Andrew Morton wrote:
> On Thu, 21 Jun 2018 14:35:20 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > The oom reaper ensures forward progress by setting MMF_OOM_SKIP itself if
> > it cannot reap an mm.  This can happen for a variety of reasons,
> > including:
> > 
> >  - the inability to grab mm->mmap_sem in a sufficient amount of time,
> > 
> >  - when the mm has blockable mmu notifiers that could cause the oom reaper
> >    to stall indefinitely,
> > 
> > but we can also add a third when the oom reaper can "reap" an mm but doing
> > so is unlikely to free any amount of memory:
> > 
> >  - when the mm's memory is mostly mlocked.
> 
> Michal has been talking about making the oom-reaper handle mlocked
> memory.  Where are we at with that?

I didn't get to mlocked memory yet because blockable mmu notifiers are
more important. And I've already posted patch for that and it is under
discussion [1]. Mlocked memory is next. 
 
[1] http://lkml.kernel.org/r/20180627074421.GF32348@dhcp22.suse.cz

Btw. I still hate this patch and making any timeout user defineable. It
is a wrong approach and my nack to this patch still applies.

-- 
Michal Hocko
SUSE Labs
