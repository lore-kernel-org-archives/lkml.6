Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65666C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2669F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2669F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeKGVPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:15:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:43728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbeKGVPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:15:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD2D5AD86;
        Wed,  7 Nov 2018 11:45:21 +0000 (UTC)
Date:   Wed, 7 Nov 2018 12:45:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <20181107114520.bi3ur2fpn62rlyje@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-11-07 19:52:53, Tetsuo Handa wrote:
> On 2018/11/06 23:35, Sergey Senozhatsky wrote:
> > - Do not allocate seq_buf if we are in printk-safe or in printk-nmi mode.
> >   To avoid "buffering for the sake of buffering". IOW, when in printk-safe
> >   use printk-safe.
> 
> Why? Since printk_safe_flush_buffer() forcibly flushes the partial line,
> calling printk_safe_log_store() after line buffering can reduce possibility of
> flushing partial lines, can't it?

Good point.

Well, printk_safe buffers are flushed via irqwork scheduled on the
same CPU. It might get flushed prematurely from other CPU but
I am not sure if this risk is worth the double buffering.

Best Regards,
Petr
