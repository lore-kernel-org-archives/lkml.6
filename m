Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4808t4jLY/KbsYkPSiD1oa5lhJ5ekBxlQU8c3JPUNBMpHX0VVuP9NYmlfD5GPvaYjOHhJNB
ARC-Seal: i=1; a=rsa-sha256; t=1523399365; cv=none;
        d=google.com; s=arc-20160816;
        b=aA++M6Ygqk/EnbksVXOklqnHK3RwR3e8XHz8s+CCHmr3a+4lIpD3dkECuxr3XqJeZN
         +8hHcCTLBVuWNpv/jhoy1ber7Gn6Wzd68a6TEmCCvHknAkT8LtC5GAUxYQtgXraJbwrk
         YENRKZ0yhtB8EM93/oD4TxCZfmFbQNRPzoWmyt+ymIygs5WIAdwvjekQKSkYGKgmwWTB
         EVyx8e182teVJMK7Le9VJ/DKgC+pa/vQ04lTaoLFQl0OPb5x42Ry7p5hPqpCtWnp73rH
         A5KYwGiw4XeI3Gzi++PCZrrRf2ielZsloyD85fo8WJLlgdtK1+oI3INYQk3XW7fd4m3M
         7cHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YHgfYIJZo73rVbQlvyfxSR8dim9NBBoMNxzYy2NIkXw=;
        b=rATRsDmVOjmcSZfMUDCUoG3kG6SQaAsubxw7cOFZsTe3vzd5ihlTgT5qvZkSCgc6kd
         uKyxVdllffQB0VzuCfH+NqR5ymTh3bipzINHPI9F/8zLcthoB4oTP+RlBTqofDA3V4UC
         K6srvTtQZ36bOlUBnAvJjxeMARh7irZINIwweVAOaNxvR94E3a0ZMFVp89srjPf8sd5O
         juSBTF0LeJpRU+gqKzTxa5slLOZZwWOVpJ/xqU86MxH2RMvPWfVmQj2v7cJXpQ5SvspI
         5hJQN2SYIv1hfC4zT9d01rlASMgOWdCnAT7Izt5Rt6ZOevuyj+e9wT7wv1KK0GWRnBd8
         7d7g==
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
Subject: [PATCH 4.15 073/168] bcache: stop writeback thread after detaching
Date: Wed, 11 Apr 2018 00:23:35 +0200
Message-Id: <20180410212803.298076212@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400013609893201?=
X-GMAIL-MSGID: =?utf-8?q?1597400013609893201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -906,6 +906,12 @@ static void cached_dev_detach_finish(str
 
 	mutex_lock(&bch_register_lock);
 
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread = NULL;
+	}
+
 	memset(&dc->sb.set_uuid, 0, 16);
 	SET_BDEV_STATE(&dc->sb, BDEV_STATE_NONE);
 
