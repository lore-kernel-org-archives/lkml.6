Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB39C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6AA2147C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6AA2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeLBBKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:10:43 -0500
Received: from nov-007-i648.relay.mailchannels.net ([46.232.183.202]:48840
        "EHLO nov-007-i648.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbeLBBKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:10:43 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 913F12EC0003;
        Sat,  1 Dec 2018 13:58:04 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id A80432EC002F;
        Sat,  1 Dec 2018 13:58:00 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Sat, 01 Dec 2018 13:58:04 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Hook-Occur: 7c8ba3a21a3d823a_1543672684378_1746381404
X-MC-Loop-Signature: 1543672684377:208710795
X-MC-Ingress-Time: 1543672684377
Received: from [178.197.234.15] (port=21001 helo=jx1y)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gT5mO-008f0W-JC; Sat, 01 Dec 2018 14:57:56 +0100
Message-ID: <5aebc712634afda1eaad820f2e4f330689b287ea.camel@bitron.ch>
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
Date:   Sat, 01 Dec 2018 14:57:54 +0100
In-Reply-To: <878t19o2h6.fsf@oldenburg.str.redhat.com>
References: <20181127225408.7553-2-j@bitron.ch>
         <20181130080004.23635-1-j@bitron.ch> <20181130080004.23635-2-j@bitron.ch>
         <87bm66u1j5.fsf@oldenburg.str.redhat.com>
         <e92ab3c06fe42fc9872261999623be19e2b0a294.camel@bitron.ch>
         <878t19o2h6.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-01 at 13:28 +0100, Florian Weimer wrote:
> * Jürg Billeter:
> 
> > On Fri, 2018-11-30 at 14:40 +0100, Florian Weimer wrote:
> > > * Jürg Billeter:
> > > 
> > > > This introduces a new thread group flag that can be set by calling
> > > > 
> > > >     prctl(PR_SET_KILL_DESCENDANTS_ON_EXIT, 1, 0, 0, 0)
> > > > 
> > > > When a thread group exits with this flag set, it will send SIGKILL to
> > > > all descendant processes.  This can be used to prevent stray child
> > > > processes.
> > > > 
> > > > This flag is cleared on privilege gaining execve(2) to ensure an
> > > > unprivileged process cannot get a privileged process to send SIGKILL.
> > > 
> > > So this is inherited across regular execve?  I'm not sure that's a good
> > > idea.
> > 
> > Yes, this matches PR_SET_CHILD_SUBREAPER (and other process
> > attributes). Besides consistency and allowing a parent to configure the
> > flag for a spawned process, this is also needed to prevent a process
> > from clearing the flag (in combination with a seccomp filter).
> 
> I think the semantics of PR_SET_CHILD_SUBREAPER are different, and the
> behavior makes more sense there.

In my opinion, introducing inconsistency by deviating from the common
behavior of retaining process attributes across execve would be more
confusing/surprising to users. I don't see why it makes sense for
PR_SET_CHILD_SUBREAPER but not for PR_SET_KILL_DESCENDANTS_ON_EXIT.

Also, the main motivation is to provide a subset of PID namespace
features to unprivileged processes with a lightweight mechanism.
Retaining kill_descendants_on_exit across execve allows very similar
usage to PID namespaces: E.g., the parent can set
PR_SET_KILL_DESCENDANTS_ON_EXIT and PR_SET_CHILD_SUBREAPER in the child
before execve and the spawned init-like executable doesn't need to know
about this flag itself, i.e., the same init-like program can function
as a leader of a PID namespace or as a subreaper with this extra flag
set without code changes.

If the flag was cleared by execve, the program would need to know about
this flag and it would be impossible for the parent to lock this down
using seccomp.

> 
> > > > Descendants that are orphaned and reparented to an ancestor of the
> > > > current process before the current process exits, will not be killed.
> > > > PR_SET_CHILD_SUBREAPER can be used to contain orphaned processes.
> > > 
> > > For double- or triple-forking daemons, the reparenting will be racy, if
> > > I understand things correctly.
> > 
> > Can you please elaborate, if you're concerned about a particular race?
> > As the commit message mentions, for containment this flag can be
> > combined with PR_SET_CHILD_SUBREAPER (and PR_SET_NO_NEW_PRIVS).
> 
> Without PR_SET_CHILD_SUBREAPER, if a newly execve'ed daemon performs
> double/triple forking to disentangle itself from the parent process
> session, and the parent process which set
> PR_SET_KILL_DESCENDANTS_ON_EXIT terminates, behavior depends on when
> exactly the parent process terminates.  The daemon process will leak if
> it has completed its reparenting.
> 
> I think this could be sufficiently common that solution is needed here.

I expect the common case to be that PR_SET_KILL_DESCENDANTS_ON_EXIT
will be used together with PR_SET_CHILD_SUBREAPER (and possibly
PR_SET_NO_NEW_PRIVS) to prevent stray children. And I don't see a race
condition in that case.

PR_SET_KILL_DESCENDANTS_ON_EXIT can be used for non-subreapers but I
expect this to be used in more specialized scenarios where the program
is designed/known to avoid such race conditions. We could theoretically
restrict PR_SET_KILL_DESCENDANTS_ON_EXIT to subreapers but I currently
don't see a strong enough reason for this.

Jürg

