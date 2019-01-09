Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E32C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8716D20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="gc/Lj5Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAIFcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:32:14 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25370 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIFcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:32:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547011907; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=US18iSuJFNbFijQQv4IWkQvBldvgT5/oUSj9DFSPlVtZy76M1uwhO06BSgoq/R43jbDbgCm37pfHVHkYo/eG00TtgNKgor+V3KZD8a7v7qv4Z8V/5MCWcUD0Rc2ywuYI2/yoNkCdFCa+KXr01/A07C3+GuwfyI0Y0ZBH6gLkXWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547011907; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=AaMjv5WPbSe3HlhnR3ynjCjoc6GHdluN4WYLbfJCURI=; 
        b=jMWPybOiLnL3FxWFin9YxjYq87dk/71NvmhQpuSOZeVBLlLVnyp8JZ1S8aSsNBl5S7E1zyFIUHqB94tP3uAes37zKRMRAH1m2MxS1oi05wSJWGcfJg4fnUmfar7mLpmnU6etRhLkIC9FhwH3Pum6kRYy03o76pZVuPiBaJ55ZPo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=eEsI0jY+aKdoKT8mfVMz8ZpgFCvlfRWwn03DUU4lVhIalboIZH8z1G10B2gItKTSx0MEuTbnuD6l
    UjPiLUA8PVc7AZGFuJsZvjG3FPXIBP15KNpjYzS44H25BHwf2Xxg  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1547011907;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2630; bh=AaMjv5WPbSe3HlhnR3ynjCjoc6GHdluN4WYLbfJCURI=;
        b=gc/Lj5JwQ86LaXgx7sSJgmabBhSQn/M6vzL6J6ATK1HP5K+N5nFeJxVEGubiMgNU
        GuxmMPgB4hwgHG8V5VM83Q9TEotFXpjdpveEFjkkOLTZBf/8GRqYoDLCFPfhMHg0vzi
        FsR1+0PiRMSx2nSJz3xvkchX5UM+PB3s39SycJvo=
Received: from YEHS1XR956R00D1.lenovo.com (123.120.89.99 [123.120.89.99]) by mx.zohomail.com
        with SMTPS id 1547011905451850.9507713112295; Tue, 8 Jan 2019 21:31:45 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 1/4] dm-writecache: remove unused size to writecache_flush_region
Date:   Wed,  9 Jan 2019 13:31:24 +0800
Message-Id: <20190109053127.8128-2-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190109053127.8128-1-yehs2007@zoho.com>
References: <20190109053127.8128-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

writecache_flush_region doesn't use size to calculate flush region.
That uses _set_bits to mark the region in dirty_bitmap directly.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 2d50eec..2d8e0c0 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -418,7 +418,7 @@ static void writecache_flush_all_metadata(struct dm_writecache *wc)
 		memset(wc->dirty_bitmap, -1, wc->dirty_bitmap_size);
 }
 
-static void writecache_flush_region(struct dm_writecache *wc, void *ptr, size_t size)
+static void writecache_flush_region(struct dm_writecache *wc, void *ptr)
 {
 	if (!WC_MODE_PMEM(wc))
 		__set_bit(((char *)ptr - (char *)wc->memory_map) / BITMAP_GRANULARITY,
@@ -657,7 +657,7 @@ static void writecache_free_entry(struct dm_writecache *wc, struct wc_entry *e)
 	writecache_unlink(wc, e);
 	writecache_add_to_freelist(wc, e);
 	clear_seq_count(wc, e);
-	writecache_flush_region(wc, memory_entry(wc, e), sizeof(struct wc_memory_entry));
+	writecache_flush_region(wc, memory_entry(wc, e));
 	if (unlikely(waitqueue_active(&wc->freelist_wait)))
 		wake_up(&wc->freelist_wait);
 }
@@ -687,9 +687,9 @@ static void writecache_poison_lists(struct dm_writecache *wc)
 
 static void writecache_flush_entry(struct dm_writecache *wc, struct wc_entry *e)
 {
-	writecache_flush_region(wc, memory_entry(wc, e), sizeof(struct wc_memory_entry));
+	writecache_flush_region(wc, memory_entry(wc, e));
 	if (WC_MODE_PMEM(wc))
-		writecache_flush_region(wc, memory_data(wc, e), wc->block_size);
+		writecache_flush_region(wc, memory_data(wc, e));
 }
 
 static bool writecache_entry_is_committed(struct dm_writecache *wc, struct wc_entry *e)
@@ -733,7 +733,7 @@ static void writecache_flush(struct dm_writecache *wc)
 
 	wc->seq_count++;
 	pmem_assign(sb(wc)->seq_count, cpu_to_le64(wc->seq_count));
-	writecache_flush_region(wc, &sb(wc)->seq_count, sizeof sb(wc)->seq_count);
+	writecache_flush_region(wc, &sb(wc)->seq_count);
 	writecache_commit_flushed(wc);
 
 	wc->overwrote_committed = false;
@@ -1757,7 +1757,7 @@ static int init_memory(struct dm_writecache *wc)
 	writecache_flush_all_metadata(wc);
 	writecache_commit_flushed(wc);
 	pmem_assign(sb(wc)->magic, cpu_to_le32(MEMORY_SUPERBLOCK_MAGIC));
-	writecache_flush_region(wc, &sb(wc)->magic, sizeof sb(wc)->magic);
+	writecache_flush_region(wc, &sb(wc)->magic);
 	writecache_commit_flushed(wc);
 
 	return 0;
-- 
1.8.3.1


