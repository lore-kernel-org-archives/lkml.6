Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DC3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2E320658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2E320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeIKDds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:33:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34814 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeIKDds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:33:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15-v6so15593399qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 15:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hN158MWIS1t7Do7D9sM3NMr+y78N0WhD5CZda7h31yg=;
        b=rdzkfwZb8dqrNuaQF9xxwXs298dXYNGYIZgZ64CrsqTOOtsWnO3ucCbteXW0VEjzJ9
         IOZd7wumlCIsP834QFnzR0S00jILu63wvqum3jdfhz8fvo4OsWaMkC61tpEICzkHC8Wz
         4jWy9SgD9hRzUMzRNGJ9w7ImwROuJPv+XRDvGIPkbb4W8k7pvqw9jyrArbEkZ9A60JwA
         KwRvwZMxougA2jk1eRvoK5iRjTMW1lA8Lc7bRPB2dYqTTCo6F4Vt/hZFHHPMSbo3m3++
         dT/DqhS/9QYqJQkOUDgyTitfZfazw6vqe+MpXMMMJ09b4lQHUK3btusD14bjPMvOisn5
         xKsQ==
X-Gm-Message-State: APzg51CQ629VgxjIXOqeR2d60KG3VbaWQ7wKfeIe9KSqJ+oKPiTWrAMB
        +9QzlIqJzlq9Zf2+Rt9xJNInSA==
X-Google-Smtp-Source: ANB0Vdbb816dTN99lR2XJQ+FDdXeoE4CXi4dpqPZol3/2NvpIW33HbM/QGb7APBPLuvRd1cLFP9elg==
X-Received: by 2002:a37:c42:: with SMTP id 63-v6mr16501889qkm.24.1536619054074;
        Mon, 10 Sep 2018 15:37:34 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id s35-v6sm11227237qtj.79.2018.09.10.15.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 15:37:32 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] scsi: ibmvscsis: Fix a stringop-overflow warning
Date:   Mon, 10 Sep 2018 15:37:23 -0700
Message-Id: <20180910223723.25357-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's currently a warning about string overflow with strncat:

drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
bound 64 equals destination size [-Werror=stringop-overflow=]
  strncat(vscsi->eye, vdev->name, MAX_EYE);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Switch to using strlcat which correctly accounts for lengths that
are equal to the destination buffer.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index fac377320158..53d344d8dc43 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3475,7 +3475,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 		vscsi->dds.window[REMOTE].liobn);
 
 	strcpy(vscsi->eye, "VSCSI ");
-	strncat(vscsi->eye, vdev->name, MAX_EYE);
+	strlcat(vscsi->eye, vdev->name, MAX_EYE);
 
 	vscsi->dds.unit_id = vdev->unit_address;
 	strncpy(vscsi->dds.partition_name, partition_name,
-- 
2.17.1

