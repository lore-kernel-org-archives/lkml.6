Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WWENOOrpyr1wjv2teBDKzJT3eINUOV5BLPjeqRC4BeXenYWCDWoCMJEEJwMqLICXDq4LF
ARC-Seal: i=1; a=rsa-sha256; t=1523472203; cv=none;
        d=google.com; s=arc-20160816;
        b=iUpelwYomO8kFEsE+R5tg1Fjyvk0vuJ/BaeDOFTFbwcYqVffxd5nUY2sSHdVDG9aA0
         TxNe1tJzFfZMBPRURppKMfxul/touG+TNFDOjXi5fHN0VjQl5NA7Q+b4v/8xBlW/Tz04
         0nFD36HdqRHSG+tFurgRviWGa5eDgMQvQjpNAZ5ncTH3cnnWTaoaqWNeTuG8DVt4GVZt
         oX1MaX3LJq4yBti9iE0t3zHFOLc2h5s1Tf9VD7gc+/MdWRCu0qHg+HWwaPFNbL0Wksb+
         HUcmt6WkreWriT1pnoJZcZa5T2vcZRPfViiBTcwSmffAD1hGy2NP6yvd0qke80AnoIYf
         bMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Or5FTTihk+rktrcu7zEOUXnJe2ra0deeEsp5gNWndQw=;
        b=R16RtoOzAp0dbv1rsjd3e8HSEaZ9rQeAhd/MiM3HMeLXaee/9IUPYcapkohK0zs0Tx
         GPRM/IcFojLyeEESkBwwO7Q4XZhukHXtbAzbIvpaV2xY6jU0NkGuFw143aMy47LqZ86L
         yImeO3iyIuf+ftJA9StH81ZuqNdv2xSD3nF1pKLLKZgDhoYAiK8gVK3dhku5YMtUlhuo
         7uWpyNivQgX3qEzZnKfT+SK3Ts3IHQp6Sj3Yp3xIcc6Ykrq9XCN3I413mhYffq2KfSvP
         lmi6s6oDtnEayOfKEPoa4a0hdgA3ejheI+Yuz+5XhZnrYDZnwCDzJd0hwE7nEXMbOLC4
         LiZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tang Junhui <tang.junhui@zte.com.cn>,
	Michael Lyle <mlyle@lyle.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 090/121] bcache: stop writeback thread after detaching
Date: Wed, 11 Apr 2018 20:36:33 +0200
Message-Id: <20180411183501.952590673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476389519799220?=
X-GMAIL-MSGID: =?utf-8?q?1597476389519799220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui@zte.com.cn>


[ Upstream commit 8d29c4426b9f8afaccf28de414fde8a722b35fdf ]

Currently, when a cached device detaching from cache, writeback thread is
not stopped, and writeback_rate_update work is not canceled. For example,
after the following command:
echo 1 >/sys/block/sdb/bcache/detach
you can still see the writeback thread. Then you attach the device to the
cache again, bcache will create another writeback thread, for example,
after below command:
echo  ba0fb5cd-658a-4533-9806-6ce166d883b9 > /sys/block/sdb/bcache/attach
then you will see 2 writeback threads.
This patch stops writeback thread and cancels writeback_rate_update work
when cached device detaching from cache.

Compare with patch v1, this v2 patch moves code down into the register
lock for safety in case of any future changes as Coly and Mike suggested.

[edit by mlyle: commit log spelling/formatting]

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/super.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -921,6 +921,12 @@ static void cached_dev_detach_finish(str
 
 	mutex_lock(&bch_register_lock);
 
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread = NULL;
+	}
+
 	memset(&dc->sb.set_uuid, 0, 16);
 	SET_BDEV_STATE(&dc->sb, BDEV_STATE_NONE);
 
