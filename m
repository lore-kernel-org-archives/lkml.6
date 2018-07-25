Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1FAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C95E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C95E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeGYQht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:37:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57231 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeGYQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:37:49 -0400
Received: from 1-161-144-158.dynamic-ip.hinet.net ([1.161.144.158] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fiLfU-00012O-T1; Wed, 25 Jul 2018 15:25:37 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/5] memstick: Prevent memstick host from getting runtime suspended during card detection
Date:   Wed, 25 Jul 2018 23:25:12 +0800
Message-Id: <20180725152515.1833-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725152515.1833-1-kai.heng.feng@canonical.com>
References: <20180725152515.1833-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
helpers to let memstick host support runtime pm.

There's a small window between memstick_detect_change() and its queued
work, memstick_check(). In this window the rpm count may go down to zero
before the memstick host powers on, so the host can be inadvertently
suspended.

Increment rpm count before calling memstick_check(), and decrement rpm
count afterward, as now we are sure the memstick host should be
suspended or not.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/memstick/core/memstick.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 76382c858c35..944fe0c93fa7 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #define DRIVER_NAME "memstick"
 
@@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_dev *card)
  */
 void memstick_detect_change(struct memstick_host *host)
 {
+	pm_runtime_get_noresume(host->dev.parent);
 	queue_work(workqueue, &host->media_checker);
 }
 EXPORT_SYMBOL(memstick_detect_change);
@@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work)
 		host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
 
 	mutex_unlock(&host->lock);
+
+	pm_runtime_put_noidle(host->dev.parent);
 	dev_dbg(&host->dev, "memstick_check finished\n");
 }
 
-- 
2.17.1

