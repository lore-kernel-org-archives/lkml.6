Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585B8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2758120861
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfAXRGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:06:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59043 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:06:36 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gmiSL-0001Is-O2; Thu, 24 Jan 2019 17:06:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] ASoC: Intel: bytcht_es8316: make mic_name static, reduces object code size
Date:   Thu, 24 Jan 2019 17:06:21 +0000
Message-Id: <20190124170621.7583-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array mic_name on the stack but instead make
it static. Makes the object code smaller by 28 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  14107	   8832	    224	  23163	   5a7b	bytcht_es8316.o

After:
   text	   data	    bss	    dec	    hex	filename
  14015	   8896	    224	  23135	   5a5f	bytcht_es8316.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index fa9c4cf97686..1364e4e601d8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -437,7 +437,7 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
-	const char * const mic_name[] = { "in1", "in2" };
+	static const char * const mic_name[] = { "in1", "in2" };
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
-- 
2.19.1

