Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF520844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEF520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeGXTG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:06:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33863 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbeGXTG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:06:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fi1aC-0004qq-Vt; Tue, 24 Jul 2018 11:58:49 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fi1aC-0001XC-5K; Tue, 24 Jul 2018 11:58:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-20-ebiederm@xmission.com>
        <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
Date:   Tue, 24 Jul 2018 12:58:35 -0500
In-Reply-To: <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 24 Jul 2018 10:27:58 -0700")
Message-ID: <874lgo5xdg.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fi1aC-0001XC-5K;;;mid=<874lgo5xdg.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DUmslOieX6tURFBDmHOwEhv8ashzDt9k=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 20/20] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This is completely broken.
>
> On Mon, Jul 23, 2018 at 8:27 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 6c358846a8b8..6ee5822f0085 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1602,6 +1603,24 @@ static __latent_entropy struct task_struct *copy_process(
>>  {
>>         int retval;
>>         struct task_struct *p;
>> +       struct multiprocess_signals delayed;
>> +
>> +       /*
>> +        * Force any signals received before this point to be delivered
>> +        * before the fork happens.  Collect up signals sent to multiple
>> +        * processes that happen during the fork and delay them so that
>> +        * they appear to happen after the fork.
>> +        */
>> +       sigemptyset(&delayed.signal);
>> +       INIT_HLIST_NODE(&delayed.node);
>> +
>> +       spin_lock_irq(&current->sighand->siglock);
>> +       if (!(clone_flags & CLONE_THREAD))
>> +               hlist_add_head(&delayed.node, &current->signal->multiprocess);
>
> Here you add the entry to the multiprocess list.
>
>> +       recalc_sigpending();
>> +       spin_unlock_irq(&current->sighand->siglock);
>> +       if (signal_pending(current))
>> +               return ERR_PTR(restart_syscall());
>
> .. and here you return with the list entry still there, pointing to
> the stack that you now no longer use.
>
> The same is true of *all* the error cases, because the only point you
> remove it is for the success case:

Yes you are quite right.   Easy enough to fix, but it definitely needs
to be fixed.

I will respin.

Eric


>> @@ -1979,6 +1982,8 @@ static __latent_entropy struct task_struct *copy_process(
>>                         attach_pid(p, PIDTYPE_TGID);
>>                         attach_pid(p, PIDTYPE_PGID);
>>                         attach_pid(p, PIDTYPE_SID);
>> +                       p->signal->shared_pending.signal = delayed.signal;
>> +                       hlist_del(&delayed.node);
>
> So for all the error cases, you leave a dangling pointer to the
> current stack in that signal handler, and then return an error.
>
> Guaranteed stack and list corruption.
>
>                  Linus
