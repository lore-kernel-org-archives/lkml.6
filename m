Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeDSKCy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:02:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38603 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeDSKCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:02:53 -0400
Date: Thu, 19 Apr 2018 12:02:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] printk: wake up klogd in vprintk_emit
Message-ID: <20180419100248.rflodqcvpvnve5vl@pathway.suse.cz>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
 <20180419014250.5692-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419014250.5692-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-19 10:42:50, Sergey Senozhatsky wrote:
> We wake up klogd very late - only when current console_sem owner
> is done pushing pending kernel messages to the serial/net consoles.
> In some cases this results in lost syslog messages, because kernel
> log buffer is a circular buffer and if we don't wakeup syslog long
> enough there are chances that logbuf simply will wrap around.
> 
> The patch moves the klog wake up call to vprintk_emit(), which is
> the only legit way for a kernel message to appear in the logbuf,
> right before we attempt to grab the console_sem (possibly spinning
> on it waiting for the hand off) and call console drivers.

The last two lines need an update. What about?

"right after the attempt to handle consoles. As a result, klog
will get waken either after flushing the new message to consoles
or immediately when consoles are still busy with older messages."

Otherwise, it looks nice:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
