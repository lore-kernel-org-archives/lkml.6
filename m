Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59875C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A53021773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="HEruFibR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfBTQfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:35:14 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25323 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfBTQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:35:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1550680506; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Ox8oHG9KzxXatMlgPGMfwfP8UEvd4b/WblFs3SjqTwHSKLzezAtu+NrxygDqgEWhTJrcXkrIXIaJV0z6UAYDqaP+x8InslKvUCY9zycca1oml+M7Idz7ZzRRFO6CVTCla7iSVbEan9YdUqGVik9iR4caLzF5iMu3SsicgsEnWfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1550680506; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=0txghivdCbyCc9Omc8FKkjrClRUgE0f7lR3Lxo6f80g=; 
        b=HvExXpkgIOoQVBOpTkhtoaOuAu09Vr7TwKK8Jir7fsJY7gisXdRAWrfzu/hPn//sXebZT4E8dyiyKVA8m+WGaGT1mLDSuVIloNHq+qiEOpxpGhh9rCZSyb3xAv1U8kNp2jzgGEaC/JmwObb4E5e8yMXbE6DzDL1kykr4sxMeO3Q=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=hI7OUK6VBQD40Tlzvxz7ViLKrfyFdZex7/xJftfX4+W7bUG2jwvj1nxYmRE66eN5byzwBEnPQLEw
    46k09HaDwfObeIGt/s95jpoLct33qm8hKAmEJVnjLZz11ktMd9Lu  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1550680506;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=833;
        bh=0txghivdCbyCc9Omc8FKkjrClRUgE0f7lR3Lxo6f80g=;
        b=HEruFibRCa1+XQBDCVU/Ov5CDisCFKnr+7HyNa9sv0YK9w5R1dgEYeQV5klEow79
        vLX4snbpQYFMmFFXWVTvmCMfdOHDp3rSaUxY2fMkLZ9N30acWT9xeOBpxZF/AMEtDj3
        ogLgkYmf2X99i+I/CmShl+oBy7cCLN/Qrlz/ziI0=
Received: from YEHS1XR956R00D1.lenovo.com (123.120.111.131 [123.120.111.131]) by mx.zohomail.com
        with SMTPS id 1550680504757912.3891591432498; Wed, 20 Feb 2019 08:35:04 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm-writecache: fix typo when alloc workqueue for writeback_wq
Date:   Thu, 21 Feb 2019 00:34:47 +0800
Message-Id: <20190220163447.9652-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The workqueue's name should be "writecache-writeback" instead of "writecache-writeabck".

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 2b8cee3..f782287 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1859,7 +1859,7 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	wc->writeback_wq = alloc_workqueue("writecache-writeabck", WQ_MEM_RECLAIM, 1);
+	wc->writeback_wq = alloc_workqueue("writecache-writeback", WQ_MEM_RECLAIM, 1);
 	if (!wc->writeback_wq) {
 		r = -ENOMEM;
 		ti->error = "Could not allocate writeback workqueue";
-- 
1.8.3.1


