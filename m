Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025CD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025CD20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbeHAJ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:28:29 -0400
Received: from nov-007-i652.relay.mailchannels.net ([46.232.183.206]:60756
        "EHLO nov-007-i652.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729769AbeHAJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:28:29 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 59E17BE03E9;
        Wed,  1 Aug 2018 07:44:03 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id A1E04BE03CF;
        Wed,  1 Aug 2018 07:44:00 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Wed, 01 Aug 2018 07:44:03 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Name-Power: 4553995a4b0cfa02_1533109443004_2258524725
X-MC-Loop-Signature: 1533109443004:3758119433
X-MC-Ingress-Time: 1533109443003
Received: from [80.219.231.201] (port=57984 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1fklnZ-00D6Aq-Sc; Wed, 01 Aug 2018 09:43:58 +0200
Message-ID: <625ede00c618783eb610b7109c35c514e8faa793.camel@bitron.ch>
Subject: Re: [PATCH] prctl: add PR_[GS]ET_KILLABLE
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Aug 2018 09:43:57 +0200
In-Reply-To: <CAG48ez1izZ+W_cPdNp3SOUwb_8YzwAYdSA6d=eqvaF=5+GKemA@mail.gmail.com>
References: <20180730075241.24002-1-j@bitron.ch>
         <CAG48ez1izZ+W_cPdNp3SOUwb_8YzwAYdSA6d=eqvaF=5+GKemA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 18:26 +0200, Jann Horn wrote:
> On Mon, Jul 30, 2018 at 10:01 AM Jürg Billeter <j@bitron.ch> wrote:
> 
> [...]
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 38509dc1f77b..264de630d548 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> 
> [...]
> > +       case PR_SET_KILLABLE:
> > +               if (arg2 != 1 || arg3 || arg4 || arg5)
> > +                       return -EINVAL;
> > +               me->signal->flags &= ~SIGNAL_UNKILLABLE;
> > +               break;
> 
> I don't have an opinion on this patchset otherwise, but should this
> prctl maybe block PR_SET_KILLABLE if you're actually the real init
> process? This seems like it could potentially lead to weird things.

While I don't expect global init to use this, I can't think of a good
reason to disallow it in the kernel. Do you have specific concerns or
is the code in kernel/fork.c the only reason? I prefer avoiding special
cases unless really required.

> This code in kernel/fork.c seems to rely on the fact that global init
> is SIGNAL_UNKILLABLE, and probably also leads to weirdness if
> container init is non-SIGNAL_UNKILLABLE:

Yes, Oleg has mentioned this as well. I have to change copy_process()
to directly check for the PID namespace root process instead of
checking for SIGNAL_UNKILLABLE.

Jürg

