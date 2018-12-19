Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA0AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5421850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLSKNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:13:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62991 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbeLSKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:13:01 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBJAC553073637;
        Wed, 19 Dec 2018 19:12:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Wed, 19 Dec 2018 19:12:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBJAC0Z8072069
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 19 Dec 2018 19:12:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_sendfile64
To:     syzbot <syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <000000000000e728ec057d5c9d90@google.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a5478450-f975-228f-1ca6-886a45b654a1@I-love.SAKURA.ne.jp>
Date:   Wed, 19 Dec 2018 19:11:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <000000000000e728ec057d5c9d90@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/19 18:27, syzbot wrote:
> HEAD commit:    ddfbab46539f Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b87fa3400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
> dashboard link: https://syzkaller.appspot.com/bug?extid=bcad772bbc241b4c6147
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13912ccd400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145781db400000

This is not a LSM problem, for the reproducer is calling
sched_setattr(SCHED_DEADLINE) with very large values.

  sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_??? */, sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=2251799813724439, sched_deadline=4611686018427453437, sched_period=0}, 0) = 0

I think that this problem is nothing but an insane sched_setattr() parameter.

#syz invalid

