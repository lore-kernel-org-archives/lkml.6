Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AADFC04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5E2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K/0haJRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE5E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeKQHHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:07:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50597 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQHHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:07:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so23458123wmw.0;
        Fri, 16 Nov 2018 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R4ENofjasmILkzT6+OfAXcy6neUWyBntZA7WcH9X380=;
        b=K/0haJRhGIswkKfETg6vJhyWzTrb1bgGoiYQrPaDE918UrjLFlgRvVDowwzO2NZW6p
         2AC3VuQVdJlo++nBLtPVLH0XzJaHofXvCCuQMx3EYGoLff9X43t0U5ITtLsEYmLZj8xZ
         Of0YQvc/kNur09AEZZ5pwj/Z145uToHwrphyoOSWgLFRehGatNe1pcSiXV5lRyioT/Y0
         mF3mgfCs2b2ZaUUFHyqHYYrwCKWrhVzfOTNOr8GpoWxmRrstNsKOMYhiGjt2qqOvogj0
         uC9vgYpq+DiQNwfvpYfSmjeWnn4gytf6KyKCIHyfQBd8UazkXvAueB9udNfA9VEkX5c1
         EYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R4ENofjasmILkzT6+OfAXcy6neUWyBntZA7WcH9X380=;
        b=CtslsbCbjh6ENbl5y/B9gu+r+furb5JHx0E4T3+/dTE3LSCoZDK65Tztqop+wufw6y
         wAWNF6yOFb75Q/PjfYST5Bcn86TRHXPUi2XUSMLXgIc/UvQa2L7/I4uXqbjmLLsLkQna
         fIjoLQOQ3oK9eqs9Zrln+cTnu0dYb8nxqzzEjGo3dnUXfWUm9mtffQE7UKqBG+SMHAA7
         9NAEe10QFWKecE/2DSNwXQCjcNi+Phh36jMpHr/5rXW/FuroawEY2Gz7A8tiPwIOseTO
         QBBs8e+Wq5YelTL94t0Xn1pFrGPEgnmQkWRChdU13hXGdc9K1AONBv24CWYqa4HLCRH5
         4ewg==
X-Gm-Message-State: AGRZ1gItiN13FQYKsDulozMFRgx4Su7/Cw5FjctdLZe1nwLP9U41pufe
        pario+WzCgqw5+5mxZhspJE=
X-Google-Smtp-Source: AJdET5fSLaluzTZFJstyAKoMmx3UifqzCXZky2e+tN6UXMv58pgZXXeFi0WBNwrlWSveA3iLND+0KQ==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr9442577wmb.127.1542401613427;
        Fri, 16 Nov 2018 12:53:33 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id z192-v6sm16610273wmc.37.2018.11.16.12.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:53:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] Meson8b: add the CPU clock post-dividers
Date:   Fri, 16 Nov 2018 21:53:00 +0100
Message-Id: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the successor to my previous series "meson8b: add the CPU_DIV16
clock for the ARM TWD" from [0]. I decided to not send this as v2 of
the original series because the PERIPH clock is not the CPU_DIV16 clock.
It's not clear whether a CPU_DIV16 clock exists.

With this series we get all the CPU_CLK post-dividers as listed in the
public S805 datasheet [1] on pages 31 and 32:
- ABP
- PERIPH (used as input for the ARM global timer and ARM TWD timer)
- AXI
- L2 DRAM

Each of these clocks has a register called "..._CLK_DIS" which is
documented as a "just in case" bit:
"Set to 1 to manually disable the [...] clock when changing the mux
selection. Typically this bit is set to 0 since the clock muxes can
switch without glitches."
Since we're not supposed to touch that register we're setting
CLK_IS_CRITICAL for these clocks in the driver.

The result of this is that we can use the PERIPH clock which clocks
the ARM TWD timer. I will send a separate series to add the TWD timer.


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
[1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf

Martin Blumenstingl (3):
  dt-bindings: clock: meson8b: export the CPU post dividers
  clk: meson: meson8b: rename cpu_div2/cpu_div3 to
    cpu_in_div2/cpu_in_div3
  clk: meson: meson8b: add the CPU clock post divider clocks

 drivers/clk/meson/meson8b.c              | 268 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h              |  17 +-
 include/dt-bindings/clock/meson8b-clkc.h |   4 +
 3 files changed, 276 insertions(+), 13 deletions(-)

-- 
2.19.1

