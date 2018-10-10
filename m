Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CBC20858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CBC20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJTrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbeJJTrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:47:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D4B9B091;
        Wed, 10 Oct 2018 12:25:41 +0000 (UTC)
Date:   Wed, 10 Oct 2018 14:25:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181010122539.GI5873@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
 <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz>
 <20181010114833.GB3949@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010114833.GB3949@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-10-18 20:48:33, Sergey Senozhatsky wrote:
> On (10/10/18 13:35), Michal Hocko wrote:
> > > Just flooding out of memory messages can trigger RCU stall problems.
> > > For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing
> > 
> > [...]
> > 
> > Quite some of them, indeed! I guess we want to rate limit the output.
> > What about the following?
> 
> A bit unrelated, but while we are at it:
> 
>   I like it when we rate-limit printk-s that lookup the system.
> But it seems that default rate-limit values are not always good enough,
> DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
> verbose. For instance, when we have a very slow IPMI emulated serial
> console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
> DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
> than we evict them.
> 
> Does it sound reasonable enough to use larger than default rate-limits
> for printk-s in OOM print-outs? OOM reports tend to be somewhat large
> and the reported numbers are not always *very* unique.
> 
> What do you think?

I do not really care about the current inerval/burst values. This change
should be done seprately and ideally with some numbers.
-- 
Michal Hocko
SUSE Labs
