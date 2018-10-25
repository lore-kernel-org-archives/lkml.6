Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B32082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4B32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJYUtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:49:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeJYUto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DA5E30C0F24;
        Thu, 25 Oct 2018 12:17:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id ABA2F662DA;
        Thu, 25 Oct 2018 12:17:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Oct 2018 14:17:11 +0200 (CEST)
Date:   Thu, 25 Oct 2018 14:17:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181025121709.GD3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 25 Oct 2018 12:17:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Tetsuo Handa wrote:
>
> On 2018/10/25 20:13, Oleg Nesterov wrote:
> >
> > So again, suppose that "child" is already dead. Its task_struct can't be freed,
> > but child->real_parent can point to the already freed memory.
>
> Yes.
>
> But if child->real_parent is pointing to the already freed memory,
> why does pid_alive(child) == true help?

Hmm. Because pid_alive(child) == true && child->real_parent is freed must not
be possible? As long as we check pid_alive() under rcu_read_lock().

> >> @@ -283,6 +283,11 @@ static int task_is_descendant(struct task_struct *parent,
> >>  		return 0;
> >>
> >>  	rcu_read_lock();
> >> +	if (!pid_alive(parent) || !pid_alive(walker)) {
> >> +		rcu_read_unlock();
> >> +		printk("parent or walker is dead.\n");
> >
> > This is what we need to do, except I think we should change yama_ptrace_access_check().
> > And iiuc parent == current, pid_alive(parent) looks unnecessary. Although we need to
> > check ptracer_exception_found(), may be it needs some changes too.
>
> There are two task_is_descendant() callers, and one of them is not passing current.

As I said below, please ignore ptracer_exception_found(), another caller for now,
perhaps it needs some changes too. I even have a vague feeling that I have already
blamed this function some time ago...

> > And yes, task_is_descendant() can hit the dead child, if nothing else it can
> > be killed. This can explain the kasan report.
>
> The kasan is reporting that child->real_parent (or maybe child->real_parent->real_parent
> or child->real_parent->real_parent->real_parent ...) was pointing to already freed memory,
> isn't it?

Yes. and you know, I am all confused. I no longer can understand you :/

> How can we check that that pointer is pointing to already freed memory? As soon as
>
>   walker = rcu_dereference(walker->real_parent);
>
> is executed, task_alive(walker) will try to read from already freed memory...

Of course we should not do it this way. The patch I sent doesn't...

Oleg.

