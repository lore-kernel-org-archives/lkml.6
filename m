Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B999215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B999215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeHQRqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:46:24 -0400
Received: from mail.windriver.com ([147.11.1.11]:57148 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeHQRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:46:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7HEgYOo024615
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 17 Aug 2018 07:42:34 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 07:42:33 -0700
From:   <zhe.he@windriver.com>
To:     <jason.wessel@windriver.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <kgdb-bugreport@lists.sourceforge.net>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] kgdboc: Change printk to the right fashion
Date:   Fri, 17 Aug 2018 22:42:29 +0800
Message-ID: <1534516949-420150-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534516949-420150-1-git-send-email-zhe.he@windriver.com>
References: <1534516949-420150-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

pr_* is preferred according to scripts/checkpatch.pl.

Cc: jason.wessel@windriver.com
Cc: gregkh@linuxfoundation.org
Cc: jslaby@suse.com
Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
v2:
- Split printk cleanups into a single patch
- Add cc to stable@vger.kernel.org
v3:
- Add pr_fmt for mod name
- Remove cc to stable@vger.kernel.org
v4:
- Add cc to maintainers and supporters

 drivers/tty/serial/kgdboc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index f4d0ef6..371357d 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -8,6 +8,9 @@
  *
  * 2007-2008 (c) Jason Wessel - Wind River Systems, Inc.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/kgdb.h>
@@ -131,12 +134,12 @@ static void kgdboc_unregister_kbd(void)
 static int kgdboc_option_setup(char *opt)
 {
 	if (!opt) {
-		pr_err("kgdboc: config string not provided\n");
+		pr_err("config string not provided\n");
 		return -EINVAL;
 	}
 
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("config string too long\n");
 		return -ENOSPC;
 	}
 	strcpy(config, opt);
@@ -253,7 +256,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	int len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
+		pr_err("config string too long\n");
 		return -ENOSPC;
 	}
 
@@ -264,8 +267,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	}
 
 	if (kgdb_connected) {
-		printk(KERN_ERR
-		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
+		pr_err("Cannot reconfigure while KGDB is connected.\n");
 
 		return -EBUSY;
 	}
-- 
2.7.4

