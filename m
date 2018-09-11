Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0210720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0210720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIKXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:16:10 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37177 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeIKXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:16:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so29241520qtl.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A743d/wM/mljAAT/I+NbjlnB3etN4k5o3DxXuJzTTUQ=;
        b=Ree7eCVaO/XanyN5IrEZQb/nJ/bE6SKi1KB+UnGu3FE38CN/wEorFYcp57I2sbH1Mr
         6EBF/+DM+ALFnxRuXv1RIQfYaqjNaxJd7A5Gc6ijl9C/9mQeXlnVuknwzS0FLnJLHHHX
         1DMunoWiKspl+V8jD+AWjyV/XwMBqASlN+RrHpaZXGGXhs+0Fi6YJPqpfOq6Ct3zHF8s
         y7ELPsXNl8N5nZzwqzCXCLw+f7+oYjqVcCCaVrWqxc8Z+bj4Aa1TcaZFS+uZi95m73yt
         Mz0U15tXReQCmlF2yGJmmao2RLHB7I3gWDqMYRW1lQnTYQuLTFCKZvT1CnH+y+Ln3yGs
         LwoA==
X-Gm-Message-State: APzg51BeznCXhJQtdN/ncgxm2DNZuoWGqZpuEJyutQip+/spaZGSkCNI
        A/9Yvr8epRPTCHtizceXdSgILA==
X-Google-Smtp-Source: ANB0Vdb9SlfG9zUHSdFAP1ap5tuZtyLlfp3M7yI8IJu07ifMJZmn+WiT8b1fy96mFOvpFqYMPpPc4Q==
X-Received: by 2002:a0c:c969:: with SMTP id v38-v6mr19726328qvj.192.1536689740060;
        Tue, 11 Sep 2018 11:15:40 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id 62-v6sm11813115qkx.66.2018.09.11.11.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:15:38 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ibmvscsis: Ensure partition name is properly NUL terminated
Date:   Tue, 11 Sep 2018 11:15:34 -0700
Message-Id: <20180911181534.18553-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing another part of the code, Kees noticed that the
strncpy of the partition name might not always be NUL terminated. Switch
to using strlcpy which does this safely.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I realized looking at this that I probably should have made
this and my previous patch a series given this has context depending on
the other patch. I can resend if the scsi maintainers want.
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 9305440a00a1..1217bf2a28db 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3477,7 +3477,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
-	strncpy(vscsi->dds.partition_name, partition_name,
+	strlcpy(vscsi->dds.partition_name, partition_name,
 		sizeof(vscsi->dds.partition_name));
 	vscsi->dds.partition_num = partition_number;
 
-- 
2.17.1

