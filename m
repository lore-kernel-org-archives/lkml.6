Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162770AbeBPSDz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161111AbeBPSDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:03:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D15B21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 13:03:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] extable: Make init_kernel_text() global
Message-ID: <20180216130350.73466435@gandalf.local.home>
In-Reply-To: <20180216175744.2towvw7lja7dpkn7@treble>
References: <cover.1518798288.git.jpoimboe@redhat.com>
        <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
        <cabcf423-2214-f175-a3fc-a9756eabd247@akamai.com>
        <20180216175744.2towvw7lja7dpkn7@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 11:57:44 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, Feb 16, 2018 at 11:55:54AM -0500, Jason Baron wrote:
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
> > 
> > Seems like this wants to use init_kernel_text() but i see its marked
> > 'static', perhaps it can be moved to a header?  
> 
> How about this patch on top?

Yes please.

> 
> ---------
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] extable: Make init_kernel_text() global
> 
> Convert init_kernel_text() to a global function and use it in a few
> places instead of manually comparing _sinittext and _einittext.
> 
> Note that kallsyms.h has a very similar function called
> is_kernel_inittext(), but its end check is inclusive.  I'm not sure
> whether that's intentional behavior, so I didn't touch it.
> 
> Suggested-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
