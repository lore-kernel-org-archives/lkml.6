Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EBDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F52145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930F52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeLCKZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:25:47 -0500
Received: from mail.windriver.com ([147.11.1.11]:53892 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLCKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:25:47 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wB3AMsQX029793
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 3 Dec 2018 02:22:55 -0800 (PST)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 02:22:54 -0800
From:   <zhe.he@windriver.com>
To:     <konrad@darnok.org>, <konrad.wilk@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH v2] kernel/dma: Fix panic caused by passing swiotlb to command line
Date:   Mon, 3 Dec 2018 18:22:51 +0800
Message-ID: <1543832571-121638-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

setup_io_tlb_npages does not check input argument before passing it
to isdigit. The argument would be a NULL pointer if "swiotlb", without
its value, is set in command line and thus causes the following panic.

PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
[    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
...
[    0.000000] Call Trace:
[    0.000000]  do_early_param+0x57/0x8e
[    0.000000]  parse_args+0x208/0x320
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_options+0x29/0x2d
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_param+0x36/0x4d
[    0.000000]  setup_arch+0x336/0x99e
[    0.000000]  start_kernel+0x6f/0x4e6
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x6f/0x72
[    0.000000]  secondary_startup_64+0xa4/0xb0

This patch adds a check to prevent the panic and sets it for 4MB by default.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Cc: konrad.wilk@oracle.com
Cc: hch@lst.de
Cc: m.szyprowski@samsung.com
Cc: robin.murphy@arm.com

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2: Set swiotlb for 4MB by default

 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e..0e18cd4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -58,6 +58,9 @@
  */
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 
+#define IO_TLB_DEFAULT_MB 4
+#define IO_TLB_DEFAULT_SLABS ((IO_TLB_DEFAULT_MB<<20) >> IO_TLB_SHIFT)
+
 enum swiotlb_force swiotlb_force;
 
 /*
@@ -103,6 +106,14 @@ static int late_alloc;
 static int __init
 setup_io_tlb_npages(char *str)
 {
+	if (!str) {
+		pr_err("No value provided for swiotlb, "
+		       "set it to %d slabs for %dMB by default.\n",
+		       IO_TLB_DEFAULT_SLABS, IO_TLB_DEFAULT_MB);
+		io_tlb_nslabs = IO_TLB_DEFAULT_SLABS;
+		return 0;
+	}
+
 	if (isdigit(*str)) {
 		io_tlb_nslabs = simple_strtoul(str, &str, 0);
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-- 
2.7.4

