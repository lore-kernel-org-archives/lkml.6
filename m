Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9722075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lkLPBcbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9722075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIGD05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:26:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46706 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeIGD04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:26:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id t19-v6so5632553ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QHZXGOMuyG3gXByNHC6fT46pjTs5Kak+Kp5kwOLCe5c=;
        b=lkLPBcbKkmKz37BZ6unJOcKtsgTFuukFeqTYRZplv/SDRjwlXOcMlQaDYEXXRTip9y
         OXmgizyujFRH73VOMO3pYVEqGHx0d5Xy49CdYqDOIXuRycLRsUd18WQjr6cCooz02QYq
         HstIFVDN5ZAlbQgfQ2LHPKPgqDxNFLha5aZl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHZXGOMuyG3gXByNHC6fT46pjTs5Kak+Kp5kwOLCe5c=;
        b=mJOs8VausnJ0XbK+ifrJiW2mnv3rce/Gdf3urq6W9oFwksTEnnq5qbAG7Fs/XQSxBa
         mqPBpozjUBKYK5JhsiThej7vihJqwS8SqBGtWZpAcZl6Qn4eN4RbR4i8BmjupCcvu7lo
         Fzj38adLDl0mSF3DrH02gCk9iKSZKLC6gxH1IOgfVOwF5jn4vkHS3GUJYwsJx2rPQehx
         vP4/RJn+7vdUyG7CVQn2kj6DK1RXHdx7sYZPKSQ1Uu6MeLRkMUbr9XTgtkhmdvD7LY6D
         zMEMTzW6+v4CJ2U0kPxR+JrP8HiaW2ndzS1M3DalRVMCX1IfumOExmSaLq9jXq1eS6HB
         CN5Q==
X-Gm-Message-State: APzg51CeHJxt1lXVpIlHOb/OWGzc+R+gSrJCDrYwRtJAOf9Ks/ZgF5D0
        yATgdJZAgfz29ratzQc2A0F2Mg==
X-Google-Smtp-Source: ANB0VdZ+P3VFZaiycIva/520U6ZEcr1JXH6hlI6eo+kq7bTdHUwgTRyYVhkk8dxokh9TWe1Ni9mkrQ==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5-v6mr5050634plk.338.1536274152734;
        Thu, 06 Sep 2018 15:49:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id b21-v6sm13613622pfm.97.2018.09.06.15.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 15:49:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, girishm@codeaurora.org, dkota@codeaurora.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] soc: qcom: geni: geni_se_clk_freq_match() should always accept multiples
Date:   Thu,  6 Sep 2018 15:49:06 -0700
Message-Id: <20180906224906.93752-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180906224906.93752-1-dianders@chromium.org>
References: <20180906224906.93752-1-dianders@chromium.org>
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

Changes in v3: None
Changes in v2:
- Init best_delta to ULONG_MAX and avoid extra test (Matthias).
- s/If/It in commit message.
- Add Matthias tag.

 drivers/soc/qcom/qcom-geni-se.c | 37 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 1b19b8428c4a..ee89ffb6dde8 100644
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
2.19.0.rc2.392.g5ba43deb5a-goog

