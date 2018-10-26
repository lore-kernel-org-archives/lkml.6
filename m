Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF53DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B4C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dA+QkIdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B4C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJ0CNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:13:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39301 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeJ0CNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:13:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so888295pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4NWRFN4cz+yL5BRB4m6RPmVKgri9C3X/yu85aJ7rb80=;
        b=dA+QkIdq3KUv9vS6P5R+LQCLmhEA0BT6oqa4TgQCEuFLI+KW2L0PtGuR7+/WW5msvy
         tHVG26mwhPdhvwj4vE9YU1RMzkm341MLvwg4f4tmPCn0dFYk7FyYRuPPIUrOPcf2qdX4
         wDts6Hiq8YVh4ZCu7V5HC1Bw+Qhy0Gda5scck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4NWRFN4cz+yL5BRB4m6RPmVKgri9C3X/yu85aJ7rb80=;
        b=R2OWKM1OEfbpaIQeHrBm7E5fA8V1UwwqQPZeSp5g9RqVqkZqX7ff1vokKm4HoRYjoc
         Wup/9Ro8YisxRZS1Hyxp5HOcHknenBQSGV3jFOoQF1R3MCRmWfDvoufPoCN87glLcUpv
         KyWFRqaiVd9AfLoycxjyz/4znzns8WZmJmrHtK1TGNKto/f9phhUyjXbcZaJY1Rf9RV3
         1whR9IWT5P7H1J6YhG6wjBZPCGdGoYm8/HUdYkalRQ2wJZaqCwcF3NSFLP2ObTgq7Nd/
         RtLvLBiK9KO176tp0xBoMfyuYZnC0k2CJWRzZ+NHakQl11g3K+CqEpNfQ1L3yyDs+bHs
         eFIA==
X-Gm-Message-State: AGRZ1gLpb29t0r1v5AckEtUnknrwriGZVzt5md2lA5hep9O5UEIRwIlY
        JC8wbe+uCaEJO5WlvVqgFYnEMA==
X-Google-Smtp-Source: AJdET5erOL+ozhE7dpie8sMeJ3Yo9Aii6GbLz1+twJJK8CvKdi2f2ycueNkiRX5Uqsziy4PTBeth8w==
X-Received: by 2002:a65:5103:: with SMTP id f3-v6mr4361049pgq.54.1540575358167;
        Fri, 26 Oct 2018 10:35:58 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id b29-v6sm20164448pfj.183.2018.10.26.10.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 10:35:57 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Fri, 26 Oct 2018 10:35:39 -0700
Message-Id: <20181026173544.136037-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the device tree bindings for the QMP PHY to properly
specify the registers for dual-lane PHYs. Update the driver to use
those new registers. Add the DT nodes for UFS on SDM845 and MTP.
Finally, fix up the USB3 PHY on SDM845, which also has a dual-lane phy

Andy/Kishon,
I believe these changes are ready to go.
Just a heads up that these changes stack on top of each other,
and if taken through separate trees might break things a little until
they come back together.

Changes in v5:
- Fix incorrect register value in example, copied from real life!

Changes in v4:
- Remove "status" from DT binding example (Rob)

Changes in v3:
 - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)

Changes in v2:
- Added dt bindings change, corresponding driver fixup, and USB PHY fixup
- Renamed ufsphy to phy (Vivek)
- Removed #clock-cells (Vivek)

Can Guo (1):
  arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

Evan Green (4):
  dt-bindings: phy-qcom-qmp: Fix register underspecification
  phy: qcom-qmp: Utilize fully-specified DT registers
  arm64: dts: qcom: sdm845: add UFS controller
  arm64: dts: qcom: sdm845: Add USB PHY lane two

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 70 ++++++++++++++++++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 14 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 71 +++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 51 ++++++++++++----
 4 files changed, 184 insertions(+), 22 deletions(-)

-- 
2.16.4

