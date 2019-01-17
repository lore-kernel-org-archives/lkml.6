Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D4120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfAQMFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:05:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47069 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfAQMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:05:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so8108842edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=MZus2zopI19uGxWBSzE/DkGX5zhW9iWblxC74ZLiybo=;
        b=VRwvoRW+g/O8X0/1qkyE6481qdg7nYX0Ur3xVZomANeB2XyFk3K5QZ32ncXq/YPZ3c
         6pbddrBqyHbTehHmrBmfRAJAw2UKIBmEab7TA8n5uyth0eYwkFW++YWCWtnaqwDgRjXI
         +zw22Mel3TYUoiyy4rHvlYozC0n0QE21wyd8aEDYYAE3cMbiYQnglhgiQOzj3QKdmrGP
         5JVW1pkIb6Ig7UD6OD/iFoWER7/wweay2bX8DipynqORuhYiI/exa/iXw73WfD4xg+aU
         8qE6PGNeBydXGnCNprZ9BEOoWfOFtXiLQ3TRwNL5YvXzhhiNaMszpaH5CToYN+pO3CeA
         s6qA==
X-Gm-Message-State: AJcUukcH5I/DMFoKbP0sbwSJf2zKLUdthnKn8UT/FBwVhF3ue/q7Di6t
        MT7wxR76cqI2CWOF6QYLvxnMlSgMAJY=
X-Google-Smtp-Source: ALg8bN72fSn4FKdkzOszTe5fErNAhP7N61tkizuJJ+Nin/MvJFyIP4L+pR1QbGOnmMwpYMIOFzQ/mA==
X-Received: by 2002:a50:898f:: with SMTP id g15mr10887085edg.257.1547726737494;
        Thu, 17 Jan 2019 04:05:37 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x58sm6068446edm.10.2019.01.17.04.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 04:05:36 -0800 (PST)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>,
        Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025232517.ywnw54qibemosjws@picard>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
Date:   Thu, 17 Jan 2019 13:05:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190117091214.7djttnpo4jjzi4su@spock>
Content-Type: multipart/mixed;
 boundary="------------E65641A5376FA8957E7DC4B6"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E65641A5376FA8957E7DC4B6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17-01-19 10:12, Dean Wallace wrote:
> Hi Hans, Mogens,
> 
> On 17-01-19, Mogens Jensen wrote:
>   
>> Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and the quirk seems to have fixed the problem caused by commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL"), as sound is now working if running "speaker-test" on my system which is clean ALSA.

Note being "clean ALSA" is really not a good thing now a days,
for lots of things we depend on pulseaudio (like setting
up UCM mixer profiles).

>>
>> Unfortunately, SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH driver is unusable on Clapper Chromebooks as audio played from everything but "speaker-test" as video players or web browsers is extremly low and sounds like played at 10x speed. At the same time kernel log is spammed with messages like this:
>>
>> max98090 i2c-193C9890:00: PLL unlocked
>> intel_sst_acpi 80860F28:00: FW Version 01.0c.00.01
>> writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
>> writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
>>
>> This is probably not related to the problem discussed in this thread, but the result is that I have to use the legacy driver SND_SOC_INTEL_BYT_MAX98090_MACH and therefore still has to revert commit 648e921888ad for sound to work.
>>
>> Is it possible to create a fix for SND_SOC_INTEL_BYT_MAX98090_MACH on kernel 4.19? Kernel 4.19 is a long term release so it would be very nice to have fix for this version upstream.
> 
> I have been reverting "clk: x86: Stop marking clocks as CLK_IS_CRITICAL"
> and the patch that initially added the quirk for swanky because of sound
> instability issues as you described.  I'm compiling vanilla Archlinux
> kernel with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH, using pulseaudio,
> and have sound in all my apps.
> 
> Baytrail sound has always been a little touchy, especially using headset
> with mic, but since the clk patch breaking sound and the quirk patch to
> fix it, there is a lot more instability.  Just running pavucontrol, or
> plugging in headset sets it off.  It's a head scratcher.

Mogens, Dean, can you please try the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
driver, without reverting any patches, with the attached patch on top and
see if that helps?

Thanks & Regards,

Hans

--------------E65641A5376FA8957E7DC4B6
Content-Type: text/x-patch;
 name="0001-ASoC-intel-cht_bsw_max98090_ti-Enable-codec-clock-on.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-intel-cht_bsw_max98090_ti-Enable-codec-clock-on.pa";
 filename*1="tch"

