Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48BC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C732085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C732085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeKGXge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:36:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:39666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbeKGXge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:36:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3503AFEA;
        Wed,  7 Nov 2018 14:06:01 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:06:01 +0100
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
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181107140601.53y5vlubtugeczyt@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-02 22:31:55, Tetsuo Handa wrote:
> How to use this API:
> 
>   (1) Call get_printk_buffer() and acquire "struct printk_buffer *".
> 
>   (2) Rewrite printk() calls in the following way. The "ptr" is
>       "struct printk_buffer *" obtained in step (1).
> 
>       printk(fmt, ...)     => printk_buffered(ptr, fmt, ...)
>       vprintk(fmt, args)   => vprintk_buffered(ptr, fmt, args)
>       pr_emerg(fmt, ...)   => bpr_emerg(ptr, fmt, ...)
>       pr_alert(fmt, ...)   => bpr_alert(ptr, fmt, ...)
>       pr_crit(fmt, ...)    => bpr_crit(ptr, fmt, ...)
>       pr_err(fmt, ...)     => bpr_err(ptr, fmt, ...)
>       pr_warning(fmt, ...) => bpr_warning(ptr, fmt, ...)
>       pr_warn(fmt, ...)    => bpr_warn(ptr, fmt, ...)
>       pr_notice(fmt, ...)  => bpr_notice(ptr, fmt, ...)
>       pr_info(fmt, ...)    => bpr_info(ptr, fmt, ...)
>       pr_cont(fmt, ...)    => bpr_cont(ptr, fmt, ...)

I am looking at the sample conversions. We actually won't need
bpr_cont(). We will use buffer_printk() instead.

Well, I think about renaming buffer_printk() to bprintk() or
define it as a wrapper at least.

Best Regards,
Petr
