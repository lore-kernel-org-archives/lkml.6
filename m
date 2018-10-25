Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2638ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C6D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C6D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJZA2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbeJZA2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 540783001A6F;
        Thu, 25 Oct 2018 15:55:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B3495B69D;
        Thu, 25 Oct 2018 15:55:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Oct 2018 17:55:06 +0200 (CEST)
Date:   Thu, 25 Oct 2018 17:55:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181025155503.GF3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 25 Oct 2018 15:55:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Tetsuo Handa wrote:
>
> On 2018/10/25 21:17, Oleg Nesterov wrote:
> >>> And yes, task_is_descendant() can hit the dead child, if nothing else it can
> >>> be killed. This can explain the kasan report.
> >>
> >> The kasan is reporting that child->real_parent (or maybe child->real_parent->real_parent
> >> or child->real_parent->real_parent->real_parent ...) was pointing to already freed memory,
> >> isn't it?
> >
> > Yes. and you know, I am all confused. I no longer can understand you :/
>
> Why don't we need to check every time like shown below?
> Why checking only once is sufficient?

Why do you think it is not sufficient?

Again, I can be easily wrong, rcu is not simple, but so far I think we need
a single check at the start.

> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -285,7 +285,7 @@ static int task_is_descendant(struct task_struct *parent,
>  	rcu_read_lock();
>  	if (!thread_group_leader(parent))
>  		parent = rcu_dereference(parent->group_leader);
> -	while (walker->pid > 0) {
> +	while (pid_alive(walker) && walker->pid > 0) {

OK. To simplify, ets suppose that task_is_descendant() is called with tasklist
lock held. And lets suppose that all tasks are single-threaded.

Then we obviously need a single check at the start, we need to ensure that the
child was not removed from its ->real_parent->children list. The latter means
that if ->real_parent exits, the child will be re-parented and its ->real_parent
will be updated.

So we could do

	read_lock(tasklist);

	if (list_empty(child->sibling))
		// it is dead, removed from ->children list, we can't trust
		// child->real_parent
		return -EWHATEVER;

	task_is_descendant(current, child);

But note that we can safely use pid_alive(child) instead, detach_pid() and
list_del_init(&p->sibling) happen "at the same time" since we hold tasklist.

(And btw, I suggested several times to rename it, or add another helper with
 a better name. Note also that we could check, say, ->sighand != NULL with
 the same effect.)


Now. Why do you think rcu_read_lock() differs in that we need to check
pid_alive() at every step?

Suppose that one of the grand parents exits, and it is going to be freed. Again,
to (over)simplify the things, lets suppose that release_task() does

	synchronize_rcu();
	free_task(p);

at the end. Now, can

	rcu_read_lock();
	if (pid_alive(child)) {
		while (child->pid)
			child = child->real_parent;
	}
	rcu_read_unlock();

hit the already freed ->real_parent ? Say, the freed child->real_parent->real_parent.

Lets denote P1 = child->real_parent, P2 = P1->real_parent. Can P2 be already freed?

This is only possible if synchronize_rcu() above was called before rcu_read_lock(),
see the last sentence below.

If P1->real_parent is still P2, then P1 has already exited too. And we still observe
that child->real_parent == P1, this too is only possible if child has exited, so we
must see pid_alive() == F.

Why must we see pid_alive() == F without tasklist? It must be true, release_task()
is serialized by tasklist_lock, but why we can't get the stale value under
rcu_read_lock() ?

Because our rcu read-lock critical section extends beyond the return from
synchronize_rcu(), and thus we must have a full memory barrier _between_
that synchronize_rcu() and our rcu_read_lock(). We must see all memory updates,
including thread_pid = NULL which makes pid_alive() == F.

Do you see any hole?

Oleg.

