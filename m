Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE68ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1AD2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1AD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJYUhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbeJYUhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:37:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3E2B308212A;
        Thu, 25 Oct 2018 12:05:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0531362527;
        Thu, 25 Oct 2018 12:05:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Oct 2018 14:05:23 +0200 (CEST)
Date:   Thu, 25 Oct 2018 14:05:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181025120520.GC3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <CAGXu5jK5c5mf=EarFNBWeq5Gc3LB=Kd8tqDc_a2nc6Xmtu=s6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jK5c5mf=EarFNBWeq5Gc3LB=Kd8tqDc_a2nc6Xmtu=s6g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 25 Oct 2018 12:05:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Kees Cook wrote:
>
> On Thu, Oct 25, 2018 at 12:13 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> > So again, suppose that "child" is already dead. Its task_struct can't be freed,
> > but child->real_parent can point to the already freed memory.
>
> I can't find a path for "child" to be released. I see task_lock()
> always called on it before it ends up in Yama.

Are you saying that yama_ptrace_access_check() is always called under
task_lock(child) ? Yes, it seems so

So what? Say, ptrace_attach() can hit a dead task. It should notice this
and fail later, but security_ptrace_access_check() is called before that.


> > This means that the 1st walker = rcu_dereference(walker->real_parent) is fine,
> > this simply reads the child->real_parent pointer, but on the second iteration
> >
> >         walker = rcu_dereference(walker->real_parent);
> >
> > reads the alredy freed memory.
>
> What does rcu_read_lock() protect actually protect here? I thought
> none of the task structs would be freed until after all
> rcu_read_unlock() finished.

See another email I sent you a minute ago.

Oleg.

