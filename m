Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46419ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1394206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1394206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeIVVfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:35:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:33293 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbeIVVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:35:10 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8MFf6U8016784
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 22 Sep 2018 08:41:06 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Sat, 22 Sep 2018 08:40:53 -0700
From:   <zhe.he@windriver.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH v3 1/2] printk: Fix panic caused by passing log_buf_len to command line
Date:   Sat, 22 Sep 2018 23:40:51 +0800
Message-ID: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

log_buf_len_setup does not check input argument before passing it to
simple_strtoull. The argument would be a NULL pointer if "log_buf_len",
without its value, is set in command line and thus causes the following
panic.

PANIC: early exception 0xe3 IP 10:ffffffffaaeacd0d error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
[    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
...
[    0.000000] Call Trace:
[    0.000000]  simple_strtoull+0x29/0x70
[    0.000000]  memparse+0x26/0x90
[    0.000000]  log_buf_len_setup+0x17/0x22
[    0.000000]  do_early_param+0x57/0x8e
[    0.000000]  parse_args+0x208/0x320
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_options+0x29/0x2d
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_param+0x36/0x4d
[    0.000000]  setup_arch+0x336/0x99e
[    0.000000]  start_kernel+0x6f/0x4ee
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x6f/0x72
[    0.000000]  secondary_startup_64+0xa4/0xb0

This patch adds a check to prevent the panic.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Cc: pmladek@suse.com
Cc: sergey.senozhatsky@gmail.com
Cc: rostedt@goodmis.org
---
v2:
Split out the addition of pr_fmt and the unsigned update
v3:
Use more clear error info
Change unsigned to unsigned in to avoid checkpatch.pl warning

 kernel/printk/printk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9bf5404..d9821c0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned size = memparse(str, &str);
+	unsigned int size;
+
+	if (!str) {
+		pr_err("boot command line parameter value not provided\n");
+		return -EINVAL;
+	}
+
+	size = memparse(str, &str);
 
 	log_buf_len_update(size);
 
-- 
2.7.4

