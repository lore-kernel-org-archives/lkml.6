Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F9C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54220663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693058;
	bh=weP5wNqF3syjXpJOod6mfYe7aPJClX9NCQ4XhvJVZVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfdK6DHrdEGkq1yDCMG6JbBvOebJMSvfDvSBCc9FzO6vUGaiqDejpQPesoPPFKdux
	 D9B8qwYleRh8l/70AEJbN/bdXbg6mI3JknWLGgO++laKuV5HLAN9jZzhuiy0CopU+q
	 Oh9TBzSVquBvi7UXZ//V2MSFHjfUpzPcef/PuIYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbfA1Qa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389616AbfA1Q1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:27:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82E7520879;
        Mon, 28 Jan 2019 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692842;
        bh=weP5wNqF3syjXpJOod6mfYe7aPJClX9NCQ4XhvJVZVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmQ43U+6d1IIw6sTpce4ZSsAsN21osdB3ZIpwAL8WU1fmWXwR/Mw0oxaUWaV7GJ8r
         YfNMVpBZnq6MAHw1APqixd+T3Kcbob2ebrqLQPI33MKKUTLH4KLnvuCJCW0BnDsE6X
         W9DDSLBptfc/F0eCIHJYo2VvpfoYeejQz8o3sqCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 33/61] memstick: Prevent memstick host from getting runtime suspended during card detection
Date:   Mon, 28 Jan 2019 11:25:55 -0500
Message-Id: <20190128162623.59854-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit e03e303edf1c63e6dd455ccd568c74e93ef3ba8c ]

We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
helpers to let memstick host support runtime pm.

The rpm count may go down to zero before the memstick host powers on, so
the host can be runtime suspended.

So before doing card detection, increment the rpm count to avoid the
host gets runtime suspended. Balance the rpm count after card detection
is done.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/core/memstick.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index a0547dbf9806..4d673a626db4 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #define DRIVER_NAME "memstick"
 
@@ -436,6 +437,7 @@ static void memstick_check(struct work_struct *work)
 	struct memstick_dev *card;
 
 	dev_dbg(&host->dev, "memstick_check started\n");
+	pm_runtime_get_noresume(host->dev.parent);
 	mutex_lock(&host->lock);
 	if (!host->card) {
 		if (memstick_power_on(host))
@@ -479,6 +481,7 @@ static void memstick_check(struct work_struct *work)
 		host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
 
 	mutex_unlock(&host->lock);
+	pm_runtime_put(host->dev.parent);
 	dev_dbg(&host->dev, "memstick_check finished\n");
 }
 
-- 
2.19.1

