Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F638ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3158B2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNWv0M3V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNWv0M3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3158B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGSWK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:10:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:10:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB8D860791; Thu, 19 Jul 2018 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532035528;
        bh=TG/ONVQvV8iZq/Tli8p/7DC6ZVQR9sreW0mUflm+k5A=;
        h=From:To:Cc:Subject:Date:From;
        b=JNWv0M3VijwzNXW6ewme2G7c8mi6bw8AuJjk1NKajbZImj1npzpFz9jnFZhCl8hf4
         B1A6IUvdRYAVee65XfJd/BRFqxaU4HB8F469FG3tMLAmyoP6+/6w7bnP5ot55ATybn
         JF0vpUDEfnx0eeDH0Lb6DHTn+x3kpL47v9sDvGXo=
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F2A4602B3;
        Thu, 19 Jul 2018 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532035528;
        bh=TG/ONVQvV8iZq/Tli8p/7DC6ZVQR9sreW0mUflm+k5A=;
        h=From:To:Cc:Subject:Date:From;
        b=JNWv0M3VijwzNXW6ewme2G7c8mi6bw8AuJjk1NKajbZImj1npzpFz9jnFZhCl8hf4
         B1A6IUvdRYAVee65XfJd/BRFqxaU4HB8F469FG3tMLAmyoP6+/6w7bnP5ot55ATybn
         JF0vpUDEfnx0eeDH0Lb6DHTn+x3kpL47v9sDvGXo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F2A4602B3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     gregkh@linuxfoundation.org, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Vikram Mulukutla <markivx@codeaurora.org>
Subject: [PATCH] firmware: Avoid caching firmware when FW_OPT_NOCACHE is set
Date:   Thu, 19 Jul 2018 14:25:21 -0700
Message-Id: <1532035521-7917-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling request_firmware_into_buf(), we pass the FW_OPT_NOCACHE
flag with the intent of skipping the caching mechanism of the
firmware loader. Unfortunately, that doesn't work, because
alloc_lookup_fw_priv() isn't told to _not_ add the struct
firmware_buf to the firmware cache (fwc) list. So when we call
request_firmware_into_buf() the second time, we find the buffer in
the cache and return it immediately without reloading.

This may break users of request_firmware_into_buf that are expecting
a fresh copy of the firmware to be reloaded into memory. The existing
copy may either be modified by drivers, remote processors or even
freed. Fix fw_lookup_and_allocate_buf to not add to the fwc list
if FW_OPT_NOCACHE is set, and also don't do the lookup in the list.

Fixes: 0e742e9271 ("firmware: provide infrastructure to make fw caching optional")

Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/base/firmware_loader/main.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 2e0c37a..db9038c0 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -210,21 +210,24 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
 				struct fw_priv **fw_priv, void *dbuf,
-				size_t size)
+				size_t size, enum fw_opt opt_flags)
 {
 	struct fw_priv *tmp;
 
 	spin_lock(&fwc->lock);
-	tmp = __lookup_fw_priv(fw_name);
-	if (tmp) {
-		kref_get(&tmp->ref);
-		spin_unlock(&fwc->lock);
-		*fw_priv = tmp;
-		pr_debug("batched request - sharing the same struct fw_priv and lookup for multiple requests\n");
-		return 1;
+	if (!(opt_flags & FW_OPT_NOCACHE)) {
+		tmp = __lookup_fw_priv(fw_name);
+		if (tmp) {
+			kref_get(&tmp->ref);
+			spin_unlock(&fwc->lock);
+			*fw_priv = tmp;
+			pr_debug("batched request - sharing the same struct fw_priv and lookup for multiple requests\n");
+			return 1;
+		}
 	}
+
 	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
-	if (tmp)
+	if (tmp && !(opt_flags & FW_OPT_NOCACHE))
 		list_add(&tmp->list, &fwc->head);
 	spin_unlock(&fwc->lock);
 
@@ -500,7 +503,8 @@ int assign_fw(struct firmware *fw, struct device *device,
  */
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
-			  struct device *device, void *dbuf, size_t size)
+			  struct device *device, void *dbuf, size_t size,
+			  enum fw_opt opt_flags)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -518,7 +522,8 @@ int assign_fw(struct firmware *fw, struct device *device,
 		return 0; /* assigned */
 	}
 
-	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size);
+	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
+				  opt_flags);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -578,7 +583,8 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 		goto out;
 	}
 
-	ret = _request_firmware_prepare(&fw, name, device, buf, size);
+	ret = _request_firmware_prepare(&fw, name, device, buf, size,
+					opt_flags);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

