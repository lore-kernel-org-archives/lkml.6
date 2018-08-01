Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0818BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BB620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kBfzqiHc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N6wCX0Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BB620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeHBBOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:14:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHBBOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:14:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65D1660B12; Wed,  1 Aug 2018 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533165978;
        bh=IFzIpJaQXyh52j439zH3CI5kKeUjehtlJShbGsAyjvM=;
        h=From:To:Cc:Subject:Date:From;
        b=kBfzqiHcQGdPNwfe6cQ/ofwyIgMYy/tCnEWsKOiE180pxv3ZSebVGqzXR6q6SZqVx
         pdFTLiTABKnh7qxN2ZGqX0C7puo5vo5D1a729Le+RUTU7BhH2bMpOWi398efchx5qz
         VDssP1aK8d5yLYX3l0jhQdSoJrHSUHz0chVZG+Ms=
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8CC4606DD;
        Wed,  1 Aug 2018 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533165977;
        bh=IFzIpJaQXyh52j439zH3CI5kKeUjehtlJShbGsAyjvM=;
        h=From:To:Cc:Subject:Date:From;
        b=N6wCX0XjPROsAk1DmmzwDek+ia13Xq5jYcif/9xzdzof1NGD4mwkP6MoLZXWF6ezh
         9lhXcsEQABoDyYxtM2VNsvFuyX+8KLk0KwF84FwP/bsFIP8uHFbGuaXmxzmOZTs2kf
         HZ673sLOKc1CZi4l/IPgHlhCzIPkM3VzSkn2+ybM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8CC4606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     mcgrof@kernel.org, zohar@linux.vnet.ibm.com,
        bjorn.andersson@linaro.org, ard.biesheuvel@linaro.org,
        vbabka@suse.cz, riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     ckadabi@codeaurora.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Vikram Mulukutla <markivx@codeaurora.org>
Subject: [PATCH] firmware: Fix security issue with request_firmware_into_buf()
Date:   Wed,  1 Aug 2018 16:25:56 -0700
Message-Id: <1533165956-23727-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling request_firmware_into_buf() with the FW_OPT_NOCACHE flag
it is expected that firmware is loaded into buffer from memory.
But inside alloc_lookup_fw_priv every new firmware that is loaded is
added to the firmware cache (fwc) list head. So if any driver requests
a firmware that is already loaded the code iterates over the above
mentioned list and it can end up giving a pointer to other device driver's
firmware buffer.
Also the existing copy may either be modified by drivers, remote processors
or even freed. This causes a potential security issue with batched requests
when using request_firmware_into_buf.

Fix alloc_lookup_fw_priv to not add to the fwc head list if FW_OPT_NOCACHE
is set, and also don't do the lookup in the list.

Fixes: 0e742e9275 ("firmware: provide infrastructure to make fw caching optional")

Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/base/firmware_loader/main.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 0943e70..b3c0498 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -209,21 +209,24 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
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
 
@@ -493,7 +496,8 @@ int assign_fw(struct firmware *fw, struct device *device,
  */
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
-			  struct device *device, void *dbuf, size_t size)
+			  struct device *device, void *dbuf, size_t size,
+			  enum fw_opt opt_flags)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -511,7 +515,8 @@ int assign_fw(struct firmware *fw, struct device *device,
 		return 0; /* assigned */
 	}
 
-	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size);
+	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
+				  opt_flags);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -571,7 +576,8 @@ static void fw_abort_batch_reqs(struct firmware *fw)
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

