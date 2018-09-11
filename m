Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6B720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6B720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeILAXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:23:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46469 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeILAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:23:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id l42-v6so4206667qtf.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IYDLXOvqXi5U1MpjfZDRh4TELVkjnKkN4SnOhEmKxyU=;
        b=c3hIiSPzlNMvsmnI28fuc14RvEgqw9P52t3cxEUAwkykcrK3hbLiSQk9WY5G3SKKWJ
         qajhG3E30ay0HxSmjloMjKU9cfCe2obOrME4dyhx1v9FgquqC8ORlaSWE+x1iKr/2kyL
         X9dWO7ZxaaydhEZE0hCCd7JmeaeksMKxXFgfGWBuniQvjk0A/3EQvxvvHRGv3wAUX0Il
         2HpOfRm3tSSA6eHsv3agJJ5tQhul8S4owGCnNeBCQcmjNfea+dTkO/1STRbR2aDqD0d/
         mzfqm+WzP4PVCX+24UszJAzGvI9YqIaCS5DAuh/tx711KHOumyL/B7AGEMEHD9cKI+8x
         JFzg==
X-Gm-Message-State: APzg51Dnf5hUzZtl+QDcct/2xU/tM20pVo4kQf8wE5Ql2NR7AsfR1eep
        QJrz7OQCi8/8uKagDVy1xftCFA==
X-Google-Smtp-Source: ANB0VdbpXC6hn2sjKF29TZkHQO+B1eGtVLUg2Sc11SgggHa2Uq7Si1DGRVx/gzX38uK0UpdskCj/jg==
X-Received: by 2002:aed:3c55:: with SMTP id u21-v6mr20941353qte.198.1536693757296;
        Tue, 11 Sep 2018 12:22:37 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id g14-v6sm13639452qtc.66.2018.09.11.12.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:22:36 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] scsi: ibmvscsis: Ensure partition name is properly NUL terminated
Date:   Tue, 11 Sep 2018 12:22:26 -0700
Message-Id: <20180911192226.3620-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911192226.3620-1-labbott@redhat.com>
References: <20180911192226.3620-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While reviewing another part of the code, Kees noticed that the
strncpy of the partition name might not always be NUL terminated. Switch
to using strscpy which does this safely.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to strscpy instead of just strlcpy
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index b3a029ad07cd..f42a619198c4 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3477,7 +3477,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
-	strncpy(vscsi->dds.partition_name, partition_name,
+	strscpy(vscsi->dds.partition_name, partition_name,
 		sizeof(vscsi->dds.partition_name));
 	vscsi->dds.partition_num = partition_number;
 
-- 
2.17.1

