Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC70C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9FA223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePyRxlVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9FA223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbeKNAqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:44 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52531 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbeKNAqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:44 -0500
Received: by mail-wm1-f49.google.com with SMTP id r11-v6so12183419wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bbY+0AzP+H3yzuk4q47b0ANkXIlf0xE24RY6DaCQYtA=;
        b=ePyRxlVJITMqp7STi/63B7AW3+0PebDSQeNxXmfy1FFYJg8PH5cBCkNpmG/tRJQiyn
         8F8v/PjaxQWOlMwC8aXa6fcRJhHqh5un5fBWM/j4NN89ASdZu4MZlU1Ft/dXeB2YMwdL
         ztNl+cEFTiok9rFF+zz1s05ZHHzvXxIFfZr0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bbY+0AzP+H3yzuk4q47b0ANkXIlf0xE24RY6DaCQYtA=;
        b=jBAwAZkZZUkgbZIdn8rqSZiuuYfea1dAfv0w70zlB9GPFNINMH1VoZaktAEvdVeHdq
         LwTQQRLNC7Mni1Ahu0feSAUcLaskRCmyXsEhU86MaUJSrf5yQYeAUFinoIkLuAAxqDuc
         ObU6cXMhK19b5UT0X/HeSEt0yXYqkHkfBNdI5Mvin+itJNuGqjNrp4ycb1qLqmme6RhK
         ZUf7VaixEXpoZ8BZvTVneusrP2N08Dn3XvhgDMTTmZzrZ4mnas37C0vdNscmt4Ee9vQA
         30AdXnqAKyKfSNEEpltvTHS0oJqLDMS117QUasUe4kbuXW5HD2Ax1x2ecl7XArjZx4bH
         e5KQ==
X-Gm-Message-State: AGRZ1gJUbHu3iJGSHp6545TbD02rZYW7RJVkXzQ5Hoe4GZuj49YiQI1O
        HslCsYHHsfmll2/lsnZDlX71rg==
X-Google-Smtp-Source: AJdET5eKnAdE58e9AXE8q/u2CG6E/c/NWy78fh2QoRQwb15FLvuvFx5vyWHYJn9es0QOJ9xDn/k2gQ==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr3574811wmf.143.1542120493849;
        Tue, 13 Nov 2018 06:48:13 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id s16sm3292020wrt.77.2018.11.13.06.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 06:48:13 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/3] Make STM32 interrupt controller use hwspinlock
Date:   Tue, 13 Nov 2018 15:48:02 +0100
Message-Id: <20181113144805.1054-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allow to protect STM32 interrupt controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors. 

Benjamin Gaignard (3):
  dt-bindings: interrupt-controller: stm32: Document hwlock properties
  irqchip: stm32: protect configuration registers with hwspinlock
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157

 .../interrupt-controller/st,stm32-exti.txt         |  4 +++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  1 +
 drivers/irqchip/irq-stm32-exti.c                   | 36 ++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.15.0

