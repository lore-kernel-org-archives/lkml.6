Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1705C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9225C2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffwTvcVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9225C2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeLJEgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:36:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeLJEgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:36:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so4615979plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 20:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=te3vyxmSC7VVBcHYAA6gnyUrJAXeb/N2qictammHc7A=;
        b=ffwTvcVj/e3A0kGLDuWKmVYqed00CT+G4rp2aOK/WiO7pLWu/rUNSdRmk3mzgzyy2W
         CXLdM5G7wqHWl1s5HcD54Oqd39TTxWYSBlgxqQXBe5FSFP2QStqip1C+fuSSwbbJWrdl
         ve/NhbDaU6Z5VeejV5oiVz2ec0tuZXmQr24EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=te3vyxmSC7VVBcHYAA6gnyUrJAXeb/N2qictammHc7A=;
        b=Sn5NkdnAudkaOB1LMNWyLBw2I5wPmhy+43d9fg8r8XIa8dphDoBpknBKGiwMbb3tzw
         TjVsXw1F16Ua5VuZd7AHdzxlx+a+dHl/Ovvx+Uo0wfxaxPbBlvoZF9oLGCgBsrbGJqfk
         qxHzke20gYSyHhlLkaCNL+7ez9vs8foq+IulS9k55Ha6nnc1jeLBQlnY8ZCBKarQkgNu
         py1gEcK2adMSfLPGCeoRWE+y+BKKHNdj5PGyl9j7Nv7KfluYcXEEPoaacLspaobP7tj+
         Z3LByFOYmGVvWhgrp4rX6xAZZ3s9zrBFwR8/LwnGBH8+vbYHErSefvhMdLKnX3qX+ihj
         ZE5A==
X-Gm-Message-State: AA+aEWbjR4eES56DxaXGZlgx54JFIIicyhPHJyXETLnoTU1XejfLRPOO
        eBOWZ2CyN6QCYO7w3C2r1wXnaA==
X-Google-Smtp-Source: AFSGD/XXxm/NmiKSpMjQIZF66RydT50IJ0jMw3AwDd+2Yk8DD7VkXBrxvsSq7WitxeiZUMSFfGo9dg==
X-Received: by 2002:a17:902:b118:: with SMTP id q24mr10939845plr.209.1544416578920;
        Sun, 09 Dec 2018 20:36:18 -0800 (PST)
Received: from zhuohao-z440.tpe.corp.google.com ([2401:fa00:1:10:e25c:13cd:9607:cc7f])
        by smtp.gmail.com with ESMTPSA id y29sm12455220pga.59.2018.12.09.20.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 20:36:18 -0800 (PST)
From:   Zhuohao Lee <zhuohao@chromium.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Max Chang <changmax@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Zhuohao Lee <zhuohao@chromium.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98927: fix the audio jack button remapping
Date:   Mon, 10 Dec 2018 12:32:13 +0800
Message-Id: <20181210043213.243881-1-zhuohao@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the da7219 spec, the button A, B, C and D are remapped to
0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND.

Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
Signed-off-by: Max Chang  <changmax@chromium.org>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 3fa1c3ca6d37..d3531f0eb357 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	jack = &ctx->kabylake_headset;
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
 
 	da7219_aad_jack_det(component, &ctx->kabylake_headset);
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

