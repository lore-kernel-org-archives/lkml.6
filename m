Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D78C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AA420883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AA420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966375AbeFSOKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:10:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:40883 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755616AbeFSOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:10:44 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5JEAXpo097734;
        Tue, 19 Jun 2018 23:10:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 19 Jun 2018 23:10:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5JEAMMv097635
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 Jun 2018 23:10:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <001a113ed5540f411c0568cc8418@google.com>
 <a274f8ff-989a-ccb8-3cc1-78fbdec0604a@I-love.SAKURA.ne.jp>
 <CACT4Y+ZJTHfFOcbReD_nOYxvxaYcD2Sa=VToZL0RWYw1TemrPA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9d0092e6-142a-7168-7b3c-084faa9268d5@i-love.sakura.ne.jp>
Date:   Tue, 19 Jun 2018 23:10:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZJTHfFOcbReD_nOYxvxaYcD2Sa=VToZL0RWYw1TemrPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/19 20:53, Dmitry Vyukov wrote:
> On Tue, Jun 19, 2018 at 1:44 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> This bug report is getting no feedback, but I guess that this bug is in
>> block or mm or locking layer rather than fs layer.
>>
>> NMI backtrace for this bug tends to report that sb_bread() from fill_super()
>>  from mount_bdev() is stalling is the cause of keep holding s_umount_key for
>> more than 120 seconds. What is strange is that NMI backtrace for this bug tends
>> to point at rcu_read_lock()/pagecache_get_page()/radix_tree_deref_slot()/
>> rcu_read_unlock() which is expected not to stall.
>>
>> Since CONFIG_RCU_CPU_STALL_TIMEOUT is set to 120 (and actually +5 due to
>> CONFIG_PROVE_RCU=y) which is longer than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT,
>> maybe setting CONFIG_RCU_CPU_STALL_TIMEOUT to smaller values (e.g. 25) can
>> give us some hints...
> 
> If an rcu stall is the true root cause of this, then I guess would see
> "rcu stall" bug too. Rcu stall is detected after 120 seconds, but task
> hang after 120-240 seconds. So rcu stall has much higher chances to be
> detected. Do you see the corresponding "rcu stall" bug?

RCU stall is detected after 125 seconds due to CONFIG_PROVE_RCU=y
(e.g. https://syzkaller.appspot.com/bug?id=1fac0fd91219f3f2a03d6fa7deafc95fbed79cc2 ).

I didn't find the corresponding "rcu stall" bug. But it is not required
that one RCU stall takes longer than 120 seconds.

down(); // Will take 120 seconds due to multiple RCU stalls
  rcu_read_lock():
  do_something();
  rcu_read_unlock(): // Took 30 seconds for unknown reason.
  rcu_read_lock():
  do_something();
  rcu_read_unlock(): // Took 30 seconds for unknown reason.
  rcu_read_lock():
  do_something();
  rcu_read_unlock(): // Took 30 seconds for unknown reason.
  rcu_read_lock():
  do_something();
  rcu_read_unlock(): // Took 30 seconds for unknown reason.
up();

