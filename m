Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4931AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AE920825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AE920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeKJRxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:53:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:21504 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeKJRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:53:39 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAA89KUF009360;
        Sat, 10 Nov 2018 17:09:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 10 Nov 2018 17:09:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAA89BhA009333
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 10 Nov 2018 17:09:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING: locking bug in loop_control_ioctl
To:     axboe@kernel.dk, Jan Kara <jack@suse.cz>
References: <00000000000026aaac057a40a183@google.com>
Cc:     syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <913c3703-f6d3-a412-3b0c-ebc7422e8e69@I-love.SAKURA.ne.jp>
Date:   Sat, 10 Nov 2018 17:09:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <00000000000026aaac057a40a183@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 4b9e5556fada37dff1eff13665a229b69e1f7dd8 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 10 Nov 2018 17:04:40 +0900
Subject: [PATCH] loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl().

Commit 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex") forgot to
remove mutex_unlock(&loop_ctl_mutex) from loop_control_ioctl() when
replacing loop_index_mutex with loop_ctl_mutex.

Reported-by: syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bf6bc35..176ab1f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2074,12 +2074,10 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-- 
1.8.3.1

