Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5AAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263EB206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jymfONg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263EB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeGQVET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:04:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39584 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbeGQVEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:04:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so932302pgs.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wrgwbd3fMX17INzoIy6yVjrKRXAFscgjA8Y31R89O+s=;
        b=jymfONg6N5moWhsxrz0TFh1ZBzE2WXqaoxoMjzZaQVlgVoDLDl7Sau854gpDIc0gWv
         JhHR7jcB5FmfGU4QZkvu+gLNhTklQgzuxPCI+lwW8B8yBJMgV/wKFVyw2aeHyKK+uC1G
         A2LbBUlNQgWeuDkbN8XVlkECBEGkZl6r1CfTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wrgwbd3fMX17INzoIy6yVjrKRXAFscgjA8Y31R89O+s=;
        b=qARwNcD2PiMvfuNedA3Z5YVbQM0Qw6m31Dlp94lE9uh6EKGDvUt3ZqO2k1K/l8lF4W
         lIDZ4B2MuAw0UybGP4ozxmwIBWB1B6rfFQYA885Fzid5rzGgzCHb/ygv9cK2PTjzMwze
         Wl9i/6FVE5v5xbcIm6aguFuSU7e5XcB65V1wEu0gjOoCnFJ2u5dU4i8F3mD+UmHuG6cT
         xcgS8AN1uCQptyD1Ekd37Eb0u3nhB4RyHsA/nGUXfrFJefS8sNBR8RLuTuzQvIZm3VYL
         encrAaKu7sRPa9y5xDUnn0Wc47H8PVuZdMrcHkP63dPfK/kcZJ8aRkbuxQSI+SNxxIab
         tJ/Q==
X-Gm-Message-State: AOUpUlGsuKUlU5isHysqA538qJUGfzhJiU7bwggA1affLUKwxsVTPCfo
        0zUVowwF7VpNUuSerfcwdzGJWg==
X-Google-Smtp-Source: AAOMgpf/0BQ4FFJ+ILITfExuF1ngRH1halHLEHsCYj6oYS46l2sP7MQu2UBhixTwFHrp5B64WOYoHw==
X-Received: by 2002:a63:4857:: with SMTP id x23-v6mr3090788pgk.30.1531859392107;
        Tue, 17 Jul 2018 13:29:52 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a20-v6sm2563426pfi.124.2018.07.17.13.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:29:51 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 2/2] soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()
Date:   Tue, 17 Jul 2018 13:29:47 -0700
Message-Id: <20180717202947.197922-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717202947.197922-1-swboyd@chromium.org>
References: <20180717202947.197922-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's change the function signature to return the pointer to memory or
an error pointer on failure, and take an argument that lets us return
the size of the aux data read. This way we can remove the
cmd_db_read_aux_data_len() API entirely and also get rid of the memcpy
operation from cmd_db to the caller.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 43 ++++++++-------------------------------
 include/soc/qcom/cmd-db.h | 12 +++--------
 2 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 5c9cc6824891..c701b3b010f1 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -192,55 +192,28 @@ EXPORT_SYMBOL(cmd_db_read_addr);
 /**
  * cmd_db_read_aux_data() - Query command db for aux data.
  *
- *  @id: Resource to retrieve AUX Data on.
- *  @data: Data buffer to copy returned aux data to. Returns size on NULL
- *  @len: Caller provides size of data buffer passed in.
+ *  @id: Resource to retrieve AUX Data on
+ *  @len: size of data buffer returned
  *
- *  Return: size of data on success, errno otherwise
+ *  Return: pointer to data on success, error pointer otherwise
  */
-int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
+const void *cmd_db_read_aux_data(const char *id, size_t *len)
 {
 	int ret;
 	const struct entry_header *ent;
 	const struct rsc_hdr *rsc_hdr;
-	u16 ent_len;
-
-	if (!data)
-		return -EINVAL;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
 	if (ret)
-		return ret;
-
-	ent_len = le16_to_cpu(ent->len);
-	if (len < ent_len)
-		return -EINVAL;
+		return ERR_PTR(ret);
 
-	len = min_t(u16, ent_len, len);
-	memcpy(data, rsc_offset(rsc_hdr, ent), len);
+	if (len)
+		*len = le16_to_cpu(ent->len);
 
-	return len;
+	return rsc_offset(rsc_hdr, ent);
 }
 EXPORT_SYMBOL(cmd_db_read_aux_data);
 
-/**
- * cmd_db_read_aux_data_len - Get the length of the auxiliary data stored in DB.
- *
- * @id: Resource to retrieve AUX Data.
- *
- * Return: size on success, 0 on error
- */
-size_t cmd_db_read_aux_data_len(const char *id)
-{
-	int ret;
-	const struct entry_header *ent;
-
-	ret = cmd_db_get_header(id, &ent, NULL);
-
-	return ret < 0 ? 0 : le16_to_cpu(ent->len);
-}
-EXPORT_SYMBOL(cmd_db_read_aux_data_len);
-
 /**
  * cmd_db_read_slave_id - Get the slave ID for a given resource address
  *
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 578180cbc134..af9722223925 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -18,9 +18,7 @@ enum cmd_db_hw_type {
 #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
 u32 cmd_db_read_addr(const char *resource_id);
 
-int cmd_db_read_aux_data(const char *resource_id, u8 *data, size_t len);
-
-size_t cmd_db_read_aux_data_len(const char *resource_id);
+const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
 
@@ -29,12 +27,8 @@ int cmd_db_ready(void);
 static inline u32 cmd_db_read_addr(const char *resource_id)
 { return 0; }
 
-static inline int cmd_db_read_aux_data(const char *resource_id, u8 *data,
-				       size_t len)
-{ return -ENODEV; }
-
-static inline size_t cmd_db_read_aux_data_len(const char *resource_id)
-{ return -ENODEV; }
+static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
+{ return ERR_PTR(-ENODEV); }
 
 static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
 { return -ENODEV; }
-- 
Sent by a computer through tubes

