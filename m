Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CFDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A4C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A4C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJaN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:28:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46628 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeJaN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:28:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHiAl-0001kE-V5; Tue, 30 Oct 2018 22:32:04 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHiAW-0006kW-I9; Tue, 30 Oct 2018 22:32:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Benjamin Gordon <bmgordon@google.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
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
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181030180012.232896-1-bmgordon@google.com>
Date:   Tue, 30 Oct 2018 23:31:17 -0500
In-Reply-To: <20181030180012.232896-1-bmgordon@google.com> (Benjamin Gordon's
        message of "Tue, 30 Oct 2018 12:00:12 -0600")
Message-ID: <87y3ae3ffu.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHiAW-0006kW-I9;;;mid=<87y3ae3ffu.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4JIihgB9+80b69+yX48H/Q9tFdH44Cgk=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] proc: use ns_capable instead of capable for timerslack_ns
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Gordon <bmgordon@google.com> writes:

> Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
> in its effective capability set, but the current check looks in the root
> namespace instead of the process' user namespace.  Since a process is
> allowed to do other activities controlled by CAP_SYS_NICE inside a
> namespace, it should also be able to adjust timerslack_ns.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I don't see any fundamental probess with how the processes user
namespace is being accessed.   You can race with setns
and that may result in a descendent user namespace of the current
user namespace being set.  But if you have permissions in the parent
user namespace you will have permissions over a child user namespace.
So the race can't effect the outcome of the ns_capable test.

That and while __task_cred(p) may change it is guaranteed there is a
valid one until __put_task_struct which only happens when a process has
a zero refcount.  Which the success of get_proc_task in before these
checks already ensures is not true.

So from my perspective this looks like a reasonable change.

I don't know how this looks from people who understand the timer bits
and what timerslack does. I suspect it is reasonable as there is no
permission check for changing yourself.

Eric

> Signed-off-by: Benjamin Gordon <bmgordon@google.com>
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
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> Changes from v1:
>   - Use the namespace of the target process instead of the file opener.
>     Didn't carry over John Stultz' Acked-by since the changes aren't
>     cosmetic.
>
>  fs/proc/base.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c78d8da09b52c..bdc093ba81dd3 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2385,10 +2385,13 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
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
> @@ -2421,11 +2424,14 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
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
