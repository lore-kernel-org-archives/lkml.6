Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeBQNkh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 08:40:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750975AbeBQNkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 08:40:36 -0500
Date: Sat, 17 Feb 2018 07:40:35 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/2] jump_label: Explicitly disable jump labels in
 __init code
Message-ID: <20180217134035.67jzcc5rwtyyufix@treble>
References: <cover.1518798288.git.jpoimboe@redhat.com>
 <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
 <20180217103848.yiutigxpukxfbtze@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180217103848.yiutigxpukxfbtze@gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 11:38:48AM +0100, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > +/* Disable any jump label entries in __init code */
> > +void __init jump_label_invalidate_init(void)
> > +{
> > +	struct jump_entry *iter_start = __start___jump_table;
> > +	struct jump_entry *iter_stop = __stop___jump_table;
> > +	struct jump_entry *iter;
> > +
> > +	for (iter = iter_start; iter < iter_stop; iter++)
> > +		if (iter->code >= (unsigned long)_sinittext &&
> > +		    iter->code < (unsigned long)_einittext)
> > +			iter->code = 0;
> > +}
> > +
> > +/* Disable any jump label entries in module init code */
> >  static void jump_label_invalidate_module_init(struct module *mod)
> >  {
> >  	struct jump_entry *iter_start = mod->jump_entries;
> >  	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
> >  	struct jump_entry *iter;
> >  
> > -	for (iter = iter_start; iter < iter_stop; iter++) {
> > +	for (iter = iter_start; iter < iter_stop; iter++)
> >  		if (within_module_init(iter->code, mod))
> >  			iter->code = 0;
> > -	}
> 
> Why did you remove the curly braces? They are canonical kernel style for 
> multi-line statements.
> 
> The new jump_label_invalidate_init() function has that problem too.

I'd say the jury is still out:

Without braces:

$ find . -name "*.[ch]" | xargs awk '/for \(.*[^{]$/ { line1=$0; f=1; next } f == 1 && /if \(.*[^{]$/ { f=0; line2=$0; i=1; next } i == 1 { i=0; line3=$0; j=1; next } j == 1 && /^$/ {j=0; print line1; print line2; print line3; print; next} { f=0; i=0; j=0; }' |grep 'for (' |wc -l
1389

With braces:

$ find . -name "*.[ch]" | xargs awk '/for \(.*{$/ { line1=$0; f=1; next } f == 1 && /if \(.*[^{]$/ { f=0; line2=$0; i=1; next } i == 1 { i=0; line3=$0; j=1; next } j == 1 && /}/ {j=0; print line1; print line2; print line3; print } { f=0; i=0; j=0; }' |grep 'for (' |wc -l
2292

And I see no mention of it in coding-style.rst.

Personally I prefer the more compact version, but I have no problem
changing it.

-- 
Josh
