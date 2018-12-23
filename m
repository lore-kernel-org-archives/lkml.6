Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D321971
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdsio913"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeLWQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:19:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43043 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeLWQTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:19:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so4853369pfk.10;
        Sun, 23 Dec 2018 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gVoqCYDLA0o5LX+xASYcFb/X6ybZadJ+i6RdGLoT/vI=;
        b=bdsio913jneybNwI5fRHLV4tKRvNwsevLL8c/GtnpuLK3kG+8S5SFOEohAXr1JrW3K
         sAaPyJjNExw2wh6x68JWdirhAYJER0pPFtApWVdC0/Wvl5tnTn2Xgbsv3remYyUr3AW0
         a8ufl1vSmbiXJ01hxy2QT32cysjcPBSo7OZrgI5oZ/fjKeksRHIiy5XgebCgWSjG76nk
         8k7oDqeUnNKVg4u9wzOvMN0kZtZ1bRJm/KW/ajzPi2JpefqvKG3vtWz6J7WnvBsgdRfQ
         8yf7vJBJsnTezBtBn8tarNCo1gCp6G04s2ej1n2z1gPQsE274rnQCwekNIGGVuAXgvy2
         bcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gVoqCYDLA0o5LX+xASYcFb/X6ybZadJ+i6RdGLoT/vI=;
        b=dGARCLPJAT8dtRoGz7dIeu01uwWiGZ81smD8QCMWIWOBA/Iz4/vkOspAlLn6OLcTjI
         PYueEkTiQGqsTxj35wYcFJgvmEMDvuysrl1YKe6+M9b9bIjmU2AcxBIJ7IC9o3jhhzth
         E00kJqMlH6Q7a4Rfv1htjDE7toDn88MBXGLZsp6ssh3yIw/1Z/0TkA84dDfBJLm51qZe
         /DRoSoGg1/egUPEHAYJtTEHeekDJRbDy4ecmjz5pTWBtzhmCTaX9yXuNYJ3SV5jHfs0O
         dU9rfFd6JFsEV/6HBln6s41ZqcFG1d01pt9UlLsH1y4E7LuWOWORT+ZMFdYi6SMSFh9w
         enhQ==
X-Gm-Message-State: AJcUukeI1yONhUjoyNhfcNClK9PYUiNegSCOnJu0e7vi8iE5vfL4zhCq
        QvDnfgMVHKhna2T9cKcZTYU=
X-Google-Smtp-Source: ALg8bN4XUuzrfiKGqYZNV4y1dE9EBPZCsk5/bRdGf+Mfl3k+KHS4YQrLDkmRZMWqhnStI8CTctPzeg==
X-Received: by 2002:a63:f201:: with SMTP id v1mr9033944pgh.232.1545581963051;
        Sun, 23 Dec 2018 08:19:23 -0800 (PST)
Received: from ceph-3.localdomain ([106.39.114.66])
        by smtp.gmail.com with ESMTPSA id u186sm44082132pfu.51.2018.12.23.08.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 08:19:22 -0800 (PST)
From:   Leo Zhang <nguzcf@gmail.com>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Colin Ian King <colin.king@canonical.com>,
        Laura Abbott <labbott@redhat.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Zhang <nguzcf@gmail.com>
Subject: [PATCH] target/iscsi: fix error msg typo when create lio_qr_cache failed
Date:   Mon, 24 Dec 2018 00:18:27 +0800
Message-Id: <1545581907-920233-1-git-send-email-nguzcf@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Leo Zhang <nguzcf@gmail.com>
---
 drivers/target/iscsi/iscsi_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index c1d5a17..780a914 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -714,7 +714,7 @@ static int __init iscsi_target_init_module(void)
 			sizeof(struct iscsi_queue_req),
 			__alignof__(struct iscsi_queue_req), 0, NULL);
 	if (!lio_qr_cache) {
-		pr_err("nable to kmem_cache_create() for"
+		pr_err("Unable to kmem_cache_create() for"
 				" lio_qr_cache\n");
 		goto bitmap_out;
 	}
-- 
1.8.3.1

