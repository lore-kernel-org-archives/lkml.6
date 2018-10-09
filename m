Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05CAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B532089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B532089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJIPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:55:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeJIPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2F62AB4C;
        Tue,  9 Oct 2018 08:39:59 +0000 (UTC)
Date:   Tue, 9 Oct 2018 10:39:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 2/3] printk: lock/unlock console only for new logbuf
 entries
Message-ID: <20181009083959.rhbxdihzjj44nogk@pathway.suse.cz>
References: <20181002023836.4487-1-sergey.senozhatsky@gmail.com>
 <20181002023836.4487-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002023836.4487-3-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-02 11:38:35, Sergey Senozhatsky wrote:
> From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> 
> Prior to 5c2992ee7fd8a29 ("printk: remove console flushing special
> cases for partial buffered lines") we would do console_cont_flush()
> for each pr_cont() to print cont fragments, so console_unlock() would
> actually print data:
> 
> 	pr_cont();
> 	 console_lock();
> 	 console_unlock()
> 	  console_cont_flush(); // print cont fragment
> 	...
> 	pr_cont();
> 	 console_lock();
> 	 console_unlock()
> 	  console_cont_flush(); // print cont fragment
> 
> We don't do console_cont_flush() anymore, so when we do pr_cont()
> console_unlock() does nothing (unless we flushed the cont buffer):
> 
> 	pr_cont();
> 	 console_lock();
> 	 console_unlock();      // noop
> 	...
> 	pr_cont();
> 	 console_lock();
> 	 console_unlock();      // noop
> 	...
> 	pr_cont();
> 	  cont_flush();
> 	    console_lock();
> 	    console_unlock();   // print data
> 
> We also wakeup klogd purposelessly for pr_cont() output - un-flushed
> cont buffer is not stored in log_buf; there is nothing to pull.
> 
> Thus we can console_lock()/console_unlock()/wake_up_klogd() only when
> we know that we log_store()-ed a message and there is something to
> print to the consoles/syslog.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/printk.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

The patch makes perfect sense. It looks a bit hacky but I can't
think about any less hacky one.

I wonder if it is worth it. But if nobody else is against it
I am going to push it.

I just hope that we will get rid of it with the buffered printk
rather sooner than later.

Best Regards,
Petr
