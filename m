Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C21C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A478A240A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A478A240A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGFFjq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932614AbeGFFjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:39:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 565DCAD37;
        Fri,  6 Jul 2018 05:39:43 +0000 (UTC)
Date:   Fri, 6 Jul 2018 07:39:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180706053942.GF32658@dhcp22.suse.cz>
References: <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
 <20180630170522.GZ3593@linux.vnet.ibm.com>
 <20180702213714.GA7604@linux.vnet.ibm.com>
 <20180703072413.GD16767@dhcp22.suse.cz>
 <20180703160101.GC3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703160101.GC3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 09:01:01, Paul E. McKenney wrote:
> On Tue, Jul 03, 2018 at 09:24:13AM +0200, Michal Hocko wrote:
> > On Mon 02-07-18 14:37:14, Paul E. McKenney wrote:
> > [...]
> > > commit d2b8d16b97ac2859919713b2d98b8a3ad22943a2
> > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Date:   Mon Jul 2 14:30:37 2018 -0700
> > > 
> > >     rcu: Remove OOM code
> > >     
> > >     There is reason to believe that RCU's OOM code isn't really helping
> > >     that much, given that the best it can hope to do is accelerate invoking
> > >     callbacks by a few seconds, and even then only if some CPUs have no
> > >     non-lazy callbacks, a condition that has been observed to be rare.
> > >     This commit therefore removes RCU's OOM code.  If this causes problems,
> > >     it can easily be reinserted.
> > >     
> > >     Reported-by: Michal Hocko <mhocko@kernel.org>
> > >     Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > I would also note that waiting in the notifier might be a problem on its
> > own because we are holding the oom_lock and the system cannot trigger
> > the OOM killer while we are holding it and waiting for oom_callback_wq
> > event. I am not familiar with the code to tell whether this can deadlock
> > but from a quick glance I _suspect_ that we might depend on __rcu_reclaim
> > and basically an arbitrary callback so no good.
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Thanks!
> 
> Like this?

Thanks!
-- 
Michal Hocko
SUSE Labs
