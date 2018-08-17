Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7288C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7541321A86
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7541321A86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeHQVvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:51:16 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33869 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:51:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqjlm-0006fR-ID; Fri, 17 Aug 2018 12:46:46 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqjll-0006px-7F; Fri, 17 Aug 2018 12:46:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-7-ebiederm@xmission.com>
        <87k1orgdoo.fsf_-_@xmission.com>
        <CACT4Y+bYFatW=CMgH4M6AjtjO297gbQ8xwnEV0_f7J64FLQ4QQ@mail.gmail.com>
Date:   Fri, 17 Aug 2018 13:46:36 -0500
In-Reply-To: <CACT4Y+bYFatW=CMgH4M6AjtjO297gbQ8xwnEV0_f7J64FLQ4QQ@mail.gmail.com>
        (Dmitry Vyukov's message of "Fri, 17 Aug 2018 10:34:12 -0700")
Message-ID: <87pnyg7rw3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fqjll-0006px-7F;;;mid=<87pnyg7rw3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/G6gJzgJ9OZ+GFm/1aKyyCeW3WriSnBZ4=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: Don't send signals to tasks that don't exist
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Wed, Aug 15, 2018 at 9:04 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Recently syzbot reported crashes in send_sigio_to_task and
>> send_sigurg_to_task in linux-next.  Despite finding a reproducer
>> syzbot apparently did not bisected this or otherwise track down the
>> offending commit in linux-next.
>>
>> I happened to see this report and examined the code because I had
>> recently changed these functions as part of making PIDTYPE_TGID a real
>> pid type so that fork would does not need to restart when receiving a
>> signal.  By examination I see that I spotted a bug in the code
>> that could explain the reported crashes.
>>
>> When I took Oleg's suggestion and optimized send_sigurg and send_sigio
>> to only send to a single task when type is PIDTYPE_PID or PIDTYPE_TGID
>> I failed to handle pids that no longer point to tasks.  The macro
>> do_each_pid_task simply iterates for zero iterations.  With pid_task
>> an explicit NULL test is needed.
>>
>> Update the code to include the missing NULL test.
>>
>> Fixes: 019191342fec ("signal: Use PIDTYPE_TGID to clearly store where file signals will be sent")
>> Reported-by: syzkaller-bugs@googlegroups.com
>
> Since the commit does not contain the syzbot-provided Reported-by tag,
> we need to tell syzbot that this is fixed explicitly:

Nor will my commits ever contain that information.  That is information
only of use to syzbot.  That is not information useful to anyone else.

Further syzbot did not track this down and report this.  Syzbot said
something is fishy here and happened to CC a public mailing list.  Only
by chance did I see the report.  There was enough information to start
an investigation but it certainly was not any kind of useful bug report.

It is very annoying that despite syzbot claming to have a reproducer
syzbot completely failed to locate the problem commit or the proper
people to repor the issue to.  I looked at the syzbot website link and
there was no evidence that syzbot even tried to track down which branch
in linux-next the commit came from.  Much less to identify the commit on
that branch.

Very annoyingly syzbot sent out emails and report this before it found a
reproducer.  This is despite several people explicitly asking syzbot
to not report issuing on linux-next where syzbot does not have a
reproducer and it can not track down the offending commit.

> #syz fix: signal: Don't send signals to tasks that don't exist

Private internal communication on a public mailing list is rude.  Please
cut it out.

I appreciate the eagerness to report bugs.  But to play well with others
and not waste developers valuable time syzbot needs to track down the
offending commits and track fixes tags like everyone else.  Special
magic syzbot tags are annoying noise.

I will give credit where credit is due.  But syzbot is not so valuable
it can set rules for everyone else.  Automation is valuable when it
removes work.  Syzbot is not doing a good job at making the most of
developers limited time.

Cyrill Gorconov and Andrey Vagin did a much better job in tracking this
down and reporting this.  They just took a little bit longer.  Please
look at what they sent if you need an example of a useful bug report
looks like.

Eric
