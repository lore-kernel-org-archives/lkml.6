Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1EC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5F82084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="iD4aasrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfAaCb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:31:58 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25385 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAaCb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:31:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548901878; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=d+QkLONkBgupsWcHiOsNzYFbm2WbqDcpLqfM3W7PxKIgCvwF1xUy9fNy5Q77goYJ+LYyCL82kI+Jdy4pDNEW7pFILTxYd6+1n6C6sFapB59OlxPcL+7om5qtHkUvfMwVt4znqhRmHAlrzYh5mx2n865dS4PMK+XTNkgOFJV/sOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548901878; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=le5j2hLw5GH/PW3GIzsYH2jGxnhrLnZ93bpxcuJQ8Vk=; 
        b=eTSrcMBdvxbZE+XMbrglSQgcap9gWdRvjJ7ficbd/TZvYseNaTNbxCJdKoQODN9ApRLLR78+V3kmhKZNP2PN4Vkw1XuSoQb+mmqRq/Ok9o8HNIGzVC0RaJHvDsNrPhtNXn9eFuhwtOR0dafon5zm7B3ED4e8CgeFDRSALzDpOt8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=NbRyIcEbfvh1m8GuyIQBhCPJgTigZttqa5wsSXBmtBVVITT7HM7LoyILbwv5P7YOT6UOo9FPIML3
    qfYneV0J2ls+odExMC70mXIVjLGaA0s5CbXffVniPP0BGT067fxy  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548901878;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=897;
        bh=le5j2hLw5GH/PW3GIzsYH2jGxnhrLnZ93bpxcuJQ8Vk=;
        b=iD4aasrFsUHThMKI/2pHxTG8Ly1NMaWH+5y8148V6doRVDik9AFL5AxPMVULRSoo
        FRY8vTZmUv/NVz8If63Dg/nX9ZnQmSaNlzGeijI3T+BFg8R4NXl25IKaCQdPWxKhrt+
        XfRM5eGHuL6jL5n+C1Pc7SPqhvAB9kPrDLZS4FIw=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 154890187700296.56872711995572; Wed, 30 Jan 2019 18:31:17 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v3 2/5] dm-writecache: get rid of memory_data flush to writecache_flush_entry
Date:   Thu, 31 Jan 2019 10:29:52 +0800
Message-Id: <20190131022955.9920-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190131022955.9920-1-yehs2007@zoho.com>
References: <20190131022955.9920-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

writecache_flush_region only works when SSD mode.
If wc->pmem_mode sets, writecache_flush_region doesn't need to be called in
writecache_flush_entry.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 2d8e0c0..c69317c 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -688,8 +688,6 @@ static void writecache_poison_lists(struct dm_writecache *wc)
 static void writecache_flush_entry(struct dm_writecache *wc, struct wc_entry *e)
 {
 	writecache_flush_region(wc, memory_entry(wc, e));
-	if (WC_MODE_PMEM(wc))
-		writecache_flush_region(wc, memory_data(wc, e));
 }
 
 static bool writecache_entry_is_committed(struct dm_writecache *wc, struct wc_entry *e)
-- 
1.8.3.1


