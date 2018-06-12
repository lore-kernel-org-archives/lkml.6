Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4AFB3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCBE208C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Up8T1MT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCBE208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeFLKzb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:55:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37984 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeFLKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so35291621lfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=Up8T1MT1sRqeYPD7+MHE3gD4Z6QM81LwNESmlHEaknYQXnd8blYYYz7t8W7CFJpS7/
         uJxt2MyL1AGg8FpH5M8kBFnfrZgWeHXyI86y4Bdy8dvVjsa9zD69x2CPwmub5KdbUDtA
         LDGpLZBiVqGN8pc2W/f9OjMvHwRFqwYz3LkO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=MmQBRkW4D0I2AXnV8YWpI1rQqJ0tQnaAO2T5WD60yqFg2xcUZB4GQNfXq7OHM0HINP
         TxSgIACbSSa8ewwtLDAv/BqhG5396la5o5Iuxj9XBko+nOOKwfoxwXS0hd7IcoiGMltd
         slMfMx6FHZcYos9JkEgatiyYKLn8hbMHvCCgliBeRICDfI+48ys2Kzmbcc0H7PjEVD3c
         /QYo4nuUHVyiKjJcqlSC153kKSCsi4QxFiUetxH1xbVAhi2BJWQ2QY41iiepNDFBJ1T2
         SAIaWPxBYsKf0M4Hjxnl9u93On/Y0CYCHGDKnAI1gyolfTAqJ1nQpah4tikPRKWB1Reu
         S6YA==
X-Gm-Message-State: APt69E3AC8QLW0J6uV8lt3pJ1yNKn64xiWEO7yWDNBtqHfoTaXVotWwY
        yEMZN/PwEq3jx5YCD/qCo0zEJcsageU=
X-Google-Smtp-Source: ADUXVKI4aRUWob0tXlSh5VrGGyp5DmyW/j0XVgLGDWTcoN4mbxpUwxpDtTEkmc/epwtoe8+0RzDUGw==
X-Received: by 2002:a2e:7a0f:: with SMTP id v15-v6mr2170228ljc.68.1528800926644;
        Tue, 12 Jun 2018 03:55:26 -0700 (PDT)
Received: from localhost (85-76-96-64-nat.elisa-mobile.fi. [85.76.96.64])
        by smtp.gmail.com with ESMTPSA id c74-v6sm137026lfh.78.2018.06.12.03.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:55:25 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2 1/5] thermal: tsens: Get rid of unused fields in structure
Date:   Tue, 12 Jun 2018 13:54:53 +0300
Message-Id: <940c162eac1e8d948e553899dafa10fdaab9399d.1528799892.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
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

