Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x224nR5LJxeHAAtZ7QGr3zambKaZUbUWyXEKXiW3CYQBjhFRWxjmexFX3z+q27iPY47GUgbnz
ARC-Seal: i=1; a=rsa-sha256; t=1518461160; cv=none;
        d=google.com; s=arc-20160816;
        b=KJQWbn5Nol6ph8XaRQFs4UOBAqEy881+2iIuE4AvVHloQFQwoi+jx7GATFW4S6Lh2R
         0rGM7FeY6qra/UmyPW8afm4MSq8eDKp1fNd5xFy7TZtsQeykSoh746mWLHBFkw6JaQsj
         Pt/sZgT9HNzoQz5aKkF7+0syzb7ibc+Amlq9bKU2d9sSWg0gwBNEqltZhj50bc9q+eZs
         JeJYfOpY+oVZRPzZ/Y/+aopFna4opSnOtlxjcgqRGmHR1L35ueJwAtfUlWWE2d0a5wJS
         j/oH1+ObjdL0zFfrDt8HI/cW/TJKT6z0/A837sNp5/clI97glmobNSf6xqpu5pGr67Pg
         w8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CsrEWVgEUhhJgU40rXv8P5u1lcGWdHKSRDHyrDyeuMg=;
        b=eLQwWDLSMchM0DJm7/cI1iF+jeeBTSivaCtBSso/B3KP/QkcAfHC8K08OeD16QhgF+
         FnaS7evRLxS65CicJwVi2Xo22D/dzLUKjGBdtwJAmzEaNYxEdhj1EX3GJmTeIBAnfx0W
         zXctaVtlS50/mD1vGzzrX6qoYBRtMSTQg0H3/cZbDbgldFMY1LBHkXAdu24CXdiVygNe
         HXPSYKRN9JxFScxaiMpnkyUTywD6RwUd6sTaN7lzekt9ndKJXm7xDB54LXMIeO0MTKW3
         Hf+DDs8pEC+IMXvKKcpGxz407nbDD3N/AHOhNMkCS6PgAVMyLUhMrBsbV36WPCw2MyE/
         yWkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH v5 11/20] firmware: arm_scmi: add support for polling based SCMI transfers
Date: Mon, 12 Feb 2018 18:45:15 +0000
Message-Id: <1518461124-17371-12-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221930093758193?=
X-GMAIL-MSGID: =?utf-8?q?1592221930093758193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It would be useful to have options to perform some SCMI transfers
atomically by polling for the completion flag instead of interrupt
driven. The SCMI specification has option to disable the interrupt and
poll for the completion flag in the shared memory.

This patch adds support for polling based SCMI transfers using that
option. This might be used for uninterrupted/atomic DVFS operations
from the scheduler context.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 49 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 939ef626bfdd..0108bb39d0f6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -26,9 +26,11 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -346,6 +348,21 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
+static bool
+scmi_xfer_poll_done(const struct scmi_info *info, struct scmi_xfer *xfer)
+{
+	struct scmi_shared_mem *mem = info->tx_payload;
+	u16 xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
+
+	if (xfer->hdr.seq != xfer_id)
+		return false;
+
+	return le32_to_cpu(mem->channel_status) &
+		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
+		SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
+}
+
+#define SCMI_MAX_POLLING_TIMEOUT_NS	(100 * NSEC_PER_USEC)
 /**
  * scmi_do_xfer() - Do one transfer
  *
@@ -372,14 +389,30 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	/* mbox_send_message returns non-negative value on success, so reset */
 	ret = 0;
 
-	/* And we wait for the response. */
-	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
-		dev_err(dev, "mbox timed out in resp(caller: %pF)\n",
-			(void *)_RET_IP_);
-		ret = -ETIMEDOUT;
-	} else if (xfer->hdr.status) {
-		ret = scmi_to_linux_errno(xfer->hdr.status);
+	if (xfer->hdr.poll_completion) {
+		ktime_t stop, cur;
+
+		stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLLING_TIMEOUT_NS);
+		do {
+			udelay(5);
+			cur = ktime_get();
+		} while (!scmi_xfer_poll_done(info, xfer) &&
+			 ktime_before(cur, stop));
+
+		if (ktime_before(cur, stop))
+			scmi_fetch_response(xfer, info->tx_payload);
+		else
+			ret = -ETIMEDOUT;
+	} else {
+		/* And we wait for the response. */
+		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
+		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
+			dev_err(dev, "mbox timed out in resp(caller: %pF)\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		} else if (xfer->hdr.status) {
+			ret = scmi_to_linux_errno(xfer->hdr.status);
+		}
 	}
 	/*
 	 * NOTE: we might prefer not to need the mailbox ticker to manage the
-- 
2.7.4
