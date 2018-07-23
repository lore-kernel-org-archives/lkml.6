Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD58ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3894820779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3894820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbeGWRoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388368AbeGWRoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:44:00 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0745020779;
        Mon, 23 Jul 2018 16:41:55 +0000 (UTC)
Date:   Mon, 23 Jul 2018 12:41:54 -0400
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
Message-ID: <20180723124154.14ef0679@gandalf.local.home>
In-Reply-To: <7749ed7d-50d5-4b95-fbd2-b056a1fff957@sony.com>
References: <20180723134210.54013-1-snild@sony.com>
        <20180723095550.08203a24@gandalf.local.home>
        <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
        <20180723113741.66df3b50@gandalf.local.home>
        <7749ed7d-50d5-4b95-fbd2-b056a1fff957@sony.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 17:49:36 +0200
Snild Dolkow <snild@sony.com> wrote:

> On 07/23/2018 05:37 PM, Steven Rostedt wrote:

> Will add:
> 
> 		/*
> 		 * task is already visible to other tasks, so updating
> 		 * COMM must be protected.
> 		 */

Thanks.

> 
> Any issues with the commit message? Reading it back again now, it doesn't
> seem quite as clear as when I wrote it.

Yeah, I think it does need some updates:

> There was a window for racing when task->comm was being written. The

It would be nice to explain this race window in more detail.

> vsnprintf function writes 16 bytes, then counts the rest, then null
> terminates. In the meantime, other threads could see the non-terminated
> comm value. In our case, it got into the trace system's saved cmdlines
> and could cause stack corruption when strcpy'd out of there.

Perhaps add in the change log something about the fact that the
vsprintf() is performed on the COMM when the task is visible to other
tasks, and that could cause problems if other tasks read the COMM (like
in tracing) without updating it properly with set_task_comm().

-- Steve


> 
> The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
> likely needed because of this bug.
> 
> Solved by vsnprintf:ing to a local buffer, then using set_task_comm().
