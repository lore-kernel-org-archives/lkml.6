Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZpA7hkVgcPMpnLCZrXLNXN/uXLFPnjrG+efO586phkJLwKppRBgBUa4TlgSXhYwfyiwU4HH
ARC-Seal: i=1; a=rsa-sha256; t=1525270336; cv=none;
        d=google.com; s=arc-20160816;
        b=r+APWaEriqagsQyDFikVLUrCk34zpPlxwuOYzVx2PZ96Pyui/uMmT8bMRG+fLYXR2z
         sXyuUajyqRvWGL51/3hT7LIiojp3vz1REAjZ2saM6Bnuo6OS4uq1BQhlLu48V5fOq+u8
         8GecN3SPH9zhbllpNrIE7BfHLMpWOk+MSQsBz6M9/6IvsptJ/y8sxpvY5WCIfog5L+hy
         zBxCWxB8ujWFxJVgtMEQM3K3QNeWuoJtlEGZ/8Mat0DbT7FsEWLE6K8MO8Nctr/e3vLj
         9UJwhTmIuvX+hfZY4wCkGbklX096CCMdxMAGZsbsJ5W0NWGcoyKfYdw/Z4z2LFqbltL+
         L5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=IO2Jnn2nDhprExMD7knXrduEpTBW1m0kn78EWbqn06c=;
        b=xD9pjqNO1HaXe0k6i18WJsqQ/iCgcxrO+XLUrVUUpavoEN+/eh71Lc1XXLQbRz9BqC
         Qoh1KGOqDC7GUvC1Uh9K6UxTYlmNVhWLvgcBQlCATYDWKbvNI5M5WBDTP8gNBlj6SOgk
         nlozvdLjU3SnSkJNr/C06Nctbr37foCE86Xi+RlSdYdXAlUHd87NaD0hbXzvbz3mvMkE
         /PbjsQgaF8cTTqbK8uBNWsxZpkNryle+QouE32KcrFiybt1qOtA9IqOneRtqwgl1EjjM
         lkviwDNx9oudnZjQuh3Spm+AMkl34mqVKkrskqZ+k1ZPZ7mvV4UyxJPp09zgf01EG33X
         lBcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: WARNING in sysfs_remove_group
To: syzbot
 <bot+9f03168400f56df89dbc6f1751f4458fe739ff29@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jens Axboe <axboe@kernel.dk>
References: <001a113ed2fa7bedfe055c8316a5@google.com>
 <94eb2c030882b2b1b505610813df@google.com>
Cc: dvyukov@google.com, gregkh@linuxfoundation.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <55ff5960-eaab-5a36-5605-4e2230b77607@I-love.SAKURA.ne.jp>
Date: Wed, 2 May 2018 23:11:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <94eb2c030882b2b1b505610813df@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582398672104881968?=
X-GMAIL-MSGID: =?utf-8?q?1599361868320682332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

syzbot has hit this bug for nearly 6000 times. Why not to fix this trivial one? ;-)

>From 626d33de1b70b11ecaf95a9f83f7644998e54cbb Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 2 May 2018 23:03:48 +0900
Subject: [PATCH] loop: remember whether sysfs_create_group() succeeded

syzbot is hitting WARN() triggered by memory allocation fault
injection [1] because loop module is calling sysfs_remove_group()
when sysfs_create_group() failed.
Fix this by remembering whether sysfs_create_group() succeeded.

[1] https://syzkaller.appspot.com/bug?id=3f86c0edf75c86d2633aeb9dd69eccc70bc7e90b

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+9f03168400f56df89dbc6f1751f4458fe739ff29@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/loop.c | 11 ++++++-----
 drivers/block/loop.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5d4e316..1d758d8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -809,16 +809,17 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	.attrs= loop_attrs,
 };
 
-static int loop_sysfs_init(struct loop_device *lo)
+static void loop_sysfs_init(struct loop_device *lo)
 {
-	return sysfs_create_group(&disk_to_dev(lo->lo_disk)->kobj,
-				  &loop_attribute_group);
+	lo->sysfs_ready = !sysfs_create_group(&disk_to_dev(lo->lo_disk)->kobj,
+					      &loop_attribute_group);
 }
 
 static void loop_sysfs_exit(struct loop_device *lo)
 {
-	sysfs_remove_group(&disk_to_dev(lo->lo_disk)->kobj,
-			   &loop_attribute_group);
+	if (lo->sysfs_ready)
+		sysfs_remove_group(&disk_to_dev(lo->lo_disk)->kobj,
+				   &loop_attribute_group);
 }
 
 static void loop_config_discard(struct loop_device *lo)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index b78de98..73c801f 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -58,6 +58,7 @@ struct loop_device {
 	struct kthread_worker	worker;
 	struct task_struct	*worker_task;
 	bool			use_dio;
+	bool			sysfs_ready;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
-- 
1.8.3.1
