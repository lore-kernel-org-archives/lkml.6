Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2328A20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ki3VVd5j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZKZv5eXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfAVGd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:33:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAVGd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:33:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC56C6085C; Tue, 22 Jan 2019 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138836;
        bh=T8++vPUHn6c4bsjAj/Ep0gnptA8B7LmOie7YQz/GEFs=;
        h=From:To:Cc:Subject:Date:From;
        b=ki3VVd5jR0SK0gl57s4+tH+XFJsEjbBRVXUpgDhEVx80m9Eh7o8V8EuUxblM9PaKF
         Tuo2oBnuDqKBmdDaH540AcmkNlXcnfevXEPGv/q1iALBb53VnO3nucN2fGEc04Nsgw
         ZfFQEx5/v69S0Gz3umZp5TRV0Aw9+V3TgxpFIL0A=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EB1660712;
        Tue, 22 Jan 2019 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138835;
        bh=T8++vPUHn6c4bsjAj/Ep0gnptA8B7LmOie7YQz/GEFs=;
        h=From:To:Cc:Subject:Date:From;
        b=ZKZv5eXdCocrID5IyaeNQSa4RpGtjUGezwr/EfxsQ8WigH0KP1vp/FB7oLdqA1Uav
         NuyZ8EeDyQn9+hirA8lpLQIakZkLQmkONgc7trLNQGkxQotru3KCNJRxbbwlXQ0YvX
         Eqnum2Uc0geVTmstbT4yMvO7MkDm00CxoLG293Po=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EB1660712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 0/6] Add interconnect support for GENI QUPs
Date:   Tue, 22 Jan 2019 12:03:30 +0530
Message-Id: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
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

