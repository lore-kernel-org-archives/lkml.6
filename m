Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB1DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E284825758
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E284825758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755236AbeFYKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:21:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34101 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbeFYKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:21:12 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fXOcQ-0001jC-OH; Mon, 25 Jun 2018 12:21:10 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ukl@pengutronix.de>)
        id 1fXOcI-0007T2-79; Mon, 25 Jun 2018 12:21:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
Subject: [PATCH] RFC: siox: don't create a thread without starting it
Date:   Mon, 25 Jun 2018 12:20:56 +0200
Message-Id: <20180625102056.28468-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with a siox device I see:

	[  241.130465] INFO: task siox-0:626 blocked for more than 120 seconds.
	[  241.136996]       Not tainted 4.17.0-20180520-1-g6248d1b64190-dirty #8
	[  241.146831] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[  241.154868] siox-0          D    0   626      2 0x00000000
	[  241.163241] [<c05f8430>] (__schedule) from [<c05f88ec>] (schedule+0x58/0xc8)
	[  241.172142] [<c05f88ec>] (schedule) from [<c0039098>] (kthread+0xc4/0x140)
	[  241.180899] [<c0039098>] (kthread) from [<c00090e0>] (ret_from_fork+0x14/0x34)
	[  241.188315] Exception stack(0xc72a7fb0 to 0xc72a7ff8)
	[  241.196327] 7fa0:                                     00000000 00000000 00000000 00000000
	[  241.204721] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	[  241.215861] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000

when I just boot without any other siox-related action. So the kthread (created
in drivers/siox/siox-core.c:siox_master_register()) is never started.

While you could argue that there is little reason to not start the
thread there also is little reason to actually do it.

peterz in #kernelnewbies said "[...] kernel/kthread.c:kthread() should
really be using __set_current_state(TASK_IDLE), I suppose". This however
seems to interfere with problems fixed in a076e4bca2fd ("freezer: fix
kthread_create vs freezer theoretical race").

So I wonder where the real problem is and how it can be fixed.

Explicitly-not-signed-off-for-discussion-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
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
2.17.1

