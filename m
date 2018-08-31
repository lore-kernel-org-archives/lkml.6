Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F3FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202DE2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQUzwCDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202DE2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeHaTvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbeHaTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:51:41 -0400
Received: from garbanzo.lan (c-73-71-40-85.hsd1.ca.comcast.net [73.71.40.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9662077C;
        Fri, 31 Aug 2018 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535730215;
        bh=wxonBuz1OQCAUPncttHA7R5KbpsKRJANxjIiesO+1Ws=;
        h=From:To:Cc:Subject:Date:From;
        b=NQUzwCDr/1BzNb2OfRDOL2HFFDyHHmBDPuX4DiW+18lDqOnO1N8Aph8qalW54nl9g
         yTTL1E16y1tdtNyFXn92gpJkRJcP9hmuMOulMEB44bUGHC6/uird8hPJYgOHDAFgEe
         QoH4K+HsvSrmtI23QsPvkKX/JwpOFh8qKAF6iTnc=
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] firmware: Fix security issue with request_firmware_into_buf()
Date:   Fri, 31 Aug 2018 08:43:31 -0700
Message-Id: <20180831154331.27505-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rishabh Bhatnagar <rishabhb@codeaurora.org>

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
[mcgrof: broken since feature introduction on v4.8]

Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This has been tested with the self test firmware scrip and found no
regressions.

 drivers/base/firmware_loader/main.c | 30 +++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 0943e7065e0e..b3c0498ee433 100644
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
@@ -511,7 +515,8 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 		return 0; /* assigned */
 	}
 
-	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size);
+	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
+				  opt_flags);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -571,7 +576,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		goto out;
 	}
 
-	ret = _request_firmware_prepare(&fw, name, device, buf, size);
+	ret = _request_firmware_prepare(&fw, name, device, buf, size,
+					opt_flags);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
-- 
2.18.0

