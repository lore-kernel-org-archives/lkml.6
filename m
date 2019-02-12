Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3DE21855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfBLBC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:02:26 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55881 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfBLBCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:02:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtMSs-0007Sg-Pn; Mon, 11 Feb 2019 18:02:22 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtMSh-0005SX-Nm; Mon, 11 Feb 2019 18:02:22 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oren Laadan <orenl@cellrox.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Rom Lemarchand <romlem@android.com>,
        Todd Kjos <tkjos@google.com>, Colin Cross <ccross@android.com>,
        Nick Kralevich <nnk@google.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Elliott Hughes <enh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <20190211141846.543045703@linuxfoundation.org>
        <20190211141904.885459037@linuxfoundation.org>
Date:   Mon, 11 Feb 2019 19:02:06 -0600
In-Reply-To: <20190211141904.885459037@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Mon, 11 Feb 2019 15:18:29 +0100")
Message-ID: <87tvh9es4x.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gtMSh-0005SX-Nm;;;mid=<87tvh9es4x.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184pEWpyPE07UBzc04qKB3dbVw1qNDY/LI=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4.20 282/352] fs/proc/base.c: use ns_capable instead of capable for timerslack_ns
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> 4.20-stable review patch.  If anyone has any objections, please let me
> know.

No objection.  But I think of this as a feature addition rather than a
fix for something.  As a feature that we now allow something we
previously did not does this qualify for a backport to stable?

It is probably no more harmful in this instance than adding PCI IDs to a
driver.  So I am not worried.  I am curious the current guidelines
are.

In most cases a small relaxation of permissions like this requires a lot
of bug fixing as typically code protected by capable(CAP_XXX) has been
written and tested assuming a trusted root user.  Those bug fixes are
many times too large for a stable backport.

Eric


> ------------------
>
> [ Upstream commit 8da0b4f692c6d90b09c91f271517db746a22ff67 ]
>
> Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
> in its effective capability set, but the current check looks in the root
> namespace instead of the process' user namespace.  Since a process is
> allowed to do other activities controlled by CAP_SYS_NICE inside a
> namespace, it should also be able to adjust timerslack_ns.
>
> Link: http://lkml.kernel.org/r/20181030180012.232896-1-bmgordon@google.com
> Signed-off-by: Benjamin Gordon <bmgordon@google.com>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Oren Laadan <orenl@cellrox.com>
> Cc: Ruchi Kandoi <kandoiruchi@google.com>
> Cc: Rom Lemarchand <romlem@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Nick Kralevich <nnk@google.com>
> Cc: Dmitry Shmidt <dimitrysh@google.com>
> Cc: Elliott Hughes <enh@google.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/proc/base.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ce3465479447..98525af0953e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2356,10 +2356,13 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>  		return -ESRCH;
>  
>  	if (p != current) {
> -		if (!capable(CAP_SYS_NICE)) {
> +		rcu_read_lock();
> +		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
> +			rcu_read_unlock();
>  			count = -EPERM;
>  			goto out;
>  		}
> +		rcu_read_unlock();
>  
>  		err = security_task_setscheduler(p);
>  		if (err) {
> @@ -2392,11 +2395,14 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
>  		return -ESRCH;
>  
>  	if (p != current) {
> -
> -		if (!capable(CAP_SYS_NICE)) {
> +		rcu_read_lock();
> +		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
> +			rcu_read_unlock();
>  			err = -EPERM;
>  			goto out;
>  		}
> +		rcu_read_unlock();
> +
>  		err = security_task_getscheduler(p);
>  		if (err)
>  			goto out;
