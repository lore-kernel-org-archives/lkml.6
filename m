Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBQUNJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:13:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBQUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:13:08 -0500
Date: Sat, 17 Feb 2018 21:13:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/2] jump_label: Explicitly disable jump labels in
 __init code
In-Reply-To: <20180217134035.67jzcc5rwtyyufix@treble>
Message-ID: <alpine.DEB.2.21.1802172108240.2087@nanos.tec.linutronix.de>
References: <cover.1518798288.git.jpoimboe@redhat.com> <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com> <20180217103848.yiutigxpukxfbtze@gmail.com> <20180217134035.67jzcc5rwtyyufix@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2018, Josh Poimboeuf wrote:
> On Sat, Feb 17, 2018 at 11:38:48AM +0100, Ingo Molnar wrote:
> > 
> > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > +/* Disable any jump label entries in __init code */
> > > +void __init jump_label_invalidate_init(void)
> > > +{
> > > +	struct jump_entry *iter_start = __start___jump_table;
> > > +	struct jump_entry *iter_stop = __stop___jump_table;
> > > +	struct jump_entry *iter;
> > > +
> > > +	for (iter = iter_start; iter < iter_stop; iter++)
> > > +		if (iter->code >= (unsigned long)_sinittext &&
> > > +		    iter->code < (unsigned long)_einittext)
> > > +			iter->code = 0;
> > > +}
> > > +
> > > +/* Disable any jump label entries in module init code */
> > >  static void jump_label_invalidate_module_init(struct module *mod)
> > >  {
> > >  	struct jump_entry *iter_start = mod->jump_entries;
> > >  	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
> > >  	struct jump_entry *iter;
> > >  
> > > -	for (iter = iter_start; iter < iter_stop; iter++) {
> > > +	for (iter = iter_start; iter < iter_stop; iter++)
> > >  		if (within_module_init(iter->code, mod))
> > >  			iter->code = 0;
> > > -	}
> > 
> > Why did you remove the curly braces? They are canonical kernel style for 
> > multi-line statements.
> 
> Personally I prefer the more compact version, but I have no problem
> changing it.

Yes, it's certainly a matter of taste. Here is the reason why myself and
others prefer the version with braces:

       https://marc.info/?l=linux-kernel&m=148467980905537&w=2

Thanks,

	tglx
