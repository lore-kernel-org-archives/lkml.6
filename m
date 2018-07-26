Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B12083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B12083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbeGZQah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:30:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42861 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:30:37 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fihx9-0002DJ-0r; Thu, 26 Jul 2018 09:13:19 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fihx6-0004LP-N4; Thu, 26 Jul 2018 09:13:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-18-ebiederm@xmission.com>
        <20180726132050.GA32718@redhat.com>
Date:   Thu, 26 Jul 2018 10:13:12 -0500
In-Reply-To: <20180726132050.GA32718@redhat.com> (Oleg Nesterov's message of
        "Thu, 26 Jul 2018 15:20:50 +0200")
Message-ID: <87tvom58tz.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fihx6-0004LP-N4;;;mid=<87tvom58tz.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vq8n2SkROnH8GMyJYcQe3gHaVwE/Wdnc=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 18/20] signal: Add calculate_sigpending()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/23, Eric W. Biederman wrote:
>>
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1988,6 +1988,7 @@ static __latent_entropy struct task_struct *copy_process(
>>  					  &p->signal->thread_head);
>>  		}
>>  		attach_pid(p, PIDTYPE_PID);
>> +		calculate_sigpending(p);
>
> In theory this looks racy if !CLONE_SIGHAND, please see below
>
>> +void calculate_sigpending(struct task_struct *new)
>> +{
>> +	/* Have any signals or users of TIF_SIGPENDING been delayed
>> +	 * until after fork?
>> +	 */
>> +	bool pending = (new->jobctl & JOBCTL_PENDING_MASK) ||
>> +		PENDING(&new->pending, &new->blocked) ||
>> +		PENDING(&new->signal->shared_pending, &new->blocked) ||
>> +		freezing(new) || klp_patch_pending(new);
>
> note that we do not hold new->sighand->siglock, but this "new" task is already
> visible to find_task_by_vpid/etc; so a new signal can come right after
> this check,

Good point.  The localtion of the call to calculate_sigpending is wrong.

>> +	update_tsk_thread_flag(new, TIF_SIGPENDING, pending);
>
> and then update_tsk_thread_flag() can wrongly clear TIF_SIGPENDING.
>
> Easy to fix, but perhaps we can simply add recalc_sigpending() into
> schedule_tail() ? It already does more than just finish_task_switch/etc.
>
> This way we do not need the new helper (which btw can only be used by
> copy_process).

The problem I have with reusing recalc_sigpending is that it does not
set TIF_SIGPENDING if (freezing || klp_patch_pending).

There is obviously synergy between these two cases, I just have not
figured out how to take advantage of it yet.

> Note also that either way you can remove set_tsk_thread_flag(TIF_SIGPENDING)
> from ptrace_init_task().

Interesting.  Yes we can remove TIF_SIGPENDING from that case because
ptrace_init_task sets jobctl or queues a pending signal.  I like
that synergy.  I like not being able to miss setting TIF_SIGPENDING
during fork.

Eric

