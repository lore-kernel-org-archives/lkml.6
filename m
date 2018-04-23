Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbeDWVnu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:43:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeDWVnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:43:49 -0400
Date: Mon, 23 Apr 2018 14:43:48 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andres Freund <andres@anarazel.de>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Always report a writeback error once
Message-ID: <20180423214348.GH13383@bombadil.infradead.org>
References: <20180423204208.GG13383@bombadil.infradead.org>
 <20180423205730.34wvykqhefbkrtfw@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423205730.34wvykqhefbkrtfw@alap3.anarazel.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:57:30PM -0700, Andres Freund wrote:
> On 2018-04-23 13:42:08 -0700, Matthew Wilcox wrote:
> > @@ -119,19 +119,11 @@ EXPORT_SYMBOL(errseq_set);
> >  errseq_t errseq_sample(errseq_t *eseq)
> >  {
> 
> There's a comment above this:
>  *
>  * This function allows callers to sample an errseq_t value, marking it as
>  * "seen" if required.

Oh, good catch.  I'll fix that.  Thanks!

> I've never really looked at this code in any depth before, but won't
> this potentially lead to the same error being reported on multiple FDs?
> Imagine two fds (potentially in different processes) getting the 0
> returned by errseq_sample() because it's not ERRSEQ_SEEN. Afaict
> file_check_and_advance_wb_err() will return an error that's always
> unlike 0 in that case, and thus the error will returned on both fds?
> 
> I'm personally perfectly fine with that, but it's not necessarily what's
> described as desired in your email?.

That's what I was trying to say with this paragraph:

> > This patch restores that behaviour by reporting errors to file descriptors
> > which are opened after the error occurred, but before it was reported
> > to any file descriptor.

Maybe it was a little unclear?  I'd appreciate a suggestion on making
it clearer.

I think this behaviour is perfectly justifiable.  Writeback errors occur
asynchronously to open.  Userspace can't tell the difference between:

kernel: writeback
p1: open
p2: open
p1: fsync
p2: fsync

and

p1: open
p2: open
kernel: writeback
p1: fsync
p2: fsync

Since both p1 and p2 would get the writeback error in the second case,
they can both get the writeback error in the first place.

p2 can't rely on this, after all we could have the sequence:

p1: open
p1: fsync
p2: open
p2: fsync

and p2 will not see the error, but it wouldn't have seen the error
before the errseq_t infrastructure went in.  And maybe p1 handled the
error three weeks ago; we don't want p2 to see the error.
