Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvqXfGumuQQ+B4LDYachBEfnH99NjqlLJlvnFZi9HLyyw1pm8yrnIJe2+DT2xR8q0dWlIyD
ARC-Seal: i=1; a=rsa-sha256; t=1521214821; cv=none;
        d=google.com; s=arc-20160816;
        b=qt5ZGWCgoLnO440XHul079VTmEdewGNZl08Z3NiD+/G07NFS3pr4z2FGyGrcbRN1cM
         WMVh1Na5CGh40ZVoaUqzpHINbtqLex1ViGmARTB8R1ARhahxmBKhHd5foabyWkBvrMZs
         K9Mzy3iYY53WOgTgpH1Wf4puUTWQfjUGjCZKtsCrqNJBTZE2LsLZgFUek0iCDDGpfnfr
         sTf0O3KssiYsl3Z5KBjIrk4ukXmIt1mKhD4bLxaiPXhfwMPhcDBZ78AET+8DJDpr5iaq
         WXmkMtr8x1zoTWmG8ad6Jh+Z/lIj+l9JkA0c0RBwfRl2L5htrFobF9HNhMatbMybfivE
         +Q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/pweFE44/ZDDceqWtuVqy4irs4VEB4+geF60fLcwXXA=;
        b=aJP33Q8/NqUXe1DV+AWvdChoBS+gJRizEvoGauinHEdS3zVGaPzB1uHtqNcsQEbs4E
         q2CcTtDv3ZGmjglBVP8Q25j5xmo3LgX3/zUFdJttXgETzMZMZnaVDHdJfyQHzB3RGQCe
         JMl0exZdGdRXuUeNYZ1/aFdnDJkxOuhmxV8FXvLZNxhK0vwyNPhAWNo8OEIVItIsZm82
         r/SZfVDIuGyNssHak1DCBMzLlGw6HJztSYONtCuAOYDDfj3pUeQFL5ku+fEukxr07jQf
         0qTfhAQ4vSOUmWD4fj20Ut6XiC1iBhzUobOzfjTK5W5HK16rcRGWbob7B0r0d6YxfTvq
         ctsQ==
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
Subject: [PATCH 4.15 003/128] ASoC: sgtl5000: Fix suspend/resume
Date: Fri, 16 Mar 2018 16:22:24 +0100
Message-Id: <20180316152336.384727825@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108883859769271?=
X-GMAIL-MSGID: =?utf-8?q?1595109353059816290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
