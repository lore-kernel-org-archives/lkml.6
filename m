Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18046C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1021920
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA0LFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:05:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfA0LFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:05:04 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gniF3-0001qs-0b; Sun, 27 Jan 2019 12:04:45 +0100
Date:   Sun, 27 Jan 2019 12:04:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     mingo@kernel.org, kjlu@umn.edu, hpa@zytor.com,
        stable@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Fix a potential double-fetch bug
 in sched_copy_attr()
In-Reply-To: <tip-120e4e76857ddbc9268e1aa3f9de61a498e84618@git.kernel.org>
Message-ID: <alpine.DEB.2.21.1901271201170.1622@nanos.tec.linutronix.de>
References: <20190109074524.10176-1-kjlu@umn.edu> <tip-120e4e76857ddbc9268e1aa3f9de61a498e84618@git.kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, tip-bot for Kangjie Lu wrote:
> Commit-ID:  120e4e76857ddbc9268e1aa3f9de61a498e84618
> Gitweb:     https://git.kernel.org/tip/120e4e76857ddbc9268e1aa3f9de61a498e84618
> Author:     Kangjie Lu <kjlu@umn.edu>
> AuthorDate: Wed, 9 Jan 2019 01:45:24 -0600
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 21 Jan 2019 11:26:17 +0100
> 
> sched/core: Fix a potential double-fetch bug in sched_copy_attr()
> 
> "uattr->size" is copied in from user space and checked. However, it is
> copied in again after the security check. A malicious user may race to
> change it. The fix sets uattr->size to be the checked size.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: pakki001@umn.edu
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/20190109074524.10176-1-kjlu@umn.edu
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a674c7db2f29..d4d3514c4fe9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4499,6 +4499,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	if (ret)
>  		return -EFAULT;
>  
> +	/* In case attr->size was changed by user-space: */
> +	attr->size = size;
> +

Just when pondering to send that to Linus, I tried to write up a concise
summary for this which made me look at the patch.

If the size changed, then its clear that user space fiddled with the date
between the size fetch and the full copy from user. So why restoring the
size instead of doing the obvious:

   	 if (attr->size != size)
	 	return -ECRAP;

Hmm?

Thanks,

	tglx
