Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PWJO8eB6biO0FhgRmtObf0jYAT+yy2EkHe6DFV4k6Y/oaTGoEuV0rDM83BJAFVimkxnca
ARC-Seal: i=1; a=rsa-sha256; t=1523399737; cv=none;
        d=google.com; s=arc-20160816;
        b=1DQVjaEHepL7lGCT/NGEsvJbF1WNEJsqe0ZO5XmdgTDGO9Pu1b5jHOv3E4R2lktiqE
         ZeAVhakWhAD3YG5wQ2d4vqIW8Q4qYhgxLLZRc7qC+pWMMAKawvbvTfBKOLRtgqQMuswG
         dW467qGRLLNXnIfkeUbCvb2Stv7IqvgeKcsTtk0wDe6RaNs6v4GB4vvuc5y4xNFEgzov
         kQ3vzNCLX+L72ixijxD+G6hM1eZqh0j0vEFdKbLgHQrelvkJnFBGpW6z6lt7rU4VyzVQ
         hRlTB3B9uwT54WktrgvEpr4VH7XK0lRfzNdm7dK4N/DlYRrkrXd/b6G3slIhoKTIEWCi
         5GNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vwo2eukSPB96s4Esb+Ps12VFTNfD72NO3mJGbVAsiYY=;
        b=AqIQrWGJfkTJARfEDLe9plF0IucbguS7qDHv5q+FlsL7q7sD+8bsDUFpeEjfWLMf5K
         6laqdrtzIZ0mVEiJAkbQcwQsdaX58mmFTDa9if4Nvcd0IVyL+qvOV228+b2CB8YG/08C
         KkLpyHRljhogAotdB+5nN00FlM5nvIWw8Ofw/PLcaxEF873UiEir3pFkzhPTr1s5DbSC
         XJn70Np6J66aF/I2YaPl+LTC7LV5clvrPrJegWCFXJGFERjixrfzv4LfSBseyhAxVlac
         PZaBMMdwYPeDb+481qT2s0H5HhXLnTtmUktxJGAEwvtR3KxxX4vMQmYHOjDOMWvWTAi5
         foHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 028/138] ASoC: Intel: cht_bsw_rt5645: Analog Mic support
Date: Wed, 11 Apr 2018 00:23:38 +0200
Message-Id: <20180410212905.408078644@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399939365598429?=
X-GMAIL-MSGID: =?utf-8?q?1597400402705951268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit b70b309950418437bbd2a30afd169c4f09dee3e5 ]

Various Cherry Trail boards with a rt5645 codec have an analog mic
connected to IN2P + IN2N. The mic on this boards also needs micbias to
be enabled, on some boards micbias1 is used and on others micbias2, so
we enable both.

This commit adds a new "Int Analog Mic" DAPM widget for this, so that we
do not end up enabling micbias on boards with a digital mic which uses
the already present "Int Mic" widget. Some existing UCM files already
refer to "Int Mic" for their "Internal Analog Microphones" SectionDevice,
but these don't work anyways since they enable the RECMIX BST1 Switch
instead of the BST2 switch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -133,6 +133,7 @@ static const struct snd_soc_dapm_widget
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Analog Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -143,6 +144,8 @@ static const struct snd_soc_dapm_route c
 	{"IN1N", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Int Mic"},
 	{"DMIC R1", NULL, "Int Mic"},
+	{"IN2P", NULL, "Int Analog Mic"},
+	{"IN2N", NULL, "Int Analog Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Ext Spk", NULL, "SPOL"},
@@ -150,6 +153,9 @@ static const struct snd_soc_dapm_route c
 	{"Headphone", NULL, "Platform Clock"},
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Int Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "micbias1"},
+	{"Int Analog Mic", NULL, "micbias2"},
 	{"Ext Spk", NULL, "Platform Clock"},
 };
 
@@ -204,6 +210,7 @@ static const struct snd_kcontrol_new cht
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Analog Mic"),
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
 
