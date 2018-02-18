Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeBRNF0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:05:26 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51323 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeBRNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:05:25 -0500
X-Google-Smtp-Source: AH8x226KUKEnVTBNoPDI+8dnjCrXTfoNM9kTMErG3WANueJDjBdOGPZyX/C0U/zSRxnBz8XNA8WNnw==
Date: Sun, 18 Feb 2018 14:05:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/2] jump_label: Explicitly disable jump labels in
 __init code
Message-ID: <20180218130520.3mmosubvt443756v@gmail.com>
References: <cover.1518798288.git.jpoimboe@redhat.com>
 <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
 <20180217103848.yiutigxpukxfbtze@gmail.com>
 <20180217134035.67jzcc5rwtyyufix@treble>
 <alpine.DEB.2.21.1802172108240.2087@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802172108240.2087@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 17 Feb 2018, Josh Poimboeuf wrote:
> > On Sat, Feb 17, 2018 at 11:38:48AM +0100, Ingo Molnar wrote:
> > > 
> > > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > 
> > > > +/* Disable any jump label entries in __init code */
> > > > +void __init jump_label_invalidate_init(void)
> > > > +{
> > > > +	struct jump_entry *iter_start = __start___jump_table;
> > > > +	struct jump_entry *iter_stop = __stop___jump_table;
> > > > +	struct jump_entry *iter;
> > > > +
> > > > +	for (iter = iter_start; iter < iter_stop; iter++)
> > > > +		if (iter->code >= (unsigned long)_sinittext &&
> > > > +		    iter->code < (unsigned long)_einittext)
> > > > +			iter->code = 0;
> > > > +}
> > > > +
> > > > +/* Disable any jump label entries in module init code */
> > > >  static void jump_label_invalidate_module_init(struct module *mod)
> > > >  {
> > > >  	struct jump_entry *iter_start = mod->jump_entries;
> > > >  	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
> > > >  	struct jump_entry *iter;
> > > >  
> > > > -	for (iter = iter_start; iter < iter_stop; iter++) {
> > > > +	for (iter = iter_start; iter < iter_stop; iter++)
> > > >  		if (within_module_init(iter->code, mod))
> > > >  			iter->code = 0;
> > > > -	}
> > > 
> > > Why did you remove the curly braces? They are canonical kernel style for 
> > > multi-line statements.
> > 
> > Personally I prefer the more compact version, but I have no problem
> > changing it.
> 
> Yes, it's certainly a matter of taste. Here is the reason why myself and
> others prefer the version with braces:
> 
>        https://marc.info/?l=linux-kernel&m=148467980905537&w=2

Easier visual parsing is indeed one of the primary reasons, but there's 
two other reasons as well:

2) code robustness 

For example:

        for (i = 0; i < 10; i++)
                if (foo)
                        bar(i);
                baz(i);

Is probably buggy code, although technically it's valid syntax and will compile 
just fine.

If all multi-line statements have curly braces then this type of bug cannot occur:

        for (i = 0; i < 10; i++) {
                if (foo)
                        bar(i);
                baz(i);
	}

3) style consistency

Nothing is worse than randomly inconsistent coding style, and in arch/x86/ and 
core kernel code using curly braces is certainly the dominant style:

  # multi-line C statements without braces:
  $ find arch/x86/ kernel mm -name "*.[ch]" | xargs awk '/for \(.*[^{]$/ { line1=$0; 
    f=1; next } f == 1 && /if \(.*[^{]$/ { f=0; line2=$0; i=1; next } i == 1 { i=0; 
    line3=$0; j=1; next } j == 1 && /^$/{j=0; print line1; print line2; print line3; 
    print; next} { f=0; i=0; j=0; }' |grep 'for (' |wc -l
  
  55

  # multi-line C statements with braces:
  $ find arch/x86 kernel mm -name "*.[ch]" | xargs awk '/for \(.*{$/ { line1=$0; f=1; 
    next } f == 1 && /if \(.*[^{]$/ { f=0; line2=$0; i=1; next } i == 1 { i=0; 
    line3=$0; j=1; next } j == 1 && /}/{j=0; print line1; print line2; print line3; 
    print } { f=0; i=0; j=0; }' |grep 'for (' |wc -l

  116

Thanks,

	Ingo
