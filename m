Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263FC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0941C24D02
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nbPaJlB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0941C24D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeFWVJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:09:35 -0400
Received: from vern.gendns.com ([206.190.152.46]:36174 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751794AbeFWVJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=maEMz18pCKG24uaA32JCn8pQVV5NOMrBgt8j+PS1fP0=; b=nbPaJlB1gtHLeiICM5m48YNO2
        sLYRT8NzDCFtRnGeOW0MlK3+Qrm/ToEIq+n19MUjUTW0UmAcNn22W2++ic/NW9wX6aSdgWnIkc+wX
        FBBQaYFEV47ohwWkMs2bjBdCQpmxPlf9si5rSQego8h5h5mLgycC8m/FVyJlrDu4BQlnrl/YJDOAi
        oq0OvO/fOt05quSRrNg6SRD+z+eLFvh7HQlqqs+TPWu0OVqQClVB214RtL0+/W9BtpkJybJ1+d8hX
        U9UiaEwsRj2dnzMe3vzV59UHz0uF4Q02dkZfDTRhGUBV3PbyOvF/tWweT7BW5M4CXG7idPdnBf9aw
        V+cdItSbw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51098 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fWpmh-00CkwS-22; Sat, 23 Jun 2018 17:09:27 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ARM: OMAP2+: add pdata quirks for PRUSS reset
Date:   Sat, 23 Jun 2018 16:08:05 -0500
Message-Id: <20180623210810.21232-4-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds platform data for the PRUSS reset on OMAP2+. This is following
the pattern used by several other platform devices on these SoCs since
there is not a proper reset controller.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-omap2/pdata-quirks.c     |  9 +++++++++
 include/linux/platform_data/ti-pruss.h | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/linux/platform_data/ti-pruss.h

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 7f02743edbe4..8ea35d6cded5 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -25,6 +25,7 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/ti-sysc.h>
+#include <linux/platform_data/ti-pruss.h>
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
@@ -424,6 +425,12 @@ static struct wkup_m3_platform_data wkup_m3_data = {
 	.assert_reset = omap_device_assert_hardreset,
 	.deassert_reset = omap_device_deassert_hardreset,
 };
+
+static struct ti_pruss_platform_data pruss_data = {
+	.reset_name = "pruss",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
@@ -568,6 +575,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_SOC_AM33XX
 	OF_DEV_AUXDATA("ti,am3352-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
+	OF_DEV_AUXDATA("ti,am3352-pru-rproc", 0x4a300000, "4a300000.cpu",
+		       &pruss_data),
 #endif
 #ifdef CONFIG_SOC_AM43XX
 	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
diff --git a/include/linux/platform_data/ti-pruss.h b/include/linux/platform_data/ti-pruss.h
new file mode 100644
index 000000000000..e401e621ebdf
--- /dev/null
+++ b/include/linux/platform_data/ti-pruss.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI PRU remote processor platform data
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_TI_PRU_H
+#define _LINUX_PLATFORM_DATA_TI_PRU_H
+
+struct platform_device;
+
+struct ti_pruss_platform_data {
+	const char *reset_name;
+
+	int (*assert_reset)(struct platform_device *pdev, const char *name);
+	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+};
+
+#endif /* _LINUX_PLATFORM_DATA_TI_PRU_H */
-- 
2.17.1

