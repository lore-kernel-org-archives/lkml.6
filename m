Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97AF2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97AF2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeI1Etl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:49:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeI1Etl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:49:41 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44E0412D2;
        Thu, 27 Sep 2018 22:29:09 +0000 (UTC)
Date:   Thu, 27 Sep 2018 15:29:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Security Officers <security@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH resend] proc: restrict kernel stack dumps to root
Message-Id: <20180927152908.f5c9239d527380c582b1bcfa@linux-foundation.org>
In-Reply-To: <20180927153316.200286-1-jannh@google.com>
References: <20180927153316.200286-1-jannh@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 17:33:16 +0200 Jann Horn <jannh@google.com> wrote:

> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
> in order to prevent a local attacker from exploiting racy stack unwinding
> to leak kernel task stack contents.
> See the added comment for a longer rationale.
> 
> There don't seem to be any users of this userspace API that can't
> gracefully bail out if reading from the file fails. Therefore, I believe
> that this change is unlikely to break things.
> In the case that this patch does end up needing a revert, the next-best
> solution might be to fake a single-entry stack based on wchan.
> 
> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

It's a bit worrisome cc'ing stable on a patch which might need a revert.

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
>  	unsigned long *entries;
>  	int err;
>  
> +	/*
> +	 * The ability to racily run the kernel stack unwinder on a running task
> +	 * and then observe the unwinder output is scary; while it is useful for
> +	 * debugging kernel issues, it can also allow an attacker to leak kernel
> +	 * stack contents.
> +	 * Doing this in a manner that is at least safe from races would require
> +	 * some work to ensure that the remote task can not be scheduled; and
> +	 * even then, this would still expose the unwinder as local attack
> +	 * surface.
> +	 * Therefore, this interface is restricted to root.
> +	 */

The /proc file is 0400 so the user can only read owned-by-self stacks,
yes?  In what way could exposure of one's own kernel stack contents
lead to plausible attacks?  I guess maybe post-setuid, perhaps?

I do think we're owed considerably more explanation of the present risk
before considering a somewhat dangerous -stable backport, please.


