Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C84C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193D72083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dqRgeJkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbeKFXHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:07:33 -0500
Received: from aer-iport-2.cisco.com ([173.38.203.52]:59629 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeKFXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3587; q=dns/txt; s=iport;
  t=1541511736; x=1542721336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCFxe4Bbl0fzD9/e7oxDvUVMoL45UUwzCzXkmZ6djS0=;
  b=dqRgeJkr6T2R9bZe6MCjRECaInghri2otBC+uVjTAFhf4IiY3cGXhBTT
   2XKkWmZdm365Bmty1CgjPKJJgzH1vEDFBJLuCK+29ze4ikQZm8KPcFd+s
   InvtIOvHiYnCHl38sCkDD9B7T1Jev+baQjQEuGHVTON0DDhLzVov9szoP
   c=;
X-IronPort-AV: E=Sophos;i="5.54,471,1534809600"; 
   d="scan'208";a="7844536"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 13:42:15 +0000
Received: from clotho.home.austad.us ([10.47.77.53])
        by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id wA6DgDcU015653
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 13:42:14 GMT
Date:   Tue, 6 Nov 2018 14:42:13 +0100
From:   Henrik Austad <haustad@cisco.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>,
        juri.lelli@arm.com, bigeasy@linutronix.de,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] backport: sched/rtmutex/deadline: Fix a PI crash for
 deadline tasks
Message-ID: <20181106134213.i4ngxa7kfkwxi763@clotho.home.austad.us>
References: <20181106124721.7516-1-haustad@cisco.com>
 <20181106132210.GA9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106132210.GA9781@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Outbound-SMTP-Client: 10.47.77.53, [10.47.77.53]
X-Outbound-Node: aer-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 02:22:10PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 06, 2018 at 01:47:21PM +0100, Henrik Austad wrote:
> > From: Xunlei Pang <xlpang@redhat.com>
> > 
> > On some of our systems, we notice this error popping up on occasion,
> > completely hanging the system.
> > 
> >    [<ffffffc0000ee398>] enqueue_task_dl+0x1f0/0x420
> >    [<ffffffc0000d0f14>] activate_task+0x7c/0x90
> >    [<ffffffc0000edbdc>] push_dl_task+0x164/0x1c8
> >    [<ffffffc0000edc60>] push_dl_tasks+0x20/0x30
> >    [<ffffffc0000cc00c>] __balance_callback+0x44/0x68
> >    [<ffffffc000d2c018>] __schedule+0x6f0/0x728
> >    [<ffffffc000d2c278>] schedule+0x78/0x98
> >    [<ffffffc000d2e76c>] __rt_mutex_slowlock+0x9c/0x108
> >    [<ffffffc000d2e9d0>] rt_mutex_slowlock+0xd8/0x198
> >    [<ffffffc0000f7f28>] rt_mutex_timed_futex_lock+0x30/0x40
> >    [<ffffffc00012c1a8>] futex_lock_pi+0x200/0x3b0
> >    [<ffffffc00012cf84>] do_futex+0x1c4/0x550
> > 
> > It runs an 4.4 kernel on an arm64 rig. The signature looks suspciously
> > similar to what Xuneli Pang observed in his crash, and with this fix, my
> > issue goes away (my system has survivied approx 1500 reboots and a few
> > nasty tests so far)
> > 
> > Alongside this patch in the tree, there are a few other bits and pieces
> > pertaining to futex, rtmutex and kernel/sched/, but those patches
> > creates
> > weird crashes that I have not been able to dissect yet. Once (if) I have
> > been able to figure those out (and test), they will be sent later.
> > 
> > I am sure other users of LTS that also use sched_deadline will run into
> > this issue, so I think it is a good candidate for 4.4-stable. Possibly
> > also
> > to 4.9 and 4.14, but I have not had time to test for those versions.
> 
> But this patch relies on:
> 
>   2a1c60299406 ("rtmutex: Deboost before waking up the top waiter")

Yes, I have that one in my other queue (that crashes)

> for pointer stability, but that patch in turn relies on the whole
> FUTEX_UNLOCK_PI patch set:
> 
>  $ git log --oneline 499f5aca2cdd5e958b27e2655e7e7f82524f46b1..56222b212e8edb1cf51f5dd73ff645809b082b40
> 
>   56222b212e8e futex: Drop hb->lock before enqueueing on the rtmutex
>   bebe5b514345 futex: Futex_unlock_pi() determinism
>   cfafcd117da0 futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
>   38d589f2fd08 futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
>   50809358dd71 futex,rt_mutex: Introduce rt_mutex_init_waiter()
>   16ffa12d7425 futex: Pull rt_mutex_futex_unlock() out from under hb->lock
>   73d786bd043e futex: Rework inconsistent rt_mutex/futex_q state
>   bf92cf3a5100 futex: Cleanup refcounting
>   734009e96d19 futex: Change locking rules
>   5293c2efda37 futex,rt_mutex: Provide futex specific rt_mutex API
>   fffa954fb528 futex: Remove rt_mutex_deadlock_account_*()
>   1b367ece0d7e futex: Use smp_store_release() in mark_wake_futex()
> 
> and possibly some follow-up fixes on that (I have vague memories of
> that).

ok, so this looks a bit like the queue I have, thanks!

> As is, just the one patch you propose isn't correct :/
> 
> Yes, that was a ginormous amount of work to fix a seemingly simple splat
> :-(

Yep, well, on the positive side, I now know that I have to figure out the 
crashes, which is useful knowledge! Thanks!

I'll hammer away at the full series of backports for this then and resend 
once I've hammered out the issues.

Thanks for the feedback, much appreciated!

-- 
Henrik Austad
CVTG Eng - Endpoints
Cisco Systems Norway
