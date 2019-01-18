Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D4BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B44520652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lrAlp7JV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DqcvPJ2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfARMXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:23:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfARMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:23:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C38A60866; Fri, 18 Jan 2019 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547814215;
        bh=MfEdnhnVsKvxbxzTh4YtcYPSLOqxn/ij39ceOo7HGr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrAlp7JVEoYUKTr7APAzMj2goh8zKgJYdApy5fBqDEEUt//pUZ/Ohubr1N6pxs5qR
         KiRLMEG1C3TzDYuf2xaopG72aTlk12YweRe3WVklsaxTpo+doA6XnCFW19gAeTZUer
         i/gHPf0j/yEef/Cb/ZsWSgpDqBYPpFpaBGHt432w=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A67A860A34;
        Fri, 18 Jan 2019 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547814211;
        bh=MfEdnhnVsKvxbxzTh4YtcYPSLOqxn/ij39ceOo7HGr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqcvPJ2cAzqJhgZvTYeJldwHDXAEJGUgCBL6P7SiJrePN7P0dJHOhbFjcFux2ho61
         jqff1/oh6dfaz5d7CiEq5Z4VBDK9+vYPVYgebI5Brfo49YbCl33j5SEV/f3zxxstTo
         FtXV34UZYKf+iyLW2d1RzJHw1Sl8JzhWK9pLbo3Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A67A860A34
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv3 3/4] coresight: etm4x: Add support to enable ETMv4.2
Date:   Fri, 18 Jan 2019 17:52:55 +0530
Message-Id: <d52546764f8570e8c07ac8e3e2841e087e66648c.1547813804.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has ETMv4.2 and can use the existing etm4x driver.
But the current etm driver checks only for ETMv4.0 and
errors out for other etm4x versions. This patch adds this
missing support to enable SoC's with ETMv4x to use same
driver by checking only the ETM architecture major version
number.

Without this change, we get below error during etm probe:

/ # dmesg | grep etm
[    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
[    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
[    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
[    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
[    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
[    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
[    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
[    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22

With this change, etm probe is successful:

/ # dmesg | grep coresight
[    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
[    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
[    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
[    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
[    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
[    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
[    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
[    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..93d5f1f3145e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -55,7 +55,7 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 
 static bool etm4_arch_supported(u8 arch)
 {
-	switch (arch) {
+	switch (arch >> 4) {
 	case ETM_ARCH_V4:
 		break;
 	default:
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 52786e9d8926..05d4bd330881 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -136,7 +136,7 @@
 #define ETM_MAX_RES_SEL			16
 #define ETM_MAX_SS_CMP			8
 
-#define ETM_ARCH_V4			0x40
+#define ETM_ARCH_V4			0x4
 #define ETMv4_SYNC_MASK			0x1F
 #define ETM_CYC_THRESHOLD_MASK		0xFFF
 #define ETM_CYC_THRESHOLD_DEFAULT       0x100
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

