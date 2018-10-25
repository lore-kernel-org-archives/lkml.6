Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD09ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA82075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEA82075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeJYUZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:25:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeJYUZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:25:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 514A93082B22;
        Thu, 25 Oct 2018 11:52:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 85A8C4DA81;
        Thu, 25 Oct 2018 11:52:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Oct 2018 13:52:48 +0200 (CEST)
Date:   Thu, 25 Oct 2018 13:52:46 +0200
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
Message-ID: <20181025115245.GB3725@redhat.com>
References: <0000000000004904df0578b7d3da@google.com>
 <bf1a083c-0d09-07fb-6ad2-4bf30ac49cd8@I-love.SAKURA.ne.jp>
 <20181022095439.GA4613@redhat.com>
 <CAGXu5jLxLqieLCZfAzw_xX-k3bbESUF3pjuGEDRRH1CY2O8JSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLxLqieLCZfAzw_xX-k3bbESUF3pjuGEDRRH1CY2O8JSA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 25 Oct 2018 11:52:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Kees Cook wrote:
>
> task_is_descendant() is called under rcu_read_lock() in both
> ptracer_exception_found() and yama_ptrace_access_check() so I don't
> understand how any of the tasks could get freed? This is walking
> group_leader and real_parent -- are these not stable under rcu_lock()?

group_leader/real_parent/etc are no longer rcu-protected after the exiting
child calls release_task() which in particular removes the child from
children/thread_group lists.

OK. Suppose you have an rcu-protected list, and each element also has a
reference counter so you can do something

	struct elt {
		atomic_t ctr;
		struct list_head list;
		int pid;
	};

	rcu_read_lock();
	list_for_each_entry(elt, &LIST, list) {
		if (elt->pid == 100) {
			atomic_inc(&elt->ctr);	// get_task_struct()
			break;
		}
	}
	rcu_read_unlock();

	do_something(elt);

This code is fine. This elt can't be freed, you have a reference. But once
you drop rcu lock you can't trust elt->list.next! So, for example, you can
not do

	rcu_read_lock();
	list_for_each_entry_continue_rcu(elt, &LIST, list) {
		...
	}
	rcu_read_unlock();

too late, elt.list.next can be already freed, or it can be freed while you
iterate the list.

Another simple example. Suppose you have a global PTR protected by rcu. So
ignoring the necessary rcu_dereference this code is fine:

	rcu_read_lock();
	if (ptr = PTR)
		do_something(ptr);
	rcu_read_unlcok();

But this is not:

	ptr = PTR;
	rcu_read_lock();
	if (ptr)
		do_something(ptr);
	rcu_read_unlock();

basically the same thing...

Oleg.

