Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3FC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06502063F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWGTla8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfAOHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:53:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32999 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfAOHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:53:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so920469plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AEvLBlZn/8mftg4VajuyVnyyVBSF5IJc0mJx1Fn5t0c=;
        b=PWGTla8xPXHZJhFLEVc9niJ+2Y0vhunlWfEtSRRf0qSvZsrk4vGOPKU8et9lXEm1LK
         vJFGBEiho6XLF6aBtpR8XyRge9bNVDVbgzWimmGMJpgxnux8wngnmuDXqcLuDqaXywRt
         Ny4WtHmxE4ET3qp3wtpSFInOLiAhM8uXDQ1O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AEvLBlZn/8mftg4VajuyVnyyVBSF5IJc0mJx1Fn5t0c=;
        b=sYUja/Su0VM4L57lYTUq6nNavccKFs+a16+8nIkbj8m5TbUnNuIUDrcOdtg07Ts3kw
         vfYd5DosImOGrItAyXTZQ0sdO/LUC5USd1kj68nhkf/zlMpoaRdh1ZHuL9WCzKW9+MEF
         RE8ImQ407ewtD9Rdj6cp0CEkdrue+IBDbqbDRjG9xGsUymvpIr5J8FH7Ajir6BhjyY7x
         s/Q5zors+h/iKi40chMLoVbMkxtYpfeGdp31csb3INdvjAojIEcCGjqNkp5ShrGb2BJu
         VAmmlVC+NECcz+29oOLhirrUdKqIPqpsqGkzw8KZncw+aOOpBgcGrrKqtKDgj5k9BL7j
         Ez7g==
X-Gm-Message-State: AJcUukdcKfijaGeO65vLJtqbPUzkZN95Jc04q+E/W+dWCzg8+bACOQbx
        10WiCV8EBHzPezdM6B+3hgRhJw==
X-Google-Smtp-Source: ALg8bN5HAHJ4nC81J1jZq7P1t7jdUyPGUqgE+w6O5qWtIui/5u7arhTnZs2ilkQ7bOjUUOdYIJkDfg==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr2812113pla.66.1547538821635;
        Mon, 14 Jan 2019 23:53:41 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g3sm4340093pfe.37.2019.01.14.23.53.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 23:53:40 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, neo.hou@unisoc.com, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpio: sprd: Fix incorrect irq type setting for the async EIC
Date:   Tue, 15 Jan 2019 15:52:59 +0800
Message-Id: <3dd0a29b2f42d41ddfa5b30b68926eb58ebfc3a9.1547538574.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
References: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
In-Reply-To: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
References: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neo Hou <neo.hou@unisoc.com>

When setting async EIC as IRQ_TYPE_EDGE_BOTH type, we missed to set the
SPRD_EIC_ASYNC_INTMODE register to 0, which means detecting edge signals.

Thus this patch fixes the issue.

Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

