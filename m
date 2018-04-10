Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48mXj1dck3psjjeifnSc9PpkxXAwY8HX3j6EJl611tKB5PBjVK03aDiSjQK+r6NLDCj6BYE
ARC-Seal: i=1; a=rsa-sha256; t=1523399295; cv=none;
        d=google.com; s=arc-20160816;
        b=Fp79jj0ml6I9Fhq9vHA/ib1Eq9J6B/y/kLePv53wKG12as2h+aWOd4Wzyn31zrYaqB
         tuopIigWKSzTXBV6OdFAK7/F5yxLBS76raePrfdBHzkQJWJxmrJD9Do/VcaIma6bFg9R
         teYWkSkNpcIvvlj6JtM20SQqBAWHMIQ/I+41GgDHptXBeOKD22qHQhT+eyc42en9Xemy
         cCKYYPlmA54prpUY55IJqES3SKxwR9ZepD5v0LzlXZQ8E6WAHmFmrJO5uwZq6jl/cuBe
         HvI6rxKxnRA6l7Vgzu6wnF2XVlSgqzPqUcOSMEnEhP8/obN1dYZHY+KdGKytg6aTVPZn
         bd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qx+c4O37P2bYJhF5AWoWl5lzTGceGTDiJ6HbkNEnQbM=;
        b=yftunVYQ8jcRAx9w+KYUX5jlxmbW3QiQf8h9Tnd5U8Afa4KQ6wAzB91QBMyXYcPnfn
         QjMh5Tp4ogRcuBIChIgK7qwX4DLADN1E+LH5t/r4pkOTnRhWb+ezreQ+AZRjb1bctqGX
         01QFDeErpOB9L0DEdJ6tIzGpNsNYveL10W9msNJfukReTJb7V4fhcc+Vc992XqbqLAx2
         bUyZ9kNp8J0SxynV/PEHpc9i+4bYVnVQ9rRV8kDHijUI9BPlthP7RpQWUeijeo16jnmQ
         mt02kgv9r03vUMqwJG3MsZL3iO+5c1i0MyB1+4oeOAbe6/rPzqfLpqk4n8yj5T+bPqrl
         2hBg==
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
Subject: [PATCH 4.15 035/168] ASoC: Intel: cht_bsw_rt5645: Analog Mic support
Date: Wed, 11 Apr 2018 00:22:57 +0200
Message-Id: <20180410212801.691934506@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399939365598429?=
X-GMAIL-MSGID: =?utf-8?q?1597399939365598429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -118,6 +118,7 @@ static const struct snd_soc_dapm_widget
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Analog Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -128,6 +129,8 @@ static const struct snd_soc_dapm_route c
 	{"IN1N", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Int Mic"},
 	{"DMIC R1", NULL, "Int Mic"},
+	{"IN2P", NULL, "Int Analog Mic"},
+	{"IN2N", NULL, "Int Analog Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Ext Spk", NULL, "SPOL"},
@@ -135,6 +138,9 @@ static const struct snd_soc_dapm_route c
 	{"Headphone", NULL, "Platform Clock"},
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Int Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "micbias1"},
+	{"Int Analog Mic", NULL, "micbias2"},
 	{"Ext Spk", NULL, "Platform Clock"},
 };
 
@@ -189,6 +195,7 @@ static const struct snd_kcontrol_new cht
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Analog Mic"),
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
 
