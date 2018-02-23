Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtMSLAUlf9nkh59Eft0JAYs0bpu84GyY/1dlh8dhbr8UtbjI7QV2oOn6O3FjQGIb8rPHEsa
ARC-Seal: i=1; a=rsa-sha256; t=1519403066; cv=none;
        d=google.com; s=arc-20160816;
        b=ukWRR160xeq8e8MzLDgEczD5zd+7rh5uSLSSxUXClwx3qgqcYWrLqXMqY4HL8qTWv5
         4kzvs9Te+5kLO/CHULphyyz6xIDJvfGZhYaQZuVCn2W3l+jQ3/03Z4g1RFOa5AACk01I
         9JD+7FwkbPbko8z8uqeS9ikStByNC3BIY6GfdeqqE0Cciqyu9Nj6U6tOdOwAQ3l/kaxI
         +TemLv/KLv5xkmIJz5MmQZnAgZBt48UXjG+3tc3XhYJdhsxp2Z6EpXDB2d/Kl+nRV6oX
         4b9oMXDxwjJ/8h+Lbvjs0fiUG1ayJlexZwThMGG6bf9y+y9+dYnAQ4PUzOWMuWBYY/FM
         V1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CHQWYzVGUcEK5mSTe/zbPq7Vjs+mNp9WK//3Yo7R1Xc=;
        b=gmmjwt5zsqNCKYlzS0pFLjMg3wsD+XoHBZ7gG6J49cnnZbLYOdgu2tgXyu2TnFDh+s
         VPu9WTYBqTkHrQRHsVnllqtDFfkMApr1ZFk8zHzl7LfCvPmSLYWTIjzI2b64LfQSKwSL
         ffv+hctvaUsNrHijBEAnuk/fqIowpqyiqRpDnaEN19knRSb8s7a1DUiNu+qf+uyLNmtt
         +6sv9WTZ4jLGPCU8cOAhN/qYIv3igBrHmgCHc/Ym5bmW/LFgsTYnA2LbjnfPL1G8QpXc
         txbk5oRnjippKrp3AgCBCsPEqzSa50haByCLzoXgOS1c2Hb2jNvyj6js9//dCS2bPLma
         tGKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 11/20] firmware: arm_scmi: add support for polling based SCMI transfers
Date: Fri, 23 Feb 2018 16:23:41 +0000
Message-Id: <1519403030-21189-12-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209589775101518?=
X-GMAIL-MSGID: =?utf-8?q?1593209589775101518?=
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
 drivers/firmware/arm_scmi/driver.c | 55 ++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 970c3a8c6e96..e6698629e15a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -29,10 +29,12 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/processor.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
 
@@ -346,6 +348,30 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
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
+#define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
+
+static bool scmi_xfer_done_no_timeout(const struct scmi_info *info,
+				      struct scmi_xfer *xfer, ktime_t stop)
+{
+	ktime_t __cur = ktime_get();
+
+	return scmi_xfer_poll_done(info, xfer) || ktime_after(__cur, stop);
+}
+
 /**
  * scmi_do_xfer() - Do one transfer
  *
@@ -372,15 +398,28 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	/* mbox_send_message returns non-negative value on success, so reset */
 	ret = 0;
 
-	/* And we wait for the response. */
-	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
-		dev_err(dev, "mbox timed out in resp(caller: %pS)\n",
-			(void *)_RET_IP_);
-		ret = -ETIMEDOUT;
-	} else if (xfer->hdr.status) {
-		ret = scmi_to_linux_errno(xfer->hdr.status);
+	if (xfer->hdr.poll_completion) {
+		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
+
+		spin_until_cond(scmi_xfer_done_no_timeout(info, xfer, stop));
+
+		if (ktime_before(ktime_get(), stop))
+			scmi_fetch_response(xfer, info->tx_payload);
+		else
+			ret = -ETIMEDOUT;
+	} else {
+		/* And we wait for the response. */
+		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
+		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
+			dev_err(dev, "mbox timed out in resp(caller: %pS)\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		}
 	}
+
+	if (!ret && xfer->hdr.status)
+		ret = scmi_to_linux_errno(xfer->hdr.status);
+
 	/*
 	 * NOTE: we might prefer not to need the mailbox ticker to manage the
 	 * transfer queueing since the protocol layer queues things by itself.
-- 
2.7.4
