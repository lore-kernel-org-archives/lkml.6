Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBAFC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C802084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="cbOACc31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfAaCcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:32:09 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25395 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAaCcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:32:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548901882; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=K7iq8hS56tegnOe4RWsYVNW4oLhY/6NLylfEiQpxzGXmsYtsRMn50h3cP18/WrwFH46wNZRcpGflqWilFojdiUfX5GHZwind3CqSOIXDDo1xXFgknpFXTJNPWHslLY4nL5nwjNMLWxm9MJttKz3TfYw7XOcpnt+vCUMZfImEzPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548901882; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=QBdUFHHZxjJDyMep6irBUJTyGeKnwnY2Xb6sUXvAs/8=; 
        b=cA0SPelfccOv9wflHNPDsYWiZlLxTOWdvpPmqu0fttuSnidkAU/yMUxHbvGiZJwjdMT93ckQgvebdT5EOc5yrl1jW+7MocjI+NPYKk550a3ACU2CIJI4uJiLF9fgCZqM+L2fUYEWGlJ+M3HGDGod1YwCa5btbTjMhuU1DDm0mmg=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=Cijfa0RMYhaDqGsZEVvnS7SY4AJ3n9BqzKEvQCBVjwGWMyJe8X9BZXgC448mrVTaY8RDVC8GYgG3
    Xq7dTyTDD4BKnKNM/Qb8jIZCx3NdYg7N3brzBE2wPFErvZoyUDH8  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548901882;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1792; bh=QBdUFHHZxjJDyMep6irBUJTyGeKnwnY2Xb6sUXvAs/8=;
        b=cbOACc31jVwC3kk0JgUvKYSi24l/2kBaCzLsREzrxvmeq5gWLSSyjXYRrRVeYS3x
        I9e9nlY3NkYwvpjoo+RooI3nK+hZ/XF19ydWQqg1+HW9IH2+rfWGhH42vVRpnoLRanx
        FPkchWOnh8uKj/3Z5Gs/c+DpnFiIHj8bCgEK4CfY=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 154890188148863.55614782976397; Wed, 30 Jan 2019 18:31:21 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v3 3/5] dm-writecache: expand pmem_reinit for struct dm_writecache
Date:   Thu, 31 Jan 2019 10:29:53 +0800
Message-Id: <20190131022955.9920-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190131022955.9920-1-yehs2007@zoho.com>
References: <20190131022955.9920-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

When use persistent memory as cache data device, sometimes
the super block of pmem has messy data stored in it. That would
have risk to lead fn ctr failed to work due to invalid magic or
version.

Here we expand pmem_reinit to optional parameters in order to solve
this issue. When user gets pmem device, which has unrelated data,
as cache device, he should use paramenter 'reinit' to avoid s.magic
and s.version don't equal to NULL or correct
MEMORY_SUPERBLOCK_MAGIC/VERSION.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index c69317c..2c1e825 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -149,6 +149,7 @@ struct dm_writecache {
 
 	bool pmem_mode:1;
 	bool writeback_fua:1;
+	bool pmem_reinit:1;
 
 	bool overwrote_committed:1;
 	bool memory_vmapped:1;
@@ -2026,6 +2027,10 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 				wc->writeback_fua = false;
 				wc->writeback_fua_set = true;
 			} else goto invalid_optional;
+		} else if (!strcasecmp(string, "reinit")) {
+			if (WC_MODE_PMEM(wc))
+				wc->pmem_reinit = true;
+			else goto invalid_optional;
 		} else {
 invalid_optional:
 			r = -EINVAL;
@@ -2127,7 +2132,7 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		ti->error = "Hardware memory error when reading superblock";
 		goto bad;
 	}
-	if (!le32_to_cpu(s.magic) && !le32_to_cpu(s.version)) {
+	if (wc->pmem_reinit || (!le32_to_cpu(s.magic) && !le32_to_cpu(s.version))) {
 		r = init_memory(wc);
 		if (r) {
 			ti->error = "Unable to initialize device";
-- 
1.8.3.1


