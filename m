Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E000C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F42052073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZbt0Yzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfACJTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:19:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33302 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfACJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:19:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so15773524pgu.0;
        Thu, 03 Jan 2019 01:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM/fiTic0aMaCgmTxDx4WWLLOVwwI2n4rkkI5hGKZoY=;
        b=qZbt0YziqBGM9Bym8j59Wats+tCkFokKuP3LuLua4aufkYtybz6FXZSxNvegwepYFv
         V8YPQsiaUw19idRQYMvLQEWK478ol7VANBZ+vGfWOxVoz8/sAHb2uyzyuhqBJWs4g7Zc
         /Fv33xVa2H8b9RhpHpA2LFDQvDvk4AerUukOkb11b0j5XEsiulq3TlR07bdqCyy7a1Yq
         Zcy0XMTExxuh/cbBDolsAWu91/ysv5xc+AP6Hxv+TIQHx/Hi2YD4lefpZGzF0ykNxN/Q
         yFVdey1npTNI1JDPPa6AT2kfw6NO7ndk8VtY4SZ6yzmWiUQeoW8HBSPpqt+xgz9qIjCC
         b+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eM/fiTic0aMaCgmTxDx4WWLLOVwwI2n4rkkI5hGKZoY=;
        b=NRrG6PdHpENqovCMxSbVOHrCjuVrBVNTL//JrQcM3CHlcoIkArfBDzAWsiD5D/DyyR
         2uXm+qnzvu287SJ/SvMTcv/w4tkl5Vg+twPraxXIPMUv+vBFPFJ02km75sSmt2vv3LkY
         faO8cblwRx07IGYGhrN36vFvcnD+UT/5QCy8ksDP+YG4y/1OfISrSpQvpqxdBn4atWkS
         aSyKgnNIhOZIKmHqnuztqE7QvB+MfGaMH77Uz712+sxBPhdqFxlAkdNvEYFPvScoPpoW
         Cr+J6OGOIaJg3mMZi2+ofIcNJqUqTkFyxzvl1itXIB6mj/TIhXiFpXpM6/HsvIeu2Lix
         2pMA==
X-Gm-Message-State: AJcUukepOY6LwWaNJq56ijK38j32Z6KU63jGI+qglReYy/35g8V7obZo
        28VsiRmUizDIZ96/izK95F6ld/FV
X-Google-Smtp-Source: ALg8bN6ue8WZXUxPhH/e80BTSHSgsnRiujlK/Zhp++VLUbZtAZJKKvMt0GNtsSbf/qYbryhose7Kog==
X-Received: by 2002:a63:3204:: with SMTP id y4mr16317953pgy.41.1546507181871;
        Thu, 03 Jan 2019 01:19:41 -0800 (PST)
Received: from huangrandall.ntc.corp.google.com ([2401:fa00:fc:1:6924:4b22:cf4b:bbca])
        by smtp.gmail.com with ESMTPSA id w5sm72046135pfn.89.2019.01.03.01.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 01:19:41 -0800 (PST)
From:   Randall Huang <ihhuang@abmail.org>
X-Google-Original-From: Randall Huang <huangrandall@google.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Subject: [PATCH] scsi: associate bio write hint with WRITE CDB
Date:   Thu,  3 Jan 2019 17:19:35 +0800
Message-Id: <20190103091935.380-1-huangrandall@google.com>
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

Bug: 120900381
Change-Id: I565c8e0c1d10e17a23e73f2a02c1adbd198b04b3
Signed-off-by: Randall Huang <huangrandall@google.com>
---
 drivers/scsi/sd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4b49cb67617e..831c0c81ffb9 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1201,7 +1201,11 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
 		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
-		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
+		if (rq_data_dir(rq) == WRITE) {
+			SCpnt->cmnd[14] = rq->bio->bi_write_hint & 0x3f;
+		} else
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
+		if (rq_data_dir(rq) == WRITE) {
+			SCpnt->cmnd[6] = rq->bio->bi_write_hint & 0x1f;
+		} else
+			SCpnt->cmnd[6] = 0;
 		SCpnt->cmnd[7] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[8] = (unsigned char) this_count & 0xff;
+		SCpnt->cmnd[9] = 0;
 	} else {
 		if (unlikely(rq->cmd_flags & REQ_FUA)) {
 			/*
-- 
2.20.1.415.g653613c723-goog

