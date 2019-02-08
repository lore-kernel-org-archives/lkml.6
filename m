Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB64C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84BF2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="T0ZqOy+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfBHRhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:35 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34933 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfBHRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:26 -0500
Received: by mail-it1-f194.google.com with SMTP id r6so10907247itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udWPKO5Lvqc0HWggsv/4sa1+FuSbuB82aM5LFvml2yw=;
        b=T0ZqOy+9Ohw+IJQxlbNHdA5xoqEWE8HBSrsuv7YEAfmcsfMREdmnrGSJvCrBt62EuP
         Ce7aUQjvZLCNwv/jOXrVM3bAIhrtXXHVmu3MUgDV5XERvXXrZt2HmF1xmlLSVHumY7V9
         nUzYw67u6PkoiOMET66b/Ge2XN1CtC7EPM9uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udWPKO5Lvqc0HWggsv/4sa1+FuSbuB82aM5LFvml2yw=;
        b=Pjo9FmHXQnpqH8GPyRvFn5civ9oAaHvSfLON3el38SxrW1hqF81aCF7uCPuUINeO0w
         B4ng11xFVa1NgsAZ5wREUQC+IDaRurYPh6ArxizysNxLAtYHcVm0+i5qo4vQ7Hc6skan
         sH48VE8x8Aqn4B1TixEzdrfgkMWDaqFqf4XIswjIYYKez/X+qroeANrvLPDR1SuHUmeL
         n8pNww4w3PgfrhEfozTMh3NaWkpWi5LAzMJzPgwv86oSpdWr2XhlN5REULquzjafmf+w
         5xtHG8IfDrT3FaXJYGHTdOp81xUvF0wiHtGkXSZyyP1N+HWGdnf+TDhmxhuDIz6Lsj+a
         vCxA==
X-Gm-Message-State: AHQUAuZFUS+g+bTDEdHK6pYVwUY+q5OIGBZ/dw8ojd848B+lXlWMCuze
        s2lVQHwgCDjCmSgrbjdl/vBfcg==
X-Google-Smtp-Source: AHgI3IYzwHMD9OjUghBIDKuFZBUrNIglpVp/SjSeiwDjlEEcmuGD/7EacJnQWUCpjGPjFUzjllqdFA==
X-Received: by 2002:a02:400a:: with SMTP id n10mr4602199jaa.128.1549647326009;
        Fri, 08 Feb 2019 09:35:26 -0800 (PST)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id k1sm1198861iob.2.2019.02.08.09.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:25 -0800 (PST)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH 1/2] udf: factor out LVID finalization for reuse
Date:   Fri,  8 Feb 2019 11:34:54 -0600
Message-Id: <20190208173455.20151-2-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173455.20151-1-steve@digidescorp.com>
References: <20190208173455.20151-1-steve@digidescorp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centralize timestamping and CRC/checksum updating of the in-core
Logical Volume Integrity Descriptor, in preparation for adding
a third site where this functionality is needed.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
--- a/fs/udf/super.c	2019-02-08 10:30:00.397978609 -0600
+++ b/fs/udf/super.c	2019-02-08 10:39:14.462529517 -0600
@@ -1771,6 +1771,17 @@ static int udf_load_vrs(struct super_blo
 	return 1;
 }
 
+static void udf_finalize_lvid(struct logicalVolIntegrityDesc *lvid)
+{
+	udf_time_to_disk_stamp(&lvid->recordingDateAndTime,
+				CURRENT_TIME);
+
+	lvid->descTag.descCRC = cpu_to_le16(
+		crc_itu_t(0, (char *)lvid + sizeof(struct tag),
+			le16_to_cpu(lvid->descTag.descCRCLength)));
+	lvid->descTag.tagChecksum = udf_tag_checksum(&lvid->descTag);
+}
+
 static void udf_open_lvid(struct super_block *sb)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
@@ -1787,15 +1798,9 @@ static void udf_open_lvid(struct super_b
 
 	lvidiu->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
 	lvidiu->impIdent.identSuffix[1] = UDF_OS_ID_LINUX;
-	udf_time_to_disk_stamp(&lvid->recordingDateAndTime,
-				CURRENT_TIME);
 	lvid->integrityType = cpu_to_le32(LVID_INTEGRITY_TYPE_OPEN);
 
-	lvid->descTag.descCRC = cpu_to_le16(
-		crc_itu_t(0, (char *)lvid + sizeof(struct tag),
-			le16_to_cpu(lvid->descTag.descCRCLength)));
-
-	lvid->descTag.tagChecksum = udf_tag_checksum(&lvid->descTag);
+	udf_finalize_lvid(lvid);
 	mark_buffer_dirty(bh);
 	sbi->s_lvid_dirty = 0;
 	mutex_unlock(&sbi->s_alloc_mutex);
@@ -1816,7 +1821,6 @@ static void udf_close_lvid(struct super_
 	lvidiu = udf_sb_lvidiu(sbi);
 	lvidiu->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
 	lvidiu->impIdent.identSuffix[1] = UDF_OS_ID_LINUX;
-	udf_time_to_disk_stamp(&lvid->recordingDateAndTime, CURRENT_TIME);
 	if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
 		lvidiu->maxUDFWriteRev = cpu_to_le16(UDF_MAX_WRITE_VERSION);
 	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
@@ -1825,11 +1829,7 @@ static void udf_close_lvid(struct super_
 		lvidiu->minUDFWriteRev = cpu_to_le16(sbi->s_udfrev);
 	lvid->integrityType = cpu_to_le32(LVID_INTEGRITY_TYPE_CLOSE);
 
-	lvid->descTag.descCRC = cpu_to_le16(
-			crc_itu_t(0, (char *)lvid + sizeof(struct tag),
-				le16_to_cpu(lvid->descTag.descCRCLength)));
-
-	lvid->descTag.tagChecksum = udf_tag_checksum(&lvid->descTag);
+	udf_finalize_lvid(lvid);
 	mark_buffer_dirty(bh);
 	sbi->s_lvid_dirty = 0;
 	mutex_unlock(&sbi->s_alloc_mutex);
