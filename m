Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90FC205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90FC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeK2XjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:39:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbeK2XjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:39:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 673C7307D931;
        Thu, 29 Nov 2018 12:34:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6662868377;
        Thu, 29 Nov 2018 12:34:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 29 Nov 2018 13:34:12 +0100 (CET)
Date:   Thu, 29 Nov 2018 13:34:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
Message-ID: <20181129123409.GA10645@redhat.com>
References: <20181127225408.7553-1-j@bitron.ch>
 <20181127225408.7553-2-j@bitron.ch>
 <20181128144230.GG30395@redhat.com>
 <87r2f5gr9g.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2f5gr9g.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 29 Nov 2018 12:34:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 11/27, Jürg Billeter wrote:
> >>
> >> @@ -704,6 +713,9 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
> >>  	struct task_struct *p, *n;
> >>  	LIST_HEAD(dead);
> >>
> >> +	if (group_dead && tsk->signal->kill_descendants_on_exit)
> >> +		walk_process_tree(tsk, kill_descendant_visitor, NULL);
> >
> > Well, this is not exactly right, at least this is suboptimal in that
> > other sub-threads can too call walk_process_tree(kill_descendant_visitor)
> > later for no reason.
>
> Oleg I think I am missing something.

No, it is stupid me who can't read,

> Reading kernel/exit.c I see "group_dead = atomic_dec_and_test(&tsk->signal->live)".
> Which seems like enough to ensure exactly one task/thread calls walk_process_tree.

Of course you right, sorry for confusion.

To me it would be more clean to call walk_process_tree(kill_descendant_visitor)
unconditionally in find_new_reaper() right before "if (has_child_subreaper)", but
then we will need to shift read_lock(tasklist) from walk_process_tree().

So I think the patch is mostly fine, the only problem I can see is that
PR_SET_KILL_DESCENDANTS_ON_EXIT can race with PR_SET_CHILD_SUBREAPER, they both
need to update the bits in the same word.

Oleg.

