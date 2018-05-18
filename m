Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526648329; cv=none;
        d=google.com; s=arc-20160816;
        b=pTs47D1wkZqHjBTOJrBE4SKngfmvi0QetIFkTgzyiyGwCIgEFWDCEdhU7qqUMvbISi
         4PPjvyxp3os65+hRxiICVeverdE60IIFaX/gXXqDpLU5LirTm3yjBITWEVe+9PEtWhuB
         /9B9Q1C9sjDPLnntWUuQMvQfDGY9KIQIYJ9KFvPg7VF+M49fWgi9sI/eKjEDt6gKFkuE
         QD4Uccg4C8+IEyijyo6JtT2+rmI3gWNitCinFngP8ISjjwlQ/ec2Oju2hWihTFMA+wOD
         /QDQGX36C8fUb9iZ4HgN7Nw8xX/JsF/lS0Ss8d1tjzIpMOHwbF6mDCz8wFQvysr2BeZa
         59BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=UV1BtHbDiWi6iEI5CX0gIssiWWpkmlV/rJrHuE1iYh8=;
        b=ZoIfMvWPBpEQouzeH1hfLNVpKe6nCykyXSi0mH/hE1cGbg3YVkqN14a9gY23ZxlDeX
         s6msMaP2t5dvD3J5HBc+I/7rG4WL0HenYqr+evKPlGIHoJC2CEc8a7HoL7Y3eplS5XL8
         cemnF9sMbiJ8o0DNIr8T4Bck4cdGGa4c+8y4f/+wR0YRZOU5b7DsIbBH8Pk4IfJ0U9jS
         jdQaJipUSwN8+zDLye1v/EmfLBbZUOLXZMMFnEQOAfc60WeMgyt3aOYLvzAhVTXH/vAT
         NtQC2AFRvTi6/9IsetgVxBBQH9l1PZ/jLPi/ACLKcrDOO+G/qSkcHI/9lgURQrW9bnOs
         YrkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YNaD6mAB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YNaD6mAB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZotgEEWwONkUo+Pbm+h9sTC6cYR0eEzC6Iw3MLErArhqvAf0iyeR7PdW8n3bq64P94tG64TNg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org
Cc: robh+dt@kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v9 10/15] ASoC: qdsp6: q6routing: Add support to all SLIMBus Mixers
Date: Fri, 18 May 2018 13:56:05 +0100
Message-Id: <20180518125610.26200-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
References: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600806798973863057?=
X-GMAIL-MSGID: =?utf-8?q?1600806798973863057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to SLIMBus related mixers to control mux between
ASM stream and AFE port.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 261 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 1d7a4088a435..43086913060a 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -241,6 +241,180 @@ static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
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
@@ -264,6 +438,28 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
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
@@ -276,6 +472,71 @@ static const struct snd_soc_dapm_route intercon[] = {
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
