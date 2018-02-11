Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeBKLvy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:51:54 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38302 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbeBKLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:51:53 -0500
X-Google-Smtp-Source: AH8x227/4jaxgrhqGe5RoWYyLbhcT+XA4qbdp0tWDldSyecqQXRM6VNrN0Nd/ARrKcK/Bl1ERP4ddg==
Date: Sun, 11 Feb 2018 12:51:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
Message-ID: <20180211115148.iylaqk3f53f2vgf4@gmail.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
 <20180210010703.GE3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210010703.GE3617@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Sat, Feb 10, 2018 at 08:46:25AM +0900, Akira Yokosawa wrote:
> > >From 7c1f497a9a51e8db1a94c8a7ef0b74b235aaab88 Mon Sep 17 00:00:00 2001
> > From: Akira Yokosawa <akiyks@gmail.com>
> > Date: Fri, 9 Feb 2018 04:51:05 -0800
> > Subject: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-" -> "_")
> > 
> > As of herd7 7.47, these '-'s are not permitted and end up in
> > errors such as:
> > 
> >     File "./linux-kernel.def", line 44, characters 29-30:
> >     unexpected '-' (in macros)
> > 
> > Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
> > identifiers match ASPLOS paper") in the repository at
> > https://github.com/aparri/memory-model can restore the compatibility
> > with herd7 7.47.
> > 
> > Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > ---
> > Paul,
> > 
> > FWIW, this is a squashed version relative to patch 07/10 in the RFC series.
> 
> Thank you, Akira!
> 
> I am going to hold off on this for a bit to see if we can instead get
> a new release of herd7, but if we can't. this might well be a very good
> way to go.

I'm wondering:

> >  // RCU
> > -rcu_read_lock() { __fence{rcu-lock}; }
> > -rcu_read_unlock() { __fence{rcu-unlock};}
> > -synchronize_rcu() { __fence{sync-rcu}; }
> > -synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > +rcu_read_lock() { __fence{rcu_lock}; }
> > +rcu_read_unlock() { __fence{rcu_unlock};}
> > +synchronize_rcu() { __fence{sync_rcu}; }
> > +synchronize_rcu_expedited() { __fence{sync_rcu}; }

What's the point of using '-' instead of '_'? In a program language syntax 
environment it's easy to confuse it with a '-' operator, and it also looks 
slightly sloppy and inconsistent if we sometimes have '_' and sometimes '-'.

If it used on purpose, to separate namespaces from kernel internal API names,
then that's rather obscure IMHO and then I'd rather suggest proper prefixes 
instead.

Thanks,

	Ingo
