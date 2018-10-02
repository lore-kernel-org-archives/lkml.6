Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8EC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139D42083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139D42083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJBUK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeJBUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:25 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB94FB2F;
        Tue,  2 Oct 2018 13:27:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 006/228] siox: dont create a thread without starting it
Date:   Tue,  2 Oct 2018 06:21:43 -0700
Message-Id: <20181002132459.478244587@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit e890591413819eeb604207ad3261ba617b2ec0bb ]

When a siox master device is registered a kthread is created that is
only started when triggered by userspace. So this thread might be in
TASK_UNINTERRUPTIBLE state for long and trigger a warning

	[  241.130465] INFO: task siox-0:626 blocked for more than 120 seconds.

with the respective debug settings enabled. It might be right to put an
unstarted thread to TASK_IDLE (in kernel/kthread.c:kthread()) instead,
but independant of this discussion it is cleaner for
siox_master_register() to start the thread immediately. The effect is
that it enters its own waiting state and then stays in state TASK_IDLE
which doesn't trigger the above warning.

As siox_poll_thread() uses some variables of the device the
initialisation of these is moved before thread creation.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Gavin Schenk <g.schenk@eckelmann.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/siox/siox-core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -715,17 +715,17 @@ int siox_master_register(struct siox_mas
 
 	dev_set_name(&smaster->dev, "siox-%d", smaster->busno);
 
+	mutex_init(&smaster->lock);
+	INIT_LIST_HEAD(&smaster->devices);
+
 	smaster->last_poll = jiffies;
-	smaster->poll_thread = kthread_create(siox_poll_thread, smaster,
-					      "siox-%d", smaster->busno);
+	smaster->poll_thread = kthread_run(siox_poll_thread, smaster,
+					   "siox-%d", smaster->busno);
 	if (IS_ERR(smaster->poll_thread)) {
 		smaster->active = 0;
 		return PTR_ERR(smaster->poll_thread);
 	}
 
-	mutex_init(&smaster->lock);
-	INIT_LIST_HEAD(&smaster->devices);
-
 	ret = device_add(&smaster->dev);
 	if (ret)
 		kthread_stop(smaster->poll_thread);


