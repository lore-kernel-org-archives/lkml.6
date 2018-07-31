Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98972C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EA1208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EA1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeGaQUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732361AbeGaQUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:20:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AA588198B06;
        Tue, 31 Jul 2018 14:39:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 166701C4C3;
        Tue, 31 Jul 2018 14:39:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 31 Jul 2018 16:39:52 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:39:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
Message-ID: <20180731143949.GA1890@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
 <20180731070337.61004-1-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180731070337.61004-1-j@bitron.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 14:39:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 14:39:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Jürg Billeter wrote:
>
> PR_SET_KILLABLE clears the SIGNAL_UNKILLABLE flag. This allows
> CLONE_NEWPID tasks to restore normal signal behavior, opting out of the
> special signal protection for init processes. This prctl does not allow
> setting the SIGNAL_UNKILLABLE flag, only clearing.
>
> The SIGNAL_UNKILLABLE flag, which is implicitly set for tasks cloned
> with CLONE_NEWPID, has the effect of ignoring all signals (from
> userspace) if the corresponding handler is set to SIG_DFL. The only
> exceptions are SIGKILL and SIGSTOP and they are only accepted if raised
> from an ancestor namespace.
>
> SIGINT, SIGQUIT and SIGTSTP are used in job control for ^C, ^\, ^Z.
> While a task with the SIGNAL_UNKILLABLE flag could install handlers for
> these signals, this is not sufficient to implement a shell that uses
> CLONE_NEWPID for child processes:

Ah. My question wasn't clear, sorry.

Could you explain your use-case? Why a shell wants to use CLONE_NEWPID?
And what do we actually want in, say, ^Z case? Just stop the child reaper
or may be it would be better to stop the whole pid namespace?

>  * As SIGSTOP is ignored when raised from the SIGNAL_UNKILLABLE process
>    itself, it's not possible to implement the stop action in a custom
>    SIGTSTP handler.

Yes. So may be we actually want to change __isig() paths to use
SEND_SIG_FORCED (this is not that simple), or perhaps we can change
__send_signal() to not drop SIGSTOP sent to itself, or may be we can even
introduce SIG_DFL_EVEN_IF_INIT, I dunno.

>  * Many applications do not install handlers for these signals and
>    thus, job control won't work properly with unmodified applications.

I can't understand this. An application should be changed anyway to do
PR_SET_KILLABLE?


Let me clarify. I am not arguing with this patch, probably it makes sense in
any case. I am just trying to understand your real motivation for this change.



> +	case PR_SET_KILLABLE:
> +		if (arg2 != 1 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		spin_lock_irq(&me->sighand->siglock);
> +		me->signal->flags &= ~SIGNAL_UNKILLABLE;
> +		spin_unlock_irq(&me->sighand->siglock);

OK, but then you need to change the CLONE_PARENT/SIGNAL_UNKILLABLE check
in copy_process().

Oleg.

