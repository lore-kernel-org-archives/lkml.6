Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E891AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1AB2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1AB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeJBUO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbeJBUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:56 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 341E6C47;
        Tue,  2 Oct 2018 13:31:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 002/137] iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
Date:   Tue,  2 Oct 2018 06:23:23 -0700
Message-Id: <20181002132458.591076701@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 7d6cd21d82bacab2d1786fe5e989e4815b75d9a3 ]

When the buffer is enabled for ina2xx driver, a dedicated kthread is
invoked to capture mesurement data.  When the buffer is disabled, the
kthread is stopped.

However if the kthread gets register access errors, it immediately exits
and when the malfunctional buffer is disabled, the stale task_struct
pointer is accessed as there is no kthread to be stopped.

A similar issue in the usbip driver is prevented by kthread_get_run and
kthread_stop_put helpers by increasing usage count of the task_struct.
This change applies the same solution.

Cc: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ina2xx-adc.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/sched/task.h>
 #include <linux/util_macros.h>
 
 #include <linux/platform_data/ina2xx.h>
@@ -701,6 +702,7 @@ static int ina2xx_buffer_enable(struct i
 {
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	unsigned int sampling_us = SAMPLING_PERIOD(chip);
+	struct task_struct *task;
 
 	dev_dbg(&indio_dev->dev, "Enabling buffer w/ scan_mask %02x, freq = %d, avg =%u\n",
 		(unsigned int)(*indio_dev->active_scan_mask),
@@ -710,11 +712,17 @@ static int ina2xx_buffer_enable(struct i
 	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
 		chip->allow_async_readout);
 
-	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
-				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
-				 sampling_us);
+	task = kthread_create(ina2xx_capture_thread, (void *)indio_dev,
+			      "%s:%d-%uus", indio_dev->name, indio_dev->id,
+			      sampling_us);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	get_task_struct(task);
+	wake_up_process(task);
+	chip->task = task;
 
-	return PTR_ERR_OR_ZERO(chip->task);
+	return 0;
 }
 
 static int ina2xx_buffer_disable(struct iio_dev *indio_dev)
@@ -723,6 +731,7 @@ static int ina2xx_buffer_disable(struct
 
 	if (chip->task) {
 		kthread_stop(chip->task);
+		put_task_struct(chip->task);
 		chip->task = NULL;
 	}
 