From b429076ee98094fe0ab5584980b178a5df1b3eb4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 17 Jan 2019 12:47:07 +0100
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Enable codec clock once and
 keep it enabled

Users have been seeing sound stability issues with max98090 codecs since:
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")

At first that commit broke sound for Chromebook Swanky and Clapper models,
the problem was that the machine-driver has been controlling the wrong
clock on those models since support for them was added. This was hidden by
clk-pmc-atom.c keeping the actual clk on unconditionally.

With the machine-driver controlling the proper clock, sound works again
but we are seeing bug reports describing it as: low volume,
"sounds like played at 10x speed" and instable.

When these issues are hit the following message is seen in dmesg:
"max98090 i2c-193C9890:00: PLL unlocked".

Attempts have been made to fix this by inserting a delay between enabling
the clk and enabling and checking the pll, but this has not helped.

It seems that if we ever disable the clk, the pll looses its lock and
then we get various issues.

This commit fixes this by enabling the clock once at probe time,
in essence restoring the old behavior of clk-pmc-atom.c always keeping
the clk on, but then only on machines with a max98090 codec.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 75 ++++++--------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 08a5152e635a..549d6ce12ec4 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -44,43 +44,11 @@ struct cht_mc_private {
 	bool ts3a227e_present;
 };
 
-static int platform_clock_control(struct snd_soc_dapm_widget *w,
-					  struct snd_kcontrol *k, int  event)
-{
-	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct snd_soc_card *card = dapm->card;
-	struct snd_soc_dai *codec_dai;
-	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
-	int ret;
-
-	codec_dai = snd_soc_card_get_codec_dai(card, CHT_CODEC_DAI);
-	if (!codec_dai) {
-		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
-		return -EIO;
-	}
-
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = clk_prepare_enable(ctx->mclk);
-		if (ret < 0) {
-			dev_err(card->dev,
-				"could not configure MCLK state");
-			return ret;
-		}
-	} else {
-		clk_disable_unprepare(ctx->mclk);
-	}
-
-	return 0;
-}
-
 static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
-			    platform_clock_control, SND_SOC_DAPM_PRE_PMU |
-			    SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route cht_audio_map[] = {
@@ -97,10 +65,6 @@ static const struct snd_soc_dapm_route cht_audio_map[] = {
 	{"codec_in0", NULL, "ssp2 Rx" },
 	{"codec_in1", NULL, "ssp2 Rx" },
 	{"ssp2 Rx", NULL, "HiFi Capture"},
-	{"Headphone", NULL, "Platform Clock"},
-	{"Headset Mic", NULL, "Platform Clock"},
-	{"Int Mic", NULL, "Platform Clock"},
-	{"Ext Spk", NULL, "Platform Clock"},
 };
 
 static const struct snd_kcontrol_new cht_mc_controls[] = {
@@ -222,25 +186,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 			"jack detection gpios not added, error %d\n", ret);
 	}
 
-	/*
-	 * The firmware might enable the clock at
-	 * boot (this information may or may not
-	 * be reflected in the enable clock register).
-	 * To change the rate we must disable the clock
-	 * first to cover these cases. Due to common
-	 * clock framework restrictions that do not allow
-	 * to disable a clock that has not been enabled,
-	 * we need to enable the clock first.
-	 */
-	ret = clk_prepare_enable(ctx->mclk);
-	if (!ret)
-		clk_disable_unprepare(ctx->mclk);
-
-	ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
-
-	if (ret)
-		dev_err(runtime->dev, "unable to set MCLK rate\n");
-
 	return ret;
 }
 
@@ -459,6 +404,16 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return PTR_ERR(drv->mclk);
 	}
 
+	/*
+	 * The MAX98090 does not seem to like it if we muck with its clock,
+	 * so we enable it here once and leave it at that.
+	 */
+	ret_val = clk_prepare_enable(drv->mclk);
+	if (ret_val < 0) {
+		dev_err(&pdev->dev, "Failed to enable MCLK: %d\n", ret_val);
+		return ret_val;
+	}
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
 	if (ret_val) {
 		dev_err(&pdev->dev,
@@ -469,11 +424,21 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	return ret_val;
 }
 
+static int snd_cht_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
+
+	clk_disable_unprepare(ctx->mclk);
+	return 0;
+}
+
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-max98090",
 	},
 	.probe = snd_cht_mc_probe,
+	.remove = snd_cht_mc_remove,
 };
 
 module_platform_driver(snd_cht_mc_driver)
-- 
2.20.1


--------------E65641A5376FA8957E7DC4B6--
