Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856EAC7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6936F2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6936F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeJVWFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeJVWFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 412788830A;
        Mon, 22 Oct 2018 13:46:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id BC27C5ED3A;
        Mon, 22 Oct 2018 13:46:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Oct 2018 15:46:36 +0200 (CEST)
Date:   Mon, 22 Oct 2018 15:46:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181022134634.GA7358@redhat.com>
References: <0000000000004904df0578b7d3da@google.com>
 <bf1a083c-0d09-07fb-6ad2-4bf30ac49cd8@I-love.SAKURA.ne.jp>
 <20181022095439.GA4613@redhat.com>
 <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 22 Oct 2018 13:46:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22, Tetsuo Handa wrote:
>
> > However, task_is_descendant() looks unnecessarily complicated, it could be
> >
> > 	static int task_is_descendant(struct task_struct *parent,
> > 				      struct task_struct *child)
> > 	{
> > 		int rc = 0;
> > 		struct task_struct *walker;
> >
> > 		if (!parent || !child)
> > 			return 0;
> >
> > 		rcu_read_lock();
> > 		for (walker = child; walker->pid; walker = rcu_dereference(walker->real_parent))
> > 			if (same_thread_group(parent, walker)) {
> > 				rc = 1;
> > 				break;
> > 			}
> > 		rcu_read_unlock();
> >
> > 		return rc;
> > 	}
> >
> > And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
> > task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?
>
> Since the caller (ptrace() path) called get_task_struct(child), child itself can't be
> released. Do we still need pid_alive(child) ?

get_task_struct(child) can only ensure that this task_struct can't be freed.

Suppose that this child exits after get_task_struct(), then its real_parent exits
too and calls call_rcu(delayed_put_task_struct).

Now, when task_is_descendant() is called, rcu_read_lock() can happen after rcu gp,
iow child->parent can be already freed/reused/unmapped.

We need to ensure that child is still protected by RCU.

Oleg.

