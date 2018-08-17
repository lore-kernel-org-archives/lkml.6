Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F47421473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F47421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeHQW2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:28:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQW2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:28:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C2C0CD5;
        Fri, 17 Aug 2018 19:24:15 +0000 (UTC)
Date:   Fri, 17 Aug 2018 12:24:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH] signal: Don't send signals to tasks that don't exist
Message-Id: <20180817122414.df0eee974434d170b1a54c31@linux-foundation.org>
In-Reply-To: <87pnyg7rw3.fsf@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-7-ebiederm@xmission.com>
        <87k1orgdoo.fsf_-_@xmission.com>
        <CACT4Y+bYFatW=CMgH4M6AjtjO297gbQ8xwnEV0_f7J64FLQ4QQ@mail.gmail.com>
        <87pnyg7rw3.fsf@xmission.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 13:46:36 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:

> Dmitry Vyukov <dvyukov@google.com> writes:
> 
> > On Wed, Aug 15, 2018 at 9:04 PM, Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >>
> >> Recently syzbot reported crashes in send_sigio_to_task and
> >> send_sigurg_to_task in linux-next.  Despite finding a reproducer
> >> syzbot apparently did not bisected this or otherwise track down the
> >> offending commit in linux-next.
> >>
> >> I happened to see this report and examined the code because I had
> >> recently changed these functions as part of making PIDTYPE_TGID a real
> >> pid type so that fork would does not need to restart when receiving a
> >> signal.  By examination I see that I spotted a bug in the code
> >> that could explain the reported crashes.
> >>
> >> When I took Oleg's suggestion and optimized send_sigurg and send_sigio
> >> to only send to a single task when type is PIDTYPE_PID or PIDTYPE_TGID
> >> I failed to handle pids that no longer point to tasks.  The macro
> >> do_each_pid_task simply iterates for zero iterations.  With pid_task
> >> an explicit NULL test is needed.
> >>
> >> Update the code to include the missing NULL test.
> >>
> >> Fixes: 019191342fec ("signal: Use PIDTYPE_TGID to clearly store where file signals will be sent")
> >> Reported-by: syzkaller-bugs@googlegroups.com
> >
> > Since the commit does not contain the syzbot-provided Reported-by tag,
> > we need to tell syzbot that this is fixed explicitly:
> 
> Nor will my commits ever contain that information.  That is information
> only of use to syzbot.  That is not information useful to anyone else.
> 
> Further syzbot did not track this down and report this.  Syzbot said
> something is fishy here and happened to CC a public mailing list.  Only
> by chance did I see the report.  There was enough information to start
> an investigation but it certainly was not any kind of useful bug report.
> 
> It is very annoying that despite syzbot claming to have a reproducer
> syzbot completely failed to locate the problem commit or the proper
> people to repor the issue to.  I looked at the syzbot website link and
> there was no evidence that syzbot even tried to track down which branch
> in linux-next the commit came from.  Much less to identify the commit on
> that branch.

Dude, lighten up.

These reports are useful.  Even if they don't have a reproducer, we
have a backtrace and we can go look and we have a good chance of fixing
the bug.  And as adding a single-line tag to the commit message helps
the syzbot people keep track of things, why not do it?  It's hardly a big
effort.

They're doing useful things - please don't get all bent out of shape
because things aren't 100% perfect.

> Very annoyingly syzbot sent out emails and report this before it found a
> reproducer.  This is despite several people explicitly asking syzbot
> to not report issuing on linux-next where syzbot does not have a
> reproducer and it can not track down the offending commit.

Dear syzbot, please report linux-next issues when you do not have a
reproducer and/or cannot track down the offending commit.


