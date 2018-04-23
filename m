Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeDWVuh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:50:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48493 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932318AbeDWVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:50:34 -0400
X-ME-Sender: <xms:KVXeWvVuqcU4eyISkqwdFPHKM7e7wq9vKN305yJ6jrsBB3OFZdYDEQ>
Date: Mon, 23 Apr 2018 14:50:32 -0700
From: Andres Freund <andres@anarazel.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Always report a writeback error once
Message-ID: <20180423215032.qfk3ktoadf4tofrq@alap3.anarazel.de>
References: <20180423204208.GG13383@bombadil.infradead.org>
 <20180423205730.34wvykqhefbkrtfw@alap3.anarazel.de>
 <20180423214348.GH13383@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423214348.GH13383@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-23 14:43:48 -0700, Matthew Wilcox wrote:
> On Mon, Apr 23, 2018 at 01:57:30PM -0700, Andres Freund wrote:
> > I've never really looked at this code in any depth before, but won't
> > this potentially lead to the same error being reported on multiple FDs?
> > Imagine two fds (potentially in different processes) getting the 0
> > returned by errseq_sample() because it's not ERRSEQ_SEEN. Afaict
> > file_check_and_advance_wb_err() will return an error that's always
> > unlike 0 in that case, and thus the error will returned on both fds?
> > 
> > I'm personally perfectly fine with that, but it's not necessarily what's
> > described as desired in your email?.
> 
> That's what I was trying to say with this paragraph:
> 
> > > This patch restores that behaviour by reporting errors to file descriptors
> > > which are opened after the error occurred, but before it was reported
> > > to any file descriptor.
> 
> Maybe it was a little unclear?  I'd appreciate a suggestion on making
> it clearer.

I think I was thinking of the following paragraph from your commit
message:

> Before errseq_t, a writeback error would be reported exactly once (as
> long as the inode remained in memory), so Postgres could open a file,
> call fsync() and find out whether there had been a writeback error on
> that file from another process.

Note the "exactly once", making "that behaviour" in the following
paragraph potentially refer to exactly once:

> This patch restores that behaviour by reporting errors to file descriptors
> which are opened after the error occurred, but before it was reported
> to any file descriptor.

Just adding a sentence here saying something like "This means that the
error might be reported to more fds than before." or such would address
that potential ambiguity?

> I think this behaviour is perfectly justifiable.

I agree.

Greetings,

Andres Freund
