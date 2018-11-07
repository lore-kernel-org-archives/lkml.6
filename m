Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F550C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3188C2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3188C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKHAtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:49:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbeKHAtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4797B613;
        Wed,  7 Nov 2018 15:19:02 +0000 (UTC)
Date:   Wed, 7 Nov 2018 16:19:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-02 22:31:57, Tetsuo Handa wrote:
> syzbot is sometimes getting mixed output like below due to concurrent
> printk(). Mitigate such output by using line-buffered printk() API.
> 
> @@ -2421,18 +2458,20 @@ static void check_chain_key(struct task_struct *curr)
>  print_usage_bug_scenario(struct held_lock *lock)
>  {
>  	struct lock_class *class = hlock_class(lock);
> +	struct printk_buffer *buf = get_printk_buffer();
>  
>  	printk(" Possible unsafe locking scenario:\n\n");
>  	printk("       CPU0\n");
>  	printk("       ----\n");
> -	printk("  lock(");
> -	__print_lock_name(class);
> -	printk(KERN_CONT ");\n");
> +	printk_buffered(buf, "  lock(");
> +	__print_lock_name(class, buf);
> +	printk_buffered(buf, ");\n");
>  	printk("  <Interrupt>\n");
> -	printk("    lock(");
> -	__print_lock_name(class);
> -	printk(KERN_CONT ");\n");
> +	printk_buffered(buf, "    lock(");
> +	__print_lock_name(class, buf);
> +	printk_buffered(buf, ");\n");
>  	printk("\n *** DEADLOCK ***\n\n");
> +	put_printk_buffer(buf);
>  }
>  
>  static int

I really hope that the maze of pr_cont() calls in lockdep.c is the most
complicated one that we would meet.

Anyway, the following comes to my mind:

1. The mixing of normal and buffered printk calls is a bit confusing
   and error prone. It would make sense to use the buffered printk
   everywhere in the given section of code even when it is not
   strictly needed.

2. I would replace "buf" with "pbuf" or "prbuf" to distinguish it a
   bit from other eventual buffers.


Best Regards,
Petr
