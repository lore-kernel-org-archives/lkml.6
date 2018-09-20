Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F72C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6454421531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpZ/3Ow6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6454421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeIUBEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36720 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbeIUBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so4798604plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUlaXOV4lrMht0i3G1NCeaTNFl9Rgz+PCtRI8r+MSMM=;
        b=JpZ/3Ow6nsnaluMufdjD2+VP+5pZGOPE4exkPo9ksN6zmGX5TerxyNTomm2ReFWAI7
         ytIZBKwIDLnwUf9mJ0oB01E+ceM+uqFJuDpgD0LbWDS4s5ydxJNDHKdfZIO35GiDqsfE
         EXhvZDdiuvW1KqVWbMODEVCgjVYa4+uSfwEns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUlaXOV4lrMht0i3G1NCeaTNFl9Rgz+PCtRI8r+MSMM=;
        b=NTGizcLfbF55f4NHSofNEq3dfrUt6nIXZ/K0374ISEbY+6SlcHaD4RtHKXtEWh5QRY
         CgZInjwVbYdX8xN/1N6kgw/XLp1xl5pIcpBvhwPOkCWMwSPXTIFjGklpzq5JypOfjNry
         QIHq8WXZDtkiBEuyXwSfNStcdFPBznmI06GP1bfzDd6POgbuyQGQyg8Uj9WM3it8H2Xd
         ktgeG5AMuNu06oKepFl1R47jvQrpVbxktK9qJI/VAaLk39kzHv3q8X5Wxb7ROTF2Ucii
         iBDXFA0G4X2iaOVMfBOB3G4gHUpLzK8Od+WijDjKhPpt5f+DMRrlBcqf3wMVZFiyhLIZ
         p4wg==
X-Gm-Message-State: APzg51DMqEKpzy0tfS1aCoFOfNCv14jiUVFWAy/eWyfyC8thbnangZEk
        ybgdoYQ6pgSscATrZxITxZ3cbQ==
X-Google-Smtp-Source: ANB0VdYrFISjoN9z/pMugXlcCfjbLVxlM+1hj7bRKCZ41+rcDLjaC+fEBL5IsQBWpgrBAKSDldskDA==
X-Received: by 2002:a17:902:758b:: with SMTP id j11-v6mr40823254pll.29.1537471141573;
        Thu, 20 Sep 2018 12:19:01 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:00 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 26/44] coresight: tmc: Refactor loops in etb dump
Date:   Thu, 20 Sep 2018 13:18:01 -0600
Message-Id: <1537471099-19781-27-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

In ETB dump function tmc_etb_dump_hw() it has nested loops.  The second
level loop is to iterate index in the range [0 .. drvdata->memwidth);
but the index isn't really used in the code, thus the second level
loop is useless.

This patch is to remove the second level loop; the refactor also reduces
indentation and we can use 'break' to replace 'goto' tag.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4156c95ce1bb..4bf3bfd7c078 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -38,23 +38,20 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
 	char *bufp;
 	u32 read_data, lost;
-	int i;
 
 	/* Check if the buffer wrapped around. */
 	lost = readl_relaxed(drvdata->base + TMC_STS) & TMC_STS_FULL;
 	bufp = drvdata->buf;
 	drvdata->len = 0;
 	while (1) {
-		for (i = 0; i < drvdata->memwidth; i++) {
-			read_data = readl_relaxed(drvdata->base + TMC_RRD);
-			if (read_data == 0xFFFFFFFF)
-				goto done;
-			memcpy(bufp, &read_data, 4);
-			bufp += 4;
-			drvdata->len += 4;
-		}
+		read_data = readl_relaxed(drvdata->base + TMC_RRD);
+		if (read_data == 0xFFFFFFFF)
+			break;
+		memcpy(bufp, &read_data, 4);
+		bufp += 4;
+		drvdata->len += 4;
 	}
-done:
+
 	if (lost)
 		coresight_insert_barrier_packet(drvdata->buf);
 	return;
-- 
2.7.4

