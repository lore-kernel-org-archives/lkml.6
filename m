Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeEGKQq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:16:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:29949 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeEGKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:16:41 -0400
Subject: Re: KASAN: null-ptr-deref Write in simple_write_to_buffer
To: syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <00000000000005aaf6056b7759ba@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1a822b55-30bc-2bf3-427e-18c3d8e2b285@I-love.SAKURA.ne.jp>
Date: Mon, 7 May 2018 19:15:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <00000000000005aaf6056b7759ba@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 166fa14420aa17f9a693621ef76bd107e1cb5ce8 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 7 May 2018 13:12:20 +0900
Subject: [PATCH] PM / hibernate: Fix oops at snapshot_write().

syzbot is reporting NULL pointer dereference at snapshot_write() [1].
This is because data->handle is zero-cleared by ioctl(SNAPSHOT_FREE).
Fix this by checking data_of(data->handle) != NULL before using it.

[1] https://syzkaller.appspot.com/bug?id=828a3c71bd344a6de8b6a31233d51a72099f27fd

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 75c959d..abd2255 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -186,6 +186,11 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 		res = PAGE_SIZE - pg_offp;
 	}
 
+	if (!data_of(data->handle)) {
+		res = -EINVAL;
+		goto unlock;
+	}
+
 	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
 			buf, count);
 	if (res > 0)
-- 
1.8.3.1
