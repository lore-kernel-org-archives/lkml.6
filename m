Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B6520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B6520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeGXPzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388516AbeGXPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:55:08 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FA52064D;
        Tue, 24 Jul 2018 14:48:17 +0000 (UTC)
Date:   Tue, 24 Jul 2018 10:48:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Snild Dolkow <snild@sony.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH RESEND] kthread, tracing: Don't expose half-written comm
 when creating kthreads
Message-ID: <20180724104815.05d2ac68@gandalf.local.home>
In-Reply-To: <72573a9f-694e-fc4b-cfd1-d9cde504a480@sony.com>
References: <20180723134210.54013-1-snild@sony.com>
        <20180723095550.08203a24@gandalf.local.home>
        <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
        <20180723113741.66df3b50@gandalf.local.home>
        <7749ed7d-50d5-4b95-fbd2-b056a1fff957@sony.com>
        <20180723124154.14ef0679@gandalf.local.home>
        <72573a9f-694e-fc4b-cfd1-d9cde504a480@sony.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 10:17:37 +0200
Snild Dolkow <snild@sony.com> wrote:

> On 07/23/2018 06:41 PM, Steven Rostedt wrote:
> > On Mon, 23 Jul 2018 17:49:36 +0200
> > Snild Dolkow <snild@sony.com> wrote:  
> >> Any issues with the commit message? Reading it back again now, it doesn't
> >> seem quite as clear as when I wrote it.  
> > 
> > Yeah, I think it does need some updates:
> >   
> >> There was a window for racing when task->comm was being written. The  
> > 
> > It would be nice to explain this race window in more detail.
> >   
> I hope the following is more clear:
> 
> kthread, tracing: Don't expose half-written comm when creating kthreads
> 
> There is a window for racing when printing directly to task->comm,
> allowing other threads to see a non-terminated string. The vsnprintf
> function fills the buffer, counts the truncated chars, then finally
> writes the \0 at the end.
> 
> 	creator                         other
> 	vsnprintf:
> 	  fill (not terminated)
> 	  count the rest                read/use comm

I think it would be better to state what was reading the comm. Like

					trace_sched_waking(p)
					  memcpy(comm, p->comm, TASK_COMM_LEN)

But the rest looks fine.

-- Steve


> 	  write \0
> 
> The consequences depend on how 'other' uses the string. In our case,
> it was copied into the tracing system's saved cmdlines, a buffer of
> adjacent TASK_COMM_LEN-byte buffers (note the 'n' where 0 should be):
> 
> 	crash-arm64> x/1024s savedcmd->saved_cmdlines | grep 'evenk'
> 	0xffffffd5b3818640:     "irq/497-pwr_evenkworker/u16:12"
> 
> ...and a strcpy out of there would cause stack corruption:
> 
> 	[224761.522292] Kernel panic - not syncing: stack-protector:
> 	    Kernel stack is corrupted in: ffffff9bf9783c78
> 
> 	crash-arm64> kbt | grep 'comm\|trace_print_context'
> 	#6  0xffffff9bf9783c78 in trace_print_context+0x18c(+396)
> 	      comm (char [16]) =  "irq/497-pwr_even"
> 
> 	crash-arm64> rd 0xffffffd4d0e17d14 8
> 	ffffffd4d0e17d14:  2f71726900000000 5f7277702d373934   ....irq/497-pwr_
> 	ffffffd4d0e17d24:  726f776b6e657665 3a3631752f72656b   evenkworker/u16:
> 	ffffffd4d0e17d34:  f9780248ff003231 cede60e0ffffff9b   12..H.x......`..
> 	ffffffd4d0e17d44:  cede60c8ffffffd4 00000fffffffffd4   .....`..........
> 
> The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
> likely needed because of this same bug.
> 
> Solved by vsnprintf:ing to a local buffer, then using set_task_comm().
> This way, there won't be a window where comm is not terminated.
> 
> 
> //Snild

