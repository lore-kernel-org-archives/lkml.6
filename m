Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9884CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7392150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7392150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeIVUr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:47:58 -0400
Received: from mail.windriver.com ([147.11.1.11]:63784 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeIVUr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:47:58 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8MErncT013924
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 22 Sep 2018 07:53:49 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Sat, 22 Sep 2018 07:53:36 -0700
From:   <zhe.he@windriver.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <pasha.tatashin@oracle.com>, <mgorman@techsingularity.net>,
        <aaron.lu@intel.com>, <osalvador@suse.de>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH v2 1/2] mm/page_alloc: Fix panic caused by passing debug_guardpage_minorder or kernelcore to command line
Date:   Sat, 22 Sep 2018 22:53:32 +0800
Message-ID: <1537628013-243902-1-git-send-email-zhe.he@windriver.com>
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
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #11
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
v2:
Use more clear error info
Split the addition of KBUILD_MODNAME out

 mm/page_alloc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2a..f34cae1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -630,6 +630,12 @@ static int __init debug_guardpage_minorder_setup(char *buf)
 {
 	unsigned long res;
 
+	if (!buf) {
+		pr_err("kernel option debug_guardpage_minorder requires an \
+			argument\n");
+		return -EINVAL;
+	}
+
 	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
 		pr_err("Bad debug_guardpage_minorder value\n");
 		return 0;
@@ -6952,6 +6958,11 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
  */
 static int __init cmdline_parse_kernelcore(char *p)
 {
+	if (!p) {
+		pr_err("kernel option kernelcore requires an argument\n");
+		return -EINVAL;
+	}
+
 	/* parse kernelcore=mirror */
 	if (parse_option_str(p, "mirror")) {
 		mirrored_kernelcore = true;
-- 
2.7.4

