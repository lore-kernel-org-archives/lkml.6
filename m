Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D668C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF3A21509
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF3A21509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeHHMqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:46:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:56422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbeHHMqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:46:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D562AD09;
        Wed,  8 Aug 2018 10:27:37 +0000 (UTC)
Date:   Wed, 8 Aug 2018 12:27:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
Message-ID: <20180808102734.GH27972@dhcp22.suse.cz>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
 <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Josh - the whole series is
http://lkml.kernel.org/r/153365347929.19074.12509495712735843805.stgit@localhost.localdomain]

On Wed 08-08-18 13:17:44, Kirill Tkhai wrote:
> On 08.08.2018 10:20, Michal Hocko wrote:
> > On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
> >> This patch kills all CONFIG_SRCU defines and
> >> the code under !CONFIG_SRCU.
> > 
> > The last time somebody tried to do this there was a pushback due to
> > kernel tinyfication. So this should really give some numbers about the
> > code size increase. Also why can't we make this depend on MMU. Is
> > anybody else than the reclaim asking for unconditional SRCU usage?
> 
> I don't know one. The size numbers (sparc64) are:
> 
> $ size image.srcu.disabled 
>    text	   data	    bss	    dec	    hex	filename
> 5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
> $ size image.srcu.enabled
>    text	   data	    bss	    dec	    hex	filename
> 5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
> The difference is: 15158625-15116156 = 42469 ~41Kb
> 
> Please, see the measurement details to my answer to Stephen.
> 
> > Btw. I totaly agree with Steven. This is a very poor changelog. It is
> > trivial to see what the patch does but it is far from clear why it is
> > doing that and why we cannot go other ways.
> We possibly can go another way, and there is comment to [2/10] about this.
> Percpu rwsem may be used instead, the only thing, it is worse, is it will
> make shrink_slab() wait unregistering shrinkers, while srcu-based
> implementation does not require this.

Well, if unregisterring doesn't do anything subtle - e.g. an allocation
or take locks which depend on allocation - and we can guarantee that
then blocking shrink_slab shouldn't be a big deal. It is subtle though.
Maybe subtle enough to make unconditional SRCU worth it. This all should
be in the changelog though.

> This may be not a big problem.
> But, if SRCU is real problem for embedded people, I really don't want they
> hate me in the future because of this, so please CC someone if you know :)

I guess Josh was trying to pursue kernel tinification.

-- 
Michal Hocko
SUSE Labs
