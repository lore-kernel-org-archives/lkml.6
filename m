Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E81ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3621F2089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3621F2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeGPSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:30:52 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46490 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeGPSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:30:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff7pD-00051t-Hw; Mon, 16 Jul 2018 12:02:19 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff7oy-000732-3K; Mon, 16 Jul 2018 12:02:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-7-ebiederm@xmission.com>
        <20180716125144.GA18262@redhat.com> <8736wjtetv.fsf@xmission.com>
        <CA+55aFxDsE8sb5wQQNJdxvt8m6n6aVpOo1yVpk1BEzXDv8XzaQ@mail.gmail.com>
Date:   Mon, 16 Jul 2018 13:01:59 -0500
In-Reply-To: <CA+55aFxDsE8sb5wQQNJdxvt8m6n6aVpOo1yVpk1BEzXDv8XzaQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 16 Jul 2018 10:17:26 -0700")
Message-ID: <87bmb7oy94.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ff7oy-000732-3K;;;mid=<87bmb7oy94.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/7fb+d7dnoukApfanCMrxTzUhukHVgjZE=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID not PIDTYPE_PID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jul 16, 2018 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In practice since glibc does not make thread id's available I don't
>> expect anyone relies on this behavior.  Since no one relies on it we
>> can change it without creating a regression.
>
> Maybe.
>
> However, possibly not.
>
> The thing is, glibc wasn't the original or only use of our threads. In
> fact, there are people out there that use clone() directly, without
> using it for posix threading. And Oleg was right to notice this,
> because the traditional model was literally to just use "kill()" on
> the pid returned from clone().

I completely agree that Oleg was right to notice this, and I was
definitely not right to overlook.  In my description and otherwise.

I also think the semantic change needs to happen in it's own separate
patch so things can be tracked down.

I really don't think anyone uses this but it is not smart to hold the
rest of the changes hostage to my belief.  So I am thinking about how
to rework this.

> So the semantics of Linux kill() really is to kill the thread, not the
> group leader. glibc's implementation of pthreads is not the only model
> out there.

There are two questions.
a) Can we use the pid of a thread to find the thread group?
b) Will the signal be queued in the thread group?

> Now, it is possible that at none of the legacy uses use CLONE_THREAD
> and thus aren't affected (because tgid will always be pid). So maybe
> nobody notices.

That is what I expect.  I don't know think legacy is a good description.
Calling other uses of CLONE_THREAD non-glibc seems better.  The old
LinuxThreads did not use CLONE_THREAD because it did not exist.
>
> But we really have three different 'kill' system calls:
>
>  - the original 'kill' system call (#37 on x86-32).
>
>    This looks up the thread ID, but signals the *group*.
>
>  - tkill (#238)
>
>    This looks up the thread, and signals the specific thread.
>
>  - tgkill (#270)
>
>    This looks up the tgid, and signals the group.

No.  tgkill is a less racy version of tkill and verifies that the
thread it signals is in the proper thread group.

> Modern glibc will not even use the original 'kill()' at all, I think.
> But it's the legacy behavior.

No.  Modern glibc definitely still uses kill.  As kill is the only one
exporting the posix kill API.  

> So I do think Oleg is right. We should be careful. You'll not notice
> breakage on a modern distro, but you might easily break old code.

Yes.  We definitely need to be careful.   At the same time since this
isn't something the old LinuxThreads had to cope with we can probably
clean it up.  But as that is not my focus it should probably be pushed out.

Eric
