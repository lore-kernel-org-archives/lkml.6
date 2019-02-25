Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43594C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124DF2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfBYO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:59:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfBYO75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:59:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4666AC81;
        Mon, 25 Feb 2019 14:59:55 +0000 (UTC)
Date:   Mon, 25 Feb 2019 15:59:54 +0100
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
Subject: Re: [RFC PATCH v1 13/25] printk: track seq per console
Message-ID: <20190225145954.62zl3tndmo2t372h@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-14-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:51, John Ogness wrote:
> Allow each console to track which seq record was last printed. This
> simplifies identifying dropped records.

I would like to see a better justification here. And I think
that it is part of this patchset.

One reason is to implement console reply a cleaner way.
Another reason is  to allows calling lockless consoles
directly in emergency situations.

Both reasons are independent on the log buffer implementation.
Therefore I suggest to move it into another patchset.


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ece54c24ea0d..ebd9aac06323 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1504,6 +1514,19 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>  		if (!cpu_online(raw_smp_processor_id()) &&
>  		    !(con->flags & CON_ANYTIME))
>  			continue;
> +		if (con->printk_seq >= seq)
> +			continue;
> +
> +		con->printk_seq++;
> +		if (con->printk_seq < seq) {
> +			print_console_dropped(con, seq - con->printk_seq);
> +			con->printk_seq = seq;

It would be great to print this message only when the real one
is not superseded.

The suppressed messages can be proceed quickly. They allow consoles
to catch up with the message producers. But if the spend time
with printing the warning, we just risk loosing more messages
again and again.

Heh, there is a bug in the current code. The warning is not
printed when the currently proceed message is superseded.
I am going to prepare a patch for this.

Best Regards,
Petr
