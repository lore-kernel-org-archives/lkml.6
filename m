Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59F3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB9820C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nER1OViF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB9820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeIZASM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:18:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45081 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:18:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so7329565pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvRiYuhYnuR651Mppw8za9+8AfZcjBxds0GLMWI0OQ0=;
        b=nER1OViF7ZLXcVC2oeSBoC5Ntqrb6s0HAzfPhp1Qwg0goF8tuUirwftzYnN3xD+rgA
         JaTz1GO/RABV5k+8XlvILiQZVOiANaVkGmnq/An+p36UUvTCwi3o6rlkwpivn4KuF3XG
         WzO1t7436PO5zR70jGEhoSX3XekFXf4e6T1v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvRiYuhYnuR651Mppw8za9+8AfZcjBxds0GLMWI0OQ0=;
        b=IkJGdXLhHm6XelU8x7QPl/cOn2qD3V0wLHbBy5V+kX4UfTCozHq8QKvPO9lt1mPqAX
         Z+rSckGINF2nz/af2Zhm6m4JoVaF0SqdpooA1Em9kQNzbfxw9F0nNqXxn5Fw5cacHqFU
         y1m1zXJZZLQFV8o55AonK+d+vFf0BuFPXKtWp5q0BIVDtaJLzKZZsY37jcXlw6uV4CPh
         yKmfNMwXAlXVUsQpR9WxEU6Vq05Mpz9QauVbESL5ozwWSO638nNbdZU78GNzmaiVIEh8
         EYYOWE69J5fL6S07AaywTYoIhmi2mOdL688akaeYSMMwJM1XgLNpAqac8FZQCiGRJKaO
         e5NQ==
X-Gm-Message-State: ABuFfoiUUi0tkiaDy1U6Im8AOH9wMTVEtXTZ71v9kn9sByAZ2g7Si8KD
        LTeit1z0A2oY4oqiETwfMUjbysQMUkPfLw==
X-Google-Smtp-Source: ACcGV62SyXvH/BV6YgJF22vxmUmTU6K5cl/7SX8T+EoT5tKFdR05ICg/jOLtxg/sa5rj3nIwMrdv1Q==
X-Received: by 2002:a65:4d42:: with SMTP id j2-v6mr2105267pgt.232.1537898969395;
        Tue, 25 Sep 2018 11:09:29 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z20-v6sm4473443pfd.99.2018.09.25.11.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:09:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops
Date:   Tue, 25 Sep 2018 11:09:14 -0700
Message-Id: <20180925180914.193244-1-mka@chromium.org>
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

Rename the symbol in soc-utils.c to 'snd_dummy_dma_ops' to avoid the
conflict.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- use 'snd_dummy_dma_ops' instead of 'snd_dummy_ops'
---
 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e0c93496c0cd..e3b9dd634c6d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops snd_dummy_dma_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
 static const struct snd_soc_component_driver dummy_platform = {
-	.ops = &dummy_dma_ops,
+	.ops = &snd_dummy_dma_ops,
 };
 
 static const struct snd_soc_component_driver dummy_codec = {
-- 
2.19.0.605.g01d371f741-goog

