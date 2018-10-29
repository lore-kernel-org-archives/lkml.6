Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695512082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695512082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeJ2VM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbeJ2VM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:12:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0962430B8A3E;
        Mon, 29 Oct 2018 12:24:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD23760C65;
        Mon, 29 Oct 2018 12:23:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Oct 2018 13:23:59 +0100 (CET)
Date:   Mon, 29 Oct 2018 13:23:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181029122356.GA29883@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <20181025130129.GE3725@redhat.com>
 <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 29 Oct 2018 12:24:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26, Kees Cook wrote:
>
> On Thu, Oct 25, 2018 at 2:01 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 10/25, Oleg Nesterov wrote:
> >> perhaps it needs some changes too. I even have a vague feeling that I have already
> >> blamed this function some time ago...
> >
> > Heh, yes, 3 years ago ;)
> >
> > https://lore.kernel.org/lkml/20150106184427.GA18153@redhat.com/
> >
> > I can't understand my email today, but note that I tried to point out that
> > task_is_descendant() can dereference the freed mem.
>
> Instead of:
>
>         while (walker->pid > 0) {
>
> should it simply be "while (pid_liave(walker)) {"?

No, this would be wrong. Probably walker->pid > 0 is not the best check,
but we do not need to change it for correctness.

> And add a
> pid_alive(parent) after rcu_read_lock()?

So you too do not read my emails ;)

I still think we need a single pid_alive() check and I even sent the patch.
Attached again at the end.

To clarify, let me repeat that ptracer_exception_found() may need some fixes
too, right now I am only talking about task_is_descendant().

> > And yes, task_is_descendant() is overcompicated for no reason, afaics.
>
> Yeah, agreed. I'll fix this up.

I have already posted this code, this is what I think it should do.


	static int task_is_descendant(struct task_struct *parent,
				      struct task_struct *child)
	{
		struct task_struct *walker;

		for (walker = child; walker->pid; walker = rcu_dereference(walker->real_parent)) {
			if (same_thread_group(parent, walker))
				return 1;
		}

		return 0;
	}

This version differs in that I removed the parent/child != NULL at the start
and rcu_read_lock(), it should be held by the caller anyway.

> Just to make sure I'm not crazy: the
> real_parent of all tasks in a thread group are the same, yes?

Well, yes and no. So if

	same_thread_group(t1, t2) == T

then
	same_thread_group(t1->real_parent, t2->real_parent) == T

which means that real_parent of all tasks in a thread group is the same
_process_.

But t1->real_parent and t2->real_parent are not necessarily the same task.

Oleg.

--- x/security/yama/yama_lsm.c
+++ x/security/yama/yama_lsm.c
@@ -368,7 +368,8 @@ static int yama_ptrace_access_check(stru
 			break;
 		case YAMA_SCOPE_RELATIONAL:
 			rcu_read_lock();
-			if (!task_is_descendant(current, child) &&
+			if (!pid_alive(child) ||
+			    !task_is_descendant(current, child) &&
 			    !ptracer_exception_found(current, child) &&
 			    !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
 				rc = -EPERM;

