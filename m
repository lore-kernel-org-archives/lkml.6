Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuoooRFy9+PmrHwhLm/83gincpsoXstYhHRZTsf1jneEeOVZA/335ywh1DskDp6e+q2DmZL
ARC-Seal: i=1; a=rsa-sha256; t=1519981338; cv=none;
        d=google.com; s=arc-20160816;
        b=J+ztI4BUh/q2UMzJUtFwyxc7HHl4lLxEA+x67ZGG9KRlGwqm2CqMue7i7Xwnpspprs
         +/jHZ1OVav4IM8LDnAqk+A3YLN+XFE0pJvRZDMkmDsr3kd2iczGiXzsNtZBPT3Knh7Fs
         26T0kFhYj+i9wCjf8w5b2J8W26KDZrND8S+nmJeLYIOKuR8VmwcaSSF96Rmcn3OO19SQ
         cGhi6iMTohaAKuLE7VHLBlLANRNcEOq5KOrUd9NrW/zypeMo5vLBVtbc4oRwfW2TBH4W
         qm+Vua+yvYYYgqnN7xUZCc/f+2vPescnLl7UZimc2ago14E1EN3W+eMia9961YLFxoVK
         52+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y0Yvhuo6j5ifdrr/kUj38X7Qpbprz0MQY0dDO5OFi0k=;
        b=q5T/qoM6vTzqTsmviAaz3H0rTG3HMbqd3u76WA4Qt2EoUol8KiP6LCkzBVRFeo+jX5
         KPghtxAmFUIPHUB/o6j90rmQ0hfyF8lpjpzFeb1qN/Us4bAH21DSdMbnbPxfj62hOTbS
         2Ov+kIGQqItU/kf6KcppcIKKAvFkTIhhjvhbo+e7UKihxATy7wglgkicHRxdzxouB8uE
         fHnpf936D2IFuJf0vtj/RbSVv85U9dcBwhh6yzjHj23BvjTYlKB2LcOFvzp2Sz7uSirH
         3Q4gXm5NlEG91C8/AfuAX+eF1U1ZOvCucltMVOe4K6vrpwOD1CmgsyOoIxjhSZJvRHMI
         ay0Q==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 026/115] ASoC: nau8825: fix issue that pop noise when start capture
Date: Fri,  2 Mar 2018 09:50:29 +0100
Message-Id: <20180302084504.931227735@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815714393485351?=
X-GMAIL-MSGID: =?utf-8?q?1593815952033217966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhijeet Kumar <abhijeet.kumar@intel.com>


[ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]

In skylake platform, we hear a loud pop noise(0 dB) at start of
audio capture power up sequence. This patch removes the pop noise
from the recording by adding a delay before enabling ADC.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/nau8825.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -905,6 +905,7 @@ static int nau8825_adc_event(struct snd_
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		msleep(125);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
 			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 		break;
