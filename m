Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A69C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0015620880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0015620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbeGXVNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:13:47 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36660 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:13:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fi3Z0-0000jx-9j; Tue, 24 Jul 2018 14:05:42 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fi3Yz-0005Ij-M7; Tue, 24 Jul 2018 14:05:42 -0600
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
Date:   Tue, 24 Jul 2018 15:05:28 -0500
In-Reply-To: <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 24 Jul 2018 11:29:39 -0700")
Message-ID: <87fu084cxj.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fi3Yz-0005Ij-M7;;;mid=<87fu084cxj.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JvOLrXCAvOgVztUGM6MNx+0tUsjWqFeM=
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

> On Tue, Jul 24, 2018 at 10:58 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Yes you are quite right.   Easy enough to fix, but it definitely needs
>> to be fixed.
>>
>> I will respin.
>
> Would you mind trying a slightly different approach for this?
>
> How about moving the "copy_signal()" and "copy_sighandler()" cases up
> to fairly early in the "copy_process()" function (and clean up late,
> obviously).
>
> Then, instead of that "struct multiprocess_signals" thing, just add a
> "struct hlist_node node" to "struct signal" itself, and add it to the
> multiprocess hlist there.
>
> And then you can just remove it in bad_fork_cleanup_signal.
>
> Does this make "struct signal" a bit larger? Yes, but it's not a huge
> deal. We *could* make is some union with existing fields if we cared.
>
> But I think it would make the code *much* more understandable, and it
> would allow us to not have that "sigpending" copy, because you can
> just populate the final "signal->shared_pending" directly.
>
> Hmm?

I don't like it.

What I hear you asking is  moving up copy_signal copy_sighand copy_creds
and alloc_pid, and anything else that signal delivery might depend on.

Then in send_signal running __send_signal in a loop first for the
forking process and then for every process that is currently in the
middle of fork.

It feels like this gets us much later in fork, and there is a lot more
code to move and review.   Which to some extent makes us more
susceptible to periodic signals, as more work will be thrown away and
have to be redone.  Plus it makes the whole thing susceptible to signal
delivery growing some additional dependency (perhaps cgroups?) and that
getting missed and never noticed until someone manages to time a sending
a signal just right.

I really want something very simple and straight forward because I don't
see us testing or hitting this code path much in practice.  Moving this
into the middle of fork and adding more depedencies does not seem like
it will be that kind of straight forward.

Eric
