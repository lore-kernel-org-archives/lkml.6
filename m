Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A9C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3462064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3462064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeJ3X0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11729 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbeJ3X0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E96773002C72;
        Tue, 30 Oct 2018 14:32:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 398D167C6E;
        Tue, 30 Oct 2018 14:32:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Oct 2018 15:32:39 +0100 (CET)
Date:   Tue, 30 Oct 2018 15:32:36 +0100
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
Message-ID: <20181030143235.GA3385@redhat.com>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029224031.29809-2-tycho@tycho.ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 30 Oct 2018 14:32:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Tycho Andersen wrote:
>
> +	/* This is where we wait for a reply from userspace. */
> +	err = wait_for_completion_interruptible(&n.ready);
> +	mutex_lock(&match->notify_lock);
> +
> +	/*
> +	 * If the noticiation fd died before we re-acquired the lock, we still
> +	 * give -ENOSYS.
> +	 */
> +	if (!match->notif)
> +		goto remove_list;
> +
> +	/*
> +	 * Here it's possible we got a signal and then had to wait on the mutex
> +	 * while the reply was sent, so let's be sure there wasn't a response
> +	 * in the meantime.
> +	 */
> +	if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> +		/*
> +		 * We got a signal. Let's tell userspace about it (potentially
> +		 * again, if we had already notified them about the first one).
> +		 */
> +		n.signaled = true;
> +		if (n.state == SECCOMP_NOTIFY_SENT) {
> +			n.state = SECCOMP_NOTIFY_INIT;
> +			up(&match->notif->request);
> +		}

I am not sure I understand the value of signaled/SECCOMP_NOTIF_FLAG_SIGNALED...
I mean, why it is actually useful?

Sorry if this was already discussed.

> +		wake_up_poll(&match->notif->wqh, EPOLLIN | EPOLLRDNORM);
> +
> +		mutex_unlock(&match->notify_lock);
> +		err = wait_for_completion_killable(&n.ready);
> +		mutex_lock(&match->notify_lock);

And it seems that SECCOMP_NOTIF_FLAG_SIGNALED is the only reason why
seccomp_do_user_notification() doesn't do wait_for_completion_killable() from
the very beginning.

But my main concern is that either way wait_for_completion_killable() allows
to trivially create a process which doesn't react to SIGSTOP, not good...

Note also that this can happen if, say, both the tracer and tracee run in the
same process group and SIGSTOP is sent to their pgid, if the tracer gets the
signal first the tracee won't stop.

Of freezer. try_to_freeze_tasks() can fail if it freezes the tracer before
it does SECCOMP_IOCTL_NOTIF_SEND.

Oleg.

