Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176650; cv=none;
        d=google.com; s=arc-20160816;
        b=FtL+TTuvED2YLNZHFHIDgRq1chaKif+EObUebQIfLF+7NT9xqvJ2vc8NdPMb1ihHTP
         hme1mQzS5VHvMJoB6YkfYSXLaI/NIsHAztvZ87SEVtcnZTCKZ5mtUWQYd4V/3kuCzPsr
         OKOWJXomMQb/2xUE5H9JzMia3iDqVzem8p+GZyGMxk3djmsJS2mbUXWIKT5OTUZxJ+uY
         ZQVKp4jIakFdcBS9R4gjN+iXKLYj61prhFtzDiJxPGqjNnLEZl0BhzAZyV6/mz9iOmn/
         QNRrrG2ezQoPS04+HUG5rnl4F6NkyWGwA8ZY2anSdeE9w0XnLqPFv56cgd6hu30/19be
         w5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HPIdZB5gqXGPTaETpD5l2jg5Ig3ya0/k0lAu2uf/60o=;
        b=TTzpNTM481gfmfnmR3zZKJSFE73tXzsD6yyXpag0wUASywL6WHMWjOLLC/RmJesqpk
         5zsQroHHIJLn+NIAcSvpvTU4uaerHr2AwWUcM1CMBzukrbVHvXBCgAWNg16wN94PXVHW
         Yf5u4Vj3spVOb0NTyfFkc82FgA7hT4UjnmsvYSKUvL2HsZuK92gk5AeU5GzynEyLgrOU
         99KQsf+XIzFm4cby5gIdvp2vm8vVskuViX5tdp89zn6+DrB0P0ti4ab7lOD1o7b0zn8P
         JLIZd7c1DfITb4i358W9Afkd0Oo1xJkPhp47Gz/xn9cHDVwvDzbRJd+da1vwl/QWsqMJ
         JMsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lnq5ru6I;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lnq5ru6I;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZriyLFXAiN9RvBwKvBv4SsH4icutowv8Z7bNPzr1k5x+9IYTy9t+4zsBztRMFCd2tobzyDMbA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 18/24] ASoC: qdsp6: q6routing: Add support to all SLIMBus Mixers
Date: Tue,  1 May 2018 13:08:14 +0100
Message-Id: <20180501120820.11016-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263631376354914?=
X-GMAIL-MSGID: =?utf-8?q?1599263631376354914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to SLIMBus related mixers to control mux between
ASM stream and AFE port.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 261 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 72863672f11f..b59147c61c16 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -234,6 +234,180 @@ static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 		       msm_routing_put_audio_mixer),
 };
 
+static const struct snd_kcontrol_new slimbus_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_1_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_2_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_3_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_4_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_4_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_4_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_4_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_5_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_6_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
 static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	/* Frontend AIF */
 	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
@@ -257,6 +431,28 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
 			   hdmi_mixer_controls,
 			   ARRAY_SIZE(hdmi_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("SLIMBUS_0_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_1_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_1_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_1_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_2_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_2_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_2_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_3_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_3_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_3_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_4_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_4_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_4_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_5_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_5_rx_mixer_controls,
+			    ARRAY_SIZE(slimbus_5_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_6_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_6_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_6_rx_mixer_controls)),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -269,6 +465,71 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HDMI Mixer", "MultiMedia7", "MM_DL7"},
 	{"HDMI Mixer", "MultiMedia8", "MM_DL8"},
 	{"HDMI_RX", NULL, "HDMI Mixer"},
+
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_0_RX", NULL, "SLIMBUS_0_RX Audio Mixer"},
+
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_1_RX", NULL, "SLIMBUS_1_RX Audio Mixer"},
+
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_2_RX", NULL, "SLIMBUS_2_RX Audio Mixer"},
+
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_3_RX", NULL, "SLIMBUS_3_RX Audio Mixer"},
+
+	{"SLIMBUS_4_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_4_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_4_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_4_RX", NULL, "SLIMBUS_4_RX Audio Mixer"},
+
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_5_RX", NULL, "SLIMBUS_5_RX Audio Mixer"},
+
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_6_RX", NULL, "SLIMBUS_6_RX Audio Mixer"},
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.16.2
