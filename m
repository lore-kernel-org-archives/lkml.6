Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A612C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1772173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1772173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeHCMLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:11:08 -0400
Received: from nov-007-i675.relay.mailchannels.net ([46.232.183.229]:23155
        "EHLO nov-007-i675.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732090AbeHCMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:11:08 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CC39E1B60411;
        Fri,  3 Aug 2018 10:15:24 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-1.mailchannels.ch [46.232.183.5])
        by relay.mailchannels.net (Postfix) with ESMTPA id 86ABE1B6039D;
        Fri,  3 Aug 2018 10:15:21 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Fri, 03 Aug 2018 10:15:24 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Unite-Turn: 622c6a3e74f4adb0_1533291324304_4291667174
X-MC-Loop-Signature: 1533291324304:1926333980
X-MC-Ingress-Time: 1533291324303
Received: from [80.219.231.201] (port=48010 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1flX76-003WpO-On; Fri, 03 Aug 2018 12:15:16 +0200
Message-ID: <7f7c57230e0279f4599bf13ae1d1d449d76ac232.camel@bitron.ch>
Subject: Re: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 12:15:16 +0200
In-Reply-To: <20180801141914.GA21248@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
         <20180731070337.61004-1-j@bitron.ch> <20180731143949.GA1890@redhat.com>
         <f21a22c9730ab455504f58a5fbda72cba0eb1227.camel@bitron.ch>
         <20180801141914.GA21248@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 16:19 +0200, Oleg Nesterov wrote:
> On 07/31, Jürg Billeter wrote:
> > 
> > > Could you explain your use-case? Why a shell wants to use
> > > CLONE_NEWPID?
> > 
> > To guarantee that there won't be any runaway processes, i.e., ensure
> > that no descendants (background helper daemons or misbehaving
> > processes) survive when the child process is terminated.
> 
> We already have PR_SET_CHILD_SUBREAPER.
> 
> Perhaps we can finally add PR_KILL_MY_DESCENDANTS_ON_EXIT? This was already
> discussed some time ago, but I can't find the previous discussion... Simple
> to implement.

This would definitely be an option. You mentioned it last October in
the PR_SET_PDEATHSIG_PROC discussion¹. However, as PID namespaces
already exist and appear to be a good fit for the most part, I think it
makes sense to just add the missing pieces to PID namespaces instead of
duplicating part of the PID namespace functionality.

Also, based on Eric's comment in that other discussion about
no_new_privs not being allowed to increase the attack surface,
PR_KILL_MY_DESCENDANTS_ON_EXIT might require CAP_SYS_ADMIN as well (due
to setuid children). In which case the only potential benefit would be
that it still allows the child to kill arbitrary processes, as far as I
can tell.

> > And to prevent children from killing their ancestors.
> 
> OK, this is the only reason for CLONE_NEWPID which I can understand so far.
> Not that I understand why this is that useful ;)

The overall goal is increasing isolation between (some) child processes
and the rest of the system. Isolation from runaway processes and
isolation from signals are independent aspects and it could be useful
to control them independently. However, I also expect it to be common
that both are wanted at the same time.

Jürg

¹ https://lkml.org/lkml/2017/10/5/546

