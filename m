Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FCCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55325206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VK8LBw6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55325206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeGQVEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:04:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36298 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbeGQVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:04:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id m19-v6so937113pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eg2Mjkb1M+l5w9+ISrAtsAOrO6qEMIH17I1Pv/SmrYg=;
        b=VK8LBw6g8slfcZTGaJVYCC4JTRIi/iZm9u74JFt/SaRYZao7EFC4ZHF65IdodSs6Jk
         yXI4BuYgxUe3dNRfmR+VJ1ggJNb1Xx1XP4WBv5+OoZd4kUgf13QmtF7+vw8uY336I+X2
         eZV9aq0LSWGrkXXRtdC6JXKAAIgz7+Q1YoTAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eg2Mjkb1M+l5w9+ISrAtsAOrO6qEMIH17I1Pv/SmrYg=;
        b=S0IyuDO+DA3ToAGqiy7xkVcJwYewr+o2UpjqAkwhD7KS2ApJVhnggEiqYx4pqYu5iZ
         eNXlHxXp/K4l3Uav5wtSBjX9htFujrpij8zHq3vj+F5rYfj8QrhlnV7u1YPTl1fu269u
         uzLTlPITBpYFSeZbo/9MxMxmOrIOW1VYnLL9aatyQ95Hl244s/aISGIK8OprA0lJhHg8
         QW3b09zYmd8G69xrWbqcstyLoMfBHsiYSBFXcgiDbiiUZK4pU94jMJmjZdKDLgb4W/FR
         YVkkiWEimTab+yN9heZzGHWuY5dBWl8r0/wNbT5nccEF4dmpk3CfJhPm5XnvdB2AI2Cr
         Gf2g==
X-Gm-Message-State: AOUpUlFETThYtsScSPJwRAYzME4fcSO5wLb1/YzipiZy1Zz96vi58P/0
        rpotlJAWdI41kmWmHHsk6Bh79Q==
X-Google-Smtp-Source: AAOMgpeZJT2YxiK6c33x8rJ9h6eWXJt3i5x6mzsr9aEmYVNdsJr/IlZCqFgqxGJp/yk9b8uH95Inkw==
X-Received: by 2002:a63:f804:: with SMTP id n4-v6mr3064902pgh.106.1531859391212;
        Tue, 17 Jul 2018 13:29:51 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a20-v6sm2563426pfi.124.2018.07.17.13.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:29:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 1/2] soc: qcom: cmd-db: Remove memcpy()ing from cmd_db_get_header()
Date:   Tue, 17 Jul 2018 13:29:46 -0700
Message-Id: <20180717202947.197922-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717202947.197922-1-swboyd@chromium.org>
References: <20180717202947.197922-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmd_db_get_header() function is a static local function that doesn't
need to copy anything from one place to another. Instead, it can just
point into the region by returning pointers to what we're looking for.
If we do that, we should mark what we're returning as const so that code
can't modify cmd-db without an obvious cast.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 60 +++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a6f646295f06..5c9cc6824891 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -101,8 +101,7 @@ static bool cmd_db_magic_matches(const struct cmd_db_header *header)
 
 static struct cmd_db_header *cmd_db_header;
 
-
-static inline void *rsc_to_entry_header(struct rsc_hdr *hdr)
+static inline const void *rsc_to_entry_header(const struct rsc_hdr *hdr)
 {
 	u16 offset = le16_to_cpu(hdr->header_offset);
 
@@ -110,7 +109,7 @@ static inline void *rsc_to_entry_header(struct rsc_hdr *hdr)
 }
 
 static inline void *
-rsc_offset(struct rsc_hdr *hdr, struct entry_header *ent)
+rsc_offset(const struct rsc_hdr *hdr, const struct entry_header *ent)
 {
 	u16 offset = le16_to_cpu(hdr->data_offset);
 	u16 loffset = le16_to_cpu(ent->offset);
@@ -134,11 +133,11 @@ int cmd_db_ready(void)
 }
 EXPORT_SYMBOL(cmd_db_ready);
 
