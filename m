Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E46ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DC320779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DC320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeJVSMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbeJVSMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:12:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BCCE83F3E;
        Mon, 22 Oct 2018 09:54:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5217F6D778;
        Mon, 22 Oct 2018 09:54:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Oct 2018 11:54:42 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:54:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181022095439.GA4613@redhat.com>
References: <0000000000004904df0578b7d3da@google.com>
 <bf1a083c-0d09-07fb-6ad2-4bf30ac49cd8@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf1a083c-0d09-07fb-6ad2-4bf30ac49cd8@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 22 Oct 2018 09:54:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21, Tetsuo Handa wrote:
>
> On 2018/10/21 16:10, syzbot wrote:
> > BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:188 [inline]
> > BUG: KASAN: use-after-free in task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
> > Read of size 8 at addr ffff8801c4666b20 by task syz-executor3/12722
> >
> > CPU: 1 PID: 12722 Comm: syz-executor3 Not tainted 4.19.0-rc8+ #70
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> >  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >  __read_once_size include/linux/compiler.h:188 [inline]
> >  task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
>
> Do we need to hold
>
>   write_lock_irq(&tasklist_lock);
>
> rather than
>
>   rcu_read_lock();
>
> when accessing
>
>   "struct task_struct"->real_parent

Well, if "task" is stable (can't exit), then I think

	rcu_dereference(task->real_parent)

is fine, we know that ->real_parent did not pass exit_notif() yet.

However, task_is_descendant() looks unnecessarily complicated, it could be

	static int task_is_descendant(struct task_struct *parent,
				      struct task_struct *child)
	{
		int rc = 0;
		struct task_struct *walker;

		if (!parent || !child)
			return 0;

		rcu_read_lock();
		for (walker = child; walker->pid; walker = rcu_dereference(walker->real_parent))
			if (same_thread_group(parent, walker)) {
				rc = 1;
				break;
			}
		rcu_read_unlock();

		return rc;
	}

And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?

Oleg.


