Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsfy8+Grf4pjEj7cUoz2g5LF9OI6QPi4vpEuewMBpMYcjKtjvQyc09irpb1ceqfv1uTJ/lP
ARC-Seal: i=1; a=rsa-sha256; t=1521214499; cv=none;
        d=google.com; s=arc-20160816;
        b=v40NJmEZ6g1oTjestdV45cKLYof4E40N/Kw+2VnJ7nlnLRU+GqDyZbBAxUxQr2RLEA
         ZzgOe+ervLK538wIz5GIT4bl4WEGG11tCyC7IGbI1/SWohguKDQXtw5YwiyGJWmTlN1Q
         fR0S8vQ8R38IZufLiFWHmjw7LgtetlMbRPpS3Yvz3iHfCiRgUdIr/xray6tdNkb7+lAM
         ghQaN5AsBRS7Xg+q9beizviQrIIyokfoCwMNS2+RNCRzDNnRlffn/Z5S5wUp4E8nRmZw
         EWCoRzAluTWTqtiumXPEh2gr0Plcd3KhU2aBgmXf+Xz4IK1PeRwwBwyrMcQsqkJvVmn1
         QVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7TigRExQD+1SGddQNFXTk2T4dURXhn1OgqJMqWPEe04=;
        b=drZ3ceirGODFytsoeqji13QMmQjCDdtBT6Njl78pKELj3X8WCxcfQb5hDKiHigPbcN
         6ldWqJeAdf5MQKLuG3jPPW5NArmviuqbnWWBLgvVpmzehSM+BUGtxxLHBSnCvmt+Lv16
         0XWmdEyhOsx00IKDbj/Ryz/4BlWR8BreyiCz+QNuF+ANECHZxkCt09NmnoUfgx6kZtbw
         BSXgoP+DHS1FYrjgKG4JVJFuTcOXxM+koh5HiBB89/QC8MZgRI+y892ml0c5UbRZo52V
         XcXx5kv6gPEnww/SdlW+wNkAX9G4MxuH7QRPWzFnX7h9dyRbSZ0jmBuXTTQOJIpoTwUT
         YJWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 4.14 005/109] ASoC: sgtl5000: Fix suspend/resume
Date: Fri, 16 Mar 2018 16:22:34 +0100
Message-Id: <20180316152330.138393689@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108883859769271?=
X-GMAIL-MSGID: =?utf-8?q?1595109015371233567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

commit a8992973edbb2555e956b90f6fe97c4bc14d761d upstream.

Commit 8419caa72702 ("ASoC: sgtl5000: Do not disable regulators in
SND_SOC_BIAS_OFF") causes the sgtl5000 to fail after a suspend/resume
sequence:

Playing WAVE '/media/a2002011001-e02.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
aplay: pcm_write:2051: write error: Input/output error

The problem is caused by the fact that the aforementioned commit
dropped the cache handling, so re-introduce the register map
resync to fix the problem.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/sgtl5000.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -871,15 +871,26 @@ static int sgtl5000_pcm_hw_params(struct
 static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
+	struct sgtl5000_priv *sgtl = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
+		regcache_cache_only(sgtl->regmap, false);
+		ret = regcache_sync(sgtl->regmap);
+		if (ret) {
+			regcache_cache_only(sgtl->regmap, true);
+			return ret;
+		}
+
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				    SGTL5000_REFTOP_POWERUP,
 				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
+		regcache_cache_only(sgtl->regmap, true);
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
