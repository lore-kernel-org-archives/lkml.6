Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526648330; cv=none;
        d=google.com; s=arc-20160816;
        b=lFF+w1sswPXYxWXBS1tX1/VbkumuhFx49seEX2PXKBZuPXVKvUmPx778DA1J0cFoTK
         gT3iz3VQbwE9whn+bH26Hopdz2WSO7AE4WrIql/uhU6IEvbEx4ILqa7p8TYkrY6MVVjr
         FBI+yRIx5jK3eJvxUZ3L6c/qBc7K5J75bEnJ4ApzIXMvnPE/IXn6M0gJwQhGWaITeb1G
         TvvLSg6S69YbWtzf08+OR8TkfJqT3p7FlPH0ysrtnzHOQnYRuacx8m1MK3beF+I6Zk1H
         AtZs2IIdeE/e7nRkYF55t59I6O8fawCgJg+Hd6A6hqhmJGHTl/9ZAKoN7uKHhV2s6/ER
         o/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RqJYWeEk2A53od2W/e2cpRMjrnB4vfEN+54pkeSM048=;
        b=RSknGbMwh2Vpkrdyq1fzm2ZBD133dY2/S7IlonihqwtFpcVK6Z47xKIgDkXi8QzsEL
         vYcjFkFNGCDAE7hrGLkYBeCpXg1AEqa9oKLxQo/KoO3L/bMS1C/x7hJ5WlAhIy9wUS2s
         O09eAq8K3kPbOqC00lHmH0V6IuWYM85tEVYxN18NnPwGrSOP8BmjcFVBsuxg6fQRDuYF
         E07BpXpcxiqi5ulMN5tBUfkMHpusQNnyahabH+0sxow4klQZ56XPsp0JulNcARnhZY/Z
         GH/GRX6HSQaTiB4l+aiGK3IaSWfz3BhTBeN27yGdy1uLAz+3qqZyfXzMRWk+esxZDqYL
         H+0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C8BRVxS2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C8BRVxS2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpoove7gy/DCo3Zu1h9hyiOR3gYrKIGT75w2WZjXCy1Ih7r8lGzFDe8x9w0ZzMJw3TfkeNzSA==
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
Subject: [PATCH v9 11/15] ASoC: qdsp6: q6routing: Add support to MI2S Mixers
Date: Fri, 18 May 2018 13:56:06 +0100
Message-Id: <20180518125610.26200-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
References: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600806800336554666?=
X-GMAIL-MSGID: =?utf-8?q?1600806800336554666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add support to MI2S mixers required to select path between
ASM stream and AFE ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 329 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 329 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 43086913060a..08c25c26adf4 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -241,6 +241,103 @@ static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 		       msm_routing_put_audio_mixer),
 };
 
+static const struct snd_kcontrol_new primary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new secondary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new quaternary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new tertiary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+
 static const struct snd_kcontrol_new slimbus_rx_mixer_controls[] = {
 	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_0_RX,
 	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
@@ -415,6 +512,126 @@ static const struct snd_kcontrol_new slimbus_6_rx_mixer_controls[] = {
 	msm_routing_put_audio_mixer),
 };
 
+static const struct snd_kcontrol_new mmul1_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul2_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul3_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul4_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul5_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul6_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul7_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul8_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
 static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	/* Frontend AIF */
 	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
@@ -460,6 +677,35 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("SLIMBUS_6_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
 			   slimbus_6_rx_mixer_controls,
 			   ARRAY_SIZE(slimbus_6_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("PRI_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   primary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(primary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SEC_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   secondary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(secondary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("QUAT_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   quaternary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(quaternary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("TERT_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   tertiary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(tertiary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia1 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul1_mixer_controls, ARRAY_SIZE(mmul1_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia2 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul2_mixer_controls, ARRAY_SIZE(mmul2_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia3 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul3_mixer_controls, ARRAY_SIZE(mmul3_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia4 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul4_mixer_controls, ARRAY_SIZE(mmul4_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia5 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul5_mixer_controls, ARRAY_SIZE(mmul5_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia6 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul6_mixer_controls, ARRAY_SIZE(mmul6_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia7 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul7_mixer_controls, ARRAY_SIZE(mmul7_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia8 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul8_mixer_controls, ARRAY_SIZE(mmul8_mixer_controls)),
+
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -537,6 +783,89 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
 	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
 	{"SLIMBUS_6_RX", NULL, "SLIMBUS_6_RX Audio Mixer"},
+
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"QUAT_MI2S_RX", NULL, "QUAT_MI2S_RX Audio Mixer"},
+
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"TERT_MI2S_RX", NULL, "TERT_MI2S_RX Audio Mixer"},
+
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia6", "MM_DL5"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia8", "MM_DL7"},
+	{"SEC_MI2S_RX", NULL, "SEC_MI2S_RX Audio Mixer"},
+
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"PRI_MI2S_RX", NULL, "PRI_MI2S_RX Audio Mixer"},
+
+	{"MultiMedia1 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia1 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia1 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia1 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia2 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia2 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia2 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia2 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia3 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia3 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia3 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia3 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia4 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia4 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia4 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia4 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia5 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia5 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia5 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia5 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia6 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia6 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia6 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia6 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia7 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia7 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia7 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia7 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia8 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia8 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia8 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia8 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MM_UL1", NULL, "MultiMedia1 Mixer"},
+	{"MM_UL2", NULL, "MultiMedia2 Mixer"},
+	{"MM_UL3", NULL, "MultiMedia3 Mixer"},
+	{"MM_UL4", NULL, "MultiMedia4 Mixer"},
+	{"MM_UL5", NULL, "MultiMedia5 Mixer"},
+	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
+	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
+	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.16.2
