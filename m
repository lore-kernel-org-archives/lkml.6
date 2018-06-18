Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A353EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A13208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A13208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbeFRGLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:11:25 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36691 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbeFRGLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:11:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fUnNm-0004xj-0c; Mon, 18 Jun 2018 00:11:18 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fUnNW-00024I-Kv; Mon, 18 Jun 2018 00:11:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
        <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
        <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
        <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
        <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
        <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
        <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
        <20180610015107.GC5020@thunk.org>
        <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
        <20180611012250.GD5020@thunk.org>
        <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
Date:   Mon, 18 Jun 2018 01:10:49 -0500
In-Reply-To: <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
        (Dmitry Vyukov's message of "Fri, 15 Jun 2018 11:54:16 +0200")
Message-ID: <87602gmxp2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fUnNW-00024I-Kv;;;mid=<87602gmxp2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19vVjeD04paReLVmPC77ULfXHbXK7SFp8I=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: what trees/branches to test on syzbot
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Mon, Jun 11, 2018 at 3:22 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> On Sun, Jun 10, 2018 at 08:11:05AM +0200, Dmitry Vyukov wrote:
>>>
>>> The set of trees where a crash happened is visible on dashboard, so
>>> one can see if it's only linux-next or whole set of trees. Potentially
>>> syzbot can act differently depending on this predicate, but I don't
>>> see what should be the difference.  However, this does not fully save
>>> from falsely assessing bugs as linux-next-only just because they
>>> happened few times and only on linux-next so far.
>>
>> So how about this, only report something as being a linux-next
>> regression if (a) there is a reproducer, and (b) the reproducer does
>> not trigger any kind of crash on mainline?
>>
>>> There is also a problem with rebasing of linux-next: reported commit
>>> hashes do not make sense and we can forget about bisection.
>>
>> If there is a valid reproducer, bisection should simply be a matter ofu
>> running and if we know the reproducer doesn't trigger on mainline,
>> then the bisection should only require no more than 8-10 VM runs.  For
>> Linux-next, this would be *super* valuable.  Reporting the commit ID
>> and the one-line commit summary will be enough for most maintainers,
>> since even if they are using a rewinding head, so long as the
>> bisection can be done quickly enough (e.g., within a few days), it
>> will still be in their git repository.
>>
>> And if you have a reproducer, then once it's identified as a
>> linux-next reproducer with a guilty commit, that can be confirmed by
>> either (a) seeing if you can revert the commit and if it makes the
>> problem go away, or (b) figure out which subsystem git tree the commit
>> was introduced via, and then verify that the reproducer triggers on
>> the tip of the subsystem git tree.
>>
>> All of this will require development effort, so I suspect it's not
>> something we'll see from syzbot tomorrow --- but it's not
>> *impossible*.
>>
>> I think though that sending e-mail about a linux-next syzbot crash if
>> there is a reproducer and the reproducer doesn't trigger a crash on
>> mainline should be really simple to implement, and it would add huge
>> value without spamming the subsystem maintainers.
>
>
> But if this also happens on upstream, then we want to report it
> twofold. So this predicate can be reduced to "report crashes that
> happen only on linux-next iff they have reproducers", right?
> We will probably also need something that will auto-invalidate old
> bugs that were never reported.
>
> Re backwards bisection (when bug is introduced), we can actually test
> linux-next-history instead of linux-next, right?
> But forward bisection (when bug is fixed) unfortunately won't work
> because these commits are not connected to HEAD. And forward bisection
> is very important, otherwise who will bring order to all these
> hundreds of open bugs?
> https://syzkaller.appspot.com/

Maybe you want to monitor linux-next and see if the problem commits
disappear.  That can let you stop worrying about the issue.

I don't see the point of worrying about which linux-next build a problem
appeared in.  It is the first commit that reproduces the problem that is
interesting.

That commit tells you who did something that was problematic.  If you
notify the committer with the reproducer they should be able to
reproduce the problem and fix it.

Very rarely I suspect it will be the merge commit into linux-next that
is the problem, but most of the time these commits are going to be in
the subsystem trees.

Eric

