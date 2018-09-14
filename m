Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EBECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE31420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE31420853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeINONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:13:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727675AbeINONI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:13:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB76FAF75;
        Fri, 14 Sep 2018 08:59:34 +0000 (UTC)
Date:   Fri, 14 Sep 2018 10:59:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20180914085934.m2bgixltdzpfh62o@pathway.suse.cz>
References: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-09-14 11:34:28, Sergey Senozhatsky wrote:
> CON_PRINTBUFFER console registration requires us to do several
> preparation steps:
> - Rollback console_seq to replay logbuf messages which were already
>   seen on other consoles;
> - Set exclusive_console flag so console_unlock() will ->write() logbuf
>   messages only to the exclusive_console driver.
> 
> The way we do it, however, is a bit racy
> 
> 	logbuf_lock_irqsave(flags);
> 	console_seq = syslog_seq;
> 	console_idx = syslog_idx;
> 	logbuf_unlock_irqrestore(flags);
> 						<< preemption enabled
> 						<< irqs enabled
> 	exclusive_console = newcon;
> 	console_unlock();
> 
> We rollback console_seq under logbuf_lock with IRQs disabled, but
> we set exclusive_console with local IRQs enabled and logbuf unlocked.
> If the system oops-es or panic-s before we set exclusive_console - and
> given that we have IRQs and preemption enabled there is such a
> possibility - we will re-play all logbuf messages to every registered
> console, which may be a bit annoying and time consuming.
>
> Move exclusive_console assignment under the same IRQs-disabled and
> logbuf_lock protected section where we rollback console_seq.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 992bb6bb7ac2..c52a986a72b3 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2705,7 +2705,6 @@ void register_console(struct console *newcon)
>  		logbuf_lock_irqsave(flags);
>  		console_seq = syslog_seq;
>  		console_idx = syslog_idx;
> -		logbuf_unlock_irqrestore(flags);
>  		/*
>  		 * We're about to replay the log buffer.  Only do this to the
>  		 * just-registered console to avoid excessive message spam to
> @@ -2713,6 +2712,7 @@ void register_console(struct console *newcon)
>  		 */
>  		exclusive_console = newcon;
>  		exclusive_console_stop_seq = console_seq;
> +		logbuf_unlock_irqrestore(flags);

This would make a false feeling that these variables need to
be synchronized using logbug_lock. It might either confuse people
or it could get removed during a code clean up.

A better solution would be to explicitly disable preemption
around the entire section and add a comment.

Well, I am not sure if it is worth the code complexity.

Best Regards,
Petr
