Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C85C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8CA2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jd5DlcOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeKHSjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43100 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id y3-v6so20043234wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ApR5+JTGZKCLP8UbiiJuNXIs+T0w8vUoXZmHnl/mYkY=;
        b=Jd5DlcORZDb5WSsHgbdofSkjB4aF/Ka/q9HJztSgKWfIMi9bUfMJPC7VSQzZNKG3R2
         bKDUx9I6Av8je/Dz0etejzxrmHw4Gjmqc0/0J608mc28tZo1j54Isn6uFIT9h+HdJDtB
         zVgVAmH2zLC2pWRcP1b0vvDBJQiUdsY/qdQF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ApR5+JTGZKCLP8UbiiJuNXIs+T0w8vUoXZmHnl/mYkY=;
        b=ld/T2O1T482ZILguoez1HmhRtn0KmNZ4EdFRjdo6e34+XFu7KwSGLWTlGEbmvbOx6F
         jfRicYfkn9UaLlYv2sNVmx7dwUr9M2qvSbbpf2gPBwglvqIUmqGyEeYsdkBWfEYv0IF2
         8M+UShXkjnQR44wBYIYrsJTVVl74HZVNKC4+vWIW5stHFOpT/ZokACEuDEOyC6kFBMkQ
         c0eXye7nBqRbmDuE+UWH2RId6IirwlNDb4MFdm9V7kMeSTWRlTr6+Ryqt8gq3yc60UFw
         zFMX+JdftxwMWt5tMGbKcW8fBPgMd8tyvML+d0bfwR3i6GniZ5Os9SflURo1m51hbI2W
         di0w==
X-Gm-Message-State: AGRZ1gKjCEaU4oO7rGG+rqSNKtt7sG+i0wXZ8Zo1O1cBVYKIxSlP0qta
        QT7VmnK7fEgIYyw5lWCEY2isUQ==
X-Google-Smtp-Source: AJdET5fkQz3aou+ljtoJNnptgC9zWuPzPSv0qVPbEOEpYFow6LmV6GPqsxXq0BaKVFWfDP/VD8JOVw==
X-Received: by 2002:adf:ea82:: with SMTP id s2-v6mr3104433wrm.180.1541667914514;
        Thu, 08 Nov 2018 01:05:14 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1094:149:440c:9368:8cda:a020])
        by smtp.gmail.com with ESMTPSA id l140-v6sm6974469wmb.24.2018.11.08.01.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:05:13 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/4] Add support of STM32 hwspinlock
Date:   Thu,  8 Nov 2018 10:04:58 +0100
Message-Id: <20181108090502.14543-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds the support of the hardware semaphore block for stm32mp1 SoC.

version 2:
- fix comments done by Bjorn about clock naming, license terms in header,
  alphabetic ordering in Makefile and Kconfig and remove function
- Do not push test module in this version while waiting for feedbacks about it

Benjamin Gaignard (4):
  dt-bindings: hwlock: Document STM32 hwspinlock bindings
  hwspinlock: add STM32 hwspinlock device
  ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
  ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1

 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 ++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
 drivers/hwspinlock/Kconfig                         |   9 ++
 drivers/hwspinlock/Makefile                        |   1 +
 drivers/hwspinlock/stm32_hwspinlock.c              | 144 +++++++++++++++++++++
 6 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c

-- 
2.15.0

