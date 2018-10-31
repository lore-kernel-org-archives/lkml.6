Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D255520685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D255520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeJaUCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:02:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeJaUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:02:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so13218057edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=MoKhVCGJrBuduLPa95Q3uN+e4avD6HdJ2vyCRrbe614=;
        b=TPLBtT5MjOjlC0QpuHZaal6XPTczP8xAXeNy2QI901UutvTv3zViNpOa+7sz3BWf5P
         rg/l1k677QrWn86gsx82HdsNoVPEjLt+w6Ix7MIY5XwIFz3tKPr4XtbXApoZ9vS8xYTc
         PMiLQds0ai2a+ApSupEOcWqhD2mmQjGwetIYJ2T0zanqn34YqjoV+S8Tu6s8NVFTVh53
         J4zpfZ/6fktSoLjhPuW4RssDqaUbDGqDgojY9v5Sj6aT+qVvqFO8k4TYds7hSGeclM2r
         OYlCMNx77k1yzAjDDJkbaVvYJoeOhkBWDGvmWOtgfkat64v1pi0EfsdXJvk1wQnz+kPy
         gNOQ==
X-Gm-Message-State: AGRZ1gKvmYOe7r5ev8zCwXeiszwF9cdSLzYKc/zQFwm9u7+1f7MeoJj0
        8dWq045JZG4Wvf+p2QqKg7gfAA==
X-Google-Smtp-Source: AJdET5cfp2WEc9CCJ+0MV1c93/IRXAyi2h7HVSL25xLsTH47t5dzQ1q96HsUsU1IutqXpsDqK7fM4A==
X-Received: by 2002:a50:9821:: with SMTP id g30-v6mr1661457edb.70.1540983891227;
        Wed, 31 Oct 2018 04:04:51 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b7-v6sm7405602edd.43.2018.10.31.04.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 04:04:50 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
Date:   Wed, 31 Oct 2018 12:04:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181030161534.wk5cf7nxbwhp2far@picard>
Content-Type: multipart/mixed;
 boundary="------------1D6A7769062B0A81C24C5809"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1D6A7769062B0A81C24C5809
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30-10-18 17:15, Dean Wallace wrote:
> On 30-10-18, Hans de Goede wrote:
>> Hi,
>>
>> On 30-10-18 16:46, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 30-10-18 16:04, Pierre-Louis Bossart wrote:
>>>> In addition I am not aware of any baytrail device using plt_clk_0,
>>>> so moving a common machine driver such a cht_bsw_max98090_ti to use
>>>> plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking
>>>> for both clocks to be on might work though,
>>>
>>> Ok, so we need to have a DMI based quirk for the Swanky and maybe also
>>> the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
>>> one does not seem like a good plan.
>>
>> Dean, Mogens,
>>
>> To write a proper patch for this I'm going to need DMI strings
>> from your devices.
>>
>> Can you please run (as normal user):
>>
>> grep . /sys/class/dmi/id/* 2> /dev/null
>>
>> And reply with the output of this command?
> Here's mine, for a coreboot uefi based swanky.
> 
> https://ptpb.pw/~swanky-dmi-log

Thanks, can you give the attached patch a try. This does the same
as the previous one you tested, but then only on the Swanky.

Note I've added:

Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>

To the commit message, I hope that is ok with you, if not let me
know and I will drop it.

Once you can confirm that this version also fixes things I will
submit this version upstream.

Regards,

Hans


--------------1D6A7769062B0A81C24C5809
Content-Type: text/x-patch;
 name="0001-ASoC-intel-cht_bsw_max98090_ti-Add-quirk-for-boards-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-intel-cht_bsw_max98090_ti-Add-quirk-for-boards-.pa";
 filename*1="tch"

From 0413a62e99a00e77392011a07c9392fc132a9b15 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 31 Oct 2018 11:35:52 +0100
Subject: [PATCH v2] ASoC: intel: cht_bsw_max98090_ti: Add quirk for boards
 using pmc_plt_clk_0

Some boards such as the Swanky model Chromebooks use pmc_plt_clk_0 for the
mclk instead of pmc_plt_clk_3.

This commit adds a DMI based quirk for this.

This fixing audio no longer working on these devices after
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
that commit fixes us unnecessary keeping unused clocks on, but in case
of the Swanky that was breaking audio support since we were not using
the right clock in the cht_bsw_max98090_ti machine driver.

Cc: stable@vger.kernel.org
Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 32 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index db6976f4ddaa..9d9f6e41d81c 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -19,6 +19,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -35,6 +36,8 @@
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"HiFi"
 
+#define QUIRK_PMC_PLT_CLK_0				0x01
+
 struct cht_mc_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
@@ -385,11 +388,29 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
 };
 
+static const struct dmi_system_id cht_max98090_quirk_table[] = {
+	{
+		/* Swanky model Chromebook (Toshiba Chromebook 2) */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Swanky"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{}
+};
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	int ret_val = 0;
 	struct cht_mc_private *drv;
+	const char *mclk_name;
+	int quirks = 0;
+
+	dmi_id = dmi_first_match(cht_max98090_quirk_table);
+	if (dmi_id)
+		quirks = (unsigned long)dmi_id->driver_data;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
@@ -411,11 +432,16 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (quirks & QUIRK_PMC_PLT_CLK_0)
+		mclk_name = "pmc_plt_clk_0";
+	else
+		mclk_name = "pmc_plt_clk_3";
+
+	drv->mclk = devm_clk_get(&pdev->dev, mclk_name);
 	if (IS_ERR(drv->mclk)) {
 		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-			PTR_ERR(drv->mclk));
+			"Failed to get MCLK from %s: %ld\n",
+			mclk_name, PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
 	}
 
-- 
2.19.0


--------------1D6A7769062B0A81C24C5809--
