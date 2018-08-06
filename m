Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44010C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D450B21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D450B21A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbeHFSL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:11:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:37663 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHFSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:11:56 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76G2AIS005294;
        Tue, 7 Aug 2018 01:02:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Tue, 07 Aug 2018 01:02:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76G29xR005264
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 01:02:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     mhocko@kernel.org
References: <0000000000006350880572c61e62@google.com>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4bf70718-59fd-dcad-c20e-8601cd665bca@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 01:02:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000006350880572c61e62@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/07 0:42, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> WARNING in try_charge
> 
> Killed process 6410 (syz-executor5) total-vm:37708kB, anon-rss:2128kB, file-rss:0kB, shmem-rss:0kB
> oom_reaper: reaped process 6410 (syz-executor5), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> task=syz-executor5 pid=6410 invoked memcg oom killer. oom_victim=1
> ------------[ cut here ]------------
> Memory cgroup charge failed because of no reclaimable memory! This looks like a misconfiguration or a kernel bug.
> WARNING: CPU: 1 PID: 6410 at mm/memcontrol.c:1707 mem_cgroup_oom mm/memcontrol.c:1706 [inline]
> WARNING: CPU: 1 PID: 6410 at mm/memcontrol.c:1707 try_charge+0x734/0x1680 mm/memcontrol.c:2264
> Kernel panic - not syncing: panic_on_warn set ...

Michal, this is "mm, oom: task_will_free_mem(current) should ignore MMF_OOM_SKIP for once."
problem which you are refusing at https://www.spinics.net/lists/linux-mm/msg133774.html .
