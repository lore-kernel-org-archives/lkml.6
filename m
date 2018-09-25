Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C23520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgIJ3E08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C23520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeIYGwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:52:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIYGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:52:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so2543860pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoPkxBa84f4BHY6i42F2EoyBa1mjEgnzLVsccUGNu4I=;
        b=GgIJ3E08dqyik1/Apy58C/vbwu7js7IAzb94o+s5SBB9ESWZ3JtyJ6ZAE+ikmMhnc1
         JtHAPbCscLbU26aUhpwLagHgK4qnfq1U8BiUncgPbhWB5FKnJ+uasLdlury9H5EbV1io
         QVM73CawEbkSvso0y8EE4DXfnmCavYw8qW/hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoPkxBa84f4BHY6i42F2EoyBa1mjEgnzLVsccUGNu4I=;
        b=oeB7Vk7w0KwF2O8kuwFwBOTY46p3xZ1PKBWCRyTp10B86niILlC27D7wDjeSHHESnU
         Zxyp6lx15lUVdNdX1l5mLjMFnJHtD4yAyAPYh++TtlGdYlJ6L52SC0w8PhuyGBBOOyIw
         M5QhQUKrfV8H4R5bZyim+u7/0hNDl8bMVzthUr4YawQMIRI03grN2CruI2ILhmCbb9vc
         w6M82bbIqKbFYtHwHjbaBPEkH3mS51gk0SPAIQ5ssR+XMqOwUk7o6pjJNnyM4KjLIzww
         cjcHMdZMzqJ8/eDAdtO/4ge4+wJfVnsqGiFWdArVphmI4Fu7B/klU0R0HFZhjLYiyZrz
         jNMA==
X-Gm-Message-State: ABuFfohKkpEw39ZMrXgWu2ILCCLlHkEuvSwmgR8vY5shk8nsvtCZZ9W5
        Hq7JNNvkW+NckUCKCfFbkOfryE+ZXU9wGg==
X-Google-Smtp-Source: ACcGV622l8W5HWjG2aL+3KuhArRehUWtErtPPpBR98PnluuhvuS67EYD6p9yi/VdHnH1pQqMn13uuQ==
X-Received: by 2002:a63:a012:: with SMTP id r18-v6mr1031581pge.166.1537836444635;
        Mon, 24 Sep 2018 17:47:24 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id w23-v6sm582401pgi.18.2018.09.24.17.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 17:47:24 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_ops
Date:   Mon, 24 Sep 2018 17:47:11 -0700
Message-Id: <20180925004711.99422-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbols 'dummy_dma_ops' is declared with different data types by
sound/soc/soc-utils.c and arch/arm64/include/asm/dma-mapping.h. This
leads to conflicts when soc-utils.c (indirectly) includes dma-mapping.h:

sound/soc/soc-utils.c:282:33: error: conflicting types for 'dummy_dma_ops'
  static const struct snd_pcm_ops dummy_dma_ops = {
                                  ^
...
arch/arm64/include/asm/dma-mapping.h:27:33: note: previous declaration of 'dummy_dma_ops' was here
  extern const struct dma_map_ops dummy_dma_ops;
                                  ^

Rename the symbol in soc-utils.c to 'snd_dummy_ops' to avoid the conflict.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e0c93496c0cd..ab44133bc0bf 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops snd_dummy_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
 static const struct snd_soc_component_driver dummy_platform = {
-	.ops = &dummy_dma_ops,
+	.ops = &snd_dummy_ops,
 };
 
 static const struct snd_soc_component_driver dummy_codec = {
-- 
2.19.0.605.g01d371f741-goog

