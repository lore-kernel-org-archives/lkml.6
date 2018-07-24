Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89A520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4cv4AC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89A520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeGXSxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:53:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46986 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeGXSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:53:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so2076854ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fjgUTSOn/e6qMreaf456g9ANoqTC/LNMTza4xLcpuZs=;
        b=d4cv4AC1tWujO2le2ILZpTjqtuN53DnxLjZ3OXpl+uagKbuYepfH85L0DwKAqYVTho
         q4y0pJQ5ouQndgy4LFpcl0M91t7lnj2zj1nUqIiWO6OsH43fvwQhZRH4dZKZ092YrbAI
         eCJllL3s5W0lPWFbgaRDUHk561a98lp1savW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fjgUTSOn/e6qMreaf456g9ANoqTC/LNMTza4xLcpuZs=;
        b=B0NkYr/9QCaFL+MCLCvkYJAQVkTKLdBwDNwVgHygyR2zAyNF/KTmXT0DKFSQBdB+n3
         rCLkWROANHYOcC1SdUQMyvAgmDqpjm0i1KgXe20AewcI/hF+7iFs2L6W5eXHyBR/EDA3
         Stls2Ogagl3PdO2hfRmx9KaJ4LA73hst51/DtJzPFLGsyniBw7uGl4+txIXgmiT1s9nA
         PYE8lQVRTvZ/0hPi5+JYn2UP4WEfdOceHqdS3hOLsvV6niuAWdVTldgZyAfEWeV62APG
         Bywda/nzo4VNCugPYAGxuvL2LT7medEaFRwKg3KLO+byYTfBjDtOBZj6UppMB3546sH0
         6kbw==
X-Gm-Message-State: AOUpUlH5BsfEIprn6G6FSuq0scpKC12O5eKSwt70jD1oZrqOEOk6yhvs
        xxgmUJfRcY5c1YPo3VKg9InMnA==
X-Google-Smtp-Source: AAOMgpec41G1Lvx7ZKwXBZmdhmxDtGrwB8uj8sqrDJjqrfZMaCGobqb/tuOWhGpkIjirkGvGv7aDaw==
X-Received: by 2002:a17:902:8482:: with SMTP id c2-v6mr18088794plo.45.1532454340768;
        Tue, 24 Jul 2018 10:45:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id b62-v6sm34278653pfm.97.2018.07.24.10.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:45:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, grahamr@codeaurora.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/2] clk: qcom: Quad SPI (qspi) clock support for sdm845
Date:   Tue, 24 Jul 2018 10:45:11 -0700
Message-Id: <20180724174513.174018-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This two-series patch adds the needed clock bits to use the Quad SPI
(qspi) part on sdm845.  It's expected that the bindings part of this
patch could land in the clock tree with an immutable git hash and then
be pulled into the Qualcomm tree so it could be used by dts files.

From the reply to my v1, the clock plan for this clock is:
- MinSVS@19.2
- LowSVS@75
- SVS@150
- Nominal@300
...and intermediate frequencies can be used at frequences less than
300.  I didn't see a need for 75 MHz and it was unclear from previous
replies if this should come from MAIN or EVEN so I left it out.  I
have added 100 MHz here since it is useful (/ 4 = 25 MHz is a useful
clock for SPI flash)

OTHER NOTES:
- From probing lines, it appears that the Quad SPI block has a divide
  by 4 somewhere inside it (probably so it can oversample the lines,
  or possibly so it can generate phase-offset clocks).  Thus we need
  the core to go 4 times faster than we'd expect to run the SPI bus.
- SPI devices usually specify the MAX frequency they should be clocked
  at, so it's important that we use the clk_rcg2_floor_ops here rather
  than the clk_rcg2_ops

Changes in v3:
- Removed gcc_parent_names_9 which I had left in (doh!).

Changes in v2:
- Only 19.2, 100, 150, and 300 MHz now.
- All clocks come from MAIN rather than EVEN.
- Use parent map 0 instead of new parent map 9.

Douglas Anderson (2):
  clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
  clk: qcom: Add qspi (Quad SPI) clocks for sdm845

 drivers/clk/qcom/gcc-sdm845.c               | 56 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h |  3 ++
 2 files changed, 59 insertions(+)

-- 
2.18.0.233.g985f88cf7e-goog

