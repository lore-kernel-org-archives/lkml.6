Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBAAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA40A20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA40A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJ3UMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:12:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52579 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJ3UMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:12:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so11339397wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=YBAjtYBHPMbOhvf67wYNjvQkFVV9ngJxYuFL7Y/ZQLs=;
        b=TRwveKDuwl/OAJ0t7QMgYnaV5FASr3DRvG+vxlaP9Ar/vmMS6BYCW9b2redx9WgXfz
         Imn2qgE6/ONmD7gpyvGmnF7ry7Ei25ynmUodBJ2Vt6EJkx1x8yAj7CkJsn0fPDBGMvu1
         jUJ1FJL+FDtwpzDm2W2psFq+tAtwjMtI2cSr2e6sP8sLk3S2zqBgrUa2Js9NAJJYTNU1
         8CSGrtbyZdL2zidpwBfOpXHQ0hZkE+MSSumKuzM28lZKwLLE66ntIt5+MOdcPrgd3HIB
         /z/HlEFHC4YFzsKgtwoGuxo/nG0P19qUV/JcnoV8kR7pRULLpd+9/1p+rthSWX28g2WD
         vdGw==
X-Gm-Message-State: AGRZ1gK6itwPQYhJo4u2XnVbBsWF1DmpE5g+oMbqUIgFGjF9LsdNpjle
        PrP1D9t3X9ERyB8q66DOcAsHAfviJ+o=
X-Google-Smtp-Source: AJdET5cmSvXk/9P9f7tRf78qcp1ubLH9/WSkFtb+8bZrCPQa1rjIeSg8l1RBVrdktq0QnWQgMup/bA==
X-Received: by 2002:a1c:e088:: with SMTP id x130-v6mr1373951wmg.6.1540898352636;
        Tue, 30 Oct 2018 04:19:12 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 74-v6sm16946432wmi.23.2018.10.30.04.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 04:19:11 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
Message-ID: <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
Date:   Tue, 30 Oct 2018 12:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
Content-Type: multipart/mixed;
 boundary="------------D8E333DA52011A9414FDF4E5"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D8E333DA52011A9414FDF4E5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dean,

Attached are 2 different attempts at fixing this.

When trying these patches do not forget to remove the revert of the
"Stop-marking-clocks-as-CLK_IS_CRITICAL" commit.

Please first try the 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
patch I expect that one to do the trick indicating that the Swanky model
uses a different pmc clk then which is normally used for the codec clock.

If that patch does not fix things, please give the other patch a try.

Regards,

Hans



On 29-10-18 23:03, Pierre-Louis Bossart wrote:
> 
> On 10/29/18 2:08 PM, Dean Wallace wrote:
>> On 29-10-18, Andy Shevchenko wrote:
>>> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> Cc: Pierre as well.
>>>>
>>>> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>>> Quoting Dean Wallace (2018-10-25 16:25:17)
>>>>>> I have found a regression in 4.18.15 that means I lose sound on my old
>>>>>> Toshiba Chromebook 2 (Swanky).  My system details are:-
>>>>>>
>>>>>> Toshiba Chromebook (Swanky)
>>>>>> MrChromebox UEFI coreboot
>>>>>> Arch Linux running latest alsa/pulseaudio
>>>>>>
>>>>>> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
>>>>>> output I mean, the card is still detected, the module loaded, all apps
>>>>>> showing sound is being playing, but no actual audible sound comes
>>>>>> through.  Upgraded to 4.18.16 same issue.
>>>>>>
>>>>>> Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
>>>>>> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
>>>>>> "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
>>>>>> devices not being able to reach S0i3 greatly decreasing their battery
>>>>>> drain when suspended."
>>>>>>
>>>>>> I reverted it and compiled 4.18.16 and have sound back again.  Could
>>>>>> this be looked into, with possibility of fix.
>>>>>>
>>>>> Thanks for the bug report. I'm adding some people involved in the commit
>>>>> you mention is causing audio regressions. The best plan is to probably
>>>>> revert the commit from the 4.18 linux stable tree. Or there may be
>>>>> another patch missing that would be useful to make this backported patch
>>>>> work. Hopefully Hans or Andy knows.
>>>> Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
>>>> I have a feeling that the problem can be fixed by properly handling
>>>> clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
>>>> better than me.
>>> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
>>> suspend-resume hooks. Perhaps, adding them like in the commit
>>> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
>>> help.
> 
> I missed this change while i was away. It's indeed the expectation that the audio mclk is handled by the firmware,

I believe that the statement "It's indeed the expectation that the
audio mclk is handled by the firmware" is not correct for BYT/CHT
platforms (and the commit causing the regression only affects BYT/CHT
platforms). Various machine drivers under sound/soc/intel/boards have
code to deal with the mclk themselves, like this:

         drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
...

         if (SND_SOC_DAPM_EVENT_ON(event)) {
                 ret = clk_prepare_enable(ctx->mclk);
		...
         } else {
                 clk_disable_unprepare(ctx->mclk);
         }

