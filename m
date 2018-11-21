Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10359C04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9621104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="M6Lvmv/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF9621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeKUOAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:00:44 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25350 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeKUOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:00:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542770850; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=HqRpAU2QJYFlyRlP2HAtbKV5Nkbgm3zs8K+e1epfj5F6EU/KaBGwGutx9fUrkRwqdM+K3ixiNGoTSdKw43TkCBElveD1iXbekHGLq4oEhY1/9xxH9QteVI5prnPcTSPhWnEqba1oOUOsO6qdJn8XFy6sTCFHdRjMDsEQRAGdJqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542770850; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=GHh1ilgk8ZdCIo8lwzMZINvkNuuU7rjdcC8nSOe4YS4=; 
        b=P/a36/jZXuJd0zloqWt9aVZn/hOpSUSUDvSPegyT5N3WnY3cpERjhuo01PH3xKHGZ86zFyyBM7MFR7Vkj2Cvsm04VMdR8HUnVd26PvcWfSpq/PhdwqP60FF0rUXcOnoR4gETgaOkI59kbbUHFyE2uqn88Twu+9Rj42N9j8euIgM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=HonwnfQeTzGWRJf/BUR7ZCsjCnI8jY1YspYxRXqdc0ZHqlNqWWW0h3B1bjrGPrbu+nAv/EWjWP5C
    Tp2azGgUK+MVMQDYXh6GebWB5lCjurMoNtDIszAyIiJ6XdXJmmL6  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1542770850;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1150; bh=GHh1ilgk8ZdCIo8lwzMZINvkNuuU7rjdcC8nSOe4YS4=;
        b=M6Lvmv/VwGyYT4m0e+UOt/Xn6zEzHb3MVK6vPfb5c+8ZK3PxFcik5ACEe/2wlbnP
        Heu75WHAXyQ7qPguULix8PdXsfLzHQp9xcfFYKFXk4H5muFSeyDsjWbkpxSCJ690lsL
        M+AoAl0Q4trWC2dRCAryGb72bvYFXM7XgjtZ6SEc=
Received: from YEHS1XR956R00D1.lenovo.com (58.243.153.247 [58.243.153.247]) by mx.zohomail.com
        with SMTPS id 1542770848969100.83345673388703; Tue, 20 Nov 2018 19:27:28 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, dan.j.williams@intel.com, willy@infradead.org,
        zwisler@kernel.org, jack@suse.cz, dave.jiang@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 3/3] dm: expand valid types for dm-ioctl
Date:   Wed, 21 Nov 2018 11:27:02 +0800
Message-Id: <20181121032702.3048-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20181121032702.3048-1-yehs2007@zoho.com>
References: <20181121032702.3048-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

If use DAX way to mount the origin device of dm_snapshot, when
merging back snapshot to origin, system call table_load during the
construction of snapshot-merge will try to detect new dm_table's type
equals to the existed md's type or not.
The existed type equals to DM_TYPE_DAX_BIO_BASED, but the new created
type belongs to DM_TYPE_BIO_BASED. So, we need to expand valid_type in
function is_valid_type.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index a27016e..158d657 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1295,7 +1295,8 @@ static int populate_table(struct dm_table *table,
 static bool is_valid_type(enum dm_queue_mode cur, enum dm_queue_mode new)
 {
 	if (cur == new ||
-	    (cur == DM_TYPE_BIO_BASED && new == DM_TYPE_DAX_BIO_BASED))
+	    (cur == DM_TYPE_BIO_BASED && new == DM_TYPE_DAX_BIO_BASED) ||
+	    (cur == DM_TYPE_DAX_BIO_BASED && new == DM_TYPE_BIO_BASED))
 		return true;
 
 	return false;
-- 
1.8.3.1


