Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16ABC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0097218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOmroL38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBFFNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:13:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37345 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfBFFNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so2583757plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Fyyjj2G3ZZZmYkTZdLJvDd3AjhVxtStH3xL7yw29ktY=;
        b=uOmroL38XoBiU1KTZeN8ZpiRzy+QAhL0XRZDgqavwgln3iI+zGXQiQ6bbJhK7Zbhpm
         hmXBYA0V/lfcxoaX91ckBULR/Na1TBeqzluBB1MOZKuf7pr01d88vNR6FioC6dmzrXmZ
         PBY5dAHhIrczs85yhbx9J215L7R7WdFCW4OSqJTtbFdaSSRJ6U1XcUAAdiTbLZMnVOHE
         64br9386KuWiBqksbxPP9A7z51VH4P4nGsEucNhRHNwPWTcet/T7D+k7VTui89HVELzU
         xU7VqPL1sk9ar4IbKV8ZxHTH3Y5r/PNLuCK7KIn5bw6BEm513FWSMX+ClEAfIQ29urYk
         Aeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fyyjj2G3ZZZmYkTZdLJvDd3AjhVxtStH3xL7yw29ktY=;
        b=CVP3cFn4j5LBl94Ls0YjrF99cydg+UOOr72iVGFhNLp3URqkUmusPplWRMrZYZ1Flw
         ESrWmGFMgQz5P+I+7g4XDttJmRZ4gK5sojz81YOQOJMtXK5Z/UfQ+ficfMzrKartOFjT
         qqx7Jb2pqf732rsPp241q4JRYFk8HwgR+Rjx3eSMOP4b+HLMpUdtyZ47o+l0cIojjyUi
         RLCelasbsXrawWRRnIEhf+n8v2zYE0nNqiF4Oi7MJzbgTeAb5aop4zAxZIoln4uZVyyu
         1GLAz5GTBP789yeSokl4trVUubret3tVMo467cap/Axr9tAhI/TQ5PxYi19WOWFcSZP9
         Snfw==
X-Gm-Message-State: AHQUAuYX8L6qCFl+f4+jt4IUog7EPqklPTGK1eIOPZn+YdVmgTFvrIeA
        luG/XwAoTSq9RHsdhh8DsP68mg==
X-Google-Smtp-Source: AHgI3IZfR2E6qR0nCys2ADl/Zjko5Ob4iULLCnrl+YEjA3PqT1ddh3UOiEzeoCDmRvye9mQ/pzRwCA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr8636716plb.120.1549430021508;
        Tue, 05 Feb 2019 21:13:41 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:40 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/8] Qualcomm AOSS QMP driver and modem dts
Date:   Tue,  5 Feb 2019 21:13:27 -0800
Message-Id: <20190206051335.23799-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the reserved memory map for SDM845, add the ADSP and CDSP nodes,
introduce a communication driver for the AOSS and a PD driver for this and
finally add the modem remoteproc driver.

Bjorn Andersson (7):
  arm64: dts: qcom: sdm845: Update reserved memory map
  arm64: dts: qcom: sdm845: Define rmtfs memory
  arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
  dt-bindings: soc: qcom: Add AOSS QMP binding
  soc: qcom: Add AOSS QMP communication driver
  soc: qcom: Add AOSS QMP genpd provider
  arm64: dts: qcom: Add AOSS QMP node

Sibi Sankar (1):
  arm64: dts: qcom: sdm845: Add Q6V5 MSS node

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  76 ++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |   8 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 209 ++++++++++-
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/aoss-qmp-pd.c                | 158 +++++++++
 drivers/soc/qcom/aoss-qmp.c                   | 326 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  15 +
 include/linux/soc/qcom/aoss-qmp.h             |  14 +
 9 files changed, 819 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

-- 
2.18.0

