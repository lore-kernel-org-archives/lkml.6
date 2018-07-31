Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24CFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698A220685
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698A220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeGaRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:54:02 -0400
Received: from nov-007-i652.relay.mailchannels.net ([46.232.183.206]:4810 "EHLO
        nov-007-i652.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727569AbeGaRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:54:02 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B7BD51B60371;
        Tue, 31 Jul 2018 16:12:56 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-2.mailchannels.ch [46.232.183.6])
        by relay.mailchannels.net (Postfix) with ESMTPA id 5EAA61B60349;
        Tue, 31 Jul 2018 16:12:53 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Tue, 31 Jul 2018 16:12:56 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Fearful-Name: 0dcebefa16f09016_1533053576195_3138394660
X-MC-Loop-Signature: 1533053576195:3064311778
X-MC-Ingress-Time: 1533053576195
Received: from [80.219.231.201] (port=50824 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1fkXGT-00As6o-3W; Tue, 31 Jul 2018 18:12:49 +0200
Message-ID: <f21a22c9730ab455504f58a5fbda72cba0eb1227.camel@bitron.ch>
Subject: Re: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Jul 2018 18:12:48 +0200
In-Reply-To: <20180731143949.GA1890@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
         <20180731070337.61004-1-j@bitron.ch> <20180731143949.GA1890@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 16:39 +0200, Oleg Nesterov wrote:
> On 07/31, Jürg Billeter wrote:
> > SIGINT, SIGQUIT and SIGTSTP are used in job control for ^C, ^\, ^Z.
> > While a task with the SIGNAL_UNKILLABLE flag could install handlers for
> > these signals, this is not sufficient to implement a shell that uses
> > CLONE_NEWPID for child processes:
> 
> Ah. My question wasn't clear, sorry.
> 
> Could you explain your use-case? Why a shell wants to use
> CLONE_NEWPID?

To guarantee that there won't be any runaway processes, i.e., ensure
that no descendants (background helper daemons or misbehaving
processes) survive when the child process is terminated. And to prevent
children from killing their ancestors. This is not something that can
be always-on in all shells, but it could be an option for users that
want this control/isolation.

> And what do we actually want in, say, ^Z case? Just stop the child reaper
> or may be it would be better to stop the whole pid namespace?

Stopping the whole PID namespace would be interesting, however, I think
this should be discussed separately if and when there is a proposal to
support this. For now the process group is stopped, same as without PID
namespaces.

> >  * As SIGSTOP is ignored when raised from the SIGNAL_UNKILLABLE process
> >    itself, it's not possible to implement the stop action in a custom
> >    SIGTSTP handler.
> 
> Yes. So may be we actually want to change __isig() paths to use
> SEND_SIG_FORCED (this is not that simple), or perhaps we can change
> __send_signal() to not drop SIGSTOP sent to itself, or may be we can even
> introduce SIG_DFL_EVEN_IF_INIT, I dunno.

In my opinion, my patch is much simpler and also more general as it
covers all scenarios where regular signal handling is required or
desired for "init" processes, with minimal code changes (after
PR_SET_KILLABLE, binaries that expect SIG_DFL to work can be executed
without changes).

> >  * Many applications do not install handlers for these signals and
> >    thus, job control won't work properly with unmodified applications.
> 
> I can't understand this. An application should be changed anyway to do
> PR_SET_KILLABLE?

PR_SET_KILLABLE can be called (e.g., by the shell) between clone() and
execve(). (Some applications may have issues running as subreaper but
that's a separate matter, signal handling will work as expected).

> > +	case PR_SET_KILLABLE:
> > +		if (arg2 != 1 || arg3 || arg4 || arg5)
> > +			return -EINVAL;
> > +		spin_lock_irq(&me->sighand->siglock);
> > +		me->signal->flags &= ~SIGNAL_UNKILLABLE;
> > +		spin_unlock_irq(&me->sighand->siglock);
> 
> OK, but then you need to change the CLONE_PARENT/SIGNAL_UNKILLABLE check
> in copy_process().

Good point, need a different check for the PID namespace root process
in copy_process().

Thanks,
Jürg

