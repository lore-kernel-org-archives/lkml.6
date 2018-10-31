Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF6AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B0620821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCz3p/z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJaS2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:28:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeJaS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:28:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id 74-v6so7432704wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i4hHSGsmWMk6v8HT5bX88V/ev/elSNXdtghM/lZz0Hw=;
        b=ZCz3p/z2iHtuFqhtgamPJy1ulsidAsb59E3JNxE9+0WQI4gv/9r/qXMVaMrIGt+ca5
         fqpSqSCoouzTl1oVvuPjPRCl/mz9hZ/MCBvUyvAIyHZxHPBcbe4L7wXNGm16J/yU1fVK
         hf3h/QR7uGUWjmgCZ+tfFP+NuvKkVgm5y+x94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i4hHSGsmWMk6v8HT5bX88V/ev/elSNXdtghM/lZz0Hw=;
        b=HVXZEHXv+wFtty/SJvyS1mM18+96sd0ZhkbOdAL9f740XNL/fsxQZQRIvxQGQ9KWFI
         dgKVIVA0Xm0Mwa6JlZgcbPrIbda4oJAwatSqSDHVyEmZ8lDQRm79ff6tAVNxqmiYo3pz
         Wz1jS+f3EpeFrCE+tZyKkUpW0myaZRNd1F8Ji9Rlc1iQjFqCldQkgRNY5iaU0e7aHqFx
         MBuFluoltBj3scqQCrOPrSHuLiWLe2FIFfg4Rq3f/7JSISpDwcF7QOIs2j+LRRQsYgk/
         rzuQDxviU7qxJsgm19aMue2n+h/JUy6WA1lRYxYZ7a7EM5DeCSeJBlQ+8ZkviAStjSRy
         iEZg==
X-Gm-Message-State: AGRZ1gLMt0+uRm6GgKpPWGSp4R8wPmgJDcNUTlVdZPRwZ/GlOmErqqZD
        c3s2JWXGGavCikZtAqMmptlnaA==
X-Google-Smtp-Source: AJdET5djPhbr+P5/E3mygRyq6IGpWVMkxCxV6Sp6TZ52UqMmR2wV5fg5nPmjb+ZzSjh7K6GnojHwAA==
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr2046516wrq.294.1540978248230;
        Wed, 31 Oct 2018 02:30:48 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1086:999:fd1b:8629:a7fc:68b])
        by smtp.gmail.com with ESMTPSA id w14-v6sm10737377wrt.73.2018.10.31.02.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 02:30:47 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/5] Add support of STM32 hwspinlock
Date:   Wed, 31 Oct 2018 10:30:27 +0100
Message-Id: <20181031093032.20386-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds the support of the hardware semaphore block for stm32mp1 SoC.
The last patch isn't related to the hardware itself but propose a way to test
hwspinlocks.

Benjamin Gaignard (5):
  dt-bindings: hwlock: Document STM32 hwspinlock bindings
  hwspinlock: add STM32 hwspinlock device
  ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
  ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
  hwspinlock: Add test module

 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 ++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
 drivers/hwspinlock/Kconfig                         |  18 +++
 drivers/hwspinlock/Makefile                        |   2 +
 drivers/hwspinlock/hwspinlock_test.c               | 132 ++++++++++++++++++
 drivers/hwspinlock/stm32_hwspinlock.c              | 147 +++++++++++++++++++++
 7 files changed, 335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 drivers/hwspinlock/hwspinlock_test.c
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c

-- 
2.15.0

