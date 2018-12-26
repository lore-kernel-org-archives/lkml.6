Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31AA2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWjo4oxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbeLZFvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:51:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33030 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeLZFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:51:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so14846687wrr.0;
        Tue, 25 Dec 2018 21:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AGrCHRxEhEsMQYMNnW32btcfGW7yeDllQpf+o+Mz9rM=;
        b=tWjo4oxT6HWy0Zr6MnIoGMFuB6hO7Qi98O9406u76gSurjdYgoMfxUjEixIIU6zVwP
         mCuHdQFUtDblF68P8fWmxvoRYUsFwVe110WFoexkJYCddxW9XgXJhwhBZxEgY9sK0tIp
         Qnm1plyolBAYJ5wfEqK2x6IMy/c52U4RiVI3KsDNCReYTR2UJIRqkvIjM9X5LIwqJrMu
         uoXVPWg83Q7m7VNfgYmST7P+EzfwgbpNjZ1A0+yCC1phxzZF1nG/BxXQEd4bzkVowJTK
         9n26XzTSBA9zD5/GIjUMradMY9xMnR90cav25nnZs/0Zac673IwIOZJ2GGQS7iM9gWYA
         +uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AGrCHRxEhEsMQYMNnW32btcfGW7yeDllQpf+o+Mz9rM=;
        b=gBSVDIhw8FxHwmr7jwTlXTB8p9BFkYHP0YJpquzGQU+gle2DdZj7vgorxg6KlmRdxH
         r8TgwsA+paKRkiUxeiskKKJkQ3Md+ixjUTuH4DKFbbegNY33dI1Rl+vBKZ+z8GUSQBm0
         ZcAaI9jHop6fKouvPrbTCgtXv6xm+IkH+w71bUPefFfDSPyoalJMjFSrDToelENzB1mV
         SQRTD1m6elfspXHEY7SWnkPvwiJIrwbbED5duDU8S1lMSnyiYg3iikxO0O0nRxr/wJOb
         bsxb5H77zDlT35WZxNMaFBg1lXJLMJVTNiNLk85LBgL7r5RBbpwJh1jdWFWb7NcaJ9BE
         I1qg==
X-Gm-Message-State: AJcUukcRuHlSKIBj9ox6f8SmJL0A8X3x7HkTGbJoAtBn1c8EDyR1jwdy
        4D9/80kO4O6xjGEkAcJFCik=
X-Google-Smtp-Source: ALg8bN7D5qYqXLHm/X2R2oncjFpQFZBAqMQkZWIIlw309Jq04QYZSs/7X6+yjPVpO8rCprvyPxYJZA==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr16170997wrv.101.1545803481865;
        Tue, 25 Dec 2018 21:51:21 -0800 (PST)
Received: from huangrandall.ntc.corp.google.com ([2401:fa00:fc:1:6924:4b22:cf4b:bbca])
        by smtp.gmail.com with ESMTPSA id a62sm21996491wmf.47.2018.12.25.21.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 21:51:21 -0800 (PST)
From:   Randall Huang <ihhuang@abmail.org>
X-Google-Original-From: Randall Huang <huangrandall@google.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Subject: [PATCH] scsi: associate bio write hint with WRITE CDB
Date:   Wed, 26 Dec 2018 13:51:11 +0800
Message-Id: <20181226055111.101325-1-huangrandall@google.com>
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

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 drivers/scsi/sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4b49cb67617e..28bfa9ed2b54 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1201,7 +1201,12 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
 		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
-		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
+		if (rq_data_dir(rq) == WRITE) {
+			SCpnt->cmnd[14] = rq->bio->bi_write_hint & 0x3f;
+		} else {
+			SCpnt->cmnd[14] = 0;
+		}
+		SCpnt->cmnd[15] = 0;
 	} else if ((this_count > 0xff) || (block > 0x1fffff) ||
 		   scsi_device_protection(SCpnt->device) ||
 		   SCpnt->device->use_10_for_rw) {
@@ -1211,9 +1216,14 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
 		SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
 		SCpnt->cmnd[5] = (unsigned char) block & 0xff;
-		SCpnt->cmnd[6] = SCpnt->cmnd[9] = 0;
+		if (rq_data_dir(rq) == WRITE) {
+			SCpnt->cmnd[6] = rq->bio->bi_write_hint & 0x1f;
+		} else {
+			SCpnt->cmnd[6] = 0;
+		}
 		SCpnt->cmnd[7] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[8] = (unsigned char) this_count & 0xff;
+		SCpnt->cmnd[9] = 0;
 	} else {
 		if (unlikely(rq->cmd_flags & REQ_FUA)) {
 			/*
-- 
2.20.1.415.g653613c723-goog

