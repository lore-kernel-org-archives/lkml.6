Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeCLSiY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCLSiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:38:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42832204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 12 Mar 2018 14:38:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180312143820.5da7cd6f@vmware.local.home>
In-Reply-To: <20180312124246.GC23111@krava>
References: <20180310023442.791997138@goodmis.org>
        <20180310023907.798690563@goodmis.org>
        <20180312124246.GC23111@krava>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018 13:42:46 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Fri, Mar 09, 2018 at 09:34:45PM -0500, Steven Rostedt wrote:
> 
> SNIP
> 
> >  
> > -/* If not of not match is equal to not of not, then it is a match */
> > +/*
> > + * Without going into a formal proof, this explains the method that is used in
> > + * parsing the logical expressions.
> > + *
> > + * For example, if we have: "a && !(!b || (c && g)) || d || e && !f"
> > + * The first pass will convert it into the following program:
> > + *
> > + * n1: r=a;       l1: if (!r) goto l4;
> > + * n2: r=b;       l2: if (!r) goto l4;  
> 
> got stuck in here.. should that be 'goto l5' ?

Nope, this is correct. In fact, my user space implementation of the
code is what generated this output.

 !(!b || (c && g)) is the same as (b && (!c || !g)), so we can rewrite
 the above as:

 a && b && (!c || !g) || d || e && !f

Which makes it more obvious why it is goto l4.

And since we have:

 n1: r=a;	l1: if (!r) goto l4;
 n2: r=b;	l2: if (!r) goto l4;
 n3: r=c; r=!r;	l3: if (r) goto l4;
 n4: r=g; r=!r;	l4: if (r) goto l5;
 n5; r=d;	l5: if (r) goto T;

If a is true, if (!r) is false so we continue to n2.
If b is false, then if (!r) is true, so we take the branch. Let's see
what that does:

 l4: if (r) goto l5;

But since we jumped because r is false, then this if statement is
guaranteed to be false, and we continue to n5. Then we need to test d.

 a && b && ... || d

You can see how that is correct. If a is true and then be is false,
then we ignore the rest of the && statement and jump to testing the
other side of || which is d.

-- Steve

> 
> jirka
> 
> > + * n3: r=c; r=!r; l3: if (r) goto l4;
> > + * n4: r=g; r=!r; l4: if (r) goto l5;
> > + * n5: r=d;       l5: if (r) goto T
> > + * n6: r=e;       l6: if (!r) goto l7;
> > + * n7: r=f; r=!r; l7: if (!r) goto F
> > + * T: return TRUE
> > + * F: return FALSE  
> 
> jirka
