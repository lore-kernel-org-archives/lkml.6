Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF920844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPoqbl88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAF920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeIGD0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:26:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38924 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeIGD0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:26:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so5954955pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGkOnj093PXjB4Lq1P50yDvsnC++VRGK5EVxrMjQze4=;
        b=EPoqbl88M6C8PsOnqlFPctMR3jj+SwwUqOQiS0yFRKnTxLs1gDPzi21mXIR1KDZg21
         01m3/RIxrnUglqTpg+NwVO0JPPgY+H2I2HfvcoJL2I/phFfVA7sxQfFulIhE5vFPrjeH
         bOuGXlHngsBeRDg1DR0jXx0uW9IXIecJtVeHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGkOnj093PXjB4Lq1P50yDvsnC++VRGK5EVxrMjQze4=;
        b=VKVF/VooIu3EG3jOIost0DMjAIkNYvlJRDA/6e73s7RB+te8pyPJnBgq54GENrkctX
         b2LfkGdHAw8lsl8uLEvzc9Xq3G017yAXXxyKdfW/acBouxGfY30YNb0jsXzt1h9Dy5OD
         DJOHVYTo9MebiCX7oYX1Gett2D3nv/kaFTx0pxfjgWh4qZlP+lF6Ymh4OcVYO9aBYDxZ
         zx/DJPJ8qRbAkHitYwVh63xDaMTBE/YqwD4un77/O4lbXCR0KI1Xtq9q9NKQElZRxjQL
         IVfzTTDiCpEI/Z1SN/lV1CITt0oZ6zE5neh7HL03lAtyPDnQvX5o/WGsK0pQXIAeebKz
         MylA==
X-Gm-Message-State: APzg51BhyytXcpAr2fqzhHV/ZLR4U6aObNUfZ71gox93UOdmji656Jmg
        MkwQdrWyWflw+UQ21iBYhe32qQ==
X-Google-Smtp-Source: ANB0VdYtH320QF6w7D6K8baTjB8zMmDKo/T88A+P7XFIVqnfBX9M2FObOFRNRbSvM8eYkE36aXsLlw==
X-Received: by 2002:a62:8704:: with SMTP id i4-v6mr5330789pfe.62.1536274151360;
        Thu, 06 Sep 2018 15:49:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id b21-v6sm13613622pfm.97.2018.09.06.15.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 15:49:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, girishm@codeaurora.org, dkota@codeaurora.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] soc: qcom: geni: Don't ignore clk_round_rate() errors in geni_se_clk_tbl_get()
Date:   Thu,  6 Sep 2018 15:49:05 -0700
Message-Id: <20180906224906.93752-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
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

Changes in v3:
- Init "freq" again since removing it was wrong (kbuild test robot).

Changes in v2:
- Get rid of unneeded init of "freq" (Matthias).
- Add Matthias tag.

 drivers/soc/qcom/qcom-geni-se.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index feed3db21c10..1b19b8428c4a 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(geni_se_resources_on);
  */
 int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 {
-	unsigned long freq = 0;
+	long freq = 0;
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
2.19.0.rc2.392.g5ba43deb5a-goog

