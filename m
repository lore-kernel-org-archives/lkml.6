Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCBC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B0621C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B0621C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeHIIm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:42:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40495 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeHIIm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:42:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fneIO-0005hM-39; Thu, 09 Aug 2018 00:19:40 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fneIN-0008UK-6t; Thu, 09 Aug 2018 00:19:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <874lgo5xdg.fsf@xmission.com>
        <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
        <87fu084cxj.fsf@xmission.com>
        <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
        <87a7qg4bb3.fsf_-_@xmission.com>
        <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
        <87pnzc2upf.fsf@xmission.com> <87k1pk2cj9.fsf_-_@xmission.com>
        <20180726134143.GB32718@redhat.com> <87pnza6ou2.fsf@xmission.com>
        <20180726155546.GA467@redhat.com>
Date:   Thu, 09 Aug 2018 01:19:26 -0500
In-Reply-To: <20180726155546.GA467@redhat.com> (Oleg Nesterov's message of
        "Thu, 26 Jul 2018 17:55:47 +0200")
Message-ID: <87600k2hap.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fneIN-0008UK-6t;;;mid=<87600k2hap.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/h1tWUbOE6SVji+GXUt0yL/3ui2649jWI=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 20/20] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/26, Eric W. Biederman wrote:
>>
>> Are the earlier patches looking ok to you?
>
> I obviously like 1-15.
>
> "[PATCH 16/20] fork: Move and describe why the code examines PIDNS_ADDING"
> is "interesting". I mean it is fine, but at the end of this series it doesn't
> matter what we check first, PIDNS_ADDING or fatal_signal_pending() - restart
> is not possible in both cases.
>
>
> As for 17-20... Yes I am biased. But I still think the simple approach I tried
> to propose from the very beginning is better. At least simpler, in that you do
> not need to worry about all these special cases/reasons for signal_pending().

I think worrying about them all now results in a future where we don't
have to worry about reasons why we can't let fork continue.  Giving a
better progress guarantee.  Which ultimately should be more maintainable
going forward.

> And you can not imagine how much I hate "[PATCH 19/20] fork: Have new threads
> join on-going signal group stops" ;) Because I spent HOURS looking at this trivial
> patch and I am still not sure...
>
> To clarify, the CLONE_THREAD with JOBCTL_STOP_PENDING case is simple, I am mostly
> worried about JOBCTL_TRAP_STOP/etc with or without CLONE_THREAD, this adds some
> subtle changes but unfortunately I failed to find something wrong so I
> can't argue

I can understand taking a hard look at JOBCTL_TRAP_STOP especially as it
gets mixed in with the multi-task (whole process) stop handling when at
least one of the tasks of a process are being ptraced.  To make certain
I understood your concern I took a second look at it myself.

The ptrace actions are defined to only affect a single task, and except
for multi-task stop handling all of the jobctl bits are used for ptrace
actions.  So I don't see how there is anything we could possibly miss
in the jobctl bits.

Eric


