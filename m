Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9069BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6728421A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfBKQDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:03:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbfBKQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:02:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFEDF806A7;
        Mon, 11 Feb 2019 16:02:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id D21B85DF4F;
        Mon, 11 Feb 2019 16:02:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Feb 2019 17:02:58 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:02:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ivan Delalande <colona@arista.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20190211160255.GC21430@redhat.com>
References: <20190205025308.GA24455@visor>
 <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
 <20190206031029.GB9368@visor>
 <87pns2q2ug.fsf@xmission.com>
 <20190209001638.GA14025@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209001638.GA14025@visor>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 11 Feb 2019 16:02:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08, Ivan Delalande wrote:
>
> A difference I've noticed with your tree (unrelated to my issue here but
> that you may want to look at) is when I run my reproducer under
> strace -f, I'm now getting quite a lot of "Exit of unknown pid 12345
> ignored" warnings from strace, which I've never seen with mainline.
> My reproducer simply fork-exec tail processes in a loop, and tries to
> sigkill them in the parent with a variable delay.

Hmm... may be because of PTRACE_EVENT_EXIT problem I mentioned in reply
to this change...

> 
> Thank you,
> 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 9ca8e5278c8e..5424cb0006bc 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
> >                 goto relock;
> >         }
> >  
> > +       /* Has this task already been marked for death? */
> > +       ksig->info.si_signo = signr = SIGKILL;
> > +       if (signal_group_exit(signal))
> > +               goto fatal;
> > +
> >         for (;;) {
> >                 struct k_sigaction *ka;
> >  
> > @@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
> >                         continue;
> >                 }
> >  
> > +       fatal:
> >                 spin_unlock_irq(&sighand->siglock);
> >  
> >    
> 
> -- 
> Ivan Delalande
> Arista Networks

