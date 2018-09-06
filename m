Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD928C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RHhxl3Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8674F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeIFVJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:09:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42478 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbeIFVJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:09:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so5492213pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oy+ohOtKALA+yDwsY6to00Xe/QmMFXZOTwjlKlW+Crc=;
        b=RHhxl3Q/WokB52H+yMCTMVlSa4bIY/W/itA5MhLya5+Rr1a8QPE//iQs/E6rcMWiZG
         8CPz2ckhAE8G+J9pVEH1oyQjjYzZPmOOMKKtbfpIUWLRSC0pgPwDm5RXvKmHpo9ZHujh
         g3K++tKTkFQa7hV6t1CmaxhF54w4HOwiQ4Km8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oy+ohOtKALA+yDwsY6to00Xe/QmMFXZOTwjlKlW+Crc=;
        b=OEEzJj7kon55gA1fHEu0MozTYxN5//OcFSHPe2zeElV2w6JOyXAr4LxlNJZM4I7v8w
         03U6b0rzaKgb5bMpAiFJTV7lYCGsaMEG+072WMbfvTsngJH/IGb+y9oVxr2wP7JQyRbt
         BgXHCtnS/uQoLUdtnnVIXFzOnZFNEHoNDgPNsIs2rO5POkLMn9IFPT5PypOqViZwUzva
         7esw5c6+WRfAeC13U8MIUe5zmIRpJrhy5XIcZY4kN52Y0OjsLv/mSEaa5epcAKqwEod9
         cKNih99ZVLwpoakFOBYgdas4u2drAuq/ljhuVbfoYvbqHS+yMMa7krenSeO7wamOoVlG
         vAPw==
X-Gm-Message-State: APzg51D2LdKZ67YXv5sW/3AEiqfmT8DScZaNI2LlSP1nKCy/CYstFIgc
        /QoqzQHhvTPM7J6dFS7OIvZsGQ==
X-Google-Smtp-Source: ANB0VdZpr5EbaSAOElhCvFPhBV3kj3Bbzr0zihfme2L+msl0MskaXO3MFTUeByl5yZ6pGSIiUhUKKw==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr3785669pfb.241.1536251616329;
        Thu, 06 Sep 2018 09:33:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id f6-v6sm7218264pgf.52.2018.09.06.09.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 09:33:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, girishm@codeaurora.org, dkota@codeaurora.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] soc: qcom: geni: geni_se_clk_freq_match() should always accept multiples
Date:   Thu,  6 Sep 2018 09:32:41 -0700
Message-Id: <20180906163241.166165-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
In-Reply-To: <20180906163241.166165-1-dianders@chromium.org>
References: <20180906163241.166165-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni_se_clk_freq_match() has some strange semantics.  Specifically
it is defined with two modes:
1. It can find a clock that's an exact multiple of the requested rate
2. It can find a non-exact match but it can't handle multiples then

...but callers should always be able to handle a clock that is a
multiple of the requested clock so mode #2 doesn't really make sense.
Let's change the semantics so that the non-exact match can also accept
multiples and then change the code to handle that.

The only caller of this code is the unlanded SPI driver [1] which
currently passes "exact = True", thus it should be safe to change the
semantics in this way.  ...and, in fact, the SPI driver should likely
be modified to pass "exact = False" (with the new semantics) since
that will allow it to work with SPI devices that request a clock rate
that doesn't exactly match a rate we can make.

[1] https://lkml.kernel.org/r/1535107336-2214-1-git-send-email-dkota@codeaurora.org

Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- Init best_delta to ULONG_MAX and avoid extra test (Matthias).
- s/If/It in commit message.
- Add Matthias tag.

 drivers/soc/qcom/qcom-geni-se.c | 37 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index d2d97f1d7428..033bd56edcbb 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -544,16 +544,17 @@ EXPORT_SYMBOL(geni_se_clk_tbl_get);
  * @se:		Pointer to the concerned serial engine.
  * @req_freq:	Requested clock frequency.
  * @index:	Index of the resultant frequency in the table.
- * @res_freq:	Resultant frequency which matches or is closer to the
- *		requested frequency.
+ * @res_freq:	Resultant frequency of the source clock.
  * @exact:	Flag to indicate exact multiple requirement of the requested
  *		frequency.
  *
- * This function is called by the protocol drivers to determine the matching
- * or exact multiple of the requested frequency, as provided by the serial
- * engine clock in order to meet the performance requirements. If there is
- * no matching or exact multiple of the requested frequency found, then it
- * selects the closest floor frequency, if exact flag is not set.
+ * This function is called by the protocol drivers to determine the best match
+ * of the requested frequency as provided by the serial engine clock in order
+ * to meet the performance requirements.
+ *
+ * If we return success:
+ * - if @exact is true  then @res_freq / <an_integer> == @req_freq
+ * - if @exact is false then @res_freq / <an_integer> <= @req_freq
  *
  * Return: 0 on success, standard Linux error codes on failure.
  */
@@ -564,6 +565,9 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
 	unsigned long *tbl;
 	int num_clk_levels;
 	int i;
+	unsigned long best_delta;
+	unsigned long new_delta;
+	unsigned int divider;
 
 	num_clk_levels = geni_se_clk_tbl_get(se, &tbl);
 	if (num_clk_levels < 0)
@@ -572,18 +576,21 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
 	if (num_clk_levels == 0)
 		return -EINVAL;
 
-	*res_freq = 0;
+	best_delta = ULONG_MAX;
 	for (i = 0; i < num_clk_levels; i++) {
-		if (!(tbl[i] % req_freq)) {
+		divider = DIV_ROUND_UP(tbl[i], req_freq);
+		new_delta = req_freq - tbl[i] / divider;
+		if (new_delta < best_delta) {
+			/* We have a new best! */
 			*index = i;
 			*res_freq = tbl[i];
-			return 0;
-		}
 
-		if (!(*res_freq) || ((tbl[i] > *res_freq) &&
-				     (tbl[i] < req_freq))) {
-			*index = i;
-			*res_freq = tbl[i];
+			/* If the new best is exact then we're done */
+			if (new_delta == 0)
+				return 0;
+
+			/* Record how close we got */
+			best_delta = new_delta;
 		}
 	}
 
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

