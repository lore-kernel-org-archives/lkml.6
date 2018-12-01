Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A34C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE2320868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE2320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeLAVvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:51:53 -0500
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:31631
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbeLAVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:51:53 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4CF352EC0004;
        Sat,  1 Dec 2018 10:39:35 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id A613B2EC001D;
        Sat,  1 Dec 2018 10:39:31 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Sat, 01 Dec 2018 10:39:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Lyrical-Scare: 3b72dba2193a9c0c_1543660775061_736159515
X-MC-Loop-Signature: 1543660775061:341173792
X-MC-Ingress-Time: 1543660775060
Received: from [88.98.246.21] (port=58586 helo=jx1y.mynet)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gT2gL-007tIe-Dy; Sat, 01 Dec 2018 11:39:29 +0100
Message-ID: <e92ab3c06fe42fc9872261999623be19e2b0a294.camel@bitron.ch>
Subject: Re: [PATCH v2 1/1] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 01 Dec 2018 10:39:28 +0000
In-Reply-To: <87bm66u1j5.fsf@oldenburg.str.redhat.com>
References: <20181127225408.7553-2-j@bitron.ch>
         <20181130080004.23635-1-j@bitron.ch> <20181130080004.23635-2-j@bitron.ch>
         <87bm66u1j5.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 14:40 +0100, Florian Weimer wrote:
> * Jürg Billeter:
> 
> > This introduces a new thread group flag that can be set by calling
> > 
> >     prctl(PR_SET_KILL_DESCENDANTS_ON_EXIT, 1, 0, 0, 0)
> > 
> > When a thread group exits with this flag set, it will send SIGKILL to
> > all descendant processes.  This can be used to prevent stray child
> > processes.
> > 
> > This flag is cleared on privilege gaining execve(2) to ensure an
> > unprivileged process cannot get a privileged process to send SIGKILL.
> 
> So this is inherited across regular execve?  I'm not sure that's a good
> idea.

Yes, this matches PR_SET_CHILD_SUBREAPER (and other process
attributes). Besides consistency and allowing a parent to configure the
flag for a spawned process, this is also needed to prevent a process
from clearing the flag (in combination with a seccomp filter).

> 
> > Descendants that are orphaned and reparented to an ancestor of the
> > current process before the current process exits, will not be killed.
> > PR_SET_CHILD_SUBREAPER can be used to contain orphaned processes.
> 
> For double- or triple-forking daemons, the reparenting will be racy, if
> I understand things correctly.

Can you please elaborate, if you're concerned about a particular race?
As the commit message mentions, for containment this flag can be
combined with PR_SET_CHILD_SUBREAPER (and PR_SET_NO_NEW_PRIVS).

Jürg

