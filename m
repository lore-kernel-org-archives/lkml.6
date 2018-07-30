Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77990C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2716120892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2716120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeG3VJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:09:34 -0400
Received: from nov-007-i652.relay.mailchannels.net ([46.232.183.206]:5600 "EHLO
        nov-007-i652.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731899AbeG3VJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:09:34 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 34A3FBE0326;
        Mon, 30 Jul 2018 19:33:00 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id CBB25BE031E;
        Mon, 30 Jul 2018 19:32:57 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Mon, 30 Jul 2018 19:33:00 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Wide-Eyed-Industry: 7291e95269f8c503_1532979179860_919390253
X-MC-Loop-Signature: 1532979179860:2635747998
X-MC-Ingress-Time: 1532979179859
Received: from [80.219.231.201] (port=49106 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1fkDuZ-007Y8q-5J; Mon, 30 Jul 2018 21:32:55 +0200
Message-ID: <922baeb3d6d6387c480026fc3a6ca01d915f60a5.camel@bitron.ch>
Subject: Re: [PATCH] prctl: add PR_[GS]ET_KILLABLE
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Jul 2018 21:32:54 +0200
In-Reply-To: <20180730101659.GA24781@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
         <20180730101659.GA24781@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 12:17 +0200, Oleg Nesterov wrote:
> On 07/30, Jürg Billeter wrote:
> > 
> > This is required for job control in a shell that uses CLONE_NEWPID for
> > child processes.
> 
> Could you explain in more details?

The SIGNAL_UNKILLABLE flag, which is implicitly set for tasks cloned
with CLONE_NEWPID, has the effect of ignoring all signals (from
userspace) if the corresponding handler is set to SIG_DFL. The only
exceptions are SIGKILL and SIGSTOP and they are only accepted if raised
from an ancestor namespace.

SIGINT, SIGQUIT and SIGTSTP are used in job control for ^C, ^\, ^Z.
While a task with the SIGNAL_UNKILLABLE flag could install handlers for
these signals, this is not sufficient to implement a shell that uses
CLONE_NEWPID for child processes:

 * As SIGSTOP is ignored when raised from the SIGNAL_UNKILLABLE process
   itself, I don't think it's possible to implement the stop action in
   a custom SIGTSTP handler.
 * Many applications do not install handlers for these signals and
   thus, job control won't work properly with unmodified applications.

Job control in a shell is just an example. There are other scenarios,
of course, where applications rely on the default actions as described
in signal(7), and PID isolation may be useful. In my opinion, the
kernel support for preventing accidental killing of the "init" process
should really be optional and this new prctl provides this without
breaking backward compatibility.

> > +	case PR_SET_KILLABLE:
> > +		if (arg2 != 1 || arg3 || arg4 || arg5)
> > +			return -EINVAL;
> > +		me->signal->flags &= ~SIGNAL_UNKILLABLE;
> 
> this needs spin_lock_irq(me->sighand->siglock).

Thanks for the review, will fix this for v2.

Jürg

