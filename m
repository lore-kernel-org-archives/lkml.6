Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3584AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5CF20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMKOPsIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5CF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeH3WkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35674 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3WkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id w8-v6so2685131pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHl6La1thHjcLDvSZRxhc58nWU+jWzOoZMZ+wwZO/SA=;
        b=SMKOPsInOKImvubYm5SamakJaEdwMKME5j5Xk1GMAI1Vy0TtWVrxstVXH540aFHaJd
         g0RpiFukF/P0GTsAwYXh/q/lnae3yVwfx83lbQwT8CdjExiKYXY6ekxBAONe8isCJo97
         nIuxtPAOGlmEZZSa4/Jxo7S9wbtE50QvoIIZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHl6La1thHjcLDvSZRxhc58nWU+jWzOoZMZ+wwZO/SA=;
        b=r2I13crfwIXJin99fhExvwD5vQul6pV9/EIrfLrOXsW4cSmNS77DcmKCbV3NEnavYG
         GDC0I2mItqDJHSeVFXSYgnZAdxu0gRNvTIBf/t+MJ3SjL3E8qF1iKbYKog/xX/p0BF/f
         xlbByFBl/ZyTZgensr3T/i7OJTrYy90VV/A7/md9TuhSy72gMP6CCDWDv8v4dwGzBdOz
         ckMYaTNAXCuG2BXdSMNHcmlpFerF9xR3KFxXW4QYw2jCSXT3ohDUQCw4ICHVt1fZvnu4
         MKB+M2szEDkvsOcnncr1PSytqcRjMEE688hJjyrCzBhiDtHcFwmne7f0MumSLdH+sOqm
         uyaQ==
X-Gm-Message-State: APzg51DqTFTpG+err5tCmveQq6VRnA5ZcC2F7MahInrg2I3TClGlhPGN
        A1xJii9RljCtBx6mKfL49nb85Q==
X-Google-Smtp-Source: ANB0Vdb787SsnMIRQnx/MOaEZTOdTeTkoqAQkga+z55P/f/JWgOcQu/W7Ib5oL5xwwQmSlAFzgIZGA==
X-Received: by 2002:a63:5fc8:: with SMTP id t191-v6mr10881113pgb.183.1535654200487;
        Thu, 30 Aug 2018 11:36:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id c68-v6sm14470946pfj.51.2018.08.30.11.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:36:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, girishm@codeaurora.org, dkota@codeaurora.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom: geni: geni_se_clk_freq_match() should always accept multiples
Date:   Thu, 30 Aug 2018 11:36:12 -0700
Message-Id: <20180830183612.169572-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830183612.169572-1-dianders@chromium.org>
References: <20180830183612.169572-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni_se_clk_freq_match() has some strange semantics.  Specifically
it is defined with two modes:
1. It can find a clock that's an exact multiple of the requested rate
2. If can find a non-exact match but it can't handle multiples then

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
---

 drivers/soc/qcom/qcom-geni-se.c | 37 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 1b19b8428c4a..092b32a315c3 100644
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
+	best_delta = 0;
 	for (i = 0; i < num_clk_levels; i++) {
-		if (!(tbl[i] % req_freq)) {
+		divider = DIV_ROUND_UP(tbl[i], req_freq);
+		new_delta = req_freq - tbl[i] / divider;
+		if (!best_delta || new_delta < best_delta) {
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
2.19.0.rc0.228.g281dcd1b4d0-goog

