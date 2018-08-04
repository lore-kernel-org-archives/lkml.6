Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B9CC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF31D217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF31D217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeHDPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:45:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:22607 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHDPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:45:52 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w74Dj4J5011061;
        Sat, 4 Aug 2018 22:45:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Sat, 04 Aug 2018 22:45:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w74Dj3bA011057
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 4 Aug 2018 22:45:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING in try_charge
To:     mhocko@kernel.org, David Rientjes <rientjes@google.com>
References: <0000000000005e979605729c1564@google.com>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <4660f164-b3e3-28a0-9898-718c5fa6b84d@I-love.SAKURA.ne.jp>
Date:   Sat, 4 Aug 2018 22:45:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000005e979605729c1564@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting WARN(1) because of mem_cgroup_out_of_memory() == false.
At first I suspected that syzbot is hitting

  static bool oom_kill_memcg_victim(struct oom_control *oc)
  {
          if (oc->chosen_memcg == NULL || oc->chosen_memcg == INFLIGHT_VICTIM)
                  return oc->chosen_memcg;

case because

  /* We have one or more terminating processes at this point. */
  oc->chosen_task = INFLIGHT_VICTIM;

is not called. But since that patch was dropped from next-20180803, syzbot
seems to be hitting a different race condition
( https://syzkaller.appspot.com/text?tag=CrashLog&x=12071654400000 ).

Therefore, next culprit I suspect is

    mm, oom: remove oom_lock from oom_reaper

    oom_reaper used to rely on the oom_lock since e2fe14564d33 ("oom_reaper:
    close race with exiting task").  We do not really need the lock anymore
    though.  212925802454 ("mm: oom: let oom_reap_task and exit_mmap run
    concurrently") has removed serialization with the exit path based on the
    mm reference count and so we do not really rely on the oom_lock anymore.

    Tetsuo was arguing that at least MMF_OOM_SKIP should be set under the lock
    to prevent from races when the page allocator didn't manage to get the
    freed (reaped) memory in __alloc_pages_may_oom but it sees the flag later
    on and move on to another victim.  Although this is possible in principle
    let's wait for it to actually happen in real life before we make the
    locking more complex again.

    Therefore remove the oom_lock for oom_reaper paths (both exit_mmap and
    oom_reap_task_mm).  The reaper serializes with exit_mmap by mmap_sem +
    MMF_OOM_SKIP flag.  There is no synchronization with out_of_memory path
    now.

which is in next-20180803, and my "mm, oom: Fix unnecessary killing of additional processes."
( https://marc.info/?i=1533389386-3501-4-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp )
could mitigate it. Michal and David, please respond.

