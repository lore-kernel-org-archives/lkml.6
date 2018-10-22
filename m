Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41342C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5168320663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JDM2CCCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5168320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeJWFLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:11:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42678 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeJWFLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:11:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so19592069plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T2MSk5N/ZFFwWz958VZ7adGUXhRzOpdmmoa1YgHIW84=;
        b=JDM2CCCNoiu5QJYOEjdux8ns1u4aDvsgZn38JRzDLH1ai5PnrjUg3O/d3PkDIcRl5/
         FmLw7g3mnHmlWyC5tZ4B7EXQdXRLBSYeSZkWXnEHp/FLsCbDxtJw6PsOm34XO3g5/cPZ
         ay3oMUgQHAeRfxD6Qvj6zP48Tan/LYvC3fLT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2MSk5N/ZFFwWz958VZ7adGUXhRzOpdmmoa1YgHIW84=;
        b=JpigEZDxIiCpJ8Mw5auSRzoTyVKLo5tUue6iSYuJmkUTkNKEfe2oQN3TtStDX+y2hl
         C/5wUOGLB3aZ/W6bbgCC2fqcJC3LJI3Cq9DdqjNP6lpNx9EvqAXbWQu3SR8hHaNU+XYs
         4K7IHSNERNUo+0XtKFK6oiLCH7XS+eAFS0IKfYSng4eXlX8ZrvTiNlPdWAlPs/2jn+go
         Kvwja2RxUkzIyU6ya4YxERYjloe4aSJ+8gG3SWadUOQg2oNN/19ESBSXPNFzwplTGcmQ
         4xXUwx/dnevyG7Tz5nmnqB+5X8j7lE/JKveSUWqsG3StZo3YMEmNMbis+FfD+v4ETzqm
         5VZg==
X-Gm-Message-State: AGRZ1gJRgMLWfuHFYq7nke9jqf09+46gZ63MVcCjEBrMxBh7Cshb6Svj
        rVLWMVjZrL4d8cbZpRgHtBigfw==
X-Google-Smtp-Source: AJdET5fW55c8Rj5KJQC9jNQr42Bbar7O1Lo4yXK8hPSKAN/F2L+DVpL8mpVjgB+nYZWcgP8+8ibHkw==
X-Received: by 2002:a17:902:6801:: with SMTP id h1-v6mr4987247plk.31.1540241490997;
        Mon, 22 Oct 2018 13:51:30 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id a11-v6sm37216041pfn.66.2018.10.22.13.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:51:29 -0700 (PDT)
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
Subject: [PATCH v3 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Mon, 22 Oct 2018 13:50:57 -0700
Message-Id: <20181022205102.74825-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the device tree bindings for the QMP PHY to properly
specify the registers for dual-lane PHYs. Update the driver to use
those new registers. Add the DT nodes for UFS on SDM845 and MTP.
Finally, fix up the USB3 PHY on SDM845, which also has a dual-lane phy

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

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 73 +++++++++++++++++++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 14 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 71 ++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 51 +++++++++++----
 4 files changed, 187 insertions(+), 22 deletions(-)

-- 
2.16.4

