Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48vjkytwmrz4jCjiIbQ3HASoVuKYDdcDpfqS3xIAQvJW2XBA2RpckBVCAgYHNYF/URQIiP/
ARC-Seal: i=1; a=rsa-sha256; t=1523473461; cv=none;
        d=google.com; s=arc-20160816;
        b=PnUncOUc3dIsDeOPqZHPQ7eT0mYDtSDE/DhNUibtCBi7J7kkurIfvAY1pHQdJyCf3b
         atet265TtipkS/CI80Q1CkDU3158Ym2B/HmpVMP1quRJjMJqoK0EacO1s0Y4Cw/XNyF1
         OOxXkAAydFxQE9pOBavZBlEo16XXDGoxLAi1XiKeobLZTzt1opiDjdgEg8mNDs7AxDuJ
         JoOaTlms9XyvxPiew4uCCx4fdwZV+O0dGFWSHLmMe5C95RVXeq5O3iB89gxlsIxrdF2K
         n82q11SkT7D6eQl9Zv+e0nlJl5iEqZ+xvMJW9HZzxvbFLSBTJYip9E1UcMBPlQQ0IM3S
         yTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jJNST+8XA8NqKPPxC2vqUJeQ6JlC9cTAfyWxAYpo91Q=;
        b=UgUQG8CHktAliMSdscbnBkXpEA+0eFwlr6iqaQifV6sMKGaN9xHYvEhlszvf4L9LAF
         UgRhcIG9/Q/VHycvphX6hYveb+fV6WKSfwNO0Vq9AW/XZ4N9gIpfsxEst1P5MRtNvCwM
         MOSjWchOEPLgjCM/4vduua6qofBkATfTNAuAhmszQvhSsJB73fAUyboCCHCy7T3gVy56
         dmALwHuI6Ro4y+hXeKNmOvfhgdXfxYkffrqyifOiHzOr21A8G8efFBuwYMMJv7KQeJL2
         I5yyFnDe3/5LbGzw5Pcc5CYMHe1jLsT5QapJIRUf2Ya9Erjy8N04dAo/y706vQHQ067o
         JG6w==
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
Subject: [PATCH 4.9 257/310] bcache: stop writeback thread after detaching
Date: Wed, 11 Apr 2018 20:36:36 +0200
Message-Id: <20180411183633.503892713@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476389519799220?=
X-GMAIL-MSGID: =?utf-8?q?1597477708311323214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -892,6 +892,12 @@ static void cached_dev_detach_finish(str
 
 	mutex_lock(&bch_register_lock);
 
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread = NULL;
+	}
+
 	memset(&dc->sb.set_uuid, 0, 16);
 	SET_BDEV_STATE(&dc->sb, BDEV_STATE_NONE);
 
