Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668C523C29
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5exfV01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668C523C29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934255AbeFVBwe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:52:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45276 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbeFVBwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:52:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so2223398pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrlY6cF/D9ECGN/lcBiooNvp63H0HkRywHeY06feTm4=;
        b=Q5exfV01tMEvE/MUi/G7Pw6o2ijN5J/mCrPkaY7T1aHXDC1fl46EgmVRvVJIK0/ypB
         diQI+C0wDzHwaBAQvtf0VozaIDNMUm2iXcqp4FoE/zH3pdVADyuDS9PeUEdWol+bswOU
         vgKp4QFcLrYTauzLxClKW5XhyVsXtAasPBTuDfnnV0qKaPOG5z5pmyxDQmNtXAOPd7Nj
         6RXSLzCKklfFweiV+wLqmiadWIrSy1CLS2DBljud5SfAeW1SkAA32G9ITFqRuPMR5GIN
         o7p2IIjstk8lgHN6dW2wzuaGgf2w9q3RhVDi3oIG4TOEaOWCzcBuyhIC/oInrhuQOVeV
         bRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XrlY6cF/D9ECGN/lcBiooNvp63H0HkRywHeY06feTm4=;
        b=J8jlfB/aEfF1Y1+wVdpxnGChWzO9l/MBtI4SaRw31NXBKCPTCqwwGUrWdHLR/Wi5mu
         StsKMF+f/o35OD23w97gaxbmTFUciadh2c8rA1fJgFJbI4zYmLgBqg3EXI41dqwmWFbB
         aFis+cyIvCecKkGZ6BskPyQPfPoSUY1rfnaLHX6OzFa4Itet9Sl8v36VOnHJ+P5UzQ3A
         lmKjsYD5H5vhUJhTo05o0oJM83mLS+ASrH8bzMCP7a00jZhG+aEBZ698ca62oMmBZAV4
         bGoujOyg1dstpdvV1pqQlptxg02xGvBHPg/0Og9jgLC0TC2gJt7p4Lu1Yn75vkXu79Kn
         1azw==
X-Gm-Message-State: APt69E3XcZRgwXb02C2UOP261zEtGyXMXr5IQBsLg+I/e+bV0b82BStK
        Tcv1rzMtzBJaNa/TXDzhcrCGmFMa
X-Google-Smtp-Source: ADUXVKIDqflEVp2PvUcF/vVlLm59Qe4Iu2fiUznS4xxXCS/oXF6zz4kjAlQrdDFT6bd6h2wCfxlfmA==
X-Received: by 2002:a62:bd03:: with SMTP id a3-v6mr29575773pff.138.1529632352752;
        Thu, 21 Jun 2018 18:52:32 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id u1-v6sm9064024pfn.59.2018.06.21.18.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 18:52:32 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: gpio_flash: add error handling for ioremap_nocache
Date:   Fri, 22 Jun 2018 09:52:20 +0800
Message-Id: <1529632343-70907-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528773302-37265-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528773302-37265-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ioremap_nocache fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling ioremap_nocache.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Move the test just after the ioremap_nocache() call.
---
 drivers/mtd/maps/gpio-addr-flash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 385305e..9d97236 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -239,6 +239,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
 	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
+	if (!state->map.virt)
+		return -ENOMEM;
+
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
 
-- 
2.7.4

