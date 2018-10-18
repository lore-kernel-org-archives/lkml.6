Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D179C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC22098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NR86EbcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EC22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJSFMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:12:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45325 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeJSFMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:12:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id s3-v6so1540739pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LINvzFDuuhqWw+WYY84avy4pEtkPi+NFOQH5uypQgPs=;
        b=NR86EbcJwPVNHJUKHMtlHiibfQOUVytAPPIwGCIsuvAQzXV1mIPdplWLL/x6QmXDZR
         hKgINUQxp3qHKO2RuLlqS7+Kne5RTsIf6VgyOZLHY0oe/CLSMtfOSCVDVLx1dfa46PcU
         PbKwbEdIFi02rnbmq8XuXTeATZiggw5vDszIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LINvzFDuuhqWw+WYY84avy4pEtkPi+NFOQH5uypQgPs=;
        b=LmSui0tghbcjW+3fHyITcN69mvuvnyYSlUsdW+q+lJHWfeKF/RYO+adoSXE4Vfb0fq
         VxlI1S7kvUrTsvH4WpX7pR3VBgwXozd+umvdhFlsiwBCseBBiMh3CQr/zpffsc4Njv71
         f/RmhPTK+wf9u68RWqlALeFP6kxzyMjJQRmyjUcPKgj0SNFEgqkQqDB+gHsDvrCotiXb
         5XuzV4LpsSrrKJz1Kl3rgsqXRxV0Sczr03kgG0bErA8b2x++7vEu2BFUGMX9uAhjimsY
         9f+5+RGI0p0qKVhBnEUU2NA7O3VjCGuNPKcRHOjWLNT59vz9wNoIc+vlnTMA7B5KOKm6
         e10A==
X-Gm-Message-State: ABuFfohuOQoXNhV3gZ8D+p+fA9Ot2JrZ+g8f8BAE5txnIf/nUY23jYpE
        GDsCw1I/p619fN5MxOvDAt7/4g==
X-Google-Smtp-Source: ACcGV63bCN6HTdK3iLIfRzFGc7owRuTuGSFU6bvcRSsFHAv6Zj981FiugB/wykfeEB7j9X0nHz+eAA==
X-Received: by 2002:a63:9c12:: with SMTP id f18-v6mr393354pge.40.1539896978619;
        Thu, 18 Oct 2018 14:09:38 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id i29-v6sm35133678pfj.82.2018.10.18.14.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 14:09:37 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        swboyd@chromium.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 0/5] arm64: dts: qcom: sdm845: Add UFS DT nodes
Date:   Thu, 18 Oct 2018 14:09:28 -0700
Message-Id: <20181018210933.113592-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the device tree bindings for the QMP PHY to
properly specify the registers for dual-lane PHYs. It then updates
the driver to use those new registers. Then it adds the DT nodes for
UFS on SDM845, and activates them on the MTP platform. Finally, it
fixes up the USB3 PHY on SDM845, which is also a dual lane PHY.

The DT binding change is needed because it was discovered that the UFS PHY
driver was reaching beyond its register region, which only happened to work by
virtue of the page size granularity.

Changes since v1:
 - Added dt bindings change, corresponding driver fixup, and USB PHY fixup
 - Renamed ufsphy to phy (Vivek).
 - Removed #clock-cells (Vivek).

This applies atop linux-next 20181018 with the addition of Doug's
changes [1] and [2].

[1] https://lore.kernel.org/lkml/20181012213632.252346-1-dianders@chromium.org/
[2] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/

Can Guo (1):
  arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

Evan Green (4):
  dt-bindings: phy-qcom-qmp: Fix register underspecification
  phy: qcom-qmp: Utilize fully-specified DT registers
  arm64: dts: qcom: sdm845: add UFS controller
  arm64: dts: qcom: sdm845: Add USB PHY lane two

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 73 ++++++++++++++++++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 14 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 75 +++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 51 +++++++++++----
 4 files changed, 190 insertions(+), 23 deletions(-)

-- 
2.16.4

