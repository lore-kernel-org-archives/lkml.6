Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7E82075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="o9a0T1rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7E82075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJISbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32846 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJISbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so689664pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5hzm3iNy1IojUsUtFYt//hQMq7pvONkwQcInQj0DBM=;
        b=o9a0T1rkRbt1vWq5JnM7tta0EmOhmjIAb0/cGcO59LfEJw56DgRpYVPfZ/15pp+WL9
         eJsl4/ePaNikFQbXn9dhcPJixJfB1sdepN3vv0CXC135/ev4myN5aHttjZQ8Cc9lpnXZ
         TUtIvswj1IqrKvMhuYwWlT3Qo+yAwUKb3B0CIyz7lq+HdZ2aQbT4x+NL2tS7Wa5qq9Tx
         aSHojxCPpDoO2a467jY9Ptt3fxylg8gN5vp+ZTAyxIZX1XijbINFCR2di/A81CE6+Rpw
         zyGkzhZBdnne9sA5JNdJ+wt9Z9xN0j28epAW7fnb3CgD4D+XzuZP34u+Ev/NPPI5zITQ
         tTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5hzm3iNy1IojUsUtFYt//hQMq7pvONkwQcInQj0DBM=;
        b=W6KxYKPT7rPbzW9JvSNARttfxxFcIrjCmhO7hb1Phn35hbWiT/uYz4bTxF6W1vIBsl
         5eLESgPjGtra1rDO3/XL869TnTVCD9It4YgXX1ihnlKVNiJA8zxjpGgc3bw4iPipkVGp
         tJtagXSJv6fguqdVMcUSp0A53H27GcMOgtXnzy/Txtm/MMgEKEvakp3tk0dmnMmo4xF+
         crNQkpdezbd9Y1xR01/9klsFQMDgCdIwurvvBAJPabNupWGoUzA88Jxz3o4XXNgLlhKp
         RK5PmgXi5Z8F1SjKYMC252Ex55SOj7rXiUC0iWJRQHUA5ooEm+IaU6RMzA4kX41tVhRO
         9MEg==
X-Gm-Message-State: ABuFfohA7bgOFMlamoB/m8L5uuVXh7aHXBI44r09Ngs/n/mIfDVzJamt
        ww931uwnpU4l7HTDUGZgWFVgCg==
X-Google-Smtp-Source: ACcGV63ozpXGW/RbIAiA9KClASyAFHw989JGh4oQVLuSRc9GhdMDSkfB9Z5a8kOQm+iQbEyzTqPThQ==
X-Received: by 2002:aa7:8643:: with SMTP id a3-v6mr29605086pfo.247.1539083719175;
        Tue, 09 Oct 2018 04:15:19 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:17 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 37/45] lightnvm: pblk: fix race on sysfs line state
Date:   Tue,  9 Oct 2018 13:12:07 +0200
Message-Id: <20181009111215.7653-38-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk exposes a sysfs interface that represents its internal state. Part
of this state is the map bitmap for the current open line, which should
be protected by the line lock to avoid a race when freeing the line
metadata. Currently, it is not.

This patch makes sure that the line state is consistent and NULL
bitmap pointers are not dereferenced.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 5 +++--
 drivers/lightnvm/pblk-sysfs.c | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 4045a9b1ee74..6944aac43b01 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1611,13 +1611,14 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	struct pblk_line *cur, *new = NULL;
 	unsigned int left_seblks;
 
-	cur = l_mg->data_line;
 	new = l_mg->data_next;
 	if (!new)
 		goto out;
+
+	spin_lock(&l_mg->free_lock);
+	cur = l_mg->data_line;
 	l_mg->data_line = new;
 
-	spin_lock(&l_mg->free_lock);
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index cba83ac43e62..2d2818155aa8 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -263,8 +263,14 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		sec_in_line = l_mg->data_line->sec_in_line;
 		meta_weight = bitmap_weight(&l_mg->meta_bitmap,
 							PBLK_DATA_LINES);
-		map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
+
+		spin_lock(&l_mg->data_line->lock);
+		if (l_mg->data_line->map_bitmap)
+			map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
 							lm->sec_per_line);
+		else
+			map_weight = 0;
+		spin_unlock(&l_mg->data_line->lock);
 	}
 	spin_unlock(&l_mg->free_lock);
 
-- 
2.17.1

