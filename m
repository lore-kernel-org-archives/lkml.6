Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF560ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7411F21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVXdKou0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7411F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeIUBD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeIUBD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so4820660pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmS56beqTImL3Fl6E6Cwq10GeXJJvehS5phOJWJ21C4=;
        b=eVXdKou0wkV9Outr8mazEtsG/LuDsWW89sghkAAEF5d91eZtzNBqzdJ+dh7sUEAaVF
         scPvJDd0AjLO9Xi0xKtNCqxXcXyu6Xq31U2TGceMwWcBYWHs3gn97eBmKX0HwZdY+Fqq
         oysuwhDQwKjcAob2FXx6HoRZqfBlfLA7eycQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmS56beqTImL3Fl6E6Cwq10GeXJJvehS5phOJWJ21C4=;
        b=sshugw9/NdPp8Df6F24teV3cmP3JV6oAEQW6p28fcWrCznowdJhvvcExh+rKWP9Pg7
         txMtjlb5AM8/mL52gbCW6elMetFpJEn1pKIVCQMBC79KnTq9CE/zgt0f/WTFg2G5MCiR
         IDI3S2kcmGNUXcAbV5vxWQjiuYk+XyESQWOzSVrg+92XoInRQEVngw7jaPugFlfwwylZ
         mKRanXK1bDAIRjhoxfYs0EX9TR04KuWUIvpraCeRqFyd09vb251xFkCBOjW2iQHAYCOE
         V4c5dxJpPr3FZGKPI4BzKyQrtfbudbuQs4KCqyxURz0gtUvOnxfQMwFt0YBHNpjCla2z
         RdSQ==
X-Gm-Message-State: APzg51AQpLXn91rWPsP1ft/Q6pfd+8p5/tzTwpKUB3v4PTS9teTPzmhz
        Sw15P+x+hX3F8TKl0ORqMjmrZw==
X-Google-Smtp-Source: ANB0VdZ/P1RIzARx78KuZZzVG0qUOJ8+89UNwk87hUE0X9q+gD3joIiXLH4YdxVK+74EgLIR68MBuw==
X-Received: by 2002:a62:4255:: with SMTP id p82-v6mr42912778pfa.238.1537471136867;
        Thu, 20 Sep 2018 12:18:56 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:55 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 23/44] coresight: etb10: Refactor etb_drvdata::mode handling
Date:   Thu, 20 Sep 2018 13:17:58 -0600
Message-Id: <1537471099-19781-24-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
as it is for the ETF and ETR drivers.  This streamlines the code and adds
commonality with the other drivers when dealing with similar operations.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 9fd77fdc1244..69287163ce4e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -5,7 +5,6 @@
  * Description: CoreSight Embedded Trace Buffer driver
  */
 
-#include <asm/local.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -72,8 +71,8 @@
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
  * @spinlock:	only one at a time pls.
  * @reading:	synchronise user space access to etb buffer.
- * @mode:	this ETB is being used.
  * @buf:	area of memory where ETB buffer content gets sent.
+ * @mode:	this ETB is being used.
  * @buffer_depth: size of @buf.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -85,8 +84,8 @@ struct etb_drvdata {
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	local_t			reading;
-	local_t			mode;
 	u8			*buf;
+	u32			mode;
 	u32			buffer_depth;
 	u32			trigger_cntr;
 };
@@ -138,44 +137,48 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
 	int ret = 0;
-	u32 val;
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	/*
-	 * We don't have an internal state to clean up if we fail to setup
-	 * the perf buffer. So we can perform the step before we turn the
-	 * ETB on and leave without cleaning up.
-	 */
-	if (mode == CS_MODE_PERF) {
-		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
-		if (ret)
-			goto out;
-	}
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	val = local_cmpxchg(&drvdata->mode,
-			    CS_MODE_DISABLED, mode);
 	/*
 	 * When accessing from Perf, a HW buffer can be handled
 	 * by a single trace entity.  In sysFS mode many tracers
 	 * can be logging to the same HW buffer.
 	 */
-	if (val == CS_MODE_PERF)
-		return -EBUSY;
+	if (drvdata->mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* Don't let perf disturb sysFS sessions */
-	if (val == CS_MODE_SYSFS && mode == CS_MODE_PERF)
-		return -EBUSY;
+	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* Nothing to do, the tracer is already enabled. */
-	if (val == CS_MODE_SYSFS)
+	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_SYSFS)
 		goto out;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	/*
+	 * We don't have an internal state to clean up if we fail to setup
+	 * the perf buffer. So we can perform the step before we turn the
+	 * ETB on and leave without cleaning up.
+	 */
+	if (mode == CS_MODE_PERF) {
+		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+		if (ret)
+			goto out;
+	}
+
+	drvdata->mode = mode;
 	etb_enable_hw(drvdata);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
 	if (!ret)
 		dev_dbg(drvdata->dev, "ETB enabled\n");
 	return ret;
@@ -277,11 +280,14 @@ static void etb_disable(struct coresight_device *csdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	etb_disable_hw(drvdata);
-	etb_dump_hw(drvdata);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	local_set(&drvdata->mode, CS_MODE_DISABLED);
+	/* Disable the ETB only if it needs to */
+	if (drvdata->mode != CS_MODE_DISABLED) {
+		etb_disable_hw(drvdata);
+		etb_dump_hw(drvdata);
+		drvdata->mode = CS_MODE_DISABLED;
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "ETB disabled\n");
 }
@@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
+	if (drvdata->mode == CS_MODE_SYSFS) {
 		etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		etb_enable_hw(drvdata);
-- 
2.7.4

