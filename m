Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9961C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C115208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C115208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937717AbeFSLpK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:45:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39048 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937592AbeFSLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:45:09 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5JBj1lN035015;
        Tue, 19 Jun 2018 20:45:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 19 Jun 2018 20:45:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5JBj0OU035005
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 Jun 2018 20:45:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <001a113ed5540f411c0568cc8418@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a274f8ff-989a-ccb8-3cc1-78fbdec0604a@I-love.SAKURA.ne.jp>
Date:   Tue, 19 Jun 2018 20:44:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <001a113ed5540f411c0568cc8418@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug report is getting no feedback, but I guess that this bug is in
block or mm or locking layer rather than fs layer.

NMI backtrace for this bug tends to report that sb_bread() from fill_super()
 from mount_bdev() is stalling is the cause of keep holding s_umount_key for
more than 120 seconds. What is strange is that NMI backtrace for this bug tends
to point at rcu_read_lock()/pagecache_get_page()/radix_tree_deref_slot()/
rcu_read_unlock() which is expected not to stall.

Since CONFIG_RCU_CPU_STALL_TIMEOUT is set to 120 (and actually +5 due to
CONFIG_PROVE_RCU=y) which is longer than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT,
maybe setting CONFIG_RCU_CPU_STALL_TIMEOUT to smaller values (e.g. 25) can
give us some hints...

