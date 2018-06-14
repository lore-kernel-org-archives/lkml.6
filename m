Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7B40C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9EC208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpcYgIyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9EC208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965732AbeFNOLC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965691AbeFNOKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:10:55 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE66208DA;
        Thu, 14 Jun 2018 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985455;
        bh=m/3r0+AswbfDnWjJI8WmRm/ghjAP2EqwTEck7KvVecg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpcYgIyxaWk9+9QqCwUb3IBHFOA4BzsLxMIGv9JZqOaxVQxis6K6y4Jagnjg9CJEX
         IdlW6m0GsH8nLuRmzbwARwEAW5q6YF/GF8VOfoy+MOqxzIeMRhUQw69Wm6onjJOngw
         tlBIZXUDxNDCNlXWv6zdaXbde8WaxBV2/QY19oHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Glauber <jglauber@cavium.com>,
        Robert Richter <rrichter@cavium.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 33/36] crypto: cavium - Limit result reading attempts
Date:   Thu, 14 Jun 2018 16:04:56 +0200
Message-Id: <20180614132158.764530576@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Glauber <jglauber@cavium.com>

commit c782a8c43e94ba6c09e9de2d69b5e3a5840ce61c upstream.

After issuing a request an endless loop was used to read the
completion state from memory which is asynchronously updated
by the ZIP coprocessor.

Add an upper bound to the retry attempts to prevent a CPU getting stuck
forever in case of an error. Additionally, add a read memory barrier
and a small delay between the reading attempts.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Reviewed-by: Robert Richter <rrichter@cavium.com>
Cc: stable <stable@vger.kernel.org> # 4.14
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/cavium/zip/common.h      |   21 +++++++++++++++++++++
 drivers/crypto/cavium/zip/zip_deflate.c |    4 ++--
 drivers/crypto/cavium/zip/zip_inflate.c |    4 ++--
 3 files changed, 25 insertions(+), 4 deletions(-)

--- a/drivers/crypto/cavium/zip/common.h
+++ b/drivers/crypto/cavium/zip/common.h
@@ -46,8 +46,10 @@
 #ifndef __COMMON_H__
 #define __COMMON_H__
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -149,6 +151,25 @@ struct zip_operation {
 	u32   sizeofzops;
 };
 
+static inline int zip_poll_result(union zip_zres_s *result)
+{
+	int retries = 1000;
+
+	while (!result->s.compcode) {
+		if (!--retries) {
+			pr_err("ZIP ERR: request timed out");
+			return -ETIMEDOUT;
+		}
+		udelay(10);
+		/*
+		 * Force re-reading of compcode which is updated
+		 * by the ZIP coprocessor.
+		 */
+		rmb();
+	}
+	return 0;
+}
+
 /* error messages */
 #define zip_err(fmt, args...) pr_err("ZIP ERR:%s():%d: " \
 			      fmt "\n", __func__, __LINE__, ## args)
--- a/drivers/crypto/cavium/zip/zip_deflate.c
+++ b/drivers/crypto/cavium/zip/zip_deflate.c
@@ -129,8 +129,8 @@ int zip_deflate(struct zip_operation *zi
 	/* Stats update for compression requests submitted */
 	atomic64_inc(&zip_dev->stats.comp_req_submit);
 
-	while (!result_ptr->s.compcode)
-		continue;
+	/* Wait for completion or error */
+	zip_poll_result(result_ptr);
 
 	/* Stats update for compression requests completed */
 	atomic64_inc(&zip_dev->stats.comp_req_complete);
--- a/drivers/crypto/cavium/zip/zip_inflate.c
+++ b/drivers/crypto/cavium/zip/zip_inflate.c
@@ -143,8 +143,8 @@ int zip_inflate(struct zip_operation *zi
 	/* Decompression requests submitted stats update */
 	atomic64_inc(&zip_dev->stats.decomp_req_submit);
 
-	while (!result_ptr->s.compcode)
-		continue;
+	/* Wait for completion or error */
+	zip_poll_result(result_ptr);
 
 	/* Decompression requests completed stats update */
 	atomic64_inc(&zip_dev->stats.decomp_req_complete);


