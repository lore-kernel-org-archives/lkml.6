Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875C720891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THFL7OKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875C720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbeG0KWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:22:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35535 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0KWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:22:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so2051808plq.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HFJoAeEclLfp/RuuuQufAkXi8dKMns+XQRSmDVIcCF4=;
        b=THFL7OKrtIDqCud9eAVUb/XK3euV1STiFVTJa8rn7iquN1XSpw+UujWz0Wb9tRGOGd
         nparnOR3Y1LOysxrtzuPG+cTnHgWqduk2LzrMBNbPXg8EJHx7gA0Rrs9HMZeG/NvXIEH
         vXrK/qYZMlAhLGtN9z650z1XJu8Bz/LYRGCx2+wbQw8Ra8uLxSeVNQstCKN/jbEj/NV2
         9kril6RsGEnT7MYhID00uXmojGavswfoE76VoqlrVAJ6SX8MAoPHaQsIlY3WXmfs8ovC
         qqztX6sNFu6hi7xtQEmKpQJ3ctwRRI077Nidyh9FhI1DEN14qhc+98TESpVv6oL17rDm
         FzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HFJoAeEclLfp/RuuuQufAkXi8dKMns+XQRSmDVIcCF4=;
        b=IS+p+eMT9QTL7zohMu1t8xCgaIAeyf/VETYdFOoPO02bGUuFx6hf7H15QYZNQnt7WU
         TvQb+no0+Ii1uQ2PyF9DSNFC+socaXbamCJNYnZ8+tQys1NdWpj0UNn+hbYAYhq0ryGu
         VogPcE/VDcFc5iwepi1WqeY+wZJpRuVPJp3EtfublRzCEv+IemJ+7PnYpUyL7cr4dI3x
         MdQR2EX69sEK2db0eUICcvWpIMYt2S2IH7Zr4eobljJSZSiv/o/f8CrKd8zD8c7V8zhw
         XEJ3X6gjjvfSEQnH0jNYDPrYRD0A79FQgpP4HMbIX3d+s46ADLFOZ+AidVlDEKSh+MUr
         AEVg==
X-Gm-Message-State: AOUpUlHgJCNHxCZi/Qitv0EC0453CpN1xmIKTnAZ8NwQdrFbbDAr3wYz
        0XJRQH+Oyy1glbqWKJ4bbV6QBLmzp64=
X-Google-Smtp-Source: AAOMgpd2TAICoPfJhFGTW420olIhSjmfKJKfzSjHB8WjrIjxWwxXPKgxHE4fUVdNwTrXPRJqjQX7sQ==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr5211612plb.298.1532682109536;
        Fri, 27 Jul 2018 02:01:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id q25-v6sm6442270pfk.96.2018.07.27.02.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:01:49 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: pci: cthw20k2: Replace mdelay() with msleep() and usleep_range()
Date:   Fri, 27 Jul 2018 17:01:43 +0800
Message-Id: <20180727090143.18686-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hw_pll_init(), hw_dac_stop(), hw_dac_start() and hw_adc_init() 
are never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/ctxfi/cthw20k2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index b866d6b2c923..3c966fafc754 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -1316,12 +1316,12 @@ static int hw_pll_init(struct hw *hw, unsigned int rsr)
 	set_field(&pllctl, PLLCTL_FD, 48000 == rsr ? 16 - 4 : 147 - 4);
 	set_field(&pllctl, PLLCTL_RD, 48000 == rsr ? 1 - 1 : 10 - 1);
 	hw_write_20kx(hw, PLL_CTL, pllctl);
-	mdelay(40);
+	msleep(40);
 
 	pllctl = hw_read_20kx(hw, PLL_CTL);
 	set_field(&pllctl, PLLCTL_FD, 48000 == rsr ? 16 - 2 : 147 - 2);
 	hw_write_20kx(hw, PLL_CTL, pllctl);
-	mdelay(40);
+	msleep(40);
 
 	for (i = 0; i < 1000; i++) {
 		pllstat = hw_read_20kx(hw, PLL_STAT);
@@ -1584,7 +1584,7 @@ static void hw_dac_stop(struct hw *hw)
 	data = hw_read_20kx(hw, GPIO_DATA);
 	data &= 0xFFFFFFFD;
 	hw_write_20kx(hw, GPIO_DATA, data);
-	mdelay(10);
+	usleep_range(10000, 11000);
 }
 
 static void hw_dac_start(struct hw *hw)
@@ -1593,7 +1593,7 @@ static void hw_dac_start(struct hw *hw)
 	data = hw_read_20kx(hw, GPIO_DATA);
 	data |= 0x2;
 	hw_write_20kx(hw, GPIO_DATA, data);
-	mdelay(50);
+	msleep(50);
 }
 
 static void hw_dac_reset(struct hw *hw)
@@ -1864,11 +1864,11 @@ static int hw_adc_init(struct hw *hw, const struct adc_conf *info)
 		hw_write_20kx(hw, GPIO_DATA, data);
 	}
 
-	mdelay(10);
+	usleep_range(10000, 11000);
 	/* Return the ADC to normal operation. */
 	data |= (0x1 << 15);
 	hw_write_20kx(hw, GPIO_DATA, data);
-	mdelay(50);
+	msleep(50);
 
 	/* I2C write to register offset 0x0B to set ADC LRCLK polarity */
 	/* invert bit, interface format to I2S, word length to 24-bit, */
-- 
2.17.0

