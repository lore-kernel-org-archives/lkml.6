Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965093AbeEJNEV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:04:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965021AbeEJNET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:04:19 -0400
Date: Thu, 10 May 2018 10:04:13 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180510100413.754d1399@vento.lan>
In-Reply-To: <20180510122036.GD12217@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
        <20180510083838.GA21846@infradead.org>
        <20180510063805.1859b1aa@vento.lan>
        <20180510122036.GD12217@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 10 May 2018 14:20:36 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Thu, May 10, 2018 at 06:38:05AM -0300, Mauro Carvalho Chehab wrote:
> > Em Thu, 10 May 2018 01:38:38 -0700
> > Christoph Hellwig <hch@infradead.org> escreveu:
> >   
> > > >   * Use either while holding wait_queue_head::lock or when used for wakeups
> > > > - * with an extra smp_mb() like:
> > > > + * with an extra smp_mb() like::    
> > > 
> > > Independent of any philosophical discussion not allowing a setence to
> > > end with a single ':' is completely idiotic.  Please fix the tooling
> > > instead to allow it, as it is very important for being able to just
> > > write understandable comments.  
> 
> That is exactly my point; the whole rst stuff detracts from normal text.
> It makes both reading and writing harder than it needs to be.
> 
> > Patches are welcome, although I don't see any easy way to solve it.
> > 
> > In English, the common case is that a line with ends with a colon is
> > followed by a list. E. g.  
> 
> (google) Dictionary says:
> 
> "a punctuation mark (:) used to precede a list of items, a quotation, or
> an expansion or explanation."
> 
> An enumeration (list) is just one of many possible uses of the colon.

True, but the point is that whatever tool is used, it should be able
to uniquely unambiguously identify what it follows.

For example, it if is a list of items, it should keep parsing the
semantics markups inside it e. g. marking %FOO as a constant,
and bar() as a function, etc, following kernel-doc syntax. 

But, if it is a quote, a code example or an ascii artwork, it
should disable all such parsers, enclosing the result into a
literal block.

> > However, in this specific case, it is followed by an ascii artwork. 
> > The double colon is a notation that tells Sphinx to not parse the
> > lines at the next block, placing the contents of it inside a literal
> > block. It is used also when the next lines contain a code example,
> > in order to avoid parsing things like @, () and * inside the code 
> > block.
> > 
> > The kernel-doc tool might eventually have some parsing logic that
> > would replace something to a '::' before sending it to Sphinx.  
> 
> I think typically there will be an 'empty' line between the colon ending
> and the 'example/explanation'. This seems true for a number of comments
> I found in drm using the '::' nonsense.

Unfortunately, that's not true treewide. The presense/absense of a
blank line after a line ending with a colon doesn't indicate if the contents
below should be handled as a literal block or not[1].

[1] you can verify some use cases with:
	$ git grep -A2 "\*.*\s.*:$" -- $(git grep kernel-doc:: Documentation/|cut -d : -f 4-)

> Simple regexes don't do multi-line patterns, but maybe the kerneldoc
> thing can parse it differently.

kernel-doc is a regex-based parser (and not an AI engine). It will do only
what it is programmed for, based on a clear regex-based semantics.

Independently on how easy/hard it would be to use a multi-line pattern
for this, what it is required is a clear non-hint based pattern that
will provide a match for a part of the tag that should be escaped
from normal parsing rules. The m/::$/ is a clear rule.

Do you have a proposal for some other rule? If so, I can see how
feasible is to add it there.

Thanks,
Mauro
