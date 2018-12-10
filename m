Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338C3C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029792086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029792086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeLJOAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:00:48 -0500
Received: from foss.arm.com ([217.140.101.70]:54604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbeLJOAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:00:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EA41682;
        Mon, 10 Dec 2018 06:00:44 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0C693F575;
        Mon, 10 Dec 2018 06:00:42 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v3 2/7] dma-debug: Expose nr_total_entries in debugfs
Date:   Mon, 10 Dec 2018 14:00:28 +0000
Message-Id: <06146c16a9c9af8b363d9e5faa73e9952b4f0865.1544447601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose nr_total_entries in debugfs, so that {num,min}_free_entries
become even more meaningful to users interested in current/maximum
utilisation. This becomes even more relevant once nr_total_entries
may change at runtime beyond just the existing AMD GART debug code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Add Christoph's review tag

 Documentation/DMA-API.txt | 3 +++
 kernel/dma/debug.c        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index ac66ae2509a9..6bdb095393b0 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -723,6 +723,9 @@ dma-api/min_free_entries	This read-only file can be read to get the
 dma-api/num_free_entries	The current number of free dma_debug_entries
 				in the allocator.
 
+dma-api/nr_total_entries	The total number of dma_debug_entries in the
+				allocator, both free and used.
+
 dma-api/driver-filter		You can write a name of a driver into this file
 				to limit the debug output to requests from that
 				particular driver. Write an empty string to
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 91b84140e4a5..29486eb9d1dc 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -144,6 +144,7 @@ static struct dentry *show_all_errors_dent  __read_mostly;
 static struct dentry *show_num_errors_dent  __read_mostly;
 static struct dentry *num_free_entries_dent __read_mostly;
 static struct dentry *min_free_entries_dent __read_mostly;
+static struct dentry *nr_total_entries_dent __read_mostly;
 static struct dentry *filter_dent           __read_mostly;
 
 /* per-driver filter related state */
@@ -928,6 +929,12 @@ static int dma_debug_fs_init(void)
 	if (!min_free_entries_dent)
 		goto out_err;
 
+	nr_total_entries_dent = debugfs_create_u32("nr_total_entries", 0444,
+			dma_debug_dent,
+			&nr_total_entries);
+	if (!nr_total_entries_dent)
+		goto out_err;
+
 	filter_dent = debugfs_create_file("driver_filter", 0644,
 					  dma_debug_dent, NULL, &filter_fops);
 	if (!filter_dent)
-- 
2.19.1.dirty

