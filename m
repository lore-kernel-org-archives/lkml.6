Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E1C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F9E27906
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XdVvv8K9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F9E27906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936758AbeF2SvZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:51:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45412 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936717AbeF2SvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:51:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so4355164pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=V/ZfJVZhF6dv8FNKwlwqRUc+ojoCtaZDQBWtteUwh3s=;
        b=XdVvv8K95TJhZiMbixlP8cLH7fGSXHX+6d/+lU9UxcdmEtgXf+q0SRHZI1ohnWtkJw
         5RgY5tNqqZ0svKDnNddnhrR5DQQnwKvxjGQD+gQ2tBh0Z0CSaNXBaKe28kcFoIaQNd12
         XS/TdJE/e9XcS9gHYg2601EJVPWnpuDZM+2y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=V/ZfJVZhF6dv8FNKwlwqRUc+ojoCtaZDQBWtteUwh3s=;
        b=VHMFbBqcB2TtPizgntGe5ZrKBpfp9SimTXHjkTfmFoukDY0VFunRcvVGasVbc6SI0Q
         V+v/3DKI6HwJOVwh18mlLrWMwnwVt/JSM5GI6i2jcTxg2OrEBbGzqtgknQ3nI6BKerlB
         Srws77fAd3vPC1mYnVlvE4gnJ0uH/f1IAyS50WYOAArXOIBUE+V28Qe/11ooDKjHIiRO
         +eNjpswP/6VpelDeVdUTSDfkC0lGPKoA2Y7elBsjQTz6lOZSCGEZHQTOrc6OpT0v7zDp
         RLMTfWMhJbgB2noQYIphfVcPsNYCq4uG9CdyDIMlzBAsL55a36oYBTwmA16Gz/3WYKYO
         MN9w==
X-Gm-Message-State: APt69E18ZRvIoDqq7yx6lK/8duOhuqzprTF2gqcDuLNGOpvWIeqpgd9Z
        dkKAT8wvgbPE12w57W+NDl+x0A==
X-Google-Smtp-Source: AAOMgpfYPT72+A1Zq0N0ymJVWBuKAHMxdoXtxl4ttz+q5OWnxKctOBNDB9NOyQ2mLJ5n1A5gEn4iUQ==
X-Received: by 2002:a62:f50b:: with SMTP id n11-v6mr5732417pfh.120.1530298269397;
        Fri, 29 Jun 2018 11:51:09 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r79-v6sm20782690pfk.153.2018.06.29.11.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:51:08 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:51:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma: ste_dma40: Remove VLA usage
Message-ID: <20180629185107.GA37488@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a pre-allocated scratch register space, set up with
all other other allocations.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/ste_dma40.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 1bc149af990e..f4edfc56f34e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -555,6 +555,7 @@ struct d40_gen_dmac {
  * @reg_val_backup_v4: Backup of registers that only exits on dma40 v3 and
  * later
  * @reg_val_backup_chan: Backup data for standard channel parameter registers.
+ * @regs_interrupt: Scratch space for registers during interrupt.
  * @gcc_pwr_off_mask: Mask to maintain the channels that can be turned off.
  * @gen_dmac: the struct for generic registers values to represent u8500/8540
  * DMA controller
@@ -592,6 +593,7 @@ struct d40_base {
 	u32				  reg_val_backup[BACKUP_REGS_SZ];
 	u32				  reg_val_backup_v4[BACKUP_REGS_SZ_MAX];
 	u32				 *reg_val_backup_chan;
+	u32				 *regs_interrupt;
 	u16				  gcc_pwr_off_mask;
 	struct d40_gen_dmac		  gen_dmac;
 };
@@ -1637,7 +1639,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 	struct d40_chan *d40c;
 	unsigned long flags;
 	struct d40_base *base = data;
-	u32 regs[base->gen_dmac.il_size];
+	u32 *regs = base->regs_interrupt;
 	struct d40_interrupt_lookup *il = base->gen_dmac.il;
 	u32 il_size = base->gen_dmac.il_size;
 
@@ -3258,13 +3260,22 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	if (!base->lcla_pool.alloc_map)
 		goto free_backup_chan;
 
+	base->regs_interrupt = kmalloc_array(base->gen_dmac.il_size,
+					     sizeof(*base->regs_interrupt),
+					     GFP_KERNEL);
+	if (!base->regs_interrupt)
+		goto free_map;
+
 	base->desc_slab = kmem_cache_create(D40_NAME, sizeof(struct d40_desc),
 					    0, SLAB_HWCACHE_ALIGN,
 					    NULL);
 	if (base->desc_slab == NULL)
-		goto free_map;
+		goto free_regs;
+
 
 	return base;
+ free_regs:
+	kfree(base->regs_interrupt);
  free_map:
 	kfree(base->lcla_pool.alloc_map);
  free_backup_chan:
-- 
2.17.1


-- 
Kees Cook
Pixel Security
