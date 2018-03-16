Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtTnUwKh2QtpPNH4+R1XBa1EgxlbaRUAgfIrSAsZ02v86lONAIR7d5n/Nkr3O03NmjG0PwP
ARC-Seal: i=1; a=rsa-sha256; t=1521214374; cv=none;
        d=google.com; s=arc-20160816;
        b=OcKRekk4zyuSKuixxqsM35m25Ylqz3ErWxEsBoSfrZ2C/U0ZBUE2mTQAGcR1Y0CwDO
         qOuGmSeBz+NJ4TUMLjVoFdsE/3gyyfgtdOSroZe5xwgIrVJPmKpaoWNH79B70Yp9faRN
         kstLJB6Rs3pWf5gTu1bIVPw+RE0Yle5LZ66aPE6iXk7bnJbEYwjNkb+X/rkCa1orByFD
         4QuXAsfNMS4IE77tq6wVtC5IfupMl9JJ/8cq1Sm32UPEsqkQGxfVScE3lR3QkqXZVu1H
         /FSno+AS9DApINDcnGmL9+5U/kokbS0s7v3D5PfbPnul/Gz/W741Gd7zB/EvLEKsUdSe
         uqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JSzBA4UxvbVZ77egFwhUBglTZnke4m25gp+Hc9uYbis=;
        b=xF8Hq3GhM/KUUE5mDaSMSFuNO7t6iwljNeV6rvRAOE+jl9dTbNO2zc9QPPlToTZui3
         A6lBGJzgT8VFddU5+nud79lFeRXz/DhijEgJhg+97ToXaL4KirZ0BxRU7Cz7XeyrjlXQ
         3bM+W84NcfcE0CtCshG8FjbAJcVLRkcGv+KgQ7hilRlTuxMadeK4ZIz7PGvIBRPj9X9H
         UJVHB8dU9R5MK9vFaODQK3NguuPKgtnrOTJdP5Qz+ybHd4puZ2hKf1JsscPAG+5eOgif
         Ma7umI+cVIKWhQUxW7HdVlPttK7mJwZwz0H6Dq/RClZ37a5feqSrm2aeL5FMRa1yR0Mm
         +VOg==
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
Subject: [PATCH 4.9 71/86] ASoC: sgtl5000: Fix suspend/resume
Date: Fri, 16 Mar 2018 16:23:34 +0100
Message-Id: <20180316152322.155265430@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108883859769271?=
X-GMAIL-MSGID: =?utf-8?q?1595108883859769271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -774,15 +774,26 @@ static int sgtl5000_pcm_hw_params(struct
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
