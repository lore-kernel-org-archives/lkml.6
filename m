Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496CEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48BD21547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HE+Tff39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48BD21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeI0ARk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:17:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39627 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI0ARk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:17:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85-v6so11271440pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eg2Mjkb1M+l5w9+ISrAtsAOrO6qEMIH17I1Pv/SmrYg=;
        b=HE+Tff39dQAvarSfSarMxP10o7T/fKZ7fFZypESU8h08qM8WUAAniAivJLswk6ysXv
         KVhRbLe7JK9rWYtaRxpMrUNnI1YFoQdo01gXZYhTvPhYD9A7uxGE0h7zwuVepburY1eM
         FDIEHN+W0PjBPvgPBQ52RmdDEyY4n8fevwsLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eg2Mjkb1M+l5w9+ISrAtsAOrO6qEMIH17I1Pv/SmrYg=;
        b=KxQU7eft+uLZN7n8handYYM432jDzi2zihEVBtz8xtNjqw4BMsmOCEztLHU/ANaTxR
         bj8uJEuWg0pOO1AnZsXI/kZ9ZqrueG/4jyEVDPqrk/zJ+F+44y6f7mgN5f9xDX9M/mQx
         WN665hDQDM061Kp/05y0KpJyQKJ/rtem11TwxW8QQXeondCmE0C0QvQreBTyfIfad2aL
         4YSWcbmkI75JGpjk5OfvhMs17J6Ywa9z9UX2qhSpPzMozOYbVa0WFVRuuBC7R4Kt8xtp
         p4PFZuQp9YRfCUlpcHd103+0Dvyt9pibBC8Ry9EZoUmKjC/Aosn2OZzkwPHrz+7Vk1Xv
         JtRg==
X-Gm-Message-State: ABuFfogbemYCcj2uKuoqqXlxkEXKI/qtm2RkS9Il2JSrbb3Qkgw1mWuG
        Vg2jnxHuM8w2H40H42gRCfBDJQ==
X-Google-Smtp-Source: ACcGV61xkjwTo+Zm/vPyTz1GcXwoDQjRSkNoFGmrsaTsh6gbVmvJqOtfnsSE9XJl2N2aoP5A4rlqcA==
X-Received: by 2002:a63:fe02:: with SMTP id p2-v6mr6844378pgh.148.1537985012939;
        Wed, 26 Sep 2018 11:03:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id j16-v6sm12246816pfk.125.2018.09.26.11.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:03:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3 1/2] soc: qcom: cmd-db: Remove memcpy()ing from cmd_db_get_header()
Date:   Wed, 26 Sep 2018 11:02:33 -0700
Message-Id: <20180926180234.55620-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180926180234.55620-1-swboyd@chromium.org>
References: <20180926180234.55620-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

