Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeECWnE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:43:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35058 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeECWnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:43:03 -0400
Date: Thu, 3 May 2018 23:42:57 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, dsterba@suse.cz,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180503224257.GE30522@ZenIV.linux.org.uk>
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org>
 <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
 <20180426192444.GA4919@avx2>
 <20180501151319.33dcb1d48a8526ed521fae9c@linux-foundation.org>
 <85dc7f54-c17f-b49f-df4d-04a339b260d7@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85dc7f54-c17f-b49f-df4d-04a339b260d7@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 12:14:57AM +0200, Rasmus Villemoes wrote:

> FWIW, it's not just removing some identifiers from cpp's hash tables, it
> also reduces I/O: Due to our header mess, we have some cyclic includes,
> e.g mm.h -> memremap.h -> mm.h. While parsing mm.h, cpp sees the #define
> _LINUX_MM_H, then goes parsing memremap.h, but since it hasn't reached
> the end of mm.h yet (seeing that there's nothing but comments outside
> the #ifndef/#endif pair), it hasn't had a chance to set the internal
> flag for mm.h, so it goes slurping in mm.h again. Obviously, the
> definedness of _LINUX_MM_H at that point means it "only" has to parse
> those 87K for comments and matching up #ifs, #ifdefs,#endifs etc. With
> #pragma once, the flag gets set for mm.h immediately, so the #include
> from memremap.h is entirely ignored. This can easily be verified with
> strace. And mm.h is not the only header getting read twice.

Which gcc version it is?  Does it *really* read anything twice?  After all,
you are going to read (and tokenize) the rest of mm.h anyway, so if it
throws away the file it has read, only to reread it again, it's bloody
dumb.

Note that sequence of preprocessor tokens does not depend upon the ifdefs;
anything under #if 0 *is* tokenized all the same.  So it's not even that
"parsing" (tokenizing, actually) has to be repeated.
