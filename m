Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34830C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD42D20685
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD42D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeIVTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:19:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:33200 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeIVTTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:19:07 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8MDP4oj087255;
        Sat, 22 Sep 2018 22:25:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Sat, 22 Sep 2018 22:25:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8MDP4Ga087251
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 22 Sep 2018 22:25:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: bpf: Massive skbuff_head_cache memory leak?
Message-ID: <b11ff285-1e8a-2729-d065-ac263572c511@I-love.SAKURA.ne.jp>
Date:   Sat, 22 Sep 2018 22:25:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

syzbot is reporting many lockup problems on bpf.git / bpf-next.git / net.git / net-next.git trees.

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

The cause of lockup seems to be flood of printk() messages from memory allocation
failures, and one of out_of_memory() messages indicates that skbuff_head_cache
usage is huge enough to suspect in-kernel memory leaks.

  [ 1554.547011] skbuff_head_cache    1847887KB    1847887KB

Unfortunately, we cannot find from logs what syzbot is trying to do
because constant printk() messages is flooding away syzkaller messages.
Can you try running your testcases with kmemleak enabled?
