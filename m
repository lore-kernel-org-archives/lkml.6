Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E4BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA6722360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA6722360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbeKNCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbeKNCRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:17:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD7E6662;
        Tue, 13 Nov 2018 16:19:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4292260851;
        Tue, 13 Nov 2018 16:18:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 13 Nov 2018 17:19:03 +0100 (CET)
Date:   Tue, 13 Nov 2018 17:18:58 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chanho Min <chanho.min@lge.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Donghwan Jung <donghwan.jung@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Message-ID: <20181113161858.GE30990@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
 <20181113145339.GD16182@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113145339.GD16182@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 13 Nov 2018 16:19:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13, Michal Hocko wrote:
>
> On Mon 12-11-18 12:54:45, Chanho Min wrote:
> > Suspend fails due to the exec family of functions blocking the freezer.
> > The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
> > all sub-threads to die, and we have the deadlock if one of them is frozen.
> > This also can occur with the schedule() waiting for the group thread leader
> > to exit if it is frozen.
> >
> > In our machine, it causes freeze timeout as bellows.
> >
> > Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze, wq_busy=0):
> > setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
> >  Call trace:
> > [<ffffffc00008ed70>] __switch_to+0x88/0xa0
> > [<ffffffc000d1c30c>] __schedule+0x1bc/0x720
> > [<ffffffc000d1ca90>] schedule+0x40/0xa8
> > [<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
> > [<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
> > [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> > [<ffffffc00021c584>] load_script+0x20c/0x228
> > [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> > [<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
> > [<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
> > [<ffffffc00008de30>] el0_svc_naked+0x24/0x28
> >
> > To fix this, make de_thread() freezable. It looks safe and works fine.
>
> It's been some time since I have looked into this code so bear with me.
> One thing is not really clear to me. Why does it help to exclude this
> particular task from the freezer

we don't exclude it,

> when it is not sleeping in the freezer.

Yes, it is not sleeping in __refrigerator(), but it does

	schedule();
	freezer_count();

so it will enter __refrigerator() right after wakeup. If it won't be woken
up we do not care, we can consider it "frozen".

> I can see how other threads need to be zapped and TASK_WAKEKILL doesn't
> do that but shouldn't we fix that instead?

Not sure I understand, but unlikely we can (or want) to make __refrigerator()
killable.

Otherwise, how can we fix that?

Oleg.

