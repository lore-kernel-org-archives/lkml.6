Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46850C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A420651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfBVOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:43:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfBVOnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:43:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3B3FAEDF;
        Fri, 22 Feb 2019 14:43:02 +0000 (UTC)
Date:   Fri, 22 Feb 2019 15:43:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 10/25] printk: redirect emit/store to new
 ringbuffer
Message-ID: <20190222144302.44zl37p75qgaixf3@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-11-john.ogness@linutronix.de>
 <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz>
 <8736oijgpf.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736oijgpf.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-02-20 22:25:00, John Ogness wrote:
> On 2019-02-20, Petr Mladek <pmladek@suse.com> wrote:
> >> vprintk_emit and vprintk_store are the main functions that all printk
> >> variants eventually go through. Change these to store the message in
> >> the new printk ring buffer that the printk kthread is reading.
> >
> > We need to switch the two buffers in a single commit
> > without disabling important functionality.
> >
> > By other words, we need to change vprintk_emit(), vprintk_store(),
> > console_unlock(), syslog(), devkmsg(), and syslog in one patch.
> 
> Agreed. But for the review process I expect it makes things much easier
> to change them one at a time. Patch-squashing is not a problem once all
> the individuals have been ack'd.

Good question. I would personally prefer to keep it in a single patch
even for review.

It would help me to see what the different readers have in common
and what can get optimized. Anyway, we should prepare the patch
a way so that it can get understand also by git history readers.


> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 5a5a685bb128..b6a6f1002741 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -584,54 +500,36 @@ static int log_store(int facility, int level,
> >>  		     const char *text, u16 text_len)
> >
> >>  	memcpy(log_dict(msg), dict, dict_len);
> >>  	msg->dict_len = dict_len;
> >>  	msg->facility = facility;
> >>  	msg->level = level & 7;
> >>  	msg->flags = flags & 0x1f;
> >
> > The existing struct printk_log is stored into the data field
> > of struct prb_entry. It is because printk_ring_buffer is supposed
> > to be a generic ring buffer.
> 
> Yes.
> 
> > It makes the code more complicated. Also it needs more space for
> > the size and seq items from struct prb_entry.
> >
> > printk() is already very complicated code. We should not make
> > it unnecessarily worse.
> 
> In my opinion it makes things considerably easier. My experience with
> printk-code is that it is so complicated because it is mixing
> printk-features with ring buffer handling code. By providing a strict
> API (and hiding the details) of the ring buffer, the implementation of
> the printk-features became pretty straight forward.

It sounds reasonable. Well, the separation is not completely clear.
We have tree layers:

   + struct prb_entry: ring buffer metadata
   + struct printk_log: message metadata
   + text, dict: message strings

Where sequence number is part of prb_entry but it is too important
part of the printk logic.

Also it does not make sense to read text and dict when we just
calculate the space taken by the messages.

That said, I agree that printk code is complicated and we should
do better. This patchset goes in the right direction.

I personally hate the following things:

  + There are too many global values. Many of them are related,
    e.g. first_idx, next_idx, first_seq, next_seq. They should
    be in some structures.

  + Too many variables are passed by parameters. They should be
    in some structures as well.

  + The name of struct printk_log is really confusing. It
    should have been printk_msg or so.

  + Continuous lines buffer makes the buffer-related code much
    more complicated.

  + Especially the console-related code is full of hacks.

printk code was not really maintained most of the history.
Random people just fixed/extended the code for their needs.

> > Please, are there any candidates or plans to reuse the new ring
> > buffer implementation?
> 
> As you pointed out below, this patch already uses the ring buffer
> implementation for a totally different purpose: NMI safe dynamic memory
> allocation.

I am not sure that this 2nd usage is worth it, see below.

> >>  int vprintk_store(int facility, int level,
> >>  		  const char *dict, size_t dictlen,
> >>  		  const char *fmt, va_list args)
> >>  {
> >> -	static char textbuf[LOG_LINE_MAX];
> >> -	char *text = textbuf;
> >> -	size_t text_len;
> >> +	return vprintk_emit(facility, level, dict, dictlen, fmt, args);
> >> +}
> >> +
> >> +/* ring buffer used as memory allocator for temporary sprint buffers */
> >> +DECLARE_STATIC_PRINTKRB(sprint_rb,
> >> +			ilog2(PRINTK_RECORD_MAX + sizeof(struct prb_entry) +
> >> +			      sizeof(long)) + 2, &printk_cpulock);
> >> +
> >> +asmlinkage int vprintk_emit(int facility, int level,
> >> +			    const char *dict, size_t dictlen,
> >> +			    const char *fmt, va_list args)
> >
> > [...]
> >
> >> +	rbuf = prb_reserve(&h, &sprint_rb, PRINTK_SPRINT_MAX);
> >
> > The second ring buffer for temporary buffers is really interesting
> > idea.
> >
> > Well, it brings some questions. For example, how many users might
> > need a reservation in parallel. Or if the nested use might cause
> > some problems when we decide to use printk-specific ring buffer
> > implementation. I still have to think about it.
> 
> Keep in mind that it is only used by the writers, which have the
> prb_cpulock. Typically there would only be 2 max users: a non-NMI writer
> that was interrupted during the reserve/commit window and the
> interrupting NMI that does printk. The only exception would be if the
> printk-code code itself triggers a BUG_ON or WARN_ON within the
> reserve/commit window. Then you will have an additional user per
> recursion level.

I am not sure it is worth to call the ring buffer machinery just
to handle 2-3 buffers.

Well, it might be just my mental block. We need to be really
careful to avoid infinite recursion when storing messages
into the log buffer. The nested reserve/commit calls provoke
my brain to spin around. It is possible that I would love
this idea once my brain stops spinning ;-)

Best Regards,
Petr
