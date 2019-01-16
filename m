Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023C220859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PXuSBDEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfAPRyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:54:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36037 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAPRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:54:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so7988904wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVtN4iPcY9zshcCkTMLevoptOZxFBUuW0e/FWPhm+M0=;
        b=PXuSBDEx8jenUvktfa+dL3KOmAHKnN1f3NXBjaaSO2lYL6p+A4jIJhsB9l/Nl7a5CO
         BatQOv3PqoY9mwywoL4V3ZP3SE03TWdwi+yGYfNReV3NjtmCO44UYXBtep1TKsJQjXdh
         gGYBm6q5BzEhdyklYb6OJAAiMtaqNgIl+SXnXs/1IbaH+vwOboBLJrhKbAROT0rEyXvr
         cSzyz0V59SYh55RCpZxN2McXyK7Ht/lFzw2fKv40lDfnzq03JV4jUl0om2TGQh0cY+VX
         8SjjDch+NxrceCkqrS5fw1TxGs8KeoSlJ5Gia3QE423cUxL1yHRxbtkCun+XQGtCSPUT
         j4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVtN4iPcY9zshcCkTMLevoptOZxFBUuW0e/FWPhm+M0=;
        b=DtOQYz45GmWh2hcMz9oXSjl83b6w/1sBiq0p3IB6NoY5hGQgP8knIeJhGiO4ouWVXa
         XjHYo+nvmiYGYd/JADNFeEy56Yz9K/BgjGZHYAbXaXQhg5WxVz8j7pduyxPpmFQCUAWR
         OuMtAsxs1uDqfKzhge05HV1tUbLHckqBG3jiL6PVeN5JYhzqBflgSoZUCTrXYNXMbx02
         yWQNzUeuZkbTdy7oTpmkhtn5F1uBQ3n6PlRN/rfzE4zvXTiS5onXZB6SCuof+y3/l9sj
         EH4/CgIF7ujQRvMTca3jHdu6PFW4HSttevEy7yHquK9U+R91m6530KMOpQgHpBdpLEOL
         ho2A==
X-Gm-Message-State: AJcUukePgd1BFLID6Yo6UStSYjZySaPIr3iHBgImwzxwHB+VSzdQdfIr
        k1kxPmXNO19XUtOSLuJEpw/jXg==
X-Google-Smtp-Source: ALg8bN7k8146w1SKv9w0xx2lsDhIDb65NLp99FCuk6OViftv3063GGkHsaM0phdh5uZDHnV8MeEU3Q==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr8857298wro.262.1547661289277;
        Wed, 16 Jan 2019 09:54:49 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z9sm68703861wrs.63.2019.01.16.09.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:54:48 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 0/3] clk: meson: claim input clocks through DT
Date:   Wed, 16 Jan 2019 18:54:32 +0100
Message-Id: <20190116175435.4990-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the preparation series [0] sent in the last cycle, this
patchset adds clock input claim through DT in the gxbb and axg clock
controllers

[0]: https://lkml.kernel.org/r/20181203171640.12110-1-jbrunet@baylibre.com

Jerome Brunet (3):
  clk: meson: gxbb: claim clock controller input clock from DT
  clk: meson: axg: claim clock controller input clock from DT
  clk: meson: ao-clkc: claim clock controller input clocks from DT

 drivers/clk/meson/axg-aoclk.c   | 22 +++++++++++++++-----
 drivers/clk/meson/axg.c         | 27 +++++++++++++++++-------
 drivers/clk/meson/gxbb-aoclk.c  | 25 ++++++++++++++++------
 drivers/clk/meson/gxbb.c        | 37 +++++++++++++++++++++------------
 drivers/clk/meson/meson-aoclk.c | 37 ++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson-aoclk.h | 12 +++++++++--
 6 files changed, 125 insertions(+), 35 deletions(-)

-- 
2.20.1

