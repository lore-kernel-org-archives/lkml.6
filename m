Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 874FFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D145208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByN4Hdqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D145208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755087AbeFNKnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:43:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33215 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeFNKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:43:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so8693532lfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=ByN4HdqeA8rhSNJ7duMK3OV/9qqXaH/8YkesWFOiqzBpgx5SH8sjzK61iqG3BHO3tj
         rNOA6mvMdc+SUUFP2rURErGGlh7kgGCI85gxO7ERyciyUqElx8tL3dcoN67GW+dRgqxV
         b+rEdDUYiAORNRN/V1gzrJ5JfAt4sncpDDMTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=nKwpNlYBdMGs6hTRmVwUAltk1NUwTOL/hj0uReG6n2SwnBFA4iM9D2sSVifwVW0Zk1
         PTrCzWudubnLWz8gQXcMbtvN6BMcGybsAbc2s12GRoqdCHNaBtk+zpq3VG0wdXL/aVuc
         6dD35q0+Eo1E+T136lfzwSE8NvuQs27oFChUP3Q4edy0iLCPTLeMZ1WjjlalAZwLAglu
         tLRzSueL8RhQMLPsh4ju5Zu8mmAcRgUwckD91uBB34pLzJUpobHLoLQFBmxp4yIe2+x3
         BOJ7/h1tQdubxOSD4oY0VPLwXLIAmgLON7nenLMWGA0WXauE8CoYLPS60Tan/qG55PPw
         7uWg==
X-Gm-Message-State: APt69E1Y6gn1jTZOeJmj4Pweh9rt6qX1J+h2MPcr5J7+96U/BEuNGMWQ
        CuxlIAaZ58cE6wcGI6F/rZHLPWbYwtM=
X-Google-Smtp-Source: ADUXVKK0o4EX6b9EwV6Fj3BKstv5KnS7JUx5Q/oPoO+41a329oLQYgV8sJp1RcGByJBlLzT/KBXNyQ==
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr5554444lfe.39.1528973026826;
        Thu, 14 Jun 2018 03:43:46 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id l16-v6sm902241lji.40.2018.06.14.03.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:43:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v3 1/6] thermal: tsens: Get rid of unused fields in structure
Date:   Thu, 14 Jun 2018 13:43:11 +0300
Message-Id: <d4e2577fe3566fa0d638cb6bd1c2c2f97f492450.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/thermal/qcom/tsens.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 911c197..dc56e1e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,9 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
-	struct regmap_field		*status_field;
 	struct tsens_context		ctx;
-	bool				trdy;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.7.4

