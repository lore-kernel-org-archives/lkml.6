Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A385C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD0C2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD0C2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJJQe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:34:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:52172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeJJQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F00A1B02B;
        Wed, 10 Oct 2018 09:13:10 +0000 (UTC)
Date:   Wed, 10 Oct 2018 11:13:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yang Shi <yang.s@alibaba-inc.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181010091309.GE5873@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
 <CACT4Y+bmYbNpu3mQR+X52KX+yPD1N2dnZOtd=iu-oETkevQ9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bmYbNpu3mQR+X52KX+yPD1N2dnZOtd=iu-oETkevQ9RA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-10-18 09:55:57, Dmitry Vyukov wrote:
> On Wed, Oct 10, 2018 at 6:11 AM, 'David Rientjes' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> > On Wed, 10 Oct 2018, Tetsuo Handa wrote:
> >
> >> syzbot is hitting RCU stall due to memcg-OOM event.
> >> https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64
> >>
> >> What should we do if memcg-OOM found no killable task because the allocating task
> >> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires
> >> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
> >> OOM header when no eligible victim left") because syzbot was terminating the test
> >> upon WARN(1) removed by that commit) is not a good behavior.
> 
> 
> You want to say that most of the recent hangs and stalls are actually
> caused by our attempt to sandbox test processes with memory cgroup?
> The process with oom_score_adj == -1000 is not supposed to consume any
> significant memory; we have another (test) process with oom_score_adj
> == 0 that's actually consuming memory.
> But should we refrain from using -1000? Perhaps it would be better to
> use -500/500 for control/test process, or -999/1000?

oom disable on a task (especially when this is the only task in the
memcg) is tricky. Look at the memcg report
[  935.562389] Memory limit reached of cgroup /syz0
[  935.567398] memory: usage 204808kB, limit 204800kB, failcnt 6081
[  935.573768] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
[  935.580650] kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
[  935.586923] Memory cgroup stats for /syz0: cache:152KB rss:176336KB rss_huge:163840KB shmem:344KB mapped_file:264KB dirty:0KB writeback:0KB swap:0KB inactive_anon:260KB active_anon:176448KB inactive_file:4KB active_file:0KB

There is still somebody holding anonymous (THP) memory. If there is no
other eligible oom victim then it must be some of the oom disabled ones.
You have suppressed the task list information so we do not know who that
might be though.
 
So it looks like there is some misconfiguration or a bug in the oom
victim selection.
-- 
Michal Hocko
SUSE Labs
