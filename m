Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F44AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205C423FAD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205C423FAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeFVJqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:46:46 -0400
Received: from verein.lst.de ([213.95.11.211]:55611 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbeFVJqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:46:44 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B806168AA6; Fri, 22 Jun 2018 11:56:08 +0200 (CEST)
Date:   Fri, 22 Jun 2018 11:56:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180622095608.GA12263@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:25:45PM +0900, Linus Torvalds wrote:
> What was the alleged advantage of the new poll methods again? Because
> it sure isn't obvious - not from the numbers, and not from the commit
> messages.

The primary goal is that we can implement a race-free aio poll,
the primary benefit is that we can get rid of the currently racy
and bug prone way we do in-kernel poll-like calls for things like
eventfd.  The first is clearly is in 4.18-rc and provides massive
performance advantanges if used, the second is not there yet,
more on that below.

> I was assuming there  was a good reason for it, but looking closer I
> see absolutely nothing but negatives. The argument that keyed wake-ups
> somehow make multiple wake-queues irrelevant doesn't hold water when
> the code is more complex and apparently slower. It's not like anybody
> ever *had* to use multiple wait-queues, but the old code was both
> simpler and cleaner and *allowed* you to use multiple queues if you
> wanted to.

It wasn't cleaner at all if you aren't poll or select, and even
for those it isn't exactly clean, see the whole mess around ->qproc.

> The disadvantages are obvious: every poll event now causes *two*
> indirect branches to the low-level filesystem or driver - one to get
> he poll head, and one to get the mask. Add to that all the new "do we
> have the new-style or old sane poll interface" tests, and poll is
> obviously more complicated.

It already caused two, and now we have three thanks to ->qproc.  One
of the advantages of the new code is that we can eventually get rid
of ->qproc once all users of a non-default qproc are switched away
from vfs_poll.  Which requires a little more work, but I have the
patches for that to be posted soon.

> If we could get the poll head by just having a direct pointer in the
> 'struct file', maybe that would be one thing. As it is, this all
> literally just adds overhead for no obvious reason. It replaced one
> simple direct call with two dependent but separate ones.

People are doing weird things with their poll heads, so we can't do
that unconditionally.  We could however offer a waitqueue pointer
in struct file and most users would be very happy with that.

In the meantime below is an ugly patch that removes the _qproc
indirect for ->poll only (similar patch is possible for select
assuming the code uses select).  And for next merge window I plan
to kill it off entirely.

How can we get this thrown into the will it scale run?

---
From 50ca47fdcfec0a1af56aac6db8a168bb678308a5 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 22 Jun 2018 11:36:26 +0200
Subject: fs: optimize away ->_qproc indirection for poll_mask based polling

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/select.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index bc3cc0f98896..54406e0ad23e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -845,7 +845,25 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 	/* userland u16 ->events contains POLL... bitmap */
 	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
 	pwait->_key = filter | busy_flag;
-	mask = vfs_poll(f.file, pwait);
+	if (f.file->f_op->poll) {
+		mask = f.file->f_op->poll(f.file, pwait);
+	} else if (file_has_poll_mask(f.file)) {
+		struct wait_queue_head *head;
+
+		head = f.file->f_op->get_poll_head(f.file, pwait->_key);
+		if (!head) {
+			mask = DEFAULT_POLLMASK;
+		} else if (IS_ERR(head)) {
+			mask = EPOLLERR;
+		} else {
+			if (pwait->_qproc)
+				__pollwait(f.file, head, pwait);
+			mask = f.file->f_op->poll_mask(f.file, pwait->_key);
+		}
+	} else {
+		mask = DEFAULT_POLLMASK;
+	}
+
 	if (mask & busy_flag)
 		*can_busy_poll = true;
 	mask &= filter;		/* Mask out unneeded events. */
-- 
2.17.1

