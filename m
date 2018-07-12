Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0DDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B78D20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B78D20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbeGLNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:52:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeGLNwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEEA04022909;
        Thu, 12 Jul 2018 13:42:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4402A111AF0E;
        Thu, 12 Jul 2018 13:42:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Jul 2018 15:42:22 +0200 (CEST)
Date:   Thu, 12 Jul 2018 15:42:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 11/11] signal: Ignore all but multi-process signals
 that come in during fork.
Message-ID: <20180712134220.GA15075@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-11-ebiederm@xmission.com>
 <20180711141456.GA6636@redhat.com>
 <87h8l5g3qi.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8l5g3qi.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 13:42:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 13:42:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >> -	recalc_sigpending();
> >> -	if (signal_pending(current)) {
> >> +	if (read_seqcount_retry(&current->signal->multi_process_seq, seq) ||
> >> +	    fatal_signal_pending(current)) {
> >>  		retval = -ERESTARTNOINTR;
> >>  		goto bad_fork_cancel_cgroup;
> >
> > So once again, I think this is not right, see the discussion on
> > bugzilla.
>
> I am trying to dig through and understand your concerns.  I am having
> difficulty understanding your concerns.
>
> Do the previous patches look good to you?

Yes, yes, personally I like 1-10 after a quick glance. I'll try to read this
series carefully later, but I don't think I will find something really wrong.

> If I understand you correctly.  Your concern is that since we added the:
>
> 	recalc_sigpending();
>         if (signal_pending(current))
>         	return -ERESTARTNOINTR;
>
> Other (non-signal) code such as the freezer has come to depend upon that
> test.  Changing the test in the proposed way will allow the new child to
> escape the freezer, as it is not guaranteed the new child will be
> frozen.

Yes.

>
> It seems reasonable to look at other things that set TIF_SIGPENDING and
> see if any of them are broken by the fork changes.

Again, please look at do_signal_stop(). If it was the source of signal_pending(),
copy_process() should fail. Or we should update the new thread to participate in
group-stop, but then we need to set TIF_SIGPENDING, copy the relevant part of
current->jobctl, and increment ->group_stop_count at least.

> A practical (and fixable) problem with your patch was that you modified
> task->blocked which was then copied to the child.  So all children now
> would start with all signals being blocked.

What are you talking about, this pseudo-code has a lot more bugs ;)

OK, at least I certainly agree that this approach needs more changes in copy_process().

> > This also makes another difference in multi-threaded case, a signal with a handler
> > sent to a forking process will be re-targeted to another thread which can handle it;
> > with your patch this signal will be "blocked" until fork() finishes or until another
> > thread gets TIF_SIGPENDING. Not that I think this is that important,
> > but still.
>
> I would not object to wants_signal deciding that a task in the middle of
> copy_process does not want signals.

This is not enough, we need to signal all in-fork threads...

Oleg.

