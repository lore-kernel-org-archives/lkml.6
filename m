Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC18C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2E7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2E7214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJJSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:05:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:44739 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJJSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:05:16 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9AAhfUM066809;
        Wed, 10 Oct 2018 19:43:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 10 Oct 2018 19:43:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9AAheZP066805
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Oct 2018 19:43:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
Date:   Wed, 10 Oct 2018 19:43:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010085945.GC5873@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/10 17:59, Michal Hocko wrote:
> On Wed 10-10-18 09:12:45, Tetsuo Handa wrote:
>> syzbot is hitting RCU stall due to memcg-OOM event.
>> https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64
> 
> This is really interesting. If we do not have any eligible oom victim we
> simply force the charge (allow to proceed and go over the hard limit)
> and break the isolation. That means that the caller gets back to running
> and realease all locks take on the way.

What happens if the caller continued trying to allocate more memory
because the caller cannot be noticed by SIGKILL from the OOM killer?

>                                         I am wondering how come we are
> seeing the RCU stall. Whole is holding the rcu lock? Certainly not the
> charge patch and neither should the caller because you have to be in a
> sleepable context to trigger the OOM killer. So there must be something
> more going on.

Just flooding out of memory messages can trigger RCU stall problems.
For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing

  INFO: rcu detected stall in filemap_fault
  https://syzkaller.appspot.com/bug?id=8e7f5412a78197a2e0f848fa513c2e7f0071ffa2

  INFO: rcu detected stall in show_free_areas
  https://syzkaller.appspot.com/bug?id=b2cc06dd0a76e7ca92aa8d13ef4227cb7fd0d217

  INFO: rcu detected stall in proc_reg_read
  https://syzkaller.appspot.com/bug?id=0d6a21d39c8ef7072c695dea11095df6c07c79af

  INFO: rcu detected stall in call_timer_fn
  https://syzkaller.appspot.com/bug?id=88a07e525266567efe221f7a4a05511c032e5822

  INFO: rcu detected stall in br_multicast_port_group_expired (2)
  https://syzkaller.appspot.com/bug?id=15c7ad8cf35a07059e8a697a22527e11d294bc94

  INFO: rcu detected stall in br_multicast_port_group_expired (2)
  https://syzkaller.appspot.com/bug?id=15c7ad8cf35a07059e8a697a22527e11d294bc94

  INFO: rcu detected stall in tun_chr_close
  https://syzkaller.appspot.com/bug?id=6c50618bde03e5a2eefdd0269cf9739c5ebb8270

  INFO: rcu detected stall in discover_timer
  https://syzkaller.appspot.com/bug?id=55da031ddb910e58ab9c6853a5784efd94f03b54

  INFO: rcu detected stall in ret_from_fork (2)
  https://syzkaller.appspot.com/bug?id=c83129a6683b44b39f5b8864a1325893c9218363

  INFO: rcu detected stall in addrconf_rs_timer
  https://syzkaller.appspot.com/bug?id=21c029af65f81488edbc07a10ed20792444711b6

  INFO: rcu detected stall in kthread (2)
  https://syzkaller.appspot.com/bug?id=6accd1ed11c31110fed1982f6ad38cc9676477d2

  INFO: rcu detected stall in ext4_filemap_fault
  https://syzkaller.appspot.com/bug?id=817e38d20e9ee53390ac361bf0fd2007eaf188af

  INFO: rcu detected stall in run_timer_softirq (2)
  https://syzkaller.appspot.com/bug?id=f5a230a3ff7822f8d39fddf8485931bd06ae47fe

  INFO: rcu detected stall in bpf_prog_ADDR
  https://syzkaller.appspot.com/bug?id=fb4911fd0e861171cc55124e209f810a0dd68744

  INFO: rcu detected stall in __run_timers (2)
  https://syzkaller.appspot.com/bug?id=65416569ddc8d2feb8f19066aa761f5a47f7451a

reports.

> 
>> What should we do if memcg-OOM found no killable task because the allocating task
>> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires 
>> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
>> OOM header when no eligible victim left") because syzbot was terminating the test
>> upon WARN(1) removed by that commit) is not a good behavior.
> 
> We definitely want to inform about ineligible oom victim. We might
> consider some rate limiting for the memcg state but that is a valuable
> information to see under normal situation (when you do not have floods
> of these situations).
> 

But if the caller cannot be noticed by SIGKILL from the OOM killer,
allowing the caller to trigger the OOM killer again and again (until
global OOM killer triggers) is bad.

