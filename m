Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtCypaHfUC54aFhQQSAnWekITm2Ge0miksTKVxiflsCszBvTj9Pc5l7hJP3jF/sAw23F2K+
ARC-Seal: i=1; a=rsa-sha256; t=1519981112; cv=none;
        d=google.com; s=arc-20160816;
        b=AXjv5Lr89YKG+UXThYBYRIVGjMR9FuWqz7EF8qb/4oxXMnU6oJHKLLaqPh4oh6zUBA
         LSJXYTiRdDm8zhbl51dDqE4XUvX/QUTpPGfniCfluGx8xtBx/efVAkVCHoLlt5UWY+M1
         bbZ7jzxUYoYCs9wP2y00gBpu6V4suH6ZAOzU4/gKchNZFOG9IQIbszPVWCkTr5PB0b7H
         2r+KmWazi1ODTvLQFU8OuYL+xOlMimMSyH4Qik2nIigPKWYWfHh4pzsvP6Cp2K9RtCh3
         xPKVy6ntwCBTf1G79XoN6wzD4wv6hzjWjOMO97fkjhK30bYJNRfGELJNumXsGQtsCuRT
         WXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r+K204wxDT/RQLf4LRW6yd98geOrsugiLhlAC15gJxU=;
        b=JKrpAFZysXT0wDWKpGf0VLHibNUpoK0qyp3sgVqM0fjpWBg65jsClC2Sp87VBkX8+S
         TADg1C+IeT5tZQydhw5kDrqtBlSRV+99ISUnb8ktacBMK/MKtsBNIibsdN0QHViNaAUe
         x/vPIVM5nGY55RSacwThK2l2zrYhEul9jWZ09nlI3oYUJXxwnIG5eVUV1sLcVr52bNe2
         uSbI2TskaZVvr38vuuHJ2ahDxE3r+Y8pmKkIeFnNFlhxwNwrPp/vLD15Wr82++gcYCL8
         phRJWcfAgtX0BKUlyAHy8AzzvKgXord1lUJe9F+5OTKxhJoqmBwJ8tPGC4hQMKXzj2Z/
         RS6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Abhijeet Kumar <abhijeet.kumar@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 17/56] ASoC: nau8825: fix issue that pop noise when start capture
Date: Fri,  2 Mar 2018 09:51:03 +0100
Message-Id: <20180302084450.493679502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815714393485351?=
X-GMAIL-MSGID: =?utf-8?q?1593815714393485351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhijeet Kumar <abhijeet.kumar@intel.com>


[ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]

In skylake platform, we hear a loud pop noise(0 dB) at start of
audio capture power up sequence. This patch removes the pop noise
from the recording by adding a delay before enabling ADC.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/nau8825.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -882,6 +882,7 @@ static int nau8825_adc_event(struct snd_
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		msleep(125);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
 			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 		break;
