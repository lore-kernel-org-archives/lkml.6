Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2B2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ED72075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+Pu+ww1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57ED72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeIEOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:38:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40767 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIEOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:38:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so7037703wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D4UX4I+iWIOl3BO9AbpXuaPHeGc3l7Q0z9qksRl/Q3M=;
        b=N+Pu+ww1sAawu78T7yChQzRjKkVLnnP2eDRCdUuK7FMvfPQPFiBG2oPcL4ZAlkCMUL
         ZhnORBCC29+5Yzyt9CR6xz9jI0gRy7CeoYgd2y14fi5QbM876n5TlK3P5Azd35UIuEKZ
         DQKYcDMvJmOJanBAs/ukx56Z2q/WxWdWXMLPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D4UX4I+iWIOl3BO9AbpXuaPHeGc3l7Q0z9qksRl/Q3M=;
        b=mYNedTZ3jFIWOdqa0uNaiUa+eH6uxXmkPO62rlgORAmzeF+1jakemv5PTemBUMqpj8
         PBvy6BZUSpus4qpZ/Cn3OmLV5HaeWu2vlExDSiQVD8fQleV77q1Tlt9PpoHozInwn672
         I8X2pP/8fFFLotk02plW8MtVgVV9jOS2wYpGIs7/XgSz6zvmmlgVA0s6PKQqyT0L4nuy
         l+Lq2ffA2wBI58RP8hPwmzx5oYptTnTn4fvYBvaDQIOFMoiWsQKId1uNDTaxincu1xz8
         Kqy4hFvR5FICjbxDDU4gMuvVXZGhwnamWfv7paGVWQIoS5YKWhbci4op2cx9fFnmY4BZ
         BoIA==
X-Gm-Message-State: APzg51BoB+MfxEU4ATUextjB4wHpai+7aQ2Upe+aWXcPQJatOjy6CPMy
        EYof/Yyd6vuzn3OHdmXrhqKeHA==
X-Google-Smtp-Source: ANB0VdZ20AJA5umfPzeGU4IupYWe4apvawZMvAYpxCAljNnrNYrHz/O9fyqR98C9qB+vEQ62n133cA==
X-Received: by 2002:a1c:46c4:: with SMTP id t187-v6mr5162358wma.158.1536142159329;
        Wed, 05 Sep 2018 03:09:19 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id x16-v6sm2065229wrm.69.2018.09.05.03.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 03:09:18 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] coresight: tmc: Refactor loops in etb dump
Date:   Wed,  5 Sep 2018 18:09:07 +0800
Message-Id: <1536142147-21323-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ETB dump function tmc_etb_dump_hw() it has nested loops.  The second
level loop is to iterate index in the range [0 .. drvdata->memwidth);
but the index isn't really used in the code, thus the second level
loop is useless.

This patch is to remove the second level loop; the refactor also reduces
indentation and we can use 'break' to replace 'goto' tag.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 9c599c9..8b34161 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -34,23 +34,20 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
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

