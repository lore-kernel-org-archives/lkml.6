Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEDC6j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:58:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40566 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEDC6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:58:39 -0400
Date: Fri, 4 May 2018 03:58:32 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, dsterba@suse.cz,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180504025832.GF30522@ZenIV.linux.org.uk>
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
 <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
 <20180426192444.GA4919@avx2>
 <20180501151319.33dcb1d48a8526ed521fae9c@linux-foundation.org>
 <85dc7f54-c17f-b49f-df4d-04a339b260d7@rasmusvillemoes.dk>
 <20180503224257.GE30522@ZenIV.linux.org.uk>
 <94db646a-4fd8-9ce3-2111-b2e4852ad324@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94db646a-4fd8-9ce3-2111-b2e4852ad324@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:23:12AM +0200, Rasmus Villemoes wrote:
> > Note that sequence of preprocessor tokens does not depend upon the ifdefs;
> > anything under #if 0 *is* tokenized all the same.  So it's not even that
> > "parsing" (tokenizing, actually) has to be repeated.
> 
> Are you sure about that? Maybe formally it has to (if the phases are
> done strictly sequentially), but can't it go into some fast-forward mode
> under #if 0 (or #ifndef $some-defined-macro) where it only looks for
> string and char literals, comments and "control-flow" directives?

What else do you expect preprocessor tokenizer to do?  It must take care
of line continuations, it must recognize and skip whitespace (including
comments) and if it recognizes string and character literals, what else
is left to do?  pp-numbers?  Sure - that'd be
	[.]?[0-9]([0-9a-zA-Z_.]|[epEP][-+])*
Horribly hard to recognize, that...  Identifiers are no harder, obviously
(especially since keywords are _not_ something special at that level)
and punctuators are also easily taken care of.

Preprocessor tokens are nowhere near as much work as C ones.  And you
can't do mapping to C ones before the preprocessing is done - if nothing
else, quoting and token concatenation needs to happen first.
