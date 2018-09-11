Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAE52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAE52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeILAXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:23:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43432 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeILAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:23:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id 130-v6so17526699qkd.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ta5tHOBMbSYoicbu0+CPW7rTPB5krKblxPmZPIYaX7A=;
        b=PVDW1tLDyGpO3rcu8s+40tq/EuqrNMOh6Vt8bX3uqyUBBdYlfAihaipSo7Ixw6S/bB
         rq3yc2c+rnNrHgGW9q0iA4FmbGBqXN4jEQ4X3IW/j9dmoRUWHvG+7LMirKXo9FaY5Twb
         D0AwE2sAvkI2LV7980JkZAA1/lIrqw/T+OlSedWF852P0aRPH4OJZf0dSJhvZMBb88Jj
         8S7CpmFVAw0MGPqp0LVWg3TMo6suTjtehSmJmh+5IoTaYs9SEzWu8UYJTn0dX9ST6grm
         MZ8+JfLdbQFyEIaXoJJXKQJDI8kV8g7eypUk4beqabeldKzp3tsNHhXYQ8y8NTsAB64+
         bz6Q==
X-Gm-Message-State: APzg51Alq/k88aVDe/8TtfmfWxfgwYJAtvfpC8GVBbale0ZeL9JPTErt
        htOfnf1n1hIHax/hnrytrjJUazy95yk=
X-Google-Smtp-Source: ANB0VdbmpoEGoSSuxumh2RAvcCGh6GccWKxp2YlXEHXHyh9qfMagyf4N92ahnEwbGZGN8jZL68aJmg==
X-Received: by 2002:a37:1414:: with SMTP id e20-v6mr19562943qkh.88.1536693754793;
        Tue, 11 Sep 2018 12:22:34 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id g14-v6sm13639452qtc.66.2018.09.11.12.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:22:33 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/2] scsi: ibmvscsis: Fix a stringop-overflow warning
Date:   Tue, 11 Sep 2018 12:22:25 -0700
Message-Id: <20180911192226.3620-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911192226.3620-1-labbott@redhat.com>
References: <20180911192226.3620-1-labbott@redhat.com>
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

Switch to a single snprintf instead of a strcpy + strcat to handle this
cleanly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Make sure there is an extra space in the partition name
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index fac377320158..b3a029ad07cd 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3474,8 +3474,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 		vscsi->dds.window[LOCAL].liobn,
 		vscsi->dds.window[REMOTE].liobn);
 
-	strcpy(vscsi->eye, "VSCSI ");
-	strncat(vscsi->eye, vdev->name, MAX_EYE);
+	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
 	strncpy(vscsi->dds.partition_name, partition_name,
-- 
2.17.1