-static int cmd_db_get_header(const char *id, struct entry_header *eh,
-			     struct rsc_hdr *rh)
+static int cmd_db_get_header(const char *id, const struct entry_header **eh,
+			     const struct rsc_hdr **rh)
 {
-	struct rsc_hdr *rsc_hdr;
-	struct entry_header *ent;
+	const struct rsc_hdr *rsc_hdr;
+	const struct entry_header *ent;
 	int ret, i, j;
 	u8 query[8];
 
@@ -146,9 +145,6 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
 	if (ret)
 		return ret;
 
-	if (!eh || !rh)
-		return -EINVAL;
-
 	/* Pad out query string to same length as in DB */
 	strncpy(query, id, sizeof(query));
 
@@ -159,14 +155,13 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
 
 		ent = rsc_to_entry_header(rsc_hdr);
 		for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
-			if (memcmp(ent->id, query, sizeof(ent->id)) == 0)
-				break;
-		}
-
-		if (j < le16_to_cpu(rsc_hdr->cnt)) {
-			memcpy(eh, ent, sizeof(*ent));
-			memcpy(rh, rsc_hdr, sizeof(*rh));
-			return 0;
+			if (memcmp(ent->id, query, sizeof(ent->id)) == 0) {
+				if (eh)
+					*eh = ent;
+				if (rh)
+					*rh = rsc_hdr;
+				return 0;
+			}
 		}
 	}
 
@@ -186,12 +181,11 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
 u32 cmd_db_read_addr(const char *id)
 {
 	int ret;
-	struct entry_header ent;
-	struct rsc_hdr rsc_hdr;
+	const struct entry_header *ent;
 
-	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, NULL);
 
-	return ret < 0 ? 0 : le32_to_cpu(ent.addr);
+	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
 EXPORT_SYMBOL(cmd_db_read_addr);
 
@@ -207,8 +201,8 @@ EXPORT_SYMBOL(cmd_db_read_addr);
 int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 {
 	int ret;
-	struct entry_header ent;
-	struct rsc_hdr rsc_hdr;
+	const struct entry_header *ent;
+	const struct rsc_hdr *rsc_hdr;
 	u16 ent_len;
 
 	if (!data)
@@ -218,12 +212,12 @@ int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 	if (ret)
 		return ret;
 
-	ent_len = le16_to_cpu(ent.len);
+	ent_len = le16_to_cpu(ent->len);
 	if (len < ent_len)
 		return -EINVAL;
 
 	len = min_t(u16, ent_len, len);
-	memcpy(data, rsc_offset(&rsc_hdr, &ent), len);
+	memcpy(data, rsc_offset(rsc_hdr, ent), len);
 
 	return len;
 }
@@ -239,12 +233,11 @@ EXPORT_SYMBOL(cmd_db_read_aux_data);
 size_t cmd_db_read_aux_data_len(const char *id)
 {
 	int ret;
-	struct entry_header ent;
-	struct rsc_hdr rsc_hdr;
+	const struct entry_header *ent;
 
-	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, NULL);
 
-	return ret < 0 ? 0 : le16_to_cpu(ent.len);
+	return ret < 0 ? 0 : le16_to_cpu(ent->len);
 }
 EXPORT_SYMBOL(cmd_db_read_aux_data_len);
 
@@ -258,15 +251,14 @@ EXPORT_SYMBOL(cmd_db_read_aux_data_len);
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 {
 	int ret;
-	struct entry_header ent;
-	struct rsc_hdr rsc_hdr;
+	const struct entry_header *ent;
 	u32 addr;
 
-	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
+	ret = cmd_db_get_header(id, &ent, NULL);
 	if (ret < 0)
 		return CMD_DB_HW_INVALID;
 
-	addr = le32_to_cpu(ent.addr);
+	addr = le32_to_cpu(ent->addr);
 	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
 }
 EXPORT_SYMBOL(cmd_db_read_slave_id);
-- 
Sent by a computer through tubes

