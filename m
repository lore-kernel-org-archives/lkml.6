Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627CE2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KdxfwXgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627CE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJYB4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:56:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43458 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeJYB4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:56:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so1913105pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VUI22asxxpRgfZvx1G8w787XAGBffs85E3H9kHNlSeE=;
        b=KdxfwXgPV26rtQ8Iop9NIyFf0yk9gQiVXt+fs+fdol0VqrL5/q3MLMgQctzdhRZXWh
         GRqxYvfWwKlcjCz6GgfJ6+1OoXhK4l9rM3d2SZ6/vh+GpzSOYwxpPApBYZofmdtiEYrB
         P3uLgxvUySDcZOgE4DdIViCSDOmdHnrbyoaCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VUI22asxxpRgfZvx1G8w787XAGBffs85E3H9kHNlSeE=;
        b=tT2t1hG9qTjdChFzOQGmxn60zmbS6z59Fitx6vdTKBQfA4BtdkQ7caMrU1ZYf8xJ2k
         CgZho4XxJ6ZifbLpqH4SvsIp7R2WXLV/alR7EGHlitFDVwcZBmKs1fdU2F9xM1y8CE0w
         WsNoSD6lq3RFKslP3CAGeAld0AnXT6GBgCA4of5sMdWDDXEcm4tPmHpa1XqWcPuZ4G46
         tUYS35GENgoEtzLOA+B25gyjeais5ECpNPaUPqL/hxa1f1e9oNejZ+AWhuNb4iIJZ6rX
         ZNtSxYzvWiy6IgCeGCVkG8AdfJE30TidJmNCcM0+aZQtyp/QBPXvZ0L0OYwhH/sKVQHN
         dAfw==
X-Gm-Message-State: AGRZ1gKvC3BXMM4wvHlrGOPRZk+e2xIZBLm3zmlZbj3wEJOAnQLxz4PV
        LSNqdQHb952rBFN00FGDEEokfA==
X-Google-Smtp-Source: AJdET5fn/d2xDopq75ozChr89woQrmw1Nn/epkMiB//MVt/MiUJddLfxTeXsWF33Qj83lp49M73AUw==
X-Received: by 2002:aa7:814f:: with SMTP id d15-v6mr3543521pfn.78.1540402076448;
        Wed, 24 Oct 2018 10:27:56 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id v185-v6sm5674265pfv.48.2018.10.24.10.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 10:27:55 -0700 (PDT)
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
Subject: [PATCH v4 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Wed, 24 Oct 2018 10:27:30 -0700
Message-Id: <20181024172735.154304-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the device tree bindings for the QMP PHY to properly
specify the registers for dual-lane PHYs. Update the driver to use
those new registers. Add the DT nodes for UFS on SDM845 and MTP.
Finally, fix up the USB3 PHY on SDM845, which also has a dual-lane phy

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

