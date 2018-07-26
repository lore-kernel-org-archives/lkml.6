Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30534C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A6820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A6820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeGZP7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:59:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38871 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbeGZP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:59:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fihT8-0006od-Jz; Thu, 26 Jul 2018 08:42:18 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fihT8-0007gP-17; Thu, 26 Jul 2018 08:42:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <20180724032419.20231-20-ebiederm@xmission.com>
        <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
        <874lgo5xdg.fsf@xmission.com>
        <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
        <87fu084cxj.fsf@xmission.com>
        <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
        <87a7qg4bb3.fsf_-_@xmission.com>
        <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
        <87pnzc2upf.fsf@xmission.com> <87k1pk2cj9.fsf_-_@xmission.com>
        <20180726134143.GB32718@redhat.com>
Date:   Thu, 26 Jul 2018 09:42:13 -0500
In-Reply-To: <20180726134143.GB32718@redhat.com> (Oleg Nesterov's message of
        "Thu, 26 Jul 2018 15:41:43 +0200")
Message-ID: <87pnza6ou2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fihT8-0007gP-17;;;mid=<87pnza6ou2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18F+m/dDyNdcr6xh1zYNeU1d2TldBrSJNU=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 20/20] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/24, Eric W. Biederman wrote:
>>
>> @@ -1979,6 +1983,8 @@ static __latent_entropy struct task_struct *copy_process(
>>  			attach_pid(p, PIDTYPE_TGID);
>>  			attach_pid(p, PIDTYPE_PGID);
>>  			attach_pid(p, PIDTYPE_SID);
>> +			p->signal->shared_pending.signal = delayed.signal;
>
> Again, in this case we do not hold p->sighand->siglock (unless CLONE_SIGHAND),
> so this should be done before list_add_tail/attach_pid above. Plus we need some
> sort of barrier.
>
> Or we can do
>
> 	if (!CLONE_SIGHAND)
> 		spin_lock_nested(child->siglock);
>
> at the start of "if (likely(p->pid))" block.

Good point.  We want to exclude races between new signals comming in and
gathering the information from the old queued signals.

I will take a look.

>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1123,6 +1123,15 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
>>  out_set:
>>  	signalfd_notify(t, sig);
>>  	sigaddset(&pending->signal, sig);
>> +
>> +	/* Let multiprocess signals appear after on-going forks */
>> +	if (type > PIDTYPE_TGID) {
>> +		struct multiprocess_signals *delayed;
>> +		hlist_for_each_entry(delayed, &t->signal->multiprocess, node) {
>> +			sigaddset(&delayed->signal, sig);
>
> This is not enough, I think...
>
> Suppose you send SIGSTOP and then SIGCONT to some process group. The 1st SIGSTOP
> will be queued correctly, but the 2nd SIGCONT won't flush the pending SIGSTOP, you
> need to modify prepare_signal() too.

Good point.  We can't have both SIGCONT and a stop signal (SIGSTOP or
SIGTSTP) enqueued at the same time.  And there is something in the
prepare_signal code about parent notifications as well.

I will look up the fine points of SIGCONT and SIGSTOP interaction
and see what we should be doing here.

Sigh.  I thought this was going to be as simple as the sequence counter
but this looks a tad more complicated.

Are the earlier patches looking ok to you?

Eric
