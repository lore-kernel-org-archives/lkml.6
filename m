Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA86FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A77920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="efeDpCR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfAODd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:33:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33129 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfAODd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:33:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so641991pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4X8kcU6d3NqyUxrmUJdEBWCif0hJtOT6s4rVRjXlFOA=;
        b=efeDpCR3Ngei9k8D7/TQEoASBe4kOWQrKK7luOm0fDonWQE/ylPUXoXe4u2i50bmOj
         WPQWHpk0zz4TSCYPXwN+iaRZ+g8t/9ykoGOkkti4sMJq6lOL3TTmJyh5/WtIhY4juh0K
         T373uvqT8SbRKTgkyja8WsY0Qxr3CtJyJx4OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4X8kcU6d3NqyUxrmUJdEBWCif0hJtOT6s4rVRjXlFOA=;
        b=YjBvFiqqJecfmlVOX9jaLDmlrxVJzYZkF+Scg5uP2NuMDgDuOdGnxi4d0NZ+e37weI
         Em3iutlkhthgAwZQJqsZeU4cn8FNhyf+5WQNF4gjEeCO7TI1oryA4r9siZ6dlawENLJ6
         2FcGNKUDAiJNSDt7RNcPv3yz1SQXv1JFi3FWvHnxvrIJAKB3ZYw/MOg/8mG9efucu/9A
         coproRitjjmonNSq+NUErKGSfwyQ5MLpJKZoh/gF5eHj+qpiqSoP8FDwj3E9QDCwC+co
         Cgh+ylLSsRQXlYdLAPS6V8vud2OAUJzbSdQTzslPZK3kqL5RiJJbLvPOmWbwdSY9xt3x
         Gp6g==
X-Gm-Message-State: AJcUukdUG3BhqHW88HjvaabplwUvkqHrjsqV79pYtVusZ69AInM9c6GZ
        UUFOl5mP/IkYX3akXDnuU/jL
X-Google-Smtp-Source: ALg8bN6jazPCc7Jqm3wzmoCByTWc9OgBNXgSdiB8IUD7rmYY0k5rlUV7vjIvzzoP6/VoC3gm/He5Bw==
X-Received: by 2002:a63:557:: with SMTP id 84mr1755834pgf.411.1547523237621;
        Mon, 14 Jan 2019 19:33:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
        by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:33:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/6] Add clock support for Actions Semi S500 SoC
Date:   Tue, 15 Jan 2019 09:03:34 +0530
Message-Id: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds common clock support for Actions Semi S500 SoC of
the Owl family SoCs. This series is based on the initial work done
by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/

Since there isn't any update from him for long time, I took the liberty
to modify his patches, address review comments and send to list for review.

This series has been tested on Allo Sparky SBC.

Thanks,
Mani

Changes in v2:

* Incorporated review comments from Stephen for driver cleanup.

Edgar Bernardi Righi (1):
  dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU

Manivannan Sadhasivam (5):
  clk: actions: Add configurable PLL delay
  ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
  ARM: dts: Remove fake UART clock for S500 based SBCs
  clk: actions: Add clock driver for S500 SoC
  MAINTAINERS: Add linux-actions mailing list for Actions Semi

 .../bindings/clock/actions,owl-cmu.txt        |   7 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
 .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
 arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
 arch/arm/boot/dts/owl-s500.dtsi               |  22 +
 drivers/clk/actions/Kconfig                   |   5 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-pll.c                 |   2 +-
 drivers/clk/actions/owl-pll.h                 |  30 +-
 drivers/clk/actions/owl-s500.c                | 525 ++++++++++++++++++
 include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
 12 files changed, 661 insertions(+), 31 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

-- 
2.17.1

