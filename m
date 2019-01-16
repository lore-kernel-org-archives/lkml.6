Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1713206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXEKEZiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbfAPWsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:48:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50702 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733300AbfAPWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:48:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so3817614wmd.0;
        Wed, 16 Jan 2019 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGzywxGnLZ58VOYPur4GY2Jad3uugEcFgDpnEvIfaI0=;
        b=uXEKEZiPikEgPhLo/Uqu94kRLrnBvZys4cMM9qmGS0Jv2k/IAeYDDPKJ5MuWzImOPm
         Ph8l7Uah9ufr6axeJb4pJ0I0D2Vy49ndOXEglASpX10dGOSlvIzOj753zxzFIMXgr26L
         8N/rsWpVnhYRiHphYoohGyF1ZzTqFafQvkorOpfiRPzBpnrDTv4s8CQX9H/WH9bl9TFY
         pPqCMFb2jBajzu+nbnUURLoKkDtKnnw1228+Bg+GAJKY3I/yuekI7v5TnYVKh+s14Mz2
         dGvgJGcbMCJYlcLRtNQr4VcBmuY6MS6w5V56IP5k6hNLuLQmZKTguZyFrp8hFO82lj/U
         KNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGzywxGnLZ58VOYPur4GY2Jad3uugEcFgDpnEvIfaI0=;
        b=Tu+JzfmftRzJMfvy5rziCLZHmdzW69y2rhIXTw3jD+DTTyvRKvhqG6svSEIG/+j7CW
         qphNySmBX3CuFiKDmJ2Jv9jETBtLexZ7QF28kxbjlb5pwMjebp+MN3e74OMm4Vo8gAUq
         NjKTIWXnkeWYDqAvnuMIoTrUflgq8NRpMYCZgVgYdQdMV2vznAeQXV8y8Hvdjulfu6Cq
         uWeOrIyVxQUWfXOLBpjXANG3kUr9x09HDYXxP5CKAMVnQGiPg3NZ90d+DJdMZptsH3Id
         k9Jcb9w3k3YxQ81ho4muVur73urlexLwjvPtrxucXyxAR2CxJzqY/LoixYRicyPrzVCo
         daog==
X-Gm-Message-State: AJcUukeub301Oc2+vH0FiOsOjPi6u/HfLkRLfy1cypAbvAGf8BdVwkYp
        rFquUG1BY3/sqve3B83K1/A=
X-Google-Smtp-Source: ALg8bN5AouGGor04TfGMBCn4maBiI69o/GLWugL2Jfx5W3G5O2ahObjfmlJ82J6w/KaPROnVZvTSZQ==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr9495014wmg.51.1547678892014;
        Wed, 16 Jan 2019 14:48:12 -0800 (PST)
Received: from voyt-hp.fritz.box ([2001:16b8:a0fa:4800:d760:eff:e759:2a3b])
        by smtp.gmail.com with ESMTPSA id m4sm27745248wml.2.2019.01.16.14.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 14:48:11 -0800 (PST)
From:   Dmitry Voytik <voytikd@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH v2] scsi: be2iscsi: fix potential NULL pointer dereference
Date:   Wed, 16 Jan 2019 23:47:35 +0100
Message-Id: <20190116224735.13061-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential NULL pointer dereference wich might happen in
beiscsi_alloc_mem(). If kmalloc_array() fails and mem_descr->mem_array
is set to NULL, then its dereferencing happens when passing
mem_descr->mem_array[] to dma_free_coherent().

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---

Changes since v1:
 - prevent double free by setting mem_arr_orig to NULL

 drivers/scsi/be2iscsi/be_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 74e260027c7d..7b8c80318c38 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2527,8 +2527,11 @@ static int beiscsi_alloc_mem(struct beiscsi_hba *phba)
 		mem_descr->size_in_bytes = phba->mem_req[i];
 		mem_descr->mem_array = kmalloc_array(j, sizeof(*mem_arr),
 						     GFP_KERNEL);
-		if (!mem_descr->mem_array)
+		if (!mem_descr->mem_array) {
+			mem_descr->mem_array = mem_arr_orig;
+			mem_arr_orig = NULL;
 			goto free_mem;
+		}
 
 		memcpy(mem_descr->mem_array, mem_arr_orig,
 		       sizeof(struct mem_array) * j);
-- 
2.20.1

