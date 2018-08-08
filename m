Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9FDC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDB921771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDB921771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeHHSVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:21:53 -0400
Received: from mail5.windriver.com ([192.103.53.11]:52520 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeHHSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:21:53 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w78FxvJM014063
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 8 Aug 2018 09:00:07 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 08:59:46 -0700
From:   <zhe.he@windriver.com>
To:     <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH] kgdboc: Passing ekgdboc to command line causes panic
Date:   Wed, 8 Aug 2018 23:59:44 +0800
Message-ID: <1533743984-426660-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

kgdboc_option_setup does not check input argument before passing it
to strlen. The argument would be a NULL pointer if "ekgdboc", without
its value, is set in command line and thus cause the following panic.

PANIC: early exception 0xe3 IP 10:ffffffff8fbbb620 error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #1
[    0.000000] RIP: 0010:strlen+0x0/0x20
...
[    0.000000] Call Trace
[    0.000000]  ? kgdboc_option_setup+0x9/0xa0
[    0.000000]  ? kgdboc_early_init+0x6/0x1b
[    0.000000]  ? do_early_param+0x4d/0x82
[    0.000000]  ? parse_args+0x212/0x330
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_options+0x20/0x23
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_param+0x2d/0x39
[    0.000000]  ? setup_arch+0x2f7/0xbf4
[    0.000000]  ? start_kernel+0x5e/0x4c2
[    0.000000]  ? load_ucode_bsp+0x113/0x12f
[    0.000000]  ? secondary_startup_64+0xa5/0xb0

This patch adds a check to prevent the panic and changes some printk
to right fashion.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/tty/serial/kgdboc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b4ba2b1..0003d6c 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -130,8 +130,13 @@ static void kgdboc_unregister_kbd(void)
 
 static int kgdboc_option_setup(char *opt)
 {
+	if (!opt) {
+		pr_err("kgdboc: null option\n");
+		return -EINVAL;
+	}
+
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("kgdboc: config string too long\n");
 		return -ENOSPC;
 	}
 	strcpy(config, opt);
@@ -248,7 +253,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	int len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("kgdboc: config string too long\n");
 		return -ENOSPC;
 	}
 
@@ -259,8 +264,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	}
 
 	if (kgdb_connected) {
-		printk(KERN_ERR
-		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
+		pr_err("kgdboc: Cannot reconfigure while KGDB is connected.\n");
 
 		return -EBUSY;
 	}
-- 
2.7.4

