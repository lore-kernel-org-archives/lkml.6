Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeDZBo0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:44:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38403 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeDZBoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:44:23 -0400
X-Google-Smtp-Source: AB8JxZodh4b/7+pJL/yCH0AARSUNQSXFK79CLgpagcd7bb2W48ntcNcdp3oiSF0EVAE0c0eHocuAdg==
Date: Thu, 26 Apr 2018 10:44:18 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not call console drivers from
 printk_safe context
Message-ID: <20180426014418.GB3282@jagdpanzerIV>
References: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
 <20180424105104.792d2d80@gandalf.local.home>
 <20180425144813.lfhvuwsf2cebwarm@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425144813.lfhvuwsf2cebwarm@pathway.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/18 16:48), Petr Mladek wrote:
[..]
> 
> The above paragraph is not easy to understand. I wonder if the
> following might be more clear:
> 
> "Calling console drivers from printk_safe() context does not really
> make call_console_drivers() any safer. They are never called
> recursively thanks to console_trylock() in vprintk_emit()."

Yes, looks good.

[..]
> Unfortunately printk_safe context helps only when console_unlock() is
> called with IRQs disabled. Otherwise, the per-CPU buffer is flushed
> in every for(;;) cycle.

Right. I thought about it. If console_unlock() is called with IRQs
disabled then we postpone flush until we return from console_unlock()
and enable local IRQs. But then we have printk_safe() flush, which
uses printk_deferred() -> queue irq_work -> irq work -> console_unlock(),
so quite likely we still print out printk_safe() buffer from atomic
context (from irq in this case).

> So I agree that printk_safe context does not help much. And I fine
> with this patch.

Thanks.

	-ss
