Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF0ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108812147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvTfzESZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108812147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIQNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:51:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39832 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeIQNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:51:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so8482573wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KQnjTwSJHg0TN3FwzHWrSFaSSGp8r2Omj4sGkkxcPKs=;
        b=NvTfzESZUDXM/J8xtVw2UoMQWGngkmtJtlzooViq1Ka4dCyNg4SX6Z57DrSl4mEJRZ
         HCQQt0EBCr70NT99WIvNXy8IHjFs0nXkvJJ7Ed6fjAzdVDKsgeYgICHU6UjFXneSijtJ
         GySlvH3yKS7qV8J72rut14vMjgiZbqDo6J8s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KQnjTwSJHg0TN3FwzHWrSFaSSGp8r2Omj4sGkkxcPKs=;
        b=n4hR8N5OLn157xim6knl4KjB5n/kpKU8MKz08wfH4wX7J5E8Bw4DISZUwKqXxgwCQ8
         ZAq6Y61XJPKc8pm3jURk2xFOevj1ARFElp+Hrl2znpRO0piimIW0g3jLVa3d6y0x/zfP
         xlNKZ0Umwys8fptaRQOE1bWs7eiqFu3gTnmzz3NPcYy2anJf5y4zWi/lqWSw1P1W9Lbt
         lakEMYqcWflllPhWnM31L1S/dq56NkKp5VRXVKPCE4s6YbGT7XPBuqIo98DHpDrguBIu
         0DEenl9JXkAc7f6Q3kBlaSgZrcHUpZU9aoyOZcaCazFpJ2nJMdWqWryZa64TtcHYMERE
         hWFQ==
X-Gm-Message-State: APzg51Bv/3WNlDkGEBtAagrCfNXzU8bws9sN4q2zej6cHoHw/NkPyQFi
        stxyMgj8uG3JKAAroFB278LOKg==
X-Google-Smtp-Source: ANB0Vdawy0a27SBp1hNkGdmIShrG/O1kPE5tCLoCsJenwtZE/LTkj59InULou8g90dBceNhQgp+gZQ==
X-Received: by 2002:a7b:c143:: with SMTP id z3-v6mr10608533wmi.105.1537172686058;
        Mon, 17 Sep 2018 01:24:46 -0700 (PDT)
Received: from lmecxl0911.lme.st.com (lya72-2-88-175-155-153.fbx.proxad.net. [88.175.155.153])
        by smtp.gmail.com with ESMTPSA id i4-v6sm10678710wrs.85.2018.09.17.01.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 01:24:45 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] MAINTAINERS: Update stm32 entry
Date:   Mon, 17 Sep 2018 10:24:41 +0200
Message-Id: <20180917082441.31979-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mailing list for stm32 architecture.
Add "stm" pattern to not miss some drivers/directories when asking for maintainers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..237e7012f3ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2085,10 +2085,12 @@ F:	include/linux/remoteproc/st_slim_rproc.h
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
 M:	Alexandre Torgue <alexandre.torgue@st.com>
+L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
 N:	stm32
+N:	stm
 F:	arch/arm/boot/dts/stm32*
 F:	arch/arm/mach-stm32/
 F:	drivers/clocksource/armv7m_systick.c
-- 
2.15.0

