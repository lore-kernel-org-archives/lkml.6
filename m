Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EF5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2422081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2422081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeKAXv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbeKAXv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB2E958E35;
        Thu,  1 Nov 2018 14:48:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D85E60C47;
        Thu,  1 Nov 2018 14:48:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Nov 2018 15:48:08 +0100 (CET)
Date:   Thu, 1 Nov 2018 15:48:05 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181101144804.GD23232@redhat.com>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030143235.GA3385@redhat.com>
 <20181030153231.GB7343@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030153231.GB7343@cisco>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 01 Nov 2018 14:48:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Tycho Andersen wrote:
>
> > I am not sure I understand the value of signaled/SECCOMP_NOTIF_FLAG_SIGNALED...
> > I mean, why it is actually useful?
> >
> > Sorry if this was already discussed.
>
> :) no problem, many people have complained about this. This is an
> implementation of Andy's suggestion here:
> https://lkml.org/lkml/2018/3/15/1122
>
> You can see some more detailed discussion here:
> https://lkml.org/lkml/2018/9/21/138

Cough, sorry, I simply can't understand what are you talking about ;)
It seems that I need to read all the previous emails... So let me ask
a stupid question below.

> > But my main concern is that either way wait_for_completion_killable() allows
> > to trivially create a process which doesn't react to SIGSTOP, not good...
> >
> > Note also that this can happen if, say, both the tracer and tracee run in the
> > same process group and SIGSTOP is sent to their pgid, if the tracer gets the
> > signal first the tracee won't stop.
> >
> > Of freezer. try_to_freeze_tasks() can fail if it freezes the tracer before
> > it does SECCOMP_IOCTL_NOTIF_SEND.
>
> I think in general the way this is intended to be used these things
> wouldn't happen.

Why?

> was malicious and had the ability to create a user namespace to
> exhaust pids this way,

Not sure I understand how this connects to my question... nevermind.

> so perhaps we should drop this part of the
> patch. I have no real need for it, but perhaps Andy can elaborate?

Yes I think it would be nice to avoid wait_for_completion_killable().

So please help me to understand the problem. Once again, why can not
seccomp_do_user_notification() use wait_for_completion_interruptible() only?

This is called before the task actually starts the syscall, so
-ERESTARTNOINTR if signal_pending() can't hurt.

Now lets suppose seccomp_do_user_notification() simply does

	err = wait_for_completion_interruptible(&n.ready);

	if (err < 0 && state != SECCOMP_NOTIFY_REPLIED) {
		syscall_set_return_value(ERESTARTNOINTR);
		list_del(&n.list);
		return -1;
	}

(I am ignoring the locking/etc). Now the obvious problem is that the listener
doing SECCOMP_IOCTL_NOTIF_SEND can't distinguish -ENOENT from the case when the
tracee was killed, yes?

Is it that important?

Any other problem?

Oleg.

