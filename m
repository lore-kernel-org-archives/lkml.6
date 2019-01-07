Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73248C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F872183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfAGSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:35:14 -0500
Received: from shell.v3.sk ([90.176.6.54]:44508 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfAGSfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:35:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CE5AEFFD8E;
        Mon,  7 Jan 2019 19:35:08 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vC8KlokcNcJD; Mon,  7 Jan 2019 19:34:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BB2FFFFD95;
        Mon,  7 Jan 2019 19:34:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KBp31BqM2Uew; Mon,  7 Jan 2019 19:34:45 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 16939FFD86;
        Mon,  7 Jan 2019 19:34:45 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 03/16] Revert "platform/olpc: Make ec explicitly non-modular"
Date:   Mon,  7 Jan 2019 19:34:26 +0100
Message-Id: <20190107183439.50626-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to always have this built-in, e.g. on ARM
multiplatform kernels.

A better way to address the problem the original commit aimed to solve is
to fix Kconfig. That is what the next commit in the series does.

This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Sort it later in the patch set

 drivers/platform/olpc/olpc-ec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 981955dce926..35a21c66cd0d 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -1,8 +1,6 @@
 /*
  * Generic driver for the OLPC Embedded Controller.
  *
- * Author: Andres Salomon <dilinger@queued.net>
- *
  * Copyright (C) 2011-2012 One Laptop per Child Foundation.
  *
  * Licensed under the GPL v2 or later.
@@ -14,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/list.h>
 #include <linux/olpc-ec.h>
=20
@@ -327,4 +325,8 @@ static int __init olpc_ec_init_module(void)
 {
 	return platform_driver_register(&olpc_ec_plat_driver);
 }
+
 arch_initcall(olpc_ec_init_module);
+
+MODULE_AUTHOR("Andres Salomon <dilinger@queued.net>");
+MODULE_LICENSE("GPL");
--=20
2.20.1

