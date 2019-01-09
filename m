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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA3120821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="YZS1IfqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfAIFc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:32:26 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25378 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:32:23 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547011910; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=D1bvQiE33wdc6DwxL+NxjEVKGDOIBmX+a67WChzSQfmO1uq4Jb1ELnkt0yDVO/wxW8svMSyIX9Au81xUJTPRC9rNc2v481HmwNFyR9/3eM65kDlgUmpvGU7gDP1MSobyNr3Kls48+mfRAKLW08jKsFDqQBcLzTxW7YVPAr34aOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547011910; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=le5j2hLw5GH/PW3GIzsYH2jGxnhrLnZ93bpxcuJQ8Vk=; 
        b=d+nujjZsNMbmscIeW4HtLKTRhnoKRdmLu7um1gv1P4q9TOtaRMo7VoBolhiCXp+R+++TlrdMrMzrZHa5VBCQXc27BHQgk69DxE68Huq6lWtbTNmq951dYFgD/T1wSNi1HYlovIRfhznRONhfSQxilkA1aOy9dPwt8tbcfZJEMgs=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=LhS5yzC5u2acAzldvuV+A7CeZiHE2dHqLVxe7bR4IGwd5nYm50Va49pVrSP99RhYSZwMvBHGeA1w
    0oX53NaX71SPutTKNz4Nbwei4kjGQNMqVgF3tfjsclAV+7c+V7qW  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1547011910;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=897;
        bh=le5j2hLw5GH/PW3GIzsYH2jGxnhrLnZ93bpxcuJQ8Vk=;
        b=YZS1IfqEQkbCTAsk+rx98Uw+CswngQBkGYFjbuPl9MQtB/QTdH6FH8DJS/45cBIP
        p+g3iTJinGqVtpOXY+9kQeA/QX60aefBU+mzs0rOd75OSIB+hjbEAhS0QjBXlVexBBv
        bNKg8G3b3KGa69LrWwG9oZRNW1vC3zI44WeIPikQ=
Received: from YEHS1XR956R00D1.lenovo.com (123.120.89.99 [123.120.89.99]) by mx.zohomail.com
        with SMTPS id 154701190890385.06785696697204; Tue, 8 Jan 2019 21:31:48 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 2/4] dm-writecache: get rid of memory_data flush to writecache_flush_entry
Date:   Wed,  9 Jan 2019 13:31:25 +0800
Message-Id: <20190109053127.8128-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190109053127.8128-1-yehs2007@zoho.com>
References: <20190109053127.8128-1-yehs2007@zoho.com>
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


