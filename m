Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136BEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF32186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfBFSIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:08:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFSH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:07:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DDD210F9F;
        Wed,  6 Feb 2019 18:07:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2295F166A4;
        Wed,  6 Feb 2019 18:07:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 Feb 2019 19:07:59 +0100 (CET)
Date:   Wed, 6 Feb 2019 19:07:54 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [RFC][PATCH] signal: Store pending signal exit in tsk.jobctl not
 in tsk.pending
Message-ID: <20190206180754.GA23476@redhat.com>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
 <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
 <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
 <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
 <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
 <8736p37xcn.fsf@xmission.com>
 <878syu7tcm.fsf@xmission.com>
 <87tvhi4vl7.fsf@xmission.com>
 <87o97q1cky.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o97q1cky.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 06 Feb 2019 18:07:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, at al,

Sorry, I am on on vacation, can't even read this thread right now,
so I am not sure I understand the problem correctly...

On 02/05, Eric W. Biederman wrote:
>
> @@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
>  		goto relock;
>  	}
>
> +	/* Has this task already been flagged for death? */
> +	ksig->info.si_signo = signr = SIGKILL;
> +	if (current->jobctl & JOBCTL_TASK_EXIT)
> +		goto fatal;
> +

Can't we simply change, say, next_signal() to return SIGKILL if it is
pending?

In any case, I am not sure we need JOBCTL_TASK_EXIT. Can't we rely on
signal_group_exit() ?

Oleg.

