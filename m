Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3627C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E91B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="19s5ocxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E91B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbeJICGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbeJICGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C40204FD;
        Mon,  8 Oct 2018 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024782;
        bh=HvNPnnT2dAuAYxGz8YW7G+ZCsYshitUnFPyctHlr7QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19s5ocxeDvPAtv0KoMUzZ7lBt6Vl84PZf7/dM9RVi7G4FOEsGtrQ3XLmOxZqwmcQy
         s2Vj87TVccLo/0e2tL7jnBicbqfI6hn4g1/D2rVuqQKLrSimR2g6mYQ34cCBYL2Eed
         HCBvFhzFVn7wjXzx2FeZYlHWqo8IEssHrT20Z8Q0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vikram Mulukutla <markivx@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4.18 152/168] firmware: Fix security issue with request_firmware_into_buf()
Date:   Mon,  8 Oct 2018 20:32:12 +0200
Message-Id: <20181008175625.821277657@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rishabh Bhatnagar <rishabhb@codeaurora.org>

commit 422b3db2a5036add39a82425b1dd9fb6c96481e8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/firmware_loader/main.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -209,21 +209,24 @@ static struct fw_priv *__lookup_fw_priv(
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
 
@@ -493,7 +496,8 @@ int assign_fw(struct firmware *fw, struc
  */
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
-			  struct device *device, void *dbuf, size_t size)
+			  struct device *device, void *dbuf, size_t size,
+			  enum fw_opt opt_flags)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -511,7 +515,8 @@ _request_firmware_prepare(struct firmwar
 		return 0; /* assigned */
 	}
 
-	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size);
+	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
+				  opt_flags);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -571,7 +576,8 @@ _request_firmware(const struct firmware
 		goto out;
 	}
 
-	ret = _request_firmware_prepare(&fw, name, device, buf, size);
+	ret = _request_firmware_prepare(&fw, name, device, buf, size,
+					opt_flags);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 


