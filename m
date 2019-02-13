Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF7222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550071140;
	bh=2tQm6hLCOgf6dUKbgxaGXedhukwhAW3gvkGr/4yUMSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jCBPCqAGTryR8nuNAUnPUFXHE7esRinQwQYiNegJipfy1lQaOzze6+7v6GKPt1IYW
	 rxmdj4ndOhtKPnaIba4o3LmE5Ek9NPY7OasBrfcRuWcjbDOVROaCgpMISkszvtXy1o
	 w3s4tY0oexpwcewiEGbfJQqFywwjHV5C0jAeQfKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391626AbfBMPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:18:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbfBMPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:18:58 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702F1222CA;
        Wed, 13 Feb 2019 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550071138;
        bh=2tQm6hLCOgf6dUKbgxaGXedhukwhAW3gvkGr/4yUMSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyqILcr4Jr+5H/vKhZcMisWTu7neNUo5MU0cb7SVJgwg6NwpuMwQF3CmACWVd042M
         Nn+o4VgMsX+Y9lASsKCOqVUgtEIaQ/BWP35k2IrVOG9L0Ran9J41t9nS9YsHFSospG
         TKrhLTPsL7t2sXdMDe2eMXtff1a/QF15n0jVNAIg=
Date:   Wed, 13 Feb 2019 16:18:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 09/32] locking/lockdep: Save stack trace for each softirq
 vector involved
Message-ID: <20190213151854.GE8524@lenoir>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-10-frederic@kernel.org>
 <CAHk-=whPfzTR8my+Ktw93SC4YXO8pBc70gTEso06ei_K2jZqRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPfzTR8my+Ktw93SC4YXO8pBc70gTEso06ei_K2jZqRQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:47:39AM -0800, Linus Torvalds wrote:
> On Tue, Feb 12, 2019 at 9:15 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> >
> > +static int save_trace_mask(struct lock_class *class, u64 mask)
> > +{
> > +       int bit = 0;
> > +
> > +       while (mask) {
> > +               long fs = __ffs64(mask) + 1;
> > +
> > +               mask >>= fs;
> > +               bit += fs;
> 
> Same buggy pattern of "ffs+1" and overflow of shift count.

You're right and there are more. I'll unify all that around
a safe iterator.

Thanks.
