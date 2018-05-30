Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeE3KAr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:00:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36507 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeE3KAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:00:41 -0400
X-Google-Smtp-Source: ADUXVKJ9xNKAYnkd9I0FmhMJoKqUP+9+omwloplgAXZrvhxObO0T6+y/QS+3qVLGMs5SG3OgrNcfGw==
Date: Wed, 30 May 2018 19:00:37 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: drop in_nmi check from
 printk_safe_flush_on_panic()
Message-ID: <20180530100037.GE12230@jagdpanzerIV>
References: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
 <20180530072419.jqoohtcvenlnym6h@pathway.suse.cz>
 <20180530075105.GA12230@jagdpanzerIV>
 <20180530084801.i5mzqhlw2w5o2eod@pathway.suse.cz>
 <20180530095504.GD12230@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530095504.GD12230@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/30/18 18:55), Sergey Senozhatsky wrote:
> > 
> > I understand why you came with it but I am against this change without
> > a proper research. This would redirect too valuable messages into
> > a buffer of a limited size and postpone flushing them to the consoles.
> > 
> > We would need to really carefully compare chances where this would
> > help and where it would make things worse. There is a high chance
> > that we could come with a better solution once we have the analyze.
> 
> I agree, sure.
> 
> The thing is, we, in fact, already invoke panic() in printk_safe mode.
> Sometimes.
> 
> Namely,
> 
>   nmi_panic() -> panic()
> 
> is invoked while we are in printk_nmi(), so all printk()-s go
> to the per-CPU buffers. So, at least to some extent, panic()
> in printk_safe context is not something never seen before. Just
> saying.

Well, we have a PRINTK_NMI_DEFERRED_CONTEXT_MASK mode for
printk_nmi(). May be we can [if need be] come up with the same trick
for printk_safe_panic() mode. If logbuf spin_lock is unlocked, then
we use the main logbuf, if it is locked, we redirect printk to per-CPU
buffers and then flush it via printk_safe_flush_on_panic(), which will
re-init (unlock) the logbuf.

	-ss
