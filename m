Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A810ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC3C21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uw+QkZmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC3C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbeIUBEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45873 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbeIUBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so4778313pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pk5MkE6PXktMeFUSi0eF98V5qiRjEJiXczfdfCTR7uw=;
        b=Uw+QkZmhSsWPmEUrlhYaDqvbj4V5m5NeQchOEHvUqsZ7IgWQMYsg8cvR3dH4cCsE0g
         9YY6ZEYG7EdfDmYQUXVRnuxJe4DefS2Ah1RhuxXwcMwxzRdUvRfcsUmiRbTNXmKFciZZ
         sj6VWndu+/pssOV5fsWGatSgPnNCsDew0TCo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pk5MkE6PXktMeFUSi0eF98V5qiRjEJiXczfdfCTR7uw=;
        b=LeqRFX3lSisJ5NcIUafi+Fo0YpnVW/9lam4rPEVgKo0LGGrFmlRW0FK4Q3+wEkNVlp
         rsIAY7iuBPTsrBlYN/kBPIWgvovJPqBpsMefzaWD8J+lKVl/MRih5z3LwFAy9wO3EqWX
         vbnD2TwCPa0CLva+L9WQzdnyXj9rJCCNhZ4QuXUFwR3UJce28mRCrbT0iEeruNBwLDkI
         L5n8ELFwcufL4ziZlDZJ6rrqSSlqOZPMwsl6GQNSGmomg3rwumjF5slaiZ1KvDsMqD18
         /Pb9uUoA2jVsGvs54bHPFfV4uGVfntQVzcx8MUj7a7KmJZM3l/w4KOy/DOw5JnLgQXdL
         zmLw==
X-Gm-Message-State: APzg51Bjaj2AAJMsYnLmqMlWMa01GIir2BEKrrW2gyLbgnRobeTiYFAB
        Sk6yMVSzKualqgK2JrSqkKVNCWseJf8=
X-Google-Smtp-Source: ANB0VdYP3IYN5XAL8EY2vMI7+c1HTX1rAn+fw/WjS/T9zKCP3L/9AGuFezxvj0tuuomdd9icSIsFDQ==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr39949151plp.14.1537471146333;
        Thu, 20 Sep 2018 12:19:06 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:05 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 29/44] coresight: tmc-etr: Refactor for handling errors
Date:   Thu, 20 Sep 2018 13:18:04 -0600
Message-Id: <1537471099-19781-30-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Refactor the tmc-etr enable operation to make it easier to
handle errors in enabling the hardware. We need to make
sure that the buffer is compatible with the ETR. This
patch re-arranges to make the error handling easier, by
deferring the hardware enablement until all the errors
are checked. This also avoids turning the CATU on/off
during a sysfs read session.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 67 ++++++++++++++++---------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 56fea4ff947e..c42693542ec8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -918,21 +918,10 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
-static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
-			      struct etr_buf *etr_buf)
+static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
-
-	/* Callers should provide an appropriate buffer for use */
-	if (WARN_ON(!etr_buf || drvdata->etr_buf))
-		return;
-	drvdata->etr_buf = etr_buf;
-
-	/*
-	 * If this ETR is connected to a CATU, enable it before we turn
-	 * this on
-	 */
-	tmc_etr_enable_catu(drvdata);
+	struct etr_buf *etr_buf = drvdata->etr_buf;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -952,11 +941,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 		axictl |= TMC_AXICTL_ARCACHE_OS;
 	}
 
-	if (etr_buf->mode == ETR_MODE_ETR_SG) {
-		if (WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
-			return;
+	if (etr_buf->mode == ETR_MODE_ETR_SG)
 		axictl |= TMC_AXICTL_SCT_GAT_MODE;
-	}
 
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, etr_buf->hwaddr);
@@ -982,6 +968,32 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
+			     struct etr_buf *etr_buf)
+{
+	/* Callers should provide an appropriate buffer for use */
+	if (WARN_ON(!etr_buf))
+		return -EINVAL;
+
+	if ((etr_buf->mode == ETR_MODE_ETR_SG) &&
+	    WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
+		return -EINVAL;
+
+	if (WARN_ON(drvdata->etr_buf))
+		return -EBUSY;
+
+	/* Set the buffer for the session */
+	drvdata->etr_buf = etr_buf;
+	/*
+	 * If this ETR is connected to a CATU, enable it before we turn
+	 * this on.
+	 */
+	tmc_etr_enable_catu(drvdata);
+
+	__tmc_etr_enable_hw(drvdata);
+	return 0;
+}
+
 /*
  * Return the available trace data in the buffer (starts at etr_buf->offset,
  * limited by etr_buf->len) from @pos, with a maximum limit of @len,
@@ -1037,7 +1049,7 @@ static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
 	}
 }
 
-static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -1053,6 +1065,11 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 
 	CS_LOCK(drvdata->base);
 
+}
+
+static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
 	/* Reset the ETR buf used by hardware */
@@ -1111,8 +1128,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		drvdata->sysfs_buf = new_buf;
 	}
 
-	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+	ret = tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -1342,8 +1360,9 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
 	drvdata->perf_data = etr_perf;
-	drvdata->mode = CS_MODE_PERF;
-	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
+	if (!rc)
+		drvdata->mode = CS_MODE_PERF;
 
 unlock_out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1425,7 +1444,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	/* Disable the TMC if we are trying to read from a running session. */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etr_disable_hw(drvdata);
+		__tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
@@ -1452,7 +1471,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
 		 * be NULL.
 		 */
-		tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
+		__tmc_etr_enable_hw(drvdata);
 	} else {
 		/*
 		 * The ETR is not tracing and the buffer was just read.
-- 
2.7.4

