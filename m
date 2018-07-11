Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD76C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945C520020
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945C520020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeGKJC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:02:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:60040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbeGKJC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12113AE9F;
        Wed, 11 Jul 2018 08:59:10 +0000 (UTC)
Date:   Wed, 11 Jul 2018 10:59:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, oom: remove sleep from under oom_lock
Message-ID: <20180711085908.GC20050@dhcp22.suse.cz>
References: <20180709074706.30635-1-mhocko@kernel.org>
 <alpine.DEB.2.21.1807091548280.125566@chino.kir.corp.google.com>
 <20180710094341.GD14284@dhcp22.suse.cz>
 <alpine.DEB.2.21.1807101152410.9234@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807101411480.29772@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807101411480.29772@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-07-18 14:12:28, David Rientjes wrote:
> On Tue, 10 Jul 2018, David Rientjes wrote:
> 
> > I think it's better, thanks.  However, does it address the question about 
> > why __oom_reap_task_mm() needs oom_lock protection?  Perhaps it would be 
> > helpful to mention synchronization between reaping triggered from 
> > oom_reaper and by exit_mmap().
> > 
> 
> Actually, can't we remove the need to take oom_lock in exit_mmap() if 
> __oom_reap_task_mm() can do a test and set on MMF_UNSTABLE and, if already 
> set, bail out immediately?

I think we do not really depend on oom_lock anymore in
__oom_reap_task_mm.  The race it was original added for (mmget_not_zero
vs. exit path) is no longer a problem. I didn't really get to evaluate
it deeper though. There are just too many things going on in parallel.

Tetsuo was proposing some patches to remove the lock but those patches
had some other problems. If we have a simple patch to remove the
oom_lock from the oom reaper then I will review it. I am not sure I can
come up with a patch myself in few days.
-- 
Michal Hocko
SUSE Labs
