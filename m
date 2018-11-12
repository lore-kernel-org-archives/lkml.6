Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F04224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F04224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeKMFRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:17:11 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:60789 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:17:10 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gMHn8-00023S-AM; Mon, 12 Nov 2018 12:22:34 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gMHn7-0005QT-Ld; Mon, 12 Nov 2018 12:22:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
        <20181112185538.GK3645@cisco>
Date:   Mon, 12 Nov 2018 13:22:27 -0600
In-Reply-To: <20181112185538.GK3645@cisco> (Tycho Andersen's message of "Mon,
        12 Nov 2018 11:55:38 -0700")
Message-ID: <87tvkmgky4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gMHn7-0005QT-Ld;;;mid=<87tvkmgky4.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+zl1QQ2mxLMPrrREa5ueM5nnjMrWuEBw0=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: siginfo pid not populated from ptrace?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.ws> writes:

> On Mon, Nov 12, 2018 at 12:30:25PM -0600, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.ws> writes:
>> 
>> > Hi Oleg,
>> >
>> > I've been running some tests on my seccomp series, and in one of the
>> > tests on v4.20-rc2, I noticed,
>> >
>> > [ RUN      ] global.syscall_restart
>> > seccomp_bpf.c:2784:global.syscall_restart:Expected getpid() (1492) == info._sifields._kill.si_pid (0)
>> > global.syscall_restart: Test failed at step #22
>> >
>> > which seems unrelated to my series (the kernel was stock v4.20 with my
>> > patches on top).
>> >
>> > I've been running a lot of tests, and only seen this once, so it seems
>> > like a fairly rare race. I tried to look through the code but didn't
>> > see anything obvious. Thoughts?
>> 
>> My guess would be pid namespaces, or stopping for a signal other than
>> SIGSTOP.
>> 
>> If you can get this to reproduce at all it would be interesting to see
>> si_signo and si_code.  So that we can see just which signal is in info,
>> and how it should be decoded. 
>
> Sure, here's what I see,
>
> seccomp_bpf.c:2784:global.syscall_restart:Expected getpid() (2195) == info._sifields._kill.si_pid (0)
> seccomp_bpf.c:2785:global.syscall_restart:si_signo: 19
> seccomp_bpf.c:2786:global.syscall_restart:si_code: 0

That is SI_USER and SIGSTOP.  So as expected. 

>> I see this test at line 2736 in 4.20-rc1 so there are almost 50 lines of
>> change in your version of seccomp_bpf.c.  So I hope I am reading the
>> proper test.
>
> Yes, sorry, that's additional test stuff from my user trap series. I
> haven't manage to reproduce it on stock v4.20-rc2, unfortunately. It
> could be that this is some memory corruption introduced by my series,
> but I'm running these tests with KASAN so hopefully it would complain?

I don't have a clue what KASAN would do.  I think it is mostly concerned
with unitialized memory, so this might be slipping through the cracks
somewhere.

It can be easy to mess up siginfo.  That is part of the reason I just
reworked things to use helpers most of the time when touching siginfo.

Eric
