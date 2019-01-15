Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4148B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Idvhwjz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfAOKd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:33:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34346 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfAOKd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:33:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so1088724pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dIyDlEhPk6JnUTXfldKLOjRO3WNV6b65BdAvK6H2ezc=;
        b=Idvhwjz2PCwfeCZlSfS8wWCImer2VupTl79ttniFdOy/ZB+YEuNAmrmVyyOmLkGq5D
         Dbv4rSDwlCtVk8Wt4wFSUwU1syU1szrBgfKGEKjXxsamyu1A3shEmeS0zJmYZ5W+RXBO
         OPZ7nV14PuHpDqoOPmRq9qwe8Gk6ATLWBL6CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dIyDlEhPk6JnUTXfldKLOjRO3WNV6b65BdAvK6H2ezc=;
        b=hn+K390sx1yoRm8A+547hiW2iuU0zNgQDxdgQeLUj/vpiEMEas8S5kLn45cvq3k1Lx
         yPp6oytgnIctHeRjHZyF1snorB44KusJj6Ui9fyXuPPGO1O1zvP0/pI0N4R2RA0nb9M5
         2tVuyomFXrBMMl41nqN91qrr0OQpFl9aOaEWa4Ms50rj8IHvzvP2SfNXFElFMoPPdtFa
         Rn6TCV7ZVBfyUCTME9t6U50iLOCugT1zc9btm0HSnpiT0HqA5BSvSnOZoWfRnyvwfdVV
         qeiMfkyTxdeu76ZT/wS1qDCzYQSYHA//z16jNfOle1HIK23JplYWNyqPkGewiA2BHH6W
         LPrQ==
X-Gm-Message-State: AJcUukflA185w+qHi+uoAR0/zT6PeRECAOiSrWm66Exf7obMqix1npw7
        JN1OncNrTU/o/4b3gRpMl00o8w==
X-Google-Smtp-Source: ALg8bN5tPJ802wXKib0Xc/vXXsEVgz30eEx1kURE+RGxE654JSqnBiMyHcJwhhMu4sFSNmONVL88SQ==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr3364348pfg.183.1547548406698;
        Tue, 15 Jan 2019 02:33:26 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d13sm5073957pfd.58.2019.01.15.02.33.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 02:33:25 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com
Subject: [PATCH 3/4] power: supply: sc27xx: Fix the incorrect formula when converting capacity to coulomb counter
Date:   Tue, 15 Jan 2019 18:32:36 +0800
Message-Id: <7d23781552d6ff1fe6bbabfc56cbbb04d807fffa.1547544142.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should multiply the calibrated current data (cur_1000ma_adc) when
converting current capacity (mAh) to coulomb counter, which can get
an accurate coulomb counter from the fuel gauge controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 4926b8a..ea1349f 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -731,7 +731,7 @@ static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity)
 	 * Convert current capacity (mAh) to coulomb counter according to the
 	 * formula: 1 mAh =3.6 coulomb.
 	 */
-	return DIV_ROUND_CLOSEST(cur_cap * 36, 10);
+	return DIV_ROUND_CLOSEST(cur_cap * 36 * data->cur_1000ma_adc, 10);
 }
 
 static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
-- 
1.7.9.5

