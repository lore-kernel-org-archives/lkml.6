Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37FC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AC320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AC320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeGXWdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:33:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59052 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGXWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:33:06 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fi4nS-0004Pk-MK; Tue, 24 Jul 2018 15:24:42 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fi4nR-0008HI-Oe; Tue, 24 Jul 2018 15:24:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-20-ebiederm@xmission.com>
        <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
        <874lgo5xdg.fsf@xmission.com>
        <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
        <87fu084cxj.fsf@xmission.com>
        <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
        <87a7qg4bb3.fsf_-_@xmission.com>
        <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
Date:   Tue, 24 Jul 2018 16:24:28 -0500
In-Reply-To: <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 24 Jul 2018 13:56:05 -0700")
Message-ID: <87pnzc2upf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fi4nR-0008HI-Oe;;;mid=<87pnzc2upf.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/wSOSEwl4W8QzPAKuZoJl+dE0jUhfEIz8=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 20/20] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jul 24, 2018 at 1:40 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> +       if (signal_pending(current)) {
>> +               retval = restart_syscall();
>> +               goto fork_out;
>> +       }
>
> Oh, the previous version had this too, but it wasn't as obvious
> because it was just in a single line:
>
>         return ERR_PTR(restart_syscall());
>
> but it's just crazy.
>
> It should just be
>
>         retval = -ERESTARTNOINTR;
>         if (signal_pending(current))
>                 goto fork_out;
>
> because it's just silly and pointless to change the code to use
> restart_syscall() here.
>
> All restart_syscall() does is
>
>         set_tsk_thread_flag(current, TIF_SIGPENDING);
>         return -ERESTARTNOINTR;
>
> and you just *checked* that TIF_SIGPENDING was already set. So the
> above is completely pointless.
>
> It is not clear why you made that change. The old code had the simpler
> "just return -ERESTARTNOINTR" model.
>
> Did the restart_syscall() thing come in by mistake from some previous
> trials and it just hung around?

I think this is the one place in the kernel where we can restart a
system call and not set TIF_SIGPENDING.

Several years ago I made the mistake in the networking code of returning
-ERESTARTNOINTR and forgetting to set TIF_SIGPENDING.  That wasn't fun.
So I wrote restart_syscall and use it so I don't make that mistake
again.

In this case your suggesting will definitely generate better code so I
am happy to make a V3 with that doesn't use restart_syscall.  A person
working in the guts of fork can reasonably be expected understand and to
have all of the subtleties in cache as they work on that part of fork.

Eric
