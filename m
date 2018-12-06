Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3124BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49E921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49E921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLFTRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:17:41 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35563 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:17:41 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUz9W-0004kz-5K; Thu, 06 Dec 2018 12:17:38 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUz9V-0002Jc-BY; Thu, 06 Dec 2018 12:17:37 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20181206121858.12215-1-christian@brauner.io>
        <87sgzahf7k.fsf@xmission.com>
        <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
Date:   Thu, 06 Dec 2018 13:17:24 -0600
In-Reply-To: <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io> (Christian
        Brauner's message of "Fri, 07 Dec 2018 06:14:34 +1300")
Message-ID: <875zw6bh2z.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gUz9V-0002Jc-BY;;;mid=<875zw6bh2z.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188A9TKyzRFrtIa1MCJvlVKJVm3UcuiMcU=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On December 7, 2018 4:01:19 AM GMT+13:00, ebiederm@xmission.com wrote:
>>Christian Brauner <christian@brauner.io> writes:
>>
>>> The kill() syscall operates on process identifiers (pid). After a
>>process
>>> has exited its pid can be reused by another process. If a caller
>>sends a
>>> signal to a reused pid it will end up signaling the wrong process.
>>This
>>> issue has often surfaced and there has been a push [1] to address
>>this
>>> problem.
>>>
>>> This patch uses file descriptors (fd) from proc/<pid> as stable
>>handles on
>>> struct pid. Even if a pid is recycled the handle will not change. The
>>fd
>>> can be used to send signals to the process it refers to.
>>> Thus, the new syscall taskfd_send_signal() is introduced to solve
>>this
>>> problem. Instead of pids it operates on process fds (taskfd).
>>
>>I am not yet thrilled with the taskfd naming.
>
> Userspace cares about what does this thing operate on?
> It operates on processes and threads.
> The most common term people use is "task".
> I literally "polled" ten non-kernel people for that purpose and asked:
> "What term would you use to refer to a process and a thread?"
> Turns out it is task. So if find this pretty apt.
> Additionally, the proc manpage uses task in the exact same way (also see the commit message).
> If you can get behind that name even if feeling it's not optimal it would be great.

Once I understand why threads and not process groups.  I don't see that
logic yet.

>>Is there any plan to support sesssions and process groups?
>
> I don't see the necessity.
> As I said in previous mails:
> we can emulate all interesting signal syscalls with this one.

I don't know what you mean by all of the interesting signal system
calls.  I do know you can not replicate kill(2).

Sending signals to a process group the "kill(-pgrp)" case with kill
sends the signals to an atomic snapshot of processes.  If the signal
is SIGKILL then it is guaranteed that then entire process group is
killed with no survivors.

> We succeeded in doing that.

I am not certain you have.

> No need to get more fancy.
> There's currently no obvious need for more features.
> Features should be implemented when someone actually needs them.

That is fair.  I don't understand what you are doing with sending
signals to a thread.  That seems like one of the least useful
corner cases of sending signals.

Eric
