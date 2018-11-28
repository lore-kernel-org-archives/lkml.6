Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD200C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD9208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFD9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeK2BKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2BKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:10:53 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70498206B6;
        Wed, 28 Nov 2018 14:09:05 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:09:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mingo@redhat.com, akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] kernel/trace: fix watchdog soft lockup
Message-ID: <20181128090903.7a27ae58@gandalf.local.home>
In-Reply-To: <20181128081334.18408-1-anders.roxell@linaro.org>
References: <20181128081334.18408-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 09:13:34 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> When building a allmodconfig kernel for arm64 and boot that in qemu,
> CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
> watchdog expires and prints out a message like this:
> 'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
> Each time the function ftrace_replace_code gets called it stays in that
> functions loop for 41424 times.
> Rework so that function cond_resched() gets called in the
> ftrace_replace_code loop.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/trace/ftrace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 5b4f73e4fd56..3f456921dedf 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2426,6 +2426,10 @@ void __weak ftrace_replace_code(int enable)
>  
>  	do_for_each_ftrace_rec(pg, rec) {
>  
> +		/* This loop can take minutes when sanitizers are enabled, so
> +		 * lets make sure we allow RCU processing.
> +		 */
> +		cond_resched();
>  		if (rec->flags & FTRACE_FL_DISABLED)
>  			continue;
>  

NACK.  On some architectures this code is run from stop machine. We
can't call cond_resched() because it may be called with interrupts
disabled.

This is a weak function. If arm64 has special needs, just copy it in
the arm64 code.

-- Steve
