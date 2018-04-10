Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeDJQab (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:30:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeDJQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:30:30 -0400
Date: Tue, 10 Apr 2018 18:30:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, aulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apw@canonical.com
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
Message-ID: <20180410163017.GH4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <20180410123305.GF4082@hirez.programming.kicks-ass.net>
 <bece0d90535709ef39006adb5f481993d6063929.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bece0d90535709ef39006adb5f481993d6063929.camel@perches.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 08:14:54AM -0700, Joe Perches wrote:
> Whinging about bool <foo> : <x> seems entirely sensible
> and straightforward to do.
> 
> I'm not so sure about bool in structs as a patch context
> could be adding a bool to local stack definitions and
> there's no real ability to determine if the bool is in a
> struct or on the stack.
> 
> Also, I think there's nothing really wrong with using
> bool in structs.  Steven Rostedt's rationale in
> https://lkml.org/lkml/2017/11/21/207 isn't really right
> as sizeof(int) is 4 not 1 and sizeof(bool) is 1 on arches
> without alignment issues.  I believe when using gcc,
> sizeof(bool) is always 1 and there may be alignment padding
> added on some arches.  Dunno.

C std simply does not define sizeof(_Bool) and leaves it up to
architecture ABI, therefore I refuse to use _Bool in composite types,
because I care about layout.

Also, not all architectures can do byte addressing, see Alpha <EV56
and for those _Bool would have to be a whole word (the existence of such
architectures likely influenced the vague definition of _Bool in the
first place).

> But I think the battle is already lost anyway.
> 
> git grep -P  '(?<!static|extern)\s+bool\s+\w+\s*;' include | wc -l
> 1543

Yes I know, doesn't mean we shouldn't discourage it for new code; also Linus.
