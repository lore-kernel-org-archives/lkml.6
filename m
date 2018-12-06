Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5388C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6F2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VqWlnJe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLFXcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:32:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeLFXcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:32:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so938126pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J+thtozG+VIwbvwMC4BGUpsaChxCrbkm//cZCBKZ+y0=;
        b=VqWlnJe+FJUR2hCcmJ7r/sh0nK82BTVFUsHG7i2Dn4ZaWwf7VIh+2na51vBJ/ND6+c
         5QxLvcPgpBZm0fvcPM5VO4yL+RRdEc29QBzcTThWd/f0bh6bWlusYQt/i9hdZ24jqu0s
         ZI4u15DtdtgKgwX8Fa5PTsJLTkgzWyYY9VOJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J+thtozG+VIwbvwMC4BGUpsaChxCrbkm//cZCBKZ+y0=;
        b=tf6jduVw4S2CxUeC8TJyRI8/flQgH5yiSs0wrOiXl+nooo8WIVNna5AmMFaVMTKP9s
         vcvMZCxaNGD4ipjxiSbCBS39gjYakpGglfcmbLcLACtmpYI8qN9Mh8Mj20u9OeBXGlNc
         qieI/MKIYDcpVTHPUQ0OgzexglKNVBJeEb2BffTlNZRBPS2EeIA/zQdoqKyzjqZTnUuC
         A9cBtFY2OJH7oD+7BupeRPQKY8R5R/JvBBEdaibobIP0aICl9y1lwcWa03svqcrzkSGu
         khugFMNmY6EPlS1wWNWJZq/nDoVAOWK6u88+JKWm/xSwceOlpcTJyrEWZzG9SuffeUgB
         TOAA==
X-Gm-Message-State: AA+aEWahWUfpNz1BWIu2BQYJxNFFire26FvQHp8FdspdwlhMecDderSW
        BmThKecdTAM3azJzJwsV/JXsaA==
X-Google-Smtp-Source: AFSGD/XE6iYik5lMWnowCo7JHhYSsApifeev+NAnOHPh/eJ90M/BBIlav6/sNlCx5STEPmqAat1UFQ==
X-Received: by 2002:a63:451a:: with SMTP id s26mr26112759pga.150.1544139130812;
        Thu, 06 Dec 2018 15:32:10 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id s190sm2100875pfb.103.2018.12.06.15.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 15:32:10 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Thu,  6 Dec 2018 15:31:59 -0800
Message-Id: <20181206233205.193244-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the device tree bindings for the QMP PHY to properly
specify the registers for dual-lane PHYs. Update the driver to use
those new registers. Add the DT nodes for UFS on SDM845 and MTP.
Finally, fix up the USB3 PHY on SDM845, which also has a dual-lane phy

Andy/Kishon,
Just a heads up that these changes stack on top of each other,
and if taken through separate trees might break things a little until
they come back together.

Changes in v6:
- Removed resets and reset-names (Bjorn)
- Renamed nodes (Bjorn)
- Fix renamed nodes in MTP (Bjorn)

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

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 70 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 14 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 68 +++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 51 ++++++++++----
 4 files changed, 181 insertions(+), 22 deletions(-)

-- 
2.18.1

