Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 687AEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D62208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dF5GopFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D62208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755146AbeFNKoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:44:22 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45312 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeFNKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:44:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id n3-v6so8639235lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=U39x3+GmFhXEta2G8HMZPe16wfFoZGxDiNc2P0jDGto=;
        b=dF5GopFegu/UvdDWgUYCmYWd+7kSkmgl8FqCNJTpT59kgAuBFzpUDDwYNzeNZcI4z1
         qA057hIqnAsl7FbKWAtj4Y/k1Auc3cRPBTbOgyNQrkMdygOcR5BOwY77cp5+KaXDsAaO
         fWFVFL3WWyhV8ERnaN7UsIE5/e99pHmvHZaIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=U39x3+GmFhXEta2G8HMZPe16wfFoZGxDiNc2P0jDGto=;
        b=UNQynEa7EvO4xC7ZF7uXx9AVK4GhMSf9URPJNWvDmKZtGiUcboLqasXJ3nf1B1Elns
         zMFAPGj+JOowfbTOB8KouVKJOK1qlxSogvSNqWryNA9ExCevkgapGVp8pT+DnptWQlkM
         868IiaJS0vEq1HoLIKZsLViLoWymRrUXUBFbcpQLeJ729yY2p3XRGNgpEBh4KIJAEth2
         JWqEt82sr6qzpqaB6I5MdwS+5T+PXDp9eJuDGKoDob/VugcGKSRnLQ44ghjv66bnNWL4
         mDPuk66d5SfTjinonhOJdhSd2PsXzeaDHB6RmiDI9ECzRxwaWA8s+I1O1u7LxNoC0Yh4
         Bz8A==
X-Gm-Message-State: APt69E2W+804hH9wDGwNSD3c05o2NHVuJ7sTDF0OYwJrWNk2+usWG3XR
        MLf0hLMAKHNxwhluBmcz8HAAdg68XEQ=
X-Google-Smtp-Source: ADUXVKLVZOkMYz+2sCNIbULEnKHTfIXk08AJA8phXNEkqlShRevsT51tN/PHCOl6Knvh43PUNWGbOg==
X-Received: by 2002:a19:97cb:: with SMTP id z194-v6mr5976920lfd.17.1528973056378;
        Thu, 14 Jun 2018 03:44:16 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id v79-v6sm888693lje.78.2018.06.14.03.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:44:15 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v3 5/6] thermal: tsens: Check if we have valid data before reading
Date:   Thu, 14 Jun 2018 13:43:15 +0300
Message-Id: <383d28a935992f62e2ff707b01de63b53e7e8418.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index abc8f13..76fb668 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -7,6 +7,9 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+#define TRDY_OFFSET            0xe4
+#define TRDY_READY_BIT         BIT(0)
+
 #define STATUS_OFFSET		0xa0
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
@@ -19,6 +22,12 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
+	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
+	if (ret)
+		return ret;
+	if (code & TRDY_READY_BIT)
+		return -ENODATA;
+
 	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
-- 
2.7.4

