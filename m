Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+UOqSaJHFQnXAxLV+vKm6oQrpRUSFagvXoZ8p0hL+nKj6EYGsrz3Ua1FD6bdfEveF8IMww
ARC-Seal: i=1; a=rsa-sha256; t=1523399771; cv=none;
        d=google.com; s=arc-20160816;
        b=F7DWKIDUxB/cW6TADkbsyOq3Evah4K7msz9j61q7205w1HgCkVyfRgqndQ9EXir6PV
         k2m0k6coy4RZQcChOz4OxcxiBTQuN8qRPcnzWP9YJGrEoIgS1xGDZhJKHZFqWxRB/8lv
         pqB48V9GUpwF14aBOW+jBqRroxiFL8tNIBYh9iSH/72TCN+0P8FK+Ux4pIJ7A4o5CDH4
         ldQ8nJciTt4HOVjStcYrv5e48QIvRePd+3sGJ29fyreNJovcWw49Z40mAR+NhwnKlJMx
         5WL/w39om73tzXnwFo04eXSumUPY/nMLQwZP3kkc7CZE+JYxLmqa5QnzLvi5lFfNM8s0
         HI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lDZpQYtmtY4FfmQ1W/V6dfXWJHHweV6B8oDkIfpXxbQ=;
        b=EmDoDXxx/w5geAPnqGWRWz9ErdtXSd8hgTGDWyod6E46XU6YYOUESeXKupr6ZPwKWB
         65Q+55fo/tD4mL/ulK2KhchJVFHN0sV++cFpZqU54ZGUSg9RNEuyeHQHwsIhfLg61XYQ
         oT5Dt3F+RFZHhTE8behoAVhz81l7tEp42ApSL6NKRcxXwDB6KGVFdtHOchgNSCQi3GzC
         BMF8cjyMps9TBEaT3BpFy/L0ETzfOfujMLj5o4MWhCDGMfcvA+ekx2OlRxO0Q/H1+GN1
         bgvm2d0BmGOw2562mMeMQ5yiH5ziL0krElTpDryqBjGR85YMitKAKY9b8mAgxtNs0Fco
         jE7g==
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
Subject: [PATCH 4.14 058/138] bcache: stop writeback thread after detaching
Date: Wed, 11 Apr 2018 00:24:08 +0200
Message-Id: <20180410212908.834750246@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400013609893201?=
X-GMAIL-MSGID: =?utf-8?q?1597400437947239190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -893,6 +893,12 @@ static void cached_dev_detach_finish(str
 
 	mutex_lock(&bch_register_lock);
 
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread = NULL;
+	}
+
 	memset(&dc->sb.set_uuid, 0, 16);
 	SET_BDEV_STATE(&dc->sb, BDEV_STATE_NONE);
 
