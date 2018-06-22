Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753D2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31572246E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31572246E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933991AbeFVRqT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:46:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41839 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933838AbeFVRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:46:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fWQ8P-00011X-U7; Fri, 22 Jun 2018 11:46:09 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fWQ8O-0006yw-RO; Fri, 22 Jun 2018 11:46:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
        <20180420120605.1612248-2-arnd@arndb.de>
        <20180621154915.GA31947@gmail.com>
        <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
        <20180621161121.GB7222@gmail.com>
        <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
        <20180622021636.GA11266@gmail.com>
Date:   Fri, 22 Jun 2018 12:45:50 -0500
In-Reply-To: <20180622021636.GA11266@gmail.com> (Ingo Molnar's message of
        "Fri, 22 Jun 2018 04:16:36 +0200")
Message-ID: <87a7rm3eb5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fWQ8O-0006yw-RO;;;mid=<87a7rm3eb5.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18NyDJtD3hlt8ugYxsIDxghFxemtJzVMNA=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Arnd Bergmann <arnd@arndb.de> wrote:
>
>> However, the other question that has to be asked then is whether
>> there is anything wrong with wait4()/waitid() and getrusuage() that
>> we want to change beyond the time value passing. We have
>> answered a similar question with 'yes' for stat(), which has led
>> to the introduction of statx(),
>
> So we are thinking about adding wait5() in essence, right?

> One thing we might want to look into whether the wait4() and waitid() ABIs could 
> be 'merged', by making wait4() essentially a natural special case of
> waitid().

Essentially waitid(2) not waitid(3) has already seen this merger.
In that there is nothing to wait for that you can not already
expression with waitid.  status vs siginfo is a little different
but the information is encoded in both.

And waitid(2) optionally returns a struct rusage.

> This would mean that the only new system call we'd have to add is waitid2() in 
> essence, which would solve both the rusage layout problem and would offer a 
> unified ABI.
>
> If that makes sense (it might not!!), then I'd also modernize waitid2() by making 
> it attribute structure based, have a length field and make the ABI extensible from 
> now on going forward without having to introduce a new syscall variant every time 
> we come up with something new...

The only part where something is not parameterized in waitid is with the
return of rusage.

What to wait for takes an explicit type parameter.
What is being returned in siginfo returns an si_code to describe how
to decode it.

If it weren't for the zombie being gone after waitid returns I don't
think it would make any sense to combine getrusage and waitid together
at all.

> I.e. how the perf syscall does ABI extensions: we've had dozens of ABI extensions, 
> some of them pretty complex, and not a single time did we have to modify glibc and 
> tooling was able to adapt quickly yet in a both backwards and forwards compatible 
> fashion.
>
> Another, simpler example is the new sys_sched_setattr() syscall, that too is using 
> the perf_copy_attr() ABI method, via sched_copy_attr(). (With a minor 
> compatibility quirk of SCHED_ATTR_SIZE_VER0 that a new wait ABI wouldn't have to 
> do - i.e. it could be made even simpler.)
>
> This way we only have:
>
> SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr, unsigned int, flags)
>
> But even 'pid' and 'flags' could have been part of the attribute, i.e. one we pick 
> up an attribute structure from user-space we can have really low argument count 
> system calls. This also concentrates all the compat concerns into handling the 
> attribute structure properly - no weird per-arch artifacts and quirks with 4-5-6 
> system call arguments.

The trouble with attributes is that means you can't filter your system
call arguments with seccomp.  Which most of the time is a pretty big
downside.


From what I have seen the only truly interesting case for extending
waitid is something file descriptor based so the parent/child
relationship is not necessary to wait for a process to terminate.

As for getrusage.  If a sane union of the rusage limits and cgroups or
something like cgroups could be devised.  That would be ideal.  Of
course except for the memory cgroups the similarity to the resource
usage measurments and limits really isn't there.  So I don't know if
merging them would be a real possibility.

So I suspect the simplest thing to do would be to set a flag in the
idtype member of waitid that says give me rusage64 and then we would
be done.  Alternately we could use the low bits of the resource usage
pointer.  Assuming we don't want to introduce another syscall that is.
I really don't see much incremental extensibility potential in the wait
or rusage interface right now.

Eric
