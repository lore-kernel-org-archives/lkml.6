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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF06C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3850320821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="KkYjXWsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfAIFcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:32:36 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25386 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIFcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:32:35 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547011914; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=KvXOoTXYyfw46ddGR7sGmAszBd3zNz+y4VRwvDv+kzmsBnQkah6dX/MsVwJUEwEhvL18YY28gVt5nQRXCAjmbGgJLtPmc5GHFIOEolpor4wkXrCY6/tWfzNi8WSSTud9xdBMlA59wmjV7X3r8J2/rQnmHhZ7qblQ3CWoaJ3VL7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547011914; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=dw8ZJTmgcsYczIjoDQEr8j6GGcL35J1OcAqunEg0lrU=; 
        b=dZbpCgY5lfthLyqcJaD4LeyIaWORytR7eW+PfurzN9yRbiw/DthK2oDPeK+vXzp/DcSK4kgEBBKuV7+7ob7UKAWzfR4NiLyt9qugWfbzFU8vCn1GttO18Shg9do324ku4AmevtZDafa9xXASqpc9Hnp5IKJTFR2CQXDpvoIIfwY=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=GlVOwrDbvVZaHCGu4pCzKpgZ5rgBwI+63BwbUa5nMjHSqGDedyJ/5OSvHRlpe/b1ukdJQwBVcSd6
    keqnu/+NXwwVX5g801DYVYsijtlyK1Z6EGlQ2HwWx2dnh6oySYQE  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1547011914;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1798; bh=dw8ZJTmgcsYczIjoDQEr8j6GGcL35J1OcAqunEg0lrU=;
        b=KkYjXWsGOkw1VS5TkVerYjTXSCsfEWTjhL9ElCg+WYNqJwDoK6CEaXgveHejQnwg
        vApNHnXTEVH3lvZqbaJzkyL7t6UM730sH+oQHmOKc2mDg91at3Z9q+9uwfTNN7Rl9hv
        R1FkBvSPJezoSB3ezWMxh10AbQSOnT3dLMpXofus=
Received: from YEHS1XR956R00D1.lenovo.com (123.120.89.99 [123.120.89.99]) by mx.zohomail.com
        with SMTPS id 1547011912293631.2697486393442; Tue, 8 Jan 2019 21:31:52 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 3/4] dm-writecache: expand pmem_reinit for struct dm_writecache
Date:   Wed,  9 Jan 2019 13:31:26 +0800
Message-Id: <20190109053127.8128-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190109053127.8128-1-yehs2007@zoho.com>
References: <20190109053127.8128-1-yehs2007@zoho.com>
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
this issue. When user gets pmem device, which has unrelated data in it,
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


