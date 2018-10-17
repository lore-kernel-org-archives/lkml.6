Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C38ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC772083A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC772083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJQSX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:23:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeJQSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:23:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F3F5AD06;
        Wed, 17 Oct 2018 10:28:22 +0000 (UTC)
Date:   Wed, 17 Oct 2018 12:28:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181017102821.GM18839@dhcp22.suse.cz>
References: <1539770782-3343-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539770782-3343-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 19:06:22, Tetsuo Handa wrote:
> syzbot is hitting RCU stall at shmem_fault() [1].
> This is because memcg-OOM events with no eligible task (current thread
> is marked as OOM-unkillable) continued calling dump_header() from
> out_of_memory() enabled by commit 3100dab2aa09dc6e ("mm: memcontrol:
> print proper OOM header when no eligible victim left.").
> 
> Michal proposed ratelimiting dump_header() [2]. But I don't think that
> that patch is appropriate because that patch does not ratelimit
> 
>   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
>   "Out of memory and no killable processes...\n"
> 
> messages which can be printed for every few milliseconds (i.e. effectively
> denial of service for console users) until the OOM situation is solved.
> 
> Let's make sure that next dump_header() waits for at least 60 seconds from
> previous "Out of memory and no killable processes..." message. Michal is
> thinking that any interval is meaningless without knowing the printk()
> throughput. But since printk() is synchronous unless handed over to
> somebody else by commit dbdda842fe96f893 ("printk: Add console owner and
> waiter logic to load balance console writes"), it is likely that all OOM
> messages from this out_of_memory() request is already flushed to consoles
> when pr_warn("Out of memory and no killable processes...\n") returned.
> Thus, we will be able to allow console users to do what they need to do.
> 
> To summarize, this patch allows threads in requested memcg to complete
> memory allocation requests for doing recovery operation, and also allows
> administrators to manually do recovery operation from console if
> OOM-unkillable thread is failing to solve the OOM situation automatically.

Could you explain why this is any better than using a well established
ratelimit approach?
-- 
Michal Hocko
SUSE Labs
