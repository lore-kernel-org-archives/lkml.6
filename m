Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E50EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3567521736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Be3ImDAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeLXH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:28:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37328 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLXH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:28:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so5304894plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 23:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b5cQe/stL77QEOSniNkNAVaDWYM99u9bRka0mV9VTPU=;
        b=Be3ImDAyAZ4bzW8VEZeH1pW/86ufVV0xyQjXpXqFwqWwJUI9fTTTb/3PyVTSjyQWEM
         KCMfT50lxGhluaH6ad8TyF1C2qMa7n9foXTd2gTk3oOGGhvWAWdalT5l9BqrBgOSwuNC
         vnU29J6S9umX2lH1G9DtToFFtidXSVeFg97rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b5cQe/stL77QEOSniNkNAVaDWYM99u9bRka0mV9VTPU=;
        b=OCmT14Xz3AVDd0c0JMX7TCczLZQ87FCuVpCEhinENO4Qiw7tymUBjHAXs4CXMDOvZt
         kQT5mygql4JIZT/v6thFmHQArmVau4551rhEgssdyLwDwNiJpjSE6BI5AkP9D9dZNC1W
         RTGN8gUy26vnzaUCEXrQNS22Dz7xKAIHUIlx2Fo9J3qBntPAJ90iNw2m7JwXTedorPmw
         dovMyUT5/06sMdqAvDzzonW597wx28wk16T4iO/M4Wu6Ij5HC+jfPdWUwbx5Whi7h/g1
         z/N8YJ/x15sVwNjgz5fOIcX+H4/JDvQ/nvbhyRkqUlnaT9AZYcyMpNmqaPpGNAkxFo7T
         n62w==
X-Gm-Message-State: AJcUukf8HkrzY7f2XA6pwfSQYd6gBWZgjMLw499Be2kgRxeeI3Zbsw39
        ZYZgguE2+nbcXX6jbN20CVDFQQ==
X-Google-Smtp-Source: ALg8bN4Sy8XoXqa80NbukSbjw7CjjQka/bf64I5tkIBmmsLoA7M2qR+3Zq6ZEnlH/Yz9WcjwwP5OCQ==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr12012427plc.137.1545636489785;
        Sun, 23 Dec 2018 23:28:09 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j197sm45534640pgc.76.2018.12.23.23.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 23:28:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH] thermal: generic-adc: Fix adc to temp interpolation
Date:   Sun, 23 Dec 2018 23:26:44 -0800
Message-Id: <20181224072644.30096-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First correct the edge case to return the last element if we're
outside the range, rather than at the last element, so that
interpolation is not omitted for points between the two last entries in
the table.

Then correct the formula to perform linear interpolation based the two
points surrounding the read ADC value. The indices for temp are kept as
"hi" and "lo" to pair with the adc indices, but there's no requirement
that the temperature is provided in descendent order. mult_frac() is
used to prevent issues with overflowing the int.

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/thermal-generic-adc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index bf1c628d4a7a..e22fc60ad36d 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -26,7 +26,7 @@ struct gadc_thermal_info {
 
 static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 {
-	int temp, adc_hi, adc_lo;
+	int temp, temp_hi, temp_lo, adc_hi, adc_lo;
 	int i;
 
 	for (i = 0; i < gti->nlookup_table; i++) {
@@ -36,13 +36,17 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 
 	if (i == 0) {
 		temp = gti->lookup_table[0];
-	} else if (i >= (gti->nlookup_table - 1)) {
+	} else if (i >= gti->nlookup_table) {
 		temp = gti->lookup_table[2 * (gti->nlookup_table - 1)];
 	} else {
 		adc_hi = gti->lookup_table[2 * i - 1];
 		adc_lo = gti->lookup_table[2 * i + 1];
-		temp = gti->lookup_table[2 * i];
-		temp -= ((val - adc_lo) * 1000) / (adc_hi - adc_lo);
+
+		temp_hi = gti->lookup_table[2 * i - 2];
+		temp_lo = gti->lookup_table[2 * i];
+
+		temp = temp_hi + mult_frac(temp_lo - temp_hi, val - adc_hi,
+					   adc_lo - adc_hi);
 	}
 
 	return temp;
-- 
2.18.0

