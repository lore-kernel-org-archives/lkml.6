Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60662C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057EA21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="XxOcowjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057EA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJJAuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:50:00 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:56141 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJJAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:26 -0400
Received: by mail-it1-f170.google.com with SMTP id c23-v6so3883115itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=syHuYulLxBme0vmwa314TMLha7/Hw7uICCzj802OzdI=;
        b=XxOcowjD9fnUFTBJX0K8ex8PQxTqsfI25Q4IoWuhfxUjKC1gsMPrJhN8crX6y+vRXk
         TqFCEH/QKILe0lYDh5VZH0wYBuiv0U9i53hwlJ9v/zHLzs81KJRzhxgdDYmn2rpSF9x7
         rQGEAzdH0E2w8juajUjutTA279PzYNmA34iOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=syHuYulLxBme0vmwa314TMLha7/Hw7uICCzj802OzdI=;
        b=fTSAGs8oODpnrx+dz4e/bMhCQiYsEahntND4Eu6InVH9m+/fA/E0vFRdvyLFwbzgVI
         zxB5XrGbfoZKi3ZJviAFtPLpDo7h81gDgILMXPXSHy1TsN6cIhSj4JcivG6E0g3Rz+EH
         bLByVxfzi+qLKsD0xxFcy8ctUBrk5w3ivTuC5URSA/UUgX4XpZX1aav+ETkmmXv8oRQz
         EXQ/qlVFIdqU6QlYBebdLLHGqAAIcFqfaWx54gGEPFdYAdVOyzMfvSfywPKg/CZGmqzT
         ldprNZzvwofjluXqC0AfYqoLjW5hruLJ/6UOwKxoVuMUSYkXko6rNlLJ8rCAY637G41S
         djCw==
X-Gm-Message-State: ABuFfoi2TrWzPtYU0JeNA4j+Nh6CfJKHzJ6gCz3+nqJbo/ETRqCE/BHv
        zdgdNcOgcwaY6CM/CYVeU1rTtjqLRvDwQwOxOwW0P4RL3giCjIK1AKgGoPUWiw1cj9LcaMg4yxr
        tvbqNX+UF5RlFCocN
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV60+vmQi17SX+s/VMyYOWueMAYtxmCb7F63hziTwxjWy2K9hYjFE9XLcaqqVqXA52z2iSHi1Gw==
X-Received: by 2002:a24:1dd8:: with SMTP id 207-v6mr2567405itj.126.1539106283979;
        Tue, 09 Oct 2018 10:31:23 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:23 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field instead of string
Date:   Tue,  9 Oct 2018 13:31:06 -0400
Message-Id: <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIRMWARE_VERSION field is 8-bytes in size and contains non-printable
characters.

Treat this field as binary and print individual byte values in hex

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.h      |  9 ++++++++-
 mmc_cmds.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/mmc.h b/mmc.h
index 5d8a7e3..86e209a 100644
--- a/mmc.h
+++ b/mmc.h
@@ -59,7 +59,14 @@
 #define EXT_CSD_OPTIMAL_READ_SIZE	266	/* RO */
 #define EXT_CSD_OPTIMAL_WRITE_SIZE	265	/* RO */
 #define EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE	264	/* RO */
-#define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_7	261	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_6	260	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_5	259	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_4	258	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_3	257	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_2	256	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_1	255	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_0	254	/* RO */
 #define EXT_CSD_CACHE_SIZE_3		252
 #define EXT_CSD_CACHE_SIZE_2		251
 #define EXT_CSD_CACHE_SIZE_1		250
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 97ea111..45aa4c0 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1758,8 +1758,15 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-		printf("eMMC Firmware Version: %s\n",
-			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
+		printf("Firmware Version: 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_5],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_4],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_3],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_2],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_1],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_0]);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
