Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D997C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C721917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbeLURUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:20:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:54995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbeLURUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:20:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 09:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="305773566"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2018 09:20:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 69927301036; Fri, 21 Dec 2018 09:20:44 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:20:44 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, hubicka@ucw.cz
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181221172044.GE25620@tassilo.jf.intel.com>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
 <20181218000800.GB25620@tassilo.jf.intel.com>
 <20181218091824.GI2218@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218091824.GI2218@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In particular turning an address-dependency into a control-dependency,
> which is something allowed by the C language, since it doesn't recognise
> these concepts as such.
> 
> The 'optimization' is allowed currently, but LTO will make it much more
> likely since it will have a much wider view of things. Esp. when combined
> with PGO.
> 
> Specifically; if you have something like:
> 
> int idx;
> struct object objs[2];
> 
> the statement:
> 
>   val = objs[idx & 1].ponies;
> 
> which you 'need' to be translated like:
> 
>   struct object *obj = objs;
>   obj += (idx & 1);
>   val = obj->ponies;
> 
> Such that the load of obj->ponies depends on the load of idx. However
> our dear compiler is allowed to make it:
> 
>   if (idx & 1)
>     obj = &objs[1];
>   else
>     obj = &objs[0];
> 
>   val = obj->ponies;

I don't see why a compiler would do such an optimization. Clearly
the second variant is worse than the first, bigger and needs
branch prediction resources.

In fact compilers usually try hard to go into the other direction
and apply if conversion.

Has anyone seen real world examples of such changes being done, or is this
all language lawyering theory?

-Andi

> 
> Because C doesn't recognise this as being different. However this is
> utterly broken, because in this translation we can speculate the load
> of obj->ponies such that it no longer depends on the load of idx, which
> breaks RCU.
> 
> Note that further 'optimization' is possible and the compiler could even
> make it:
> 
>   if (idx & 1)
>     val = objs[1].ponies;
>   else
>     val = objs[0].ponies;
> 
> Now, granted, this is a fairly artificial example, but it does
> illustrate the exact problem.
> 
> The more the compiler can see of the complete program, the more likely
> it can make inferrences like this, esp. when coupled with PGO.
> 
> Now, we're (usually) very careful to wrap things in READ_ONCE() and
> rcu_dereference() and the like, which makes it harder on the compiler
> (because 'volatile' is special), but nothing really stops it from doing
> this.
> 
> Paul has been trying to beat clue into the language people, but given
> he's been at it for 10 years now, and there's no resolution, I figure we
> ought to get compiler implementations to give us a knob.
