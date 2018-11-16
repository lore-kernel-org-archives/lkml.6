Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E8FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD97420818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ENN1QLls";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e2XN8asc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD97420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbeKPRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:53:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:53:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A72260C1C; Fri, 16 Nov 2018 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542354144;
        bh=fqp4AT1uIem7ySYLI609JUEky7lrVM8VWGL4thGluHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENN1QLlstWs2rcjqmRqW3BuwnbgJ/b5Kx46RfUFI5qPIA2Spfapl+tkPbnqnaPSM3
         qBi1WRXMKhDV/eB2FLZ5KXIzIH/CN+IeAbj6hDPDIAhp+1k5PhonMpyKo6rBVN3dg9
         JvM5b5bHWtJpv05iesJNPdt8gH9RH19Ic4xWL674=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9128D6086B;
        Fri, 16 Nov 2018 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542354143;
        bh=fqp4AT1uIem7ySYLI609JUEky7lrVM8VWGL4thGluHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2XN8asc6Zq4UMwA9mQ+gALVdb0ZLPHqsMHqxSFyN/ZxHhUqBjWm4RhBheP8q/mH2
         TInw+hB2gNh3mKoSMiEeuTVbuSSsHrbxrbb3Usseakkq0LG2sGkTI/wiGEAAQljrne
         iSXzfAHmEsBd5Fz1xbtnhyrsquby+8NLROZyids4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9128D6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 2/2] ASoC: sdm845: Add support for Secondary MI2S interface
Date:   Fri, 16 Nov 2018 13:11:58 +0530
Message-Id: <1542354118-23360-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure bit clock for secondary MI2S
TX interface.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/sdm845.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 84e6ee7..58593db 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -19,6 +19,7 @@
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
+	uint32_t sec_mi2s_clk_count;
 	uint32_t quat_tdm_clk_count;
 };
 
@@ -121,6 +122,15 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
 
+	case SECONDARY_MI2S_TX:
+		if (++(data->sec_mi2s_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
+		}
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		break;
+
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		if (++(data->quat_tdm_clk_count) == 1) {
@@ -157,6 +167,14 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 		};
 		break;
 
+	case SECONDARY_MI2S_TX:
+		if (--(data->sec_mi2s_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+				0, SNDRV_PCM_STREAM_CAPTURE);
+		}
+		break;
+
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		if (--(data->quat_tdm_clk_count) == 0) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

