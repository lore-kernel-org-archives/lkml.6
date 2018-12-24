Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79769C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44432218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U72NF7bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbeLXWBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so12577021wrw.1;
        Mon, 24 Dec 2018 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udGuEX53oRB5GV/3f+gVr+zAATNu7u19AoIlIUxdTxs=;
        b=U72NF7bm7zVcZBnH2rCG7LhaNv6Wl3/T8yT8P8uvpwnHTjTZnlFKcgrKE8BJ7HguUX
         c7pel5om9TouzlgT31UTRUiYtZeoFkQlLz8xDCMPjz7l+e5U8S9y5+P4/KMWICArT0EA
         MeN8UlkaiBQZ1Y4T9yWJoKoICesLXMwSL5AXrBf5FDFpws/fkD6zcjSXISemTIMC55gy
         DlnYUCbmdqF4wkxJAFtZgaBawkGbdRdORO3FkiWBXVuEQG225eSSAp1/aPntilr4gFLB
         UAC+W+faQgsDbYNkFGbmuFjWv7kQi28NWjtkAV8RYbKVXg9rTQfnmDBT8n9UO9pDawTS
         ujQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udGuEX53oRB5GV/3f+gVr+zAATNu7u19AoIlIUxdTxs=;
        b=W1VkOztOMP+t2ehxnRJmrB+ziOjHDVYWthhV9xy2cWw3IDEaePaTq6T4+IN9hM79Kx
         yTDHv22KKvciM49FaLfj0rk8X3V4aZSV+is3JrPnP4e50J2LtNcwhezqg7zMMq7T9MN0
         hpwbAaO5iMVjjIqEJLPT1P8jmlIEuvxcwbyUmoqJYo/U+Hx9+qfhykiuVzXzSpzB6wvF
         y66IiGV9aq4fvI/miNkfy3hhocEE/vSeBeP7GUF+WiJ0h4iuIsWL6n7np9FzOuF6yO3H
         BvwM3u2l+FoWS6890F+p6quIZl0Lfzngl2vVbQ6Z77gX1qPv1eQjTO3CLVpuIzj0YNZ4
         PJrg==
X-Gm-Message-State: AJcUukdVYWYuaX/u0v8AlmpuE71uDwL0rOdv0MID2gTApcNrJeqP3h1g
        dg4fZR75JBspJmWjnGF1jKw=
X-Google-Smtp-Source: ALg8bN6YCAr6jpBroycEmEomnBH6mIaMhIowdt8+KhGh1DaMYHkKnkplkuJQZbKV+nDKLdUMVhwvZg==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr12680550wrs.75.1545688859102;
        Mon, 24 Dec 2018 14:00:59 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:00:58 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 04/14] spi: fix typo in SPI_STM32 help text
Date:   Mon, 24 Dec 2018 23:00:30 +0100
Message-Id: <1545688840-23992-5-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Fix typo from STMicroelectonics to STMicroelectronics.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f89cb1..ceb6b7e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -665,7 +665,7 @@ config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	  SPI driver for STMicroelectonics STM32 SoCs.
+	  SPI driver for STMicroelectronics STM32 SoCs.
 
 	  STM32 SPI controller supports DMA and PIO modes. When DMA
 	  is not available, the driver automatically falls back to
-- 
2.7.4

