Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FE62082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FE62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJZDbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:31:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57016 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:31:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gFkog-0007Kf-M3; Thu, 25 Oct 2018 12:57:10 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gFkoQ-0004t8-N6; Thu, 25 Oct 2018 12:57:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     bmgordon@google.com
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
References: <20181017224738.193598-1-bmgordon@google.com>
Date:   Thu, 25 Oct 2018 13:56:27 -0500
In-Reply-To: <20181017224738.193598-1-bmgordon@google.com>
        (bmgordon@google.com's message of "Wed, 17 Oct 2018 16:47:38 -0600")
Message-ID: <87in1pn9d0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gFkoQ-0004t8-N6;;;mid=<87in1pn9d0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MLkmM19+AxlyqAYGafXv7HeI30Iaa6MA=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: use ns_capable instead of capable for timerslack_ns
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bmgordon@google.com writes:

> From: Benjamin Gordon <bmgordon@google.com>
>
> Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
> in its effective capability set, but the current check looks in the root
> namespace instead of the process' user namespace.  Since a process is
> allowed to do other activities controlled by CAP_SYS_NICE inside a
> namespace, it should also be able to adjust timerslack_ns.

The goal seems legitimate.  However the permission checks look wrong.

In particular the choice of user namespace should be
"p->cred->user_ns".  This will limit this to tasks that have
CAP_SYS_NICE in the same namespace as the task that is being modified.

Testing file->f_cred->user_ns it is testing whoever opened the file and
that could be anyone.

Eric


> Signed-off-by: Benjamin Gordon <bmgordon@google.com>
> Cc: John Stultz <john.stultz@linaro.org>
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
>  fs/proc/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7e9f07bf260d..4b50937dff80 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2356,7 +2356,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>  		return -ESRCH;
>  
>  	if (p != current) {
> -		if (!capable(CAP_SYS_NICE)) {
> +		if (!ns_capable(file->f_cred->user_ns, CAP_SYS_NICE)) {
>  			count = -EPERM;
>  			goto out;
>  		}
> @@ -2393,7 +2393,7 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
>  
>  	if (p != current) {
>  
> -		if (!capable(CAP_SYS_NICE)) {
> +		if (!ns_capable(seq_user_ns(m), CAP_SYS_NICE)) {
>  			err = -EPERM;
>  			goto out;
>  		}
