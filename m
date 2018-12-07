Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F04C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2D20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vlhhll3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA2D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLGJGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:06:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44234 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:06:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so1436640pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0iDGOJbCZroxMtJ3hiLe5dpdBlJPtu8jhQdax+5mZw=;
        b=Vlhhll3HUEjel2bZ/kA6HMS7iv5xfhXaJJlflmsCmEsZ/UE0tajv6js2eUx30KNNYM
         ixDOb5bdpR96+AUb7eX1apStawqJqtwnfOrMQ04S5D37Gvs2HluUQnifDWYBHZVeXuEC
         f9lyJdi4+n7/QnH5LznpRDlawHnQQZAj6pAOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0iDGOJbCZroxMtJ3hiLe5dpdBlJPtu8jhQdax+5mZw=;
        b=KK6eoaDViZLznY/nNgp3ABEFYbILNKncH45s5Mkab1VBaxUBoD0oXlsmkoxclox80M
         TE5NlwpTi0V5E1GgSUZnW+QbfldPgAO0LISHKADfTt3ViWASITG9qcH4bzwd4hdoWF7F
         lYRDGj+4t+5Lr8nwS8VcA+3+4drqm23txoNM5oCMZBzgTHT70yD0ChT2P/Xid3DH/JIG
         bmBvwokAuLFbrI3Dqqn+lPHGUIJh50z3ngOf2woXwgHztO2zyTovKChu7yT6cqtXa85b
         eWouIQtF6GU29OX9LlSKjGLK3sksyG5j6JvmOzFICJiZWwtGeRB6YcmmipDf8OrC5jMj
         rRSQ==
X-Gm-Message-State: AA+aEWaUFcrsV9uFzQtlKINCnFnty5SNw70L+R9oo6v7Viw8oD5pcFPv
        17PBR5ZPtjphLYgKcZsDGlwrlaTblE7T8v+w
X-Google-Smtp-Source: AFSGD/VGD+WTzPL2uh0Zq4iL+0zcz0WgQvFU/Vj6pnp8mREjEEwA3yUTSm9tvKetklGnvY8jP1W7Tg==
X-Received: by 2002:a63:608f:: with SMTP id u137mr1223822pgb.203.1544173561805;
        Fri, 07 Dec 2018 01:06:01 -0800 (PST)
Received: from zhuohao-z440.tpe.corp.google.com ([2401:fa00:1:10:e25c:13cd:9607:cc7f])
        by smtp.gmail.com with ESMTPSA id p67sm4542135pfg.44.2018.12.07.01.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 01:06:01 -0800 (PST)
From:   Zhuohao Lee <zhuohao@chromium.org>
To:     alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Max Chang <changmax@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Zhuohao Lee <zhuohao@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: Intel: kbl_da7219_max98927: fix the audio jack button remapping
Date:   Fri,  7 Dec 2018 17:05:52 +0800
Message-Id: <20181207090552.105205-1-zhuohao@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the da7219 spec, the button A, B, C and D are remapped to
0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND

Change-Id: I67f929f226883bd289cb7beb0a7b23f40e7121e2
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

