Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A46C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3232083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FRpMWCnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3232083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIFVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:09:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39800 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeIFVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:09:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so5503687pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMn9WpVsEvxR9qxhobRpRP3+BfkwLxuj1AdE722RwMg=;
        b=FRpMWCnnutAbxu2Fy5Wwt5g3fgl7YjOyocn+9Ef+ltP4JYQm8+9FMpYN5F5sRMDkBA
         JM3VjhEF39BnlgqQj1T2RfXDVMGRCv1g2JCn5xaYtpMGnFzOQ2Rq0fNhnwyQcJCHRZht
         Alvg3HAvWa6Y8qFSuggBVxrwJsY1LoF2QdIYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMn9WpVsEvxR9qxhobRpRP3+BfkwLxuj1AdE722RwMg=;
        b=iq4s6Mkx0R1y2ggcB6tdCYmH3Kk6dB9fcRZFmUe+O1RjX6/hB84z5BByXRpQA+sman
         TElMpXl5QvXwq5fjJzxmISW14oMUX/85vW9TC2TjRHPsIvPXi5dAjFdiycwsBejfGqaJ
         MMraSpZ8aMccTi7DHFyrtx5U9hTY4VEqIVERNjFuDqGcsjdDA7psf1rof805ULr9N6kf
         7w1DP8PvcrmZEhRee2veA/DtuwNRwMEbn+4IhieiIfTWuTOcrVq4c74Kph/3NTye/36o
         AhQxZKHFaowBBNRdnP8wRTv/CbTMStZd2/AAyKS3bOj8ncvDR4Dw/xfD50mB2aqT1K4R
         6S3w==
X-Gm-Message-State: APzg51DimnG1lbdIxMY0/ISxNRPszKh2rzJLSjy4/fWevL0QaVlH8uks
        2Y0KHC0zM0/m5fDJ0zqd3IwLAA==
X-Google-Smtp-Source: ANB0VdYSq4CvTFtoC7vkovOSEV/mR1p6SRGuyxN5ufhgGS3AZcvfnZHTP4vGY47DHVOvcgChjxeHUg==
X-Received: by 2002:a62:7983:: with SMTP id u125-v6mr3707444pfc.177.1536251614934;
        Thu, 06 Sep 2018 09:33:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id f6-v6sm7218264pgf.52.2018.09.06.09.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 09:33:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, girishm@codeaurora.org, dkota@codeaurora.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] soc: qcom: geni: Don't ignore clk_round_rate() errors in geni_se_clk_tbl_get()
Date:   Thu,  6 Sep 2018 09:32:40 -0700
Message-Id: <20180906163241.166165-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_round_rate() is defined to return a "long", not an
"unsigned long".  That's because it might return a negative error
code.  Change the call in geni_se_clk_tbl_get() to check for errors.

While we're at it, get rid of a useless init of "freq".

NOTE: overall the idea that we should iterate over clk_round_rate() to
try to reconstruct a table already present in the clock driver is
questionable.  Specifically:
- This method relies on "clk_round_rate()" rounding up.
- This method only works if the table is sorted and has no duplicates.
...this patch doesn't try to fix those problems, it just makes the
error handling more correct.

Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- Get rid of unneeded init of "freq" (Matthias).
- Add Matthias tag.

 drivers/soc/qcom/qcom-geni-se.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index feed3db21c10..d2d97f1d7428 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(geni_se_resources_on);
  */
 int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 {
-	unsigned long freq = 0;
+	long freq;
 	int i;
 
 	if (se->clk_perf_tbl) {
@@ -529,7 +529,7 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 
 	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
 		freq = clk_round_rate(se->clk, freq + 1);
-		if (!freq || freq == se->clk_perf_tbl[i - 1])
+		if (freq <= 0 || freq == se->clk_perf_tbl[i - 1])
 			break;
 		se->clk_perf_tbl[i] = freq;
 	}
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

