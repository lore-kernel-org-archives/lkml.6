Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357BA21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357BA21EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHIU2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:28:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52428 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeHIU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:28:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnpGm-0004WO-Nv; Thu, 09 Aug 2018 12:02:44 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnpGX-0005zh-4h; Thu, 09 Aug 2018 12:02:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <wen.yang99@zte.com.cn>
Cc:     <oleg@redhat.com>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <ma.jiang@zte.com.cn>,
        <torvalds@linux-foundation.org>, <cheng.shengyu@zte.com.cn>,
        <zhong.weidong@zte.com.cn>
References: <201808091624383651898@zte.com.cn>
Date:   Thu, 09 Aug 2018 13:02:14 -0500
In-Reply-To: <201808091624383651898@zte.com.cn> (wen's message of "Thu, 9 Aug
        2018 16:24:38 +0800 (CST)")
Message-ID: <87lg9fv2op.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fnpGX-0005zh-4h;;;mid=<87lg9fv2op.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+eS/74+6UjTrdhO3eu+Ie1fMxqSTOt9kQ=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v5 3/6] signal: Add calculate_sigpending()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<wen.yang99@zte.com.cn> writes:

> EricW.Biederman <ebiederm@xmission.com> wrote:
>> Add a function calculate_sigpending to test to see if any signals are
>> pending for a new task immediately following fork. Signals have to
>> happen either before or after fork. Today our practice is to push
>> all of the signals to before the fork, but that has the downside that
>> frequent or periodic signals can make fork take much much longer than
>> normal or prevent fork from completing entirely.
>> 
>
>> + calculate_sigpending();
>> }
>> /*
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index dddbea558455..1e06f1eba363 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -172,6 +172,17 @@ void recalc_sigpending(void)
>> }
>> +void calculate_sigpending(void)
>> +{
>> + /* Have any signals or users of TIF_SIGPENDING been delayed
>> + * until after fork?
>> + */
>> + spin_lock_irq(&current->sighand->siglock);
>> + set_tsk_thread_flag(current, TIF_SIGPENDING);
>> + recalc_sigpending();
>> + spin_unlock_irq(&current->sighand->siglock);
>> +}
>> +
>
> The new function calculate_sigpending is similar to  recalc_sigpending,
> but recalc_sigpending has no spin_lock_irq(&current->sighand->siglock) in it.
> This gives recalc_sigpending more flexibility, 
> we may use spin_lock_irq or spin_lock_irqsave before recalc_sigpending .
> eg: 
>
> static int autofs4_write(struct autofs_sb_info *sbi,
>              struct file *file, const void *addr, int bytes)
> {
>   ...
>         spin_lock_irqsave(&current->sighand->siglock, flags);
>         sigdelset(&current->pending.signal, SIGPIPE);
>         recalc_sigpending();
>         spin_unlock_irqrestore(&current->sighand->siglock, flags);
>   ... 
> }
>
> or:
> void kernel_sigaction(int sig, __sighandler_t action)
> {
>     spin_lock_irq(&current->sighand->siglock);
> ...
>         recalc_sigpending();
> ...   
>     spin_unlock_irq(&current->sighand->siglock);
> }
>
>
> But calculate_sigpending is currently hardwired to call spin_lock_irq.

calculate_sigpending really only exists to keep the code comprehensible.

It is only ever expected to be called in exactly one place so the lack
of flexibility should not be a problem.  Further the use of irqsave
is discouraged unless it is necessary.

The irqsave in autofs_write actually looks like a misfeature.  We take
a mutex a few lines earlier, so we know that irqs are enabled.  Saving
and restoring them is uncessary work.  Further unless I am missing
something that code path should be calling kernel_dequeue_signal, to
ensure that any siginfo associated with that SIGPIPE gets dequeued.

Eric

