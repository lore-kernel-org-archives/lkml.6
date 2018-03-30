Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522379765; cv=none;
        d=google.com; s=arc-20160816;
        b=uoywexZdUzqjJNbWTcoW/VlEZln6N+3wzFwbGsfcG4fdKjxf3nGAk/MgJapdTCKNsk
         8muUv9F1Q1EL0TCwyXmelGyWNJ4sc5U2NA1c0QIo4YKCuP9FZbIwyo4MnDZjxaQhlmVp
         okTyvdYra+Igfmz5O8FpZjnpEujgvzM9X6lbwH12qmN7EC0maPeTI30TQkfNsaWqKfwq
         v+KQJGsnpfpPIBmQLFsuos4mwyo2WgtLr2G6xsfpyKdWjiwAZ1ErrTs4Qzisa/YmM3Y2
         7OJEqaV4dp0w0tAyhBnRaFhBjIgGnAwOwTx4SJfvhcIqMoS4C9Gk9UywLBL0x7b/VcQ5
         FugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HpmWK/7Q87q15GSW6+wUQSscqm4fAYVRmYYCeuwbnNw=;
        b=dPWitcs6gAh05RWs7DHA6cQtwQIqzrGAa29OZY0dFMhQdMfjjPJ7JBkm4wPJC9VY0m
         tJvo7Co/peBJQXBXjg2LCCfX7lsj49lStaUAjuBDs1RrmuKDmt62yCOia9t2vJbsiT5J
         UfxKixC4oqH2qtI1oLVZ32sq77tVkMdYPqf9T/gKgSBTdhaPe28h4sA2c/C/gsXcW1MX
         DGJ89WQlwJ89uiX4Qtfey7y/p+5H1v7P+pt93yMkVpgvLi7Xk+/QTqEU46FfKybuyqHE
         ZZKmXXtqq/Pkr66vH9sTXIYnKH+iYatM7JZrCvLv5bp+PGKDD1wwrw0XdaU8eP0ym/nl
         5Rzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XMsb5V8m;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XMsb5V8m;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+gbi+82S56f0PFR9nTXThbF/t6iDlzni03R5NrGl4GoNtgK6L2tafQ90olVPp0zhTir1280A==
From: Leo Yan <leo.yan@linaro.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/6] coresight: tmc: Hook callback for panic kdump
Date: Fri, 30 Mar 2018 11:15:22 +0800
Message-Id: <1522379724-30648-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330884321271490?=
X-GMAIL-MSGID: =?utf-8?q?1596330884321271490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since Coresight panic kdump functionality has been ready, this patch is
to hook panic callback function for ETB/ETF driver.  The driver data
structure has allocated a buffer when the session started, so simply
save tracing data into this buffer when panic happens and update buffer
related info for kdump.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e2513b7..d20d546 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -504,6 +504,35 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	CS_LOCK(drvdata->base);
 }
 
+static void tmc_panic_cb(void *data)
+{
+	struct coresight_device *csdev = (struct coresight_device *)data;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
+			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
+		return;
+
+	if (drvdata->mode == CS_MODE_DISABLED)
+		return;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+	tmc_etb_dump_hw(drvdata);
+
+	CS_LOCK(drvdata->base);
+
+	/* Update buffer info for panic dump */
+	csdev->kdump_buf = drvdata->buf;
+	csdev->kdump_buf_sz = drvdata->len;
+
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -512,6 +541,7 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.set_buffer	= tmc_set_etf_buffer,
 	.reset_buffer	= tmc_reset_etf_buffer,
 	.update_buffer	= tmc_update_etf_buffer,
+	.panic_cb	= tmc_panic_cb,
 };
 
 static const struct coresight_ops_link tmc_etf_link_ops = {
-- 
2.7.4
