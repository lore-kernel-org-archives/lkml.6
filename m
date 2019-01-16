Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C10C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DD920866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2E8A9Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfAPFG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:06:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38916 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfAPFG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:06:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so2441774pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9ynBcaxK3CJHYg4HRNeVDHHJ2xqNFOYZq7LdDnGeVDc=;
        b=S2E8A9Urg+gVERs/SW0nSzv56nv0l/wNjzEAYfluqoc8s9ZBEpy3rF+eoAGOK3eBJN
         mFaN8VX18vhHqBQIRFKMCt5d9DBFhRyDkMs+M7C4CMPcELkckG6fm+TvgcFYCY2/sM7+
         ghQbKed+NYnG0/KBPBdcHFpVyztW4lNoq+3gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9ynBcaxK3CJHYg4HRNeVDHHJ2xqNFOYZq7LdDnGeVDc=;
        b=QVG23ca2QejVoQndrUwDQ0u/6/ccgR9UoYoKtuBJF2DdbThqjYaXkuMfQVcKZqXL5Y
         20RbMKdoAfsMkM4rfsmj+q4BsrhoqxE2ajDQnQNsoofCwKQvSjIXB2zh4pqg3hxkABHK
         wQbU7X9cTPBfufTyaB+oA8NQmUuBhZBYIevS/zSOguFtD4GfZQkFGCJKIfnT1OGumZTa
         4qoxCZW+dyhvRPuQ/MX8R5/9W4BkXN+gTfWWO2JjA6KT8AlrK66FvrwgVq81lV7+Ikiy
         /aZypGs6PH+EyM4vYH6b0tyEt1pQLKIeBL3a7aqVyNgLYegACz5Wbte6dqd29xw70fUQ
         dfXw==
X-Gm-Message-State: AJcUukdMNR71Y+gdUNW2GRHpIolEI3OZGuwesxnNX9/dAwcTw7jZJ6wP
        628pJHiQxMSasGERidS6P8L6iQ==
X-Google-Smtp-Source: ALg8bN5XFB0qtjONVecpdYJ3HHnPjZSIhGqW4AP7En++61VYzoT4TXGTrC92RiivONLKfZze7GSGZw==
X-Received: by 2002:a63:5455:: with SMTP id e21mr7190501pgm.316.1547615216267;
        Tue, 15 Jan 2019 21:06:56 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m20sm4784888pgv.93.2019.01.15.21.06.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 21:06:55 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        neo.hou@unisoc.com, broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpio: sprd: Fix incorrect irq type setting for the async EIC
Date:   Wed, 16 Jan 2019 13:06:14 +0800
Message-Id: <46524f86b327de62753be9046ef217a66d674b33.1547615070.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
References: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
In-Reply-To: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
References: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neo Hou <neo.hou@unisoc.com>

When setting async EIC as IRQ_TYPE_EDGE_BOTH type, we missed to set the
SPRD_EIC_ASYNC_INTMODE register to 0, which means detecting edge signals.

Thus this patch fixes the issue.

Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add fix tag and CC stable.
---
 drivers/gpio/gpio-eic-sprd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 257df59..e41223c 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -379,6 +379,7 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
-- 
1.7.9.5

