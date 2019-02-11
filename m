Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E207C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA7E21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898627;
	bh=35LdIzx/7qy+0HKIZPDWAiTxYCFCQmatXMhVQ6w5Kxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e/+qEm1bzuzW2X3Jega1tDIq/Q+NJiuxGEJVwKym4De5kIdN1sYaqrOCOhpWMNEtD
	 AbMtj9sMWAg9Z6EW27uwri/7GP2/s8pWiEbgXS78hXzGX+AE1ANeQF0u/E2fl6juQI
	 0s/CGwRVOEXr1nFVnsIHve+Rs5GabiLVLplEERIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbfBKPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390564AbfBKPDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67A3222A7;
        Mon, 11 Feb 2019 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897389;
        bh=35LdIzx/7qy+0HKIZPDWAiTxYCFCQmatXMhVQ6w5Kxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh7mQh1FB+mj3eFQmO1guIFhs4+Xb1lnKCg0OVVdryzrgBOOSbXTHCGngE4M2ojVh
         XBJp2MOj63NIzki6k8do7wrVLd4RqALKOg0gbPyFPXO3NRYhrvGgn6a8FAA4T7rrEM
         sHhQNOrTKpvs8YzWic5M62D3FqjBloU8Q113ER1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 156/205] thermal: generic-adc: Fix adc to temp interpolation
Date:   Mon, 11 Feb 2019 15:19:14 +0100
Message-Id: <20190211141838.565396292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 73f55d6a1721..ad601e5b4175 100644
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



