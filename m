Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZo3zS5vABOBioGJ3FPlOUvk67ErOQwRL4pWgrR3MOLsgs8Z/uyHkmlvBSZFcEscrud+u1FF
ARC-Seal: i=1; a=rsa-sha256; t=1525780171; cv=none;
        d=google.com; s=arc-20160816;
        b=loeOnq7czSs4w+9/BQ/fObqXFcyc/0JxEztDYEjvNu7BW2Tu6vrKB0/n+E1s/nXK/a
         m+4kMGWVXPIVpqo7M6Fq81EerwW609lxFoBXquruOsEBMN0/MUYCHzP33WJQ+IrSZejX
         usUa1gTn12P7R8mQVYo6OPkPdtKVkvd4oyPeebb9mfyTt6kT20N2XrEW6YiZebzAVuQk
         GQyZ5Ln2ZKLhryM6Si8YTjPjEWLHBYG+nWpkB4S8HmjCRuMCyYcLAKl1eaC8+eJOc6Kr
         UNyo1CUlIS9pAH6CvaAqxeGE+iDA7IfHO0VSGQ2GhKLZYc+WugAK9rUhzZkcBcIg9O/Y
         kg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=3oXg2sChChfKPhPNCmHoFnlC04ifsi9a2IcLNL+n090=;
        b=QUqlcI1h696BlDODw0XeYQPRCyj2+a8y576ixCewCUwykhH6+k4dZMfHBL4uL0wxOS
         pE40zC6HsXRrNupr542BQ8Dl9gwHNEVx7qHk3meXbR3W3aMRRTtgMuAvmVu+tLnEYhyt
         MCGIu9iWqvzX0zMpbx76qlPswSCz/90owIreSKhqrrUay+XgEhD0gPE6iAyxCgDltM3v
         fx0CNKTJ2zj4VvvAClu5hvYKy/5eKTBDefpZhXgwdfl9O/P6PHeRDLHnfC8j4rBHl9vn
         eFrvptNAZOUzAJbYBSPX+IBswpqKd2Pzr6//rE8tW1z+1pqclYU59UUeUAy8/7W2vnH1
         1meg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 08 May 2018 04:49:30 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Mikko Perttunen" <mperttunen@nvidia.com>
Subject: [PATCH 3/8] mailbox: Add transmit done by blocking option
Date: Tue, 8 May 2018 14:43:58 +0300
Message-ID: <20180508114403.14499-4-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896468962132530?=
X-GMAIL-MSGID: =?utf-8?q?1599896468962132530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
send_data function of the mailbox driver is expected to block until
the message has been sent. The new option is used with the Tegra
Combined UART driver to minimize unnecessary overhead when transmitting
data.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
 drivers/mailbox/mailbox.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..5c76b70e673c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -53,6 +53,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	return idx;
 }
 
+static void tx_tick(struct mbox_chan *chan, int r, bool submit_next);
+
 static void msg_submit(struct mbox_chan *chan)
 {
 	unsigned count, idx;
@@ -60,10 +62,13 @@ static void msg_submit(struct mbox_chan *chan)
 	void *data;
 	int err = -EBUSY;
 
+next:
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
-		goto exit;
+	if (!chan->msg_count || chan->active_req) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return;
+	}
 
 	count = chan->msg_count;
 	idx = chan->msg_free;
@@ -82,15 +87,21 @@ static void msg_submit(struct mbox_chan *chan)
 		chan->active_req = data;
 		chan->msg_count--;
 	}
-exit:
+
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
 		/* kick start the timer immediately to avoid delays */
 		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+
+	if (chan->txdone_method & TXDONE_BY_BLOCK) {
+		tx_tick(chan, err, false);
+		if (!err)
+			goto next;
+	}
 }
 
-static void tx_tick(struct mbox_chan *chan, int r)
+static void tx_tick(struct mbox_chan *chan, int r, bool submit_next)
 {
 	unsigned long flags;
 	void *mssg;
@@ -101,7 +112,8 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Submit next message */
-	msg_submit(chan);
+	if (submit_next)
+		msg_submit(chan);
 
 	if (!mssg)
 		return;
@@ -127,7 +139,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 		if (chan->active_req && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
-				tx_tick(chan, 0);
+				tx_tick(chan, 0, true);
 			else
 				resched = true;
 		}
@@ -176,7 +188,7 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, true);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 
@@ -196,7 +208,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, true);
 }
 EXPORT_SYMBOL_GPL(mbox_client_txdone);
 
@@ -275,7 +287,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		ret = wait_for_completion_timeout(&chan->tx_complete, wait);
 		if (ret == 0) {
 			t = -ETIME;
-			tx_tick(chan, t);
+			tx_tick(chan, t, true);
 		}
 	}
 
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 456ba68513bb..ec68e2e28cd6 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -10,5 +10,6 @@
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+#define TXDONE_BY_BLOCK	BIT(3) /* mailbox driver send_data blocks until done */
 
 #endif /* __MAILBOX_H */
-- 
2.16.1
