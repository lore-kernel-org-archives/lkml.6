Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7F4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED597206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlW4gjHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfACJze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:55:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33498 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfACJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:55:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so15715411plo.0;
        Thu, 03 Jan 2019 01:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvksfxDJztssxsSA8yomJBjdYl2oiH6i1OWje0NSK68=;
        b=TlW4gjHeMuV3Xar39RktjehRoFI0sO5b8YbKzdCHifSOQY9+Qjxqj2JRt1ROVE1Ef6
         PSNybifYw38VqIEgoyTxWj6yTM1nw2q8/1oNB2GRzCTjJd+T9hbHVjFgkWLn5o5smR4d
         NUHCwXfdPYuuOTgBU90/FXRZGMglL7aR+yG/hRSEbKXZOLQAoTxZCPz4xhseDrPba8su
         DLfk8hT+AKzuMV/DtYtqjulSu6c25o5UnxZUAL2cSAkypppPAPsH49VmrQVf7YG8ioQw
         NXOKah633mUIo9r4+K/NNbiKmRTSXRdVhxqvEiwa6DjeSyl9Ya9vJVAvWaxIfMp/S2RI
         MPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HvksfxDJztssxsSA8yomJBjdYl2oiH6i1OWje0NSK68=;
        b=a4iQnvf6cWbCflhrmGe+fW1AAB4/MUS9reLw6KETgV+c2bu5IVfyguoS+njbPUUwsW
         hgz5iVxIVaGdVsO0OvTUGdq531aeUX+mSX1dyjtGd1W/yzmg6RFAQ9YTxj5r7XX/Gr71
         wHvhU8PxS04EQkEplEriCSJvayV39h5bZDOux6EBx1oz4iFBuakc8ftHTEQ+jsbOQQ+X
         Y++ZjGvIPEreroAp/KNlyUk1A5Fv+a5HNoIbuJFBQfACqgMzp+IuklW4M41vgpHv4Gdx
         P0oheqnOukNjuLgMTs8K7BBFkQ8RjUanoF3cXK637fmA2qDB0snWnpdhgnq4VsaOPQzP
         4m+A==
X-Gm-Message-State: AJcUukd+qgBO/Df05jijRHFgXkYi6WRJXk4HaiHb2nMFZpgEqnrSBtHu
        8qqIpTlEmWb8sOBvcIcM+9Q=
X-Google-Smtp-Source: ALg8bN4hR5JHAR0QgWFlLt47EapfO3F9rK7iPGqJHwh2u7bm3a1cPQC0m0ejROPykggfZEk+txGwzw==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr45940195plb.24.1546509332850;
        Thu, 03 Jan 2019 01:55:32 -0800 (PST)
Received: from huangrandall.ntc.corp.google.com ([2401:fa00:fc:1:6924:4b22:cf4b:bbca])
        by smtp.gmail.com with ESMTPSA id g26sm71451814pfh.61.2019.01.03.01.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 01:55:32 -0800 (PST)
From:   Randall Huang <ihhuang@abmail.org>
X-Google-Original-From: Randall Huang <huangrandall@google.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Subject: [PATCH] scsi: associate bio write hint with WRITE CDB
Date:   Thu,  3 Jan 2019 17:55:28 +0800
Message-Id: <20190103095528.102345-1-huangrandall@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SPC-3, WRITE(10)/(16) support grouping function.
Let's associate bio write hint with group number for
enabling StreamID or Turbo Write feature.

Change-Id: I565c8e0c1d10e17a23e73f2a02c1adbd198b04b3
Signed-off-by: Randall Huang <huangrandall@google.com>
---
 drivers/scsi/sd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4b49cb67617e..db48a849107e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1201,7 +1201,11 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
 		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
-		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
+		if (rq_data_dir(rq) == WRITE)
+			SCpnt->cmnd[14] = rq->bio->bi_write_hint & 0x3f;
+		else
+			SCpnt->cmnd[14] = 0;
+		SCpnt->cmnd[15] = 0;
 	} else if ((this_count > 0xff) || (block > 0x1fffff) ||
 		   scsi_device_protection(SCpnt->device) ||
 		   SCpnt->device->use_10_for_rw) {
@@ -1211,9 +1215,13 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
 		SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
 		SCpnt->cmnd[5] = (unsigned char) block & 0xff;
-		SCpnt->cmnd[6] = SCpnt->cmnd[9] = 0;
+		if (rq_data_dir(rq) == WRITE)
+			SCpnt->cmnd[6] = rq->bio->bi_write_hint & 0x1f;
+		else
+			SCpnt->cmnd[6] = 0;
 		SCpnt->cmnd[7] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[8] = (unsigned char) this_count & 0xff;
+		SCpnt->cmnd[9] = 0;
 	} else {
 		if (unlikely(rq->cmd_flags & REQ_FUA)) {
 			/*
-- 
2.20.1.415.g653613c723-goog

