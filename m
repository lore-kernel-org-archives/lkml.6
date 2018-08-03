Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DE821757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DE821757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbeHCQgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:36:04 -0400
Received: from nov-007-i649.relay.mailchannels.net ([46.232.183.203]:28448
        "EHLO nov-007-i649.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732271AbeHCQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:36:03 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 55DECBE04F1;
        Fri,  3 Aug 2018 14:39:21 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-3.mailchannels.ch [46.232.178.210])
        by relay.mailchannels.net (Postfix) with ESMTPA id F297FBE031A;
        Fri,  3 Aug 2018 14:39:17 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Fri, 03 Aug 2018 14:39:21 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Macabre-Cooing: 443225050d1d9cce_1533307160937_2055385670
X-MC-Loop-Signature: 1533307160937:260901966
X-MC-Ingress-Time: 1533307160936
Received: from [80.219.231.201] (port=55852 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1flbEZ-004Dx7-FU; Fri, 03 Aug 2018 16:39:15 +0200
Message-ID: <548ab0d300c6b9839ad645655182d0ba26607d47.camel@bitron.ch>
Subject: Re: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 16:39:14 +0200
In-Reply-To: <87sh3vd14s.fsf@xmission.com>
References: <20180730075241.24002-1-j@bitron.ch>
         <20180731070337.61004-1-j@bitron.ch> <20180731143949.GA1890@redhat.com>
         <f21a22c9730ab455504f58a5fbda72cba0eb1227.camel@bitron.ch>
         <20180801141914.GA21248@redhat.com>
         <7f7c57230e0279f4599bf13ae1d1d449d76ac232.camel@bitron.ch>
         <87sh3vd14s.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 08:34 -0500, Eric W. Biederman wrote:
> From the other direction I think we can just go ahead and fix handling
> of the job control stop signals as well.  As far as I understand it
> there is a legitimate complaint that SIGTSTP SIGTTIN SIGTTOU do not work
> on a pid namespace leader.
> 
> The current implementation actual overshoots.  We only need to ignore
> signals from the descendants in the pid namespace.  Ideally signals from
> other processes are treated like normal.  We have only been able to
> apply that ideal to SIGSTOP and SIGKILL as we can handle them in
> prepare_signal.  Other signals can be blocked which means the logic to
> handle them needs to live in get_signal where we may have no sender
> information.

SIGINT and SIGQUIT are also relevant for job control. Would the same
approach be possible for them?

And I would like to allow regular POSIX signal behavior also for
signals used outside job control, e.g., SIGTERM, for maximum
compatibility with existing applications. Furthermore, it would also be
good to allow a PID namespace leader to send a signal to itself.

Do you think we can and should cover all of the above without a prctl
by loosening the restrictions imposed by SIGNAL_UNKILLABLE (with
reasonable effort)?

In my opinion, my patch still makes sense as it simply allows regular
POSIX signal behavior for PID namespace leaders and it doesn't risk any
compatibility issues as the behavior doesn't change at all for
processes that don't invoke the new prctl. I.e., simple patch, low
risk, and covers all signals.

In the meantime I've tested the missing patch for copy_process() and
will send out v3 of the patch in case the new prctl makes sense after
all.

Jürg

