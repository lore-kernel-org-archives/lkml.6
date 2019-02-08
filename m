Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C533AC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9953A217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="bBtfyIzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfBHRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33109 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbfBHRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:29 -0500
Received: by mail-it1-f194.google.com with SMTP id q78so9316858itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/48HGg+33SRO0lkRonK7zd7mhVUUhsHQ0929pL4R4rI=;
        b=bBtfyIzhLUdRgnMl4RNRmSpqKPPgtUbO3+QacKCcGzGXowrypAcsD3C/oSOZy8kLuE
         kmgDRpvRDbKTq2jSZBthdeRtrcSuuX4HYNq5FWvWSWMIzppmSwI6y/Cn+MGPBLW5/G/9
         jrJlrbTAA1/idTyYYCZ1/Blx893FffaTisUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/48HGg+33SRO0lkRonK7zd7mhVUUhsHQ0929pL4R4rI=;
        b=Tun54djwcH5ilQTMvp7AupQENW0qQnOUNbNyBoxo8/OsrL16JtDIjfH6MnPpvsG0KG
         iaDrZL8KoMLOmp7b9nd9ZNRrDKQcsvGkBpuPQ4/x0qBoDJSZvtVCoQ2CmXzciyIr2GTf
         qP1Jz8CuM70YPQ+kYAOfuqU3LWQT4TlybHTzMBtK0E+xHylQZfOo9MvLnw+wRmDnwoIa
         HDtFCIXyD/iTvDsKg4IJXA2lFomov2Yif2L8OfSDmUe4LkBsOob8lSmDVbSvnXJQLxiG
         aQ2BIcXWEzam5UbRC0NR5gJ1lixOprCvZ1yE3CTiKtSbhW69aiPOVWwMNBbr/HBm4gVh
         F+wA==
X-Gm-Message-State: AHQUAuZBs1uVxPMl5RerihVyANmQ/qPbPPellEa9Y9le3nePj8NI9Bjl
        1uLv5SqY33ishbC5bb62eZTV4A==
X-Google-Smtp-Source: AHgI3IagAZX1jsBpv6nmkze3UVMfkjuAFS1OurYyS3yC1iAHPCxZZfEMm4/nkpjqLzCKMyoydgJ85g==
X-Received: by 2002:a6b:ec08:: with SMTP id c8mr6730109ioh.37.1549647328785;
        Fri, 08 Feb 2019 09:35:28 -0800 (PST)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id k1sm1198861iob.2.2019.02.08.09.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:28 -0800 (PST)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH 2/2] udf: finalize integrity descriptor before writeback
Date:   Fri,  8 Feb 2019 11:34:55 -0600
Message-Id: <20190208173455.20151-3-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173455.20151-1-steve@digidescorp.com>
References: <20190208173455.20151-1-steve@digidescorp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the CRC and tag checksum of the Logical Volume Integrity
Descriptor are valid before the structure is written out to disk.
Otherwise, unless the filesystem is unmounted gracefully, the on-disk
LVID will be invalid - which is unnecessary filesystem damage.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
--- a/fs/udf/super.c	2019-02-08 10:39:48.351039434 -0600
+++ b/fs/udf/super.c	2019-02-08 10:42:26.017400020 -0600
@@ -1856,8 +1856,8 @@ u64 lvid_get_unique_id(struct super_bloc
 	if (!(++uniqueID & 0xFFFFFFFF))
 		uniqueID += 16;
 	lvhd->uniqueID = cpu_to_le64(uniqueID);
+	udf_updated_lvid(sb);
 	mutex_unlock(&sbi->s_alloc_mutex);
-	mark_buffer_dirty(bh);
 
 	return ret;
 }
@@ -2154,11 +2154,20 @@ static int udf_sync_fs(struct super_bloc
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	if (sbi->s_lvid_dirty) {
+		struct buffer_head *bh = sbi->s_lvid_bh;
+
+		if (bh) {
+			struct logicalVolIntegrityDesc *lvid;
+
+			lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
+			udf_finalize_lvid(lvid);
+		}
+
 		/*
 		 * Blockdevice will be synced later so we don't have to submit
 		 * the buffer for IO
 		 */
-		mark_buffer_dirty(sbi->s_lvid_bh);
+		mark_buffer_dirty(bh);
 		sb->s_dirt = 0;
 		sbi->s_lvid_dirty = 0;
 	}
