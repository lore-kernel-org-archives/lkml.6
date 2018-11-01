Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE665C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52F1204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H9Zd8Xp8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DsGR+uIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52F1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKAUx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:53:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:53:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 187396083C; Thu,  1 Nov 2018 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541073080;
        bh=SLiJ4Q6hOF/SXE6FcBOR70+ZQbL4JfEozjHWi0hsby4=;
        h=From:To:Subject:Date:From;
        b=H9Zd8Xp8YW7ttomgbYjE4A7PwhbaCTdRSi6fPhujsaWEcIZ0kktyvLGq0TvPN36Ka
         S01KKGdXpWMQ4jrI4XpTc9UqRkdoCnFNySsbc4imE/Vsmq0mWe2DlP+eoaXpROVEPU
         HHKbFSVBElLyIWZxTR6RCzX9oSYbbsoVn9wmxijE=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE0A96053D;
        Thu,  1 Nov 2018 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541073079;
        bh=SLiJ4Q6hOF/SXE6FcBOR70+ZQbL4JfEozjHWi0hsby4=;
        h=From:To:Subject:Date:From;
        b=DsGR+uIsM3lGn2ztdnaGM+TmpyG36Km4mDV/hJmfdoj2v4sDLme/VHs3CvNcYgf7Q
         yle4g7oKhz+Gfa+A4qdaA6fwgyygf+21UhcQa34NOF1VlNQqH10G+3JYC4eKu5EL52
         lEV4WHPeBfsEaZfShZb1JKIM7g4aVd7+Flw3cjmo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE0A96053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, niklas.cassel@linaro.org
Subject: [PATCH] ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask
Date:   Thu,  1 Nov 2018 17:21:07 +0530
Message-Id: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD line mask for MI2S starts from BIT 0 instead of BIT 1.
Fix all bit mask for MI2S SD lines.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 000775b..829b5e987 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -49,14 +49,14 @@
 #define AFE_PORT_I2S_SD1		0x2
 #define AFE_PORT_I2S_SD2		0x3
 #define AFE_PORT_I2S_SD3		0x4
-#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
-#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
-#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
-#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
-#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
-#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
-#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
-#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
+#define AFE_PORT_I2S_SD0_MASK		BIT(0x0)
+#define AFE_PORT_I2S_SD1_MASK		BIT(0x1)
+#define AFE_PORT_I2S_SD2_MASK		BIT(0x2)
+#define AFE_PORT_I2S_SD3_MASK		BIT(0x3)
+#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(1, 0)
+#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(3, 2)
+#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(2, 0)
+#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
 #define AFE_PORT_I2S_QUAD01		0x5
 #define AFE_PORT_I2S_QUAD23		0x6
 #define AFE_PORT_I2S_6CHS		0x7
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

