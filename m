Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58857C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4878214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4878214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJJHcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:32:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48823 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeJJHcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:32:12 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9A0CjA8047787;
        Wed, 10 Oct 2018 09:12:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Wed, 10 Oct 2018 09:12:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9A0Cjd4047783;
        Wed, 10 Oct 2018 09:12:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9A0Cjtn047782;
        Wed, 10 Oct 2018 09:12:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: INFO: rcu detected stall in =?ISO-2022-JP?B?c2htZW1fZmF1bHQ=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, mhocko@kernel.org
Cc:     akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com
MIME-Version: 1.0
Date:   Wed, 10 Oct 2018 09:12:45 +0900
References: <000000000000dc48d40577d4a587@google.com>
In-Reply-To: <000000000000dc48d40577d4a587@google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting RCU stall due to memcg-OOM event.
https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64

What should we do if memcg-OOM found no killable task because the allocating task
was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires 
(which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
OOM header when no eligible victim left") because syzbot was terminating the test
upon WARN(1) removed by that commit) is not a good behavior.


syz-executor0 invoked oom-killer: gfp_mask=0x6200ca(GFP_HIGHUSER_MOVABLE), nodemask=(null), order=0, oom_score_adj=-1000
syz-executor0 cpuset=syz0 mems_allowed=0
CPU: 0 PID: 2050 Comm: syz-executor0 Not tainted 4.19.0-rc7-next-20181009+ #90
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
(...snipped...)
Memory limit reached of cgroup /syz0
memory: usage 205168kB, limit 204800kB, failcnt 6909
memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
Memory cgroup stats for /syz0: cache:680KB rss:176336KB rss_huge:163840KB shmem:740KB mapped_file:660KB dirty:0KB writeback:0KB swap:0KB inactive_anon:712KB active_anon:176448KB inactive_file:0KB active_file:4KB unevictable:0KB
Out of memory and no killable processes...
