Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AEEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817CF2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="T2WHc9eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfACIee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:34:34 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25489 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfACIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:34:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546504469; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=hsxd+IG5siAOer5zevSylQWsq2wWd4MRRGMxHdvIT8gxysGbN89zWlNuguxxwAB7vSvQT8Swftah/RU3AKOatA5Dfpso0sj/K2ErkopBVgTlmUoG8+BbPCk5qbrxs55DyPSHnFQSTFsGK1Ab5xPVLbIdXHrzGqDV3ZPoVUjiLJw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546504469; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=le5j2hLw5GH/PW3GIzsYH2jGxnhrLnZ93bpxcuJQ8Vk=; 
        b=bgzQoR2e33NTBTdP++mJYyT9hbII2LigLCaQ4scS/L88kgDzOqunSDaktmjgyG6hdKCNMGrmW6qzTM6FCxMSGW6gU/nSaP2fdZnN7bvPWWCGeuCSXKQERgfF7kfUbxI2yupBZurBEMfbkp7aQv4D8l8Vbk//20ct3yOJ47B9LVc=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=IVqTgtIQWkhml9e6aCtyxZ/ZGW59gawrVaNgwpEcYp1eBBKIhTsBtdIH8EW8UM1IgmgrF8cAnPo7
    1isxdU3kMojauQ8TQkIaqfYj4JBQhDTI95HwM6Q6l80ZY2GX6A/F  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546504469;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=897;
        bh=le5j2hLw5GH/PW3GIzsYH2jGxnhrLnZ93bpxcuJQ8Vk=;
        b=T2WHc9eNBILJ8eTxQZXmeoJMTTgu9DQB4ZJV9NatfHFjIZB0+dYkoFYPqUGscA6C
        PSs03WiaY0Ic2GX0HzhYpGRj2VdtLfCprbVZKNNWIT8TGdLoWITgCPhQ9M+yrBcFB7u
        dBib/CmGw4TkCr74f3bOFOc0bHMF4b3qpsXv6SZg=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1546504468117807.9374932010533; Thu, 3 Jan 2019 00:34:28 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com
Cc:     agk@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 2/2] dm-writecache: get rid of memory_data flush to writecache_flush_entry
Date:   Thu,  3 Jan 2019 16:34:20 +0800
Message-Id: <20190103083420.8444-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
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


