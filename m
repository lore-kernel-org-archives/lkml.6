Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43871C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1897421852
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691118;
	bh=qDZbz7DAUnPmFklUjGLebSGJh3C4+5RwJy3JHN1ck8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xj/zE9MAwlKxpBqONvgCPSltFY4wcdOe1pPd40y9BYO4c+dgsdPDLVRDdy2lnfCo/
	 lnk4Z615XRNHBgrJZ/Xul1m2qf/Jo2fyeyr+gLIuPKDPp8Ij3gDTx4mhncaKhKz/4X
	 hnqqMtegXCCT9mmO2kuYJfTApaxYCb6dI0rimYLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfA1P6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbfA1P6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E724C21852;
        Mon, 28 Jan 2019 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691112;
        bh=qDZbz7DAUnPmFklUjGLebSGJh3C4+5RwJy3JHN1ck8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cV8GwmqBlW7HLqnmHEnVqvVz5IZTMBil4DOwHpBwovw1bD1CvVONOIzFIUrzh3Gza
         UXd9BQrOZITSrAvWAyJweFsBmljzEMf8dDRiEG65e0BsvQ0aToCfkWmLOXn/kpLSQW
         JrHa5Dit8QUoKms+FtlUrk5POPfoqgnBOHxCH02c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 292/304] thermal: generic-adc: Fix adc to temp interpolation
Date:   Mon, 28 Jan 2019 10:43:29 -0500
Message-Id: <20190128154341.47195-292-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 9d216211fded20fff301d0317af3238d8383634c ]

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
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

