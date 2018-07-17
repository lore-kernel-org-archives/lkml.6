Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BA82147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BA82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbeGQLaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:30:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbeGQLav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 127AD859A0;
        Tue, 17 Jul 2018 10:58:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 93E24111CA17;
        Tue, 17 Jul 2018 10:58:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Jul 2018 12:58:47 +0200 (CEST)
Date:   Tue, 17 Jul 2018 12:58:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK  to
 forcibly kill tasks
Message-ID: <20180717105845.GC27482@redhat.com>
References: <877em2jxyr.fsf_-_@xmission.com>
 <20180711024459.10654-9-ebiederm@xmission.com>
 <20180716145540.GA20960@redhat.com>
 <87lgabrzfd.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgabrzfd.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 17 Jul 2018 10:58:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 17 Jul 2018 10:58:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 07/10, Eric W. Biederman wrote:
> >>
> >> Therefore use do_send_sig_info in all cases in __do_SAK to kill
> >> tasks as allows for exactly what the code wants to do.
> >
> > OK, but probably the changelog should also mention that now even the global
> > init will be killed if it has this tty opened.
>
> force_sig was ensuring the global init would die.  So that isn't a
> change.  Mentioning it isn't a bad idea.

I meant another "p->signal->tty == tty" case which uses send_sig(SIGKILL).

As for force_sig(), yes it kills init, but "by accident". See your commit
20ac94378 "do_SAK: Don't recursively take the tasklist_lock", it replaced
send_sig() because it took tasklist_lock.

Nevermind, let me repeat I am not arguing with this change.

But it looks off-topic in this series, why do we need it? Yes, these
send_sig/force_sig are ugly, we need do_send_sig_info(PIDTYPE_TGID). But
__do_SAK() needs more cleanups, do_each_thread() is ugly too by the same
reason, we should not send SIGKILL per-thread. And iirc it is racy either
way, a process can open tty right after it was checkeda process can open
tty right after it was checked.

I think the main loop should be rewritten as

	for_each_process(p) {
		if (p->signal->tty == tty) {
			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
				   task_pid_nr(p), p->comm);
			goto kill;
		}

		files = NULL;
		for_each_thread(p, t) {
				if (t->files == files) /* racy but we do not care */
					continue;

				task_lock(t);
				files = t->files;
				i = iterate_fd(files, 0, this_tty, tty);
				task_unlock(t);

				if (i != 0) {
					tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
						   task_pid_nr(p), p->comm, i - 1);
					goto kill;
				}
		}

		continue;
 kill:
		do_send_sig_info(SIGKILL, SEND_SIG_NOINFO, p, true);
	}

If we want to kill init's as well, we can use SEND_SIG_FORCE and this can come
as a separate change, although I am personally fine either way.

Oleg.

