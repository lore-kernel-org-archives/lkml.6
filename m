Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55CFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9316120815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfACB2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:28:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:38059 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfACB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:28:47 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x031SjC4040606;
        Thu, 3 Jan 2019 10:28:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 03 Jan 2019 10:28:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x031Siwb040603
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 3 Jan 2019 10:28:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: possible deadlock in __wake_up_common_lock
To:     Qian Cai <cai@lca.pw>, Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190102180611.GE31517@techsingularity.net>
 <73c41960-e282-e2ec-4edd-788a1f49f06a@lca.pw>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <530f88a1-3aa1-c36f-f487-7e5e33402fb0@I-love.SAKURA.ne.jp>
Date:   Thu, 3 Jan 2019 10:28:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <73c41960-e282-e2ec-4edd-788a1f49f06a@lca.pw>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/03 3:19, Qian Cai wrote:
> On 1/2/19 1:06 PM, Mel Gorman wrote:
> 
>> While I recognise there is no test case available, how often does this
>> trigger in syzbot as it would be nice to have some confirmation any
>> patch is really fixing the problem.
> 
> I think I did manage to trigger this every time running a mmap() workload
> causing swapping and a low-memory situation [1].
> 
> [1]
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c

wakeup_kswapd() is called because tlb_next_batch() is doing GFP_NOWAIT
allocation. But since tlb_next_batch() can tolerate allocation failure,
does below change in tlb_next_batch() help?

#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)

-	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
+	batch = (void *)__get_free_pages(__GFP_NOWARN, 0);