The above code is from sound/soc/intel/boards/cht_bsw_max98090_ti.c
which is the machine driver used on the machines for which problems
are now being reported.

And my commit introducing the problem is in essence a revert of:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d31fd43c0f9a41e2678a1e78c0f22f0384c6edd3

Which is from 2017-07-14 and the ASoC code for BYT/CHT platforms is
much older then that.

Also I asked Carlo why he wrote that patch and it was to fix a problem
with ethernet on some laptops.

> not sure I understand why removing the CLK_IS_CRITICAL was necessary or what it has to do with S0ix.

It is necessary, because if it is set the clock never gets disabled and
on x86 platforms using suspend2idle we are responsible for *all* the hardware
power-management as OS. If we do not disable the clocks then we can only
reach S0i1 instead of S0i3 when suspended leading to increased battery
drain during suspend.

Also note that this patch is only causing problems on CHT + max98090 codec
using machines. I've tested it on many other BYT/CHT machines myself and
we've not had any other bug reports related to this.

So this clearly points to a problem with the clock management in the
cht_bsw_max98090_ti.c machine driver.

I've some ideas how to fix this and I will prepare some patches to test.

Regards,

Hans

--------------D8E333DA52011A9414FDF4E5
Content-Type: text/x-patch;
 name="0001-ASoC-intel-cht_bsw_max98090_ti-Also-enable-disable-p.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-intel-cht_bsw_max98090_ti-Also-enable-disable-p.pa";
 filename*1="tch"

From 52e56378721f2e0ffde337f38db96a92d1870dc7 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 30 Oct 2018 12:14:27 +0100
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Also enable/disable
 pmc_plt_clk_0

Testing has shown that some boards not only use pmc_plt_clk_3 but also
use pmc_plt_clk_0.

This commit makes us also get and enable/disable pmc_plt_clk_0 as
necessary, fixing sound not working on these boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index db6976f4ddaa..750ac2160200 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -36,7 +36,7 @@
 #define CHT_CODEC_DAI	"HiFi"
 
 struct cht_mc_private {
-	struct clk *mclk;
+	struct clk_bulk_data clks[2];
 	struct snd_soc_jack jack;
 	bool ts3a227e_present;
 };
@@ -57,14 +57,14 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = clk_prepare_enable(ctx->mclk);
+		ret = clk_bulk_prepare_enable(ARRAY_SIZE(ctx->clks), ctx->clks);
 		if (ret < 0) {
 			dev_err(card->dev,
 				"could not configure MCLK state");
 			return ret;
 		}
 	} else {
-		clk_disable_unprepare(ctx->mclk);
+		clk_bulk_disable_unprepare(ARRAY_SIZE(ctx->clks), ctx->clks);
 	}
 
 	return 0;
@@ -229,11 +229,11 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	 * to disable a clock that has not been enabled,
 	 * we need to enable the clock first.
 	 */
-	ret = clk_prepare_enable(ctx->mclk);
+	ret = clk_prepare_enable(ctx->clks[0].clk);
 	if (!ret)
-		clk_disable_unprepare(ctx->mclk);
+		clk_disable_unprepare(ctx->clks[0].clk);
 
-	ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
+	ret = clk_set_rate(ctx->clks[0].clk, CHT_PLAT_CLK_3_HZ);
 
 	if (ret)
 		dev_err(runtime->dev, "unable to set MCLK rate\n");
@@ -411,12 +411,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-	if (IS_ERR(drv->mclk)) {
-		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-			PTR_ERR(drv->mclk));
-		return PTR_ERR(drv->mclk);
+	drv->clks[0].id = "pmc_plt_clk_3"; /* Standard codec clk */
+	drv->clks[1].id = "pmc_plt_clk_0"; /* Extra clk used on some boards */
+	ret_val = devm_clk_bulk_get(&pdev->dev, 2, drv->clks);
+	if (ret_val) {
+		dev_err(&pdev->dev, "Failed to get clocks: %d\n", ret_val);
+		return ret_val;
 	}
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
-- 
2.19.0


--------------D8E333DA52011A9414FDF4E5
Content-Type: text/x-patch;
 name="0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.pa";
 filename*1="tch"

From 03c73955ccc8cf925fac48295e92e62b6b1b35f7 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 30 Oct 2018 11:55:28 +0100
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Use pmc_plt_clk_0 instead
 of pmc_plt_clk_3

Testing has shown that CHT boards with a max98090 codec use pmc_plt_clk_0
instead of pmc_plt_clk_3, adjust the code to match this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index db6976f4ddaa..ce44ebee8d88 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -411,10 +411,10 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_0");
 	if (IS_ERR(drv->mclk)) {
 		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
+			"Failed to get MCLK from pmc_plt_clk_0: %ld\n",
 			PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
 	}
-- 
2.19.0


--------------D8E333DA52011A9414FDF4E5--
