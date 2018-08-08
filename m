Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE3221723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3221723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeHHSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:38:35 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58144 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727062AbeHHSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:38:35 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 199753A01E6;
        Wed,  8 Aug 2018 18:13:53 +0200 (CEST)
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DF6E52000A;
        Wed,  8 Aug 2018 16:13:32 +0000 (UTC)
Date:   Wed, 8 Aug 2018 09:13:30 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
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
Message-ID: <20180808161330.GA22863@localhost>
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

On Wed, Aug 08, 2018 at 01:17:44PM +0300, Kirill Tkhai wrote:
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

41k is a *substantial* size increase. However, can you compare
tinyconfig with and without this patch? That may have a smaller change.
