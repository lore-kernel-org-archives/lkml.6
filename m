Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/4QEsZzOqVGErvGzailPjPZihKE+sj6KeBi5m2Fk1QXp+bk84nXdEvUfxbgGPBTjhJheEr
ARC-Seal: i=1; a=rsa-sha256; t=1523473422; cv=none;
        d=google.com; s=arc-20160816;
        b=NOy3WX12EiQ6y0bRPLKG67DiL24JYpyDpwjZRPicFrRtz9uypPZOikKgFLYpKxSFDo
         HdeWEJpspWc5gPSSqOMSgNwwu25v3OutdGu285hJuD7h3RSG07ZODbXs4aN6iZnO3ql3
         w+tnkBd1wWAGAPQvletanhSZbs8zupt+UdaZHZoaos2ccM75wpWQ4adJVpHS1c2/YZca
         JdT3azDeg0x4tESEvzbekQPwH0Vhel/d6p6iBWjg7TA+X4ian74HJ5kjaSznFmLmVOFa
         u++OK9ckkSxv5wZZUyhi3g7bzPvtC+gjFB2t1gV8efDEVONHVfcVkwWC65ftjoiNz1js
         V4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i50J5FM2Wpqc1lHS9RlUwN0J0zU6YwXtv3klu00Mut4=;
        b=vutF6cwQc7PNFZg+PUZ3FP7QNMTTKCpfnZynmyfMbZixd1tGVjvLwz1iAL9tM1J2rk
         hCNy6LHszK6jgGaVwFoVZNXFMiL7QmSv9xJh5xzJ2yHaoZnCLz1AtC6bMXYDQ1bTdJpn
         /YjAyw0sAj/kiLgMcZWQW5g/c4zXqe2AU2Z3axdx2mopGo8kbvLkbJ2LKldrxfha9vRW
         JMmVSkYU+r6qNp8NFUES6YQOzPM5WbUQZdDEiP03jKPZvxE2gUL/YWFwWrRjvN8ih+sx
         gweA1dVoAmrZDOXUL/GxmrWQMyUpmKQZNJlccIP/WMun7ybcxLtcpIRzR3DJH4eehbD6
         NwHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Netanel Belgazal <netanel@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 241/310] net: ena: fix rare uncompleted admin command false alarm
Date: Wed, 11 Apr 2018 20:36:20 +0200
Message-Id: <20180411183632.847583014@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477667758581998?=
X-GMAIL-MSGID: =?utf-8?q?1597477667758581998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>


[ Upstream commit a77c1aafcc906f657d1a0890c1d898be9ee1d5c9 ]

The current flow to detect admin completion is:
while (command_not_completed) {
	if (timeout)
		error

	check_for_completion()
		sleep()
   }
So in case the sleep took more than the timeout
(in case the thread/workqueue was not scheduled due to higher priority
task or prolonged VMexit), the driver can detect a stall even if
the completion is present.

The fix changes the order of this function to first check for
completion and only after that check if the timeout expired.

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -508,15 +508,20 @@ static int ena_com_comp_status_to_errno(
 static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_ctx,
 						     struct ena_com_admin_queue *admin_queue)
 {
-	unsigned long flags;
-	u32 start_time;
+	unsigned long flags, timeout;
 	int ret;
 
-	start_time = ((u32)jiffies_to_usecs(jiffies));
+	timeout = jiffies + ADMIN_CMD_TIMEOUT_US;
 
-	while (comp_ctx->status == ENA_CMD_SUBMITTED) {
-		if ((((u32)jiffies_to_usecs(jiffies)) - start_time) >
-		    ADMIN_CMD_TIMEOUT_US) {
+	while (1) {
+		spin_lock_irqsave(&admin_queue->q_lock, flags);
+		ena_com_handle_admin_completion(admin_queue);
+		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
+
+		if (comp_ctx->status != ENA_CMD_SUBMITTED)
+			break;
+
+		if (time_is_before_jiffies(timeout)) {
 			pr_err("Wait for completion (polling) timeout\n");
 			/* ENA didn't have any completion */
 			spin_lock_irqsave(&admin_queue->q_lock, flags);
@@ -528,10 +533,6 @@ static int ena_com_wait_and_process_admi
 			goto err;
 		}
 
-		spin_lock_irqsave(&admin_queue->q_lock, flags);
-		ena_com_handle_admin_completion(admin_queue);
-		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
-
 		msleep(100);
 	}
 
