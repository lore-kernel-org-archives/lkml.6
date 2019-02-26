Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714832173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBZPiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:38:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:49010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbfBZPiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:38:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5EA7AD07;
        Tue, 26 Feb 2019 15:38:15 +0000 (UTC)
Date:   Tue, 26 Feb 2019 16:38:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 16/25] printk: implement CON_PRINTBUFFER
Message-ID: <20190226153814.cem5lxr7sla2ihb5@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-17-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-17-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:54, John Ogness wrote:
> If the CON_PRINTBUFFER flag is not set, do not replay the history
> for that console.

This patch fixes a regression caused by previous patches.
We need to do it a way that does not cause the regression
and do not break bisection.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6c875abd7b17..b97d4195b09a 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1596,8 +1592,12 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
>  		if (!con->wrote_history) {
> -			printk_write_history(con, seq);
> -			continue;
> +			if (con->flags & CON_PRINTBUFFER) {
> +				printk_write_history(con, seq);
> +				continue;
> +			}
> +			con->wrote_history = 1;

I have just got an idea that we do not need a new flag.
We could clear CON_PRINTBUFFER bit instead.

Best Regards,
Petr
