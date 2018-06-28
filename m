Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A78BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A2127099
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A2127099
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934638AbeF1H5v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:57:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56187 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934364AbeF1H5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:57:49 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fYRoJ-0001LX-It; Thu, 28 Jun 2018 09:57:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fYRoG-0003dN-IS; Thu, 28 Jun 2018 09:57:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@suse.de>
Cc:     linux-kernel@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>,
        kernel@pengutronix.de, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] siox: don't create a thread without starting it
Date:   Thu, 28 Jun 2018 09:57:42 +0200
Message-Id: <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
References: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Hello,

this is the same patch as before with an updated commit log. I added
Peter's ack anyhow assuming my text isn't too bad to make him withdraw
it.

I think this issue isn't critical as the machine works fine otherwise,
so applying it for 4.18-rc isn't necessary.
(OTOH it's an SMP machine so the tests might not have noticed one blocked
CPU, didn't test this.)

Greg, you applied the initial patches creating drivers/siox. I assume
you will continue to apply siox patches and tell if I should search a
different path for these.

Best regards
Uwe

 drivers/siox/siox-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 16590dfaafa4..cef307c0399c 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -715,17 +715,17 @@ int siox_master_register(struct siox_master *smaster)
 
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
-- 
2.18.0

