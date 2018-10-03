Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188C021486
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188C021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJCQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:11:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:55572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbeJCQLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:11:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2CF7AEBA;
        Wed,  3 Oct 2018 09:23:49 +0000 (UTC)
Date:   Wed, 3 Oct 2018 11:23:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20181003092349.a6h5tprezkfo2xcu@pathway.suse.cz>
References: <20180928095304.9972-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928095304.9972-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-09-28 18:53:04, Sergey Senozhatsky wrote:
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
> Move exclusive_console assignment to the same IRQs-disabled and
> logbuf_lock-protected section where we rollback console_seq.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

JFYI, I have just pushed this into printk.git, for-4.20 branch.

Best Regards,
Petr
