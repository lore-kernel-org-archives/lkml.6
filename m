Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054DDC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3CF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q/17GSch";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q/17GSch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfAULVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:21:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAULVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:21:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B4B29601D3; Mon, 21 Jan 2019 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069712;
        bh=T8++vPUHn6c4bsjAj/Ep0gnptA8B7LmOie7YQz/GEFs=;
        h=From:To:Cc:Subject:Date:From;
        b=Q/17GSchUIMqfdFX2HtIcL+pYmCv1C4SxeESFnWrnSWnyD7Sp5Ceihv7Yt4mkUayi
         qmwpAPei3FH4IA5zIT1g/vkNXtfdhR0XqNMGVh+nvu1jR/dHMxMVpbbEhY8pI0o5On
         es8wutKF+OUAGiKW7veDZqPK6MrC9VlF+rpCPJuM=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00968601D3;
        Mon, 21 Jan 2019 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069712;
        bh=T8++vPUHn6c4bsjAj/Ep0gnptA8B7LmOie7YQz/GEFs=;
        h=From:To:Cc:Subject:Date:From;
        b=Q/17GSchUIMqfdFX2HtIcL+pYmCv1C4SxeESFnWrnSWnyD7Sp5Ceihv7Yt4mkUayi
         qmwpAPei3FH4IA5zIT1g/vkNXtfdhR0XqNMGVh+nvu1jR/dHMxMVpbbEhY8pI0o5On
         es8wutKF+OUAGiKW7veDZqPK6MrC9VlF+rpCPJuM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00968601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 0/6] Add interconnect support for GENI QUPs
Date:   Mon, 21 Jan 2019 16:51:37 +0530
Message-Id: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains following:
* Add wrapper framework to support interconnect path from GENI QUPs.
  This wrapper enabled and help individual SEs to put their BW request.
  Adding this wrapper make sense because we don't want individual SEs
  to request to interconnect driver separately and put individual bw
  votes from QUP.

  This wrapper framework does the following:
  - Request for interconnect path handle
  - Maintain record of individual SEs' avg/peak bw.
  - Aggregated avg/peak bw based on how many SE's are active and put
    single bw request from QUP

* Interconnect wrapper API calling from I2C, SPI & Uart driver
* dt binding in sdm845 soc for Interconnect path for GENI QUPs
* dt binding documentation


Alok Chauhan (6):
  dt-bindings: soc: qcom: Add interconnect binding for GENI QUP
  soc: qcom: Add wrapper to support for Interconnect path
  i2c: i2c-qcom-geni: Add interconnect support
  spi: spi-geni-qcom: Add interconnect support
  tty: serial: qcom_geni_serial: Add interconnect support
  arm64: dts: sdm845: Add interconnect for GENI QUP

 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  10 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  14 +++
 drivers/i2c/busses/i2c-qcom-geni.c                 |  13 +++
 drivers/soc/qcom/qcom-geni-se.c                    | 129 +++++++++++++++++++++
 drivers/spi/spi-geni-qcom.c                        |  20 +++-
 drivers/tty/serial/qcom_geni_serial.c              |  27 ++++-
 include/linux/qcom-geni-se.h                       |  11 ++
 7 files changed, 222 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

