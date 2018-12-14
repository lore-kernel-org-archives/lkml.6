Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8720DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648AC20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqegc8gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeLNPLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:11:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36370 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbeLNPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:11:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so4787973wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2OEhyVYGwNvGpX/TNQZpzfpD5NsrteBRRKArChDs2kg=;
        b=iqegc8gnG9oY1FO5Zo5pNCjRd1E9N7JkmsEs5fd06a2ecUBk1zH4fhsBwpAH1NO94Z
         OJhpX5P64lpJKbUIgkmd+RkqNwBSq+dFLKHD+N9nnhVPGUjT6A+MJT61fAnvvfjonEIk
         f5X51WP8E9nbXb6kzSibmn3MrpYOuUZ/ovJFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2OEhyVYGwNvGpX/TNQZpzfpD5NsrteBRRKArChDs2kg=;
        b=SU04qZAowQjpLTSkhiN4VDtKIQRPXgjOU/Wd7KFm2pOFib1bQi4cAVoV0Q3ecSWXb/
         +a9T4Yk75VqHiJE9X7Eylv0QrSvFo86/Ot0XFKApSgTq5alDXKKu8SphFVxL8/cI6BP5
         2s0bEBZ3eDlg4ap5VHoltEiw/8G1vCB6w3YJoNeQWah/xZxX2uhEqdg8Y1tNZue5IqHb
         Gt0YvdmxJVCOGB5JHVJtU/JYsfRzUw6e9V124OJowcQAVJxjINwXJxO1Uo7N16bOv2Qs
         4kzqxb18k65rkVt12xOzBB18mnVBqNEfoPG3qlFkxBVrBxa92IKAYm5m2hlVykxzYaoX
         9wxA==
X-Gm-Message-State: AA+aEWbm8KH37kPNpy+ZPjr+8PkHDV8mZe3Uqn9ho9OG4V/Y1guMR6aY
        4hQEJ6lI1+XD9mZhD1EazwRlMA==
X-Google-Smtp-Source: AFSGD/WHB2QQV9H9gW3wM8NzL6iAKV51gm1WmEZN9ca52EYa4pB/RhDTd+8ZH3qMcs5AT5HTVvNO4g==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr2803270wrn.307.1544800294582;
        Fri, 14 Dec 2018 07:11:34 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:113f:f362:2090:a70c:c5c6:347e])
        by smtp.gmail.com with ESMTPSA id i13sm3381567wrw.32.2018.12.14.07.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 07:11:34 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/2] Make STM32 interrupt controller use hwspinlock
Date:   Fri, 14 Dec 2018 16:11:26 +0100
Message-Id: <20181214151128.10005-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

This series allow to protect STM32 interrupt controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors. 

version 2:
- rework hwspinlock locking sequence in stm32 irqchip to take care of the
  cases where hwspinlock node is disabled or not yet probed

Benjamin Gaignard (2):
  irqchip: stm32: protect configuration registers with hwspinlock
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157

 arch/arm/boot/dts/stm32mp157c.dtsi |   1 +
 drivers/irqchip/irq-stm32-exti.c   | 116 ++++++++++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 16 deletions(-)

-- 
2.15.0

