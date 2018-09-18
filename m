Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0792150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0792150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbeIRWws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:52:48 -0400
Received: from mail5.windriver.com ([192.103.53.11]:46086 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeIRWws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:52:48 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8IHI20F012667
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Sep 2018 10:18:13 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Sep 2018 10:17:50 -0700
From:   <zhe.he@windriver.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len to command line
Date:   Wed, 19 Sep 2018 01:17:47 +0800
Message-ID: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
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

 kernel/printk/printk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9bf5404..34c0403 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned size = memparse(str, &str);
+	unsigned size;
+
+	if (!str) {
+		pr_err("Config string not provided\n");
+		return -EINVAL;
+	}
+
+	size = memparse(str, &str);
 
 	log_buf_len_update(size);
 
-- 
2.7.4

