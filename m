Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D26C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0819122408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0819122408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHJOp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:45:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47921 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeHJOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:45:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fo6KZ-0005tL-NU; Fri, 10 Aug 2018 06:15:47 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fo6KU-0006yH-V8; Fri, 10 Aug 2018 06:15:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <wen.yang99@zte.com.cn>
Cc:     <torvalds@linux-foundation.org>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <ma.jiang@zte.com.cn>, <chen.shengyuan@zte.com.cn>,
        <zhong.weidong@zte.com.cn>
References: <201808101434273569497@zte.com.cn>
Date:   Fri, 10 Aug 2018 07:15:28 -0500
In-Reply-To: <201808101434273569497@zte.com.cn> (wen's message of "Fri, 10 Aug
        2018 14:34:27 +0800 (CST)")
Message-ID: <8736vmto2n.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fo6KU-0006yH-V8;;;mid=<8736vmto2n.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ND/iFoEVJj480kfJIVLHM6tlZzRtfbso=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v6 6/6] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<wen.yang99@zte.com.cn> writes:

> ebiederm@xmission.com <ebiederm@xmission.com> writes
>> Subject: [PATCH v6 6/6] signal: Don't restart fork when signals come in.
>> 
>> Wen Yang <wen.yang99@zte.com.cn> and majiang <ma.jiang@zte.com.cn>
>> report that a periodic signal received during fork can cause fork to
>> continually restart preventing an application from making progress.
>> 
>> ...
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 9f0eafb6d474..cfa9d10e731a 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1121,6 +1121,21 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
>> out_set:
>> signalfd_notify(t, sig);
>> sigaddset(&pending->signal, sig);
>> +
>> + /* Let multiprocess signals appear after on-going forks */
>> + if (type > PIDTYPE_TGID) {
>> + struct multiprocess_signals *delayed;
>> + hlist_for_each_entry(delayed, &t->signal->multiprocess, node) {
>> + sigset_t *signal = &delayed->signal;
>> + /* Can't queue both a stop and a continue signal */
>> + if (sig == SIGCONT)
>> + sigdelsetmask(signal, SIG_KERNEL_STOP_MASK);
>> + else if (sig_kernel_stop(sig))
>> + sigdelset(signal, SIGCONT);
>> + sigaddset(signal, sig);
>> + }
>> + }
>> +
>> complete_signal(sig, t, type);
>> ret:
>> trace_signal_generate(sig, info, t, type != PIDTYPE_PID, result);
>
> I've migrated this patch and try to test it, but  I ran into a compile error:
>
> kernel/signal.c: In function '__send_signal':
> kernel/signal.c:1192:9: error: 'type' undeclared (first use in this function)
>      if (type > PIDTYPE_TGID) {
>          ^
> We may also need some patches, which pass pid type into
> __send_signal.

We most definitely need the the first 15 patches from my last series of
patches that push the pid type down.

I did not repeat them here because there is consensus that they
are fine working fine.

I have a branch with everything at:

https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-testing

Eric
