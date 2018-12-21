Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D012AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B0F21924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n8+A7sZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbeLUQCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:02:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32840 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbeLUQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:02:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so5792367wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuNbTUIJB2KQ1KWfbG11yHK+NOLYz3WFk+GRuq8n3EI=;
        b=n8+A7sZgm6byDFHH6PhGFRlLlxdUy7mWfeO4fkzYkjf5jDCAvbo5ZLGGdMZxaJ5Ee9
         03cjKQnkTPKjrvT8f23sG38aYPMvcFS5Mwyf+rQOFo6GYeNHBays80AUXv8HLWCICHES
         1jQjfV6iPSwg87KQm1U82D+Kn1g8hX2QKaCVyw0vzfAgNtU6a1Rg73JOjVxJ30QFN4NR
         pLRg/axgJTb591/wbgiJTmzaeEerLXBOaZH/DxymkoQfphe9ASFhm4J9f/vxgbdoDbKt
         y6/TSyWYon2HHcAkYXWHBhuDKuJYFWFp60kADFx+tJbmNDBhzE7JLijzFFT0hilyJTho
         NzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuNbTUIJB2KQ1KWfbG11yHK+NOLYz3WFk+GRuq8n3EI=;
        b=H/ExjOdgQrF322Cp0yuK/ADieDxOv8SNHV7xZDNDg4Sj0XT+w2G8QsKnpfHK88p8dd
         w/AOl6rxormhOCUp8YR7ekrRUqZs4sOZJbAU0OBDZWHluUZRJspVqzm6vjVmC86SbGKy
         fEec6SppLUHfJni/LhnJxRZHwMETbYssI/RtAg84yOpv6bD2wAViH1uBgAEHciUOws+O
         SJ07bPGhM7XainsJEDxC8DLLjheDeQmI9J1ySVxtZ5kiarLP43vfu/t8jiWxz0k/Mz8V
         ex3JZz5xaO7QJha2B/CAYoOji7EGOHHYV97Y0YDoDRESSO+FBHU78PibMfsIezhjE8Gb
         Gcmw==
X-Gm-Message-State: AJcUukcv8MVrOCMIj/mtJYV16QQLxPEHPC+FnLc1O4lCMW6JSE9AcdBL
        zGhIQvfRFuIvOy1pmd8z9FXS5w==
X-Google-Smtp-Source: ALg8bN66cugOeyIXXAyYGeREaUNhYbEcLYQlXEO8zEo5Cv5NFj7Xoj2NDo4M/davvFY/SqFnX9xVhw==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr3104693wrt.43.1545408167111;
        Fri, 21 Dec 2018 08:02:47 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y138sm13044021wmc.16.2018.12.21.08.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:02:46 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] clk: meson: axg: add 32k clock generation
Date:   Fri, 21 Dec 2018 17:02:34 +0100
Message-Id: <20181221160239.26265-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patchset is to add the internal generation of the
32768Hz clock within the axg AO clock controller.

This was initially added has the CEC clock on gxbb. To properly
integrate it on the axg, a simpler 'dual divider' driver is added.
Then gxbb AO clock controller is reworked to use it. Finally the 32k
clock tree is added to the AXG.

This patchset *no longer* requires depends on this CCF change [0].
There is a work around in place until a solution gets merged in
the framework.

Changes since v1: [1]
 * Add work around for [0] in gxbb-aoclk

[0]: https://lkml.kernel.org/r/20181204163257.32085-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20181204165310.20806-1-jbrunet@baylibre.com

Jerome Brunet (5):
  dt-bindings: clk: meson: add ao slow clock path ids
  clk: meson: clean-up clock registration
  clk: meson: add dual divider clock driver
  clk: meson: gxbb-ao: replace cec-32k with the dual divider
  clk: meson: axg-ao: add 32k generation subtree

 drivers/clk/meson/Makefile              |   4 +-
 drivers/clk/meson/axg-aoclk.c           | 175 +++++++++++++++--
 drivers/clk/meson/axg-aoclk.h           |  13 +-
 drivers/clk/meson/clk-dualdiv.c         | 130 ++++++++++++
 drivers/clk/meson/clkc.h                |  19 ++
 drivers/clk/meson/gxbb-aoclk-32k.c      | 193 ------------------
 drivers/clk/meson/gxbb-aoclk.c          | 251 +++++++++++++++++++-----
 drivers/clk/meson/gxbb-aoclk.h          |  20 +-
 drivers/clk/meson/meson-aoclk.c         |  15 +-
 include/dt-bindings/clock/axg-aoclkc.h  |   7 +-
 include/dt-bindings/clock/gxbb-aoclkc.h |   7 +
 11 files changed, 540 insertions(+), 294 deletions(-)
 create mode 100644 drivers/clk/meson/clk-dualdiv.c
 delete mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c

-- 
2.19.2

