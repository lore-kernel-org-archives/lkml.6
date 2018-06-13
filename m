Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 890DEC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492592086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492592086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935556AbeFMN3s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:29:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44899 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935269AbeFMN3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:29:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38C2DAE2A;
        Wed, 13 Jun 2018 13:29:45 +0000 (UTC)
Date:   Wed, 13 Jun 2018 15:29:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc patch] mm, oom: fix unnecessary killing of additional
 processes
Message-ID: <20180613132944.GL13364@dhcp22.suse.cz>
References: <20180525072636.GE11881@dhcp22.suse.cz>
 <alpine.DEB.2.21.1805251227380.158701@chino.kir.corp.google.com>
 <20180528081345.GD1517@dhcp22.suse.cz>
 <alpine.DEB.2.21.1805301357100.150424@chino.kir.corp.google.com>
 <20180531063212.GF15278@dhcp22.suse.cz>
 <alpine.DEB.2.21.1805311400260.74563@chino.kir.corp.google.com>
 <20180601074642.GW15278@dhcp22.suse.cz>
 <alpine.DEB.2.21.1806042100200.71129@chino.kir.corp.google.com>
 <20180605085707.GV19202@dhcp22.suse.cz>
 <56138495-fd91-62f8-464a-db9960bfeb28@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56138495-fd91-62f8-464a-db9960bfeb28@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-06-18 22:20:49, Tetsuo Handa wrote:
> On 2018/06/05 17:57, Michal Hocko wrote:
> >> For this reason, we see testing harnesses often oom killed immediately 
> >> after running a unittest that stresses reclaim or compaction by inducing a 
> >> system-wide oom condition.  The harness spawns the unittest which spawns 
> >> an antagonist memory hog that is intended to be oom killed.  When memory 
> >> is mlocked or there are a large number of threads faulting memory for the 
> >> antagonist, the unittest and the harness itself get oom killed because the 
> >> oom reaper sets MMF_OOM_SKIP; this ends up happening a lot on powerpc.  
> >> The memory hog has mm->mmap_sem readers queued ahead of a writer that is 
> >> doing mmap() so the oom reaper can't grab the sem quickly enough.
> > 
> > How come the writer doesn't back off. mmap paths should be taking an
> > exclusive mmap sem in killable sleep so it should back off. Or is the
> > holder of the lock deep inside mmap path doing something else and not
> > backing out with the exclusive lock held?
> > 
>  
> Here is an example where the writer doesn't back off.
> 
>   http://lkml.kernel.org/r/20180607150546.1c7db21f70221008e14b8bb8@linux-foundation.org
> 
> down_write_killable(&mm->mmap_sem) is nothing but increasing the possibility of
> successfully back off. There is no guarantee that the owner of that exclusive
> mmap sem will not be blocked by other unkillable waits.

but we are talking about mmap() path here. Sure there are other paths
which might need a back off while the lock is held and that should be
addressed if possible but this is not really related to what David wrote
above and I tried to understand.

-- 
Michal Hocko
SUSE Labs
