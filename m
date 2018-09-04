Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F7C20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F7C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeIDLjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:39:55 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:62159 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIDLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:39:55 -0400
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id w847DRj5008557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Sep 2018 15:13:27 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 4 Sep 2018 15:14:20
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeson Gao <jeson.gao@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] thermal: core: using power_efficient_wq for thermal worker
Date:   Tue, 4 Sep 2018 15:14:08 +0800
Message-ID: <1536045248-11677-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536043068-11487-1-git-send-email-chunyan.zhang@unisoc.com>
References: <1536043068-11487-1-git-send-email-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com w847DRj5008557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeson Gao <jeson.gao@unisoc.com>

For SMP systems, thermal worker should use power_efficient_wq in power
saving mode, that will make scheduler more flexible on selecting an active
core for running work handler to avoid keeping work handler always
running on a single core, that will save some power.

Even if 'power_efficient_wq' relevant configs are disabled
'system_freezable_power_efficient_wq' is identical to system_freezable_wq,
behavior is unchanged.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab9823..99df89f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -290,10 +290,12 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
 	if (delay > 1000)
-		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				 &tz->poll_queue,
 				 round_jiffies(msecs_to_jiffies(delay)));
 	else if (delay)
-		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				 &tz->poll_queue,
 				 msecs_to_jiffies(delay));
 	else
 		cancel_delayed_work(&tz->poll_queue);
-- 
2.7.4

