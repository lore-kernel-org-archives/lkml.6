Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7AFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BCB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BCB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeLJRhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:19 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:33552 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeLJRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gWPUZ-00068U-7k; Mon, 10 Dec 2018 10:37:15 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gWPUY-0006d2-IO; Mon, 10 Dec 2018 10:37:15 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
        <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
        <87zhtthkuy.fsf@xmission.com>
        <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
        <87k1ktqoe5.fsf@xmission.com>
        <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
        <87r2euiuql.fsf@xmission.com>
        <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
        <20181206192059.GD10086@cisco> <87lg528io7.fsf@xmission.com>
        <20181210153717.GA7581@redhat.com>
Date:   Mon, 10 Dec 2018 11:36:59 -0600
In-Reply-To: <20181210153717.GA7581@redhat.com> (Oleg Nesterov's message of
        "Mon, 10 Dec 2018 16:37:18 +0100")
Message-ID: <87tvjl1dxg.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gWPUY-0006d2-IO;;;mid=<87tvjl1dxg.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18RFJ4hTxzPQvTm5gMfsW0SEsDQvOQ8JtM=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: siginfo pid not populated from ptrace?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 12/06, Eric W. Biederman wrote:
>>
>> The challenge is that we could be delivering this to a zombie signal
>> group leader.
>
> ...
>
>> Sigh it is probably time that I dig in and figure out how to avoid that
>> case which we need to fix anyway because we can get the permission
>> checks wrong for multi-threaded processes that call setuid and friends.
>
> this is another issue... I am sure we have already discussed this, but I
> failed to find any link to the previous discussion.

Now that we have PIDTYPE_TGID I think we are closer to being able to
solve that issue.  You are absolutely right it is another issue.

>> Once that is sorted your small change will at least be safe.
>
> I don't think so, any sub-thread can dequeue SIGSTOP unless type == PIDTYPE_PID,
> this has nothing to do with the problems connected to zombie leader, or I
> misunderstood you.

I forgot to check what wants_signal does in this case.  I thought
SIGSTOP was like SIGKILL and being unblockable would always be delivered
to the thread we are aiming at.  With a zombie leader being the
exception.

Having reread wants_signal you are absolutely correct.  SIGSTOP can be
delivered to any thread so this won't help.  I don't understand why for
SIGSTOP we don't treat SIGSTOP like SIGKILL, but that is also another
conversation.  It feels like the differences between SIGSTOP and SIGKILL
in wants_signal are silly.  I don't see them leading to incorrect behavior.

Eric
