Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE21ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E35214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E35214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeIRVJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:09:11 -0400
Received: from mail5.windriver.com ([192.103.53.11]:44718 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeIRVJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:09:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8IFXLdt009250
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 18 Sep 2018 08:33:32 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Sep 2018 08:33:11 -0700
From:   <zhe.he@windriver.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <pasha.tatashin@oracle.com>, <mgorman@techsingularity.net>,
        <aaron.lu@intel.com>, <osalvador@suse.de>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH] mm/page_alloc: Fix panic caused by passing debug_guardpage_minorder or kernelcore to command line
Date:   Tue, 18 Sep 2018 23:33:08 +0800
Message-ID: <1537284788-428784-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

debug_guardpage_minorder_setup and cmdline_parse_kernelcore do not check
input argument before using it. The argument would be a NULL pointer if
"debug_guardpage_minorder" or "kernelcore", without its value, is set in
command line and thus causes the following panic.

PANIC: early exception 0xe3 IP 10:ffffffffa08146f1 error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
[    0.000000] RIP: 0010:parse_option_str+0x11/0x90
...
[    0.000000] Call Trace:
[    0.000000]  cmdline_parse_kernelcore+0x19/0x41
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

This patch adds a check to prevent the panic and adds KBUILD_MODNAME to
prints.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Cc: akpm@linux-foundation.org
Cc: mhocko@suse.com
Cc: vbabka@suse.cz
Cc: pasha.tatashin@oracle.com
Cc: mgorman@techsingularity.net
Cc: aaron.lu@intel.com
Cc: osalvador@suse.de
Cc: iamjoonsoo.kim@lge.com
---
 mm/page_alloc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2a..d4cda06 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -14,6 +14,8 @@
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
@@ -630,6 +632,11 @@ static int __init debug_guardpage_minorder_setup(char *buf)
 {
 	unsigned long res;
 
+	if (!buf) {
+		pr_err("Config string not provided\n");
+		return -EINVAL;
+	}
+
 	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
 		pr_err("Bad debug_guardpage_minorder value\n");
 		return 0;
@@ -6952,6 +6959,11 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
  */
 static int __init cmdline_parse_kernelcore(char *p)
 {
+	if (!p) {
+		pr_err("Config string not provided\n");
+		return -EINVAL;
+	}
+
 	/* parse kernelcore=mirror */
 	if (parse_option_str(p, "mirror")) {
 		mirrored_kernelcore = true;
-- 
2.7.4

