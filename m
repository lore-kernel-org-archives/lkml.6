Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755326AbeEaOF3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:05:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755199AbeEaOF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:05:27 -0400
Date: Thu, 31 May 2018 16:05:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: drop in_nmi check from
 printk_safe_flush_on_panic()
Message-ID: <20180531140524.4vazxpalztzujcgh@pathway.suse.cz>
References: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-05-30 16:03:50, Sergey Senozhatsky wrote:
> Drop the in_nmi() check from printk_safe_flush_on_panic()
> and attempt to re-init (IOW unlock) locked logbuf spinlock
> from panic CPU regardless of its context. Otherwise,
> theoretically, we can deadlock on logbuf trying to flush
> per-CPU buffers:
> a) Panic CPU is running in non-NMI context
> b) Panic CPU sends out shutdown IPI via reboot vector
> c) Panic CPU fails to stop all remote CPUs
> d) Panic CPU sends out shutdown IPI via NMI vector
>    One of the CPUs that we bring down via NMI vector can hold
>    logbuf spin lock (theoretically).
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

I have pushed this into printk.git, branch for-4.18.

Best Regards,
Petr
