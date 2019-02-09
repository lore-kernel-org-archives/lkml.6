Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4710C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF38F20869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cbPykIdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBIAQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:16:39 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:54406 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfBIAQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:16:39 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id C6BF2E5F;
        Fri,  8 Feb 2019 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549671398;
        bh=R7LyMcPXHlOVl1UD0M9CSASLtyZS2/6CtFGEODaNu1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cbPykIdLztrpZESk5irYbGbb15kb3VJTJipvSUNXHRBwaSTVQecuIEC8Ag84NPZ7t
         XsFEISWyZaZCqm2adY01WA09jnW+FCHX62mRBA+WAe+s/oBaWQUJ9821wv5V9qUtua
         RJd9iyci0L11buPyKP1ueMf/jbhgsAgBLHJdj9SDngTqBGp90VY3ShtSR3ZFfHbwC0
         rCzZX6PWqf8BxHqnd5YUqit52FB+bEj4gqgkDFAOpdMOFpRh+A7PJIdCRMt9wHkVAu
         VTZkol73sD4gORrZbcVJKc+YrULK/XOY+Rk8Vdat9bMJm0RtDbZaqQb7dAu+/sjTkQ
         KtQuDYtx5YGsA==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id B88B9E39;
        Fri,  8 Feb 2019 16:16:38 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:16:38 -0800
From:   Ivan Delalande <colona@arista.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20190209001638.GA14025@visor>
References: <20190205025308.GA24455@visor>
 <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
 <20190206031029.GB9368@visor>
 <87pns2q2ug.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pns2q2ug.fsf@xmission.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Feb 07, 2019 at 11:13:59PM -0600, Eric W. Biederman wrote:
> I just noticed this.  From  my patch queue that I intend to send to
> Linus tomorrow. I think this change fixes your issue of getting
> the SIGSEGV instead of the already pending fatal signal.
> 
> So I think this fixes your issue without any other code changes.
> Ivan can you verify that the patch below is enough?

I was having issues with just this patch applied on top of v5.0-rc5 or
the latest master: defunct processes accumulating, exiting processes
that would hang forever, and some kernel functions eating all the CPU
(setup_sigcontext, common_interrupt, __clear_user, do_signal…).

But using your user-namespace.git/for-linus worked great and I've been
running my reproducer for a few hours now without issue. I'll probably
keep it running over the week-end as it has been unreliable at times,
but it looks promising so far.


A difference I've noticed with your tree (unrelated to my issue here but
that you may want to look at) is when I run my reproducer under
strace -f, I'm now getting quite a lot of "Exit of unknown pid 12345
ignored" warnings from strace, which I've never seen with mainline.
My reproducer simply fork-exec tail processes in a loop, and tries to
sigkill them in the parent with a variable delay.

Thank you,

> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9ca8e5278c8e..5424cb0006bc 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
>                 goto relock;
>         }
>  
> +       /* Has this task already been marked for death? */
> +       ksig->info.si_signo = signr = SIGKILL;
> +       if (signal_group_exit(signal))
> +               goto fatal;
> +
>         for (;;) {
>                 struct k_sigaction *ka;
>  
> @@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
>                         continue;
>                 }
>  
> +       fatal:
>                 spin_unlock_irq(&sighand->siglock);
>  
>    

-- 
Ivan Delalande
Arista Networks
