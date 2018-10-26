Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601C8ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9AD2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9AD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJZX7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:59:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJZX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:59:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CE593082DD1;
        Fri, 26 Oct 2018 15:22:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id CCBCB100190B;
        Fri, 26 Oct 2018 15:22:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 26 Oct 2018 17:22:12 +0200 (CEST)
Date:   Fri, 26 Oct 2018 17:22:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181026152208.GB18848@redhat.com>
References: <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
 <20181025155503.GF3725@redhat.com>
 <3423a470-c152-0dbf-c7a7-2775a9679194@i-love.sakura.ne.jp>
 <20181026130442.GB10581@redhat.com>
 <522c4993-4d98-be98-def2-452ed28098f9@i-love.sakura.ne.jp>
 <20181026143937.GA18848@redhat.com>
 <4264173d-4947-9fad-97e6-5269defb6eb4@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4264173d-4947-9fad-97e6-5269defb6eb4@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 26 Oct 2018 15:22:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27, Tetsuo Handa wrote:
>
> On 2018/10/26 23:39, Oleg Nesterov wrote:
> > On 10/26, Tetsuo Handa wrote:
> >> Suppose p1 == p2->real_parent and p2 == p3->real_parent, and p1 exited
> >> when someone tried to attach on p2, p2->real_parent was pointing to already
> >> (or about to be) freed p1.
> >
> > I don't see a difference.
> >
> > If p1 exits it will re-parent p2, p2->real_parent will be updated.
> >
> >> So, the puzzle part is why p2->real_parent was still pointing p1 even after
> >> p1 was freed...
> >
> > I don't understand the question.
> >
> > Once again. TASK->real_parent can point to the freed mem only if a) TASK exits,
> > and b) _after_ that its parent TASK->real_parent exits too.
>
> Oh, p2 exited and then p1 also exited when someone tried to attach on p2.
> Then, p2->real_parent can point to already (or about to be) freed p1.

Then we must see pid_alive(p2) == F as I already explained you in my
yesterday's email.

Because if p1 exits _after_ p2, then pid_alive(p2) == F must be already
completed, p1 can't exit (I mean, release_task(p1) can't be called) until
release_task(p2) does detach_pid() and drops tasklist_lock.

> (By the way, if p->real_parent were updated to point to init_task when p exits,
> we could omit pid_alive() check?)

Sorry, I don't understand the question...

Ignoring the PR_SET_CHILD_SUBREAPER parents, ignoring the exiting sub-threads
which reparent to group leader, ->real_parent is alwasy updated to point to
init_task. But I don't see why we could omit pid_alive() check.

Oleg.

