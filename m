Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C89ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EF2208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EF2208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIOWp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 18:45:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:27299 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeIOWp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 18:45:56 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8FHPx4B061473;
        Sun, 16 Sep 2018 02:25:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sun, 16 Sep 2018 02:25:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8FHPsvq061451
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 16 Sep 2018 02:25:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in fsnotify_connector_destroy_workfn (2)
To:     syzbot <syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com>,
        amir73il@gmail.com, jack@suse.cz, syzkaller-bugs@googlegroups.com
References: <0000000000006364200575dfc280@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2f4ce251-cf84-8bd2-72fc-a3ff687d5188@I-love.SAKURA.ne.jp>
Date:   Sun, 16 Sep 2018 02:25:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000006364200575dfc280@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/15 11:33, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=141ffbca400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=6fb572170402d311dd39
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a60ae400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6fb572170402d311dd39@syzkaller.appspotmail.com
> 

Since it kept printk()ing for at least 93 seconds, it might have kept for 150 seconds.

[  174.614333] hid-generic 0000:0000:0000.0003: unknown main item tag 0x0
[  268.196102] INFO: task kworker/u4:1:23 blocked for more than 140 seconds.

Since the reproducer is simple, this might be lockup due to continuous printk().
If syzbot can reliably reproduce this problem using the reproducer, try
ratelimiting printk().
