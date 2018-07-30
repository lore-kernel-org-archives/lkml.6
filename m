Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2AC16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D452083E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gUVSDk8c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gUVSDk8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D452083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeG3TAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:00:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeG3TAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:00:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A5B6621C9; Mon, 30 Jul 2018 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532971445;
        bh=eGkFwWgTmLmb2R/W18zUWdG0bbAYBsCc7+V6EU8OSDY=;
        h=From:To:Cc:Subject:Date:From;
        b=gUVSDk8cPpjIM1uxP1oLvTTfKmPKuvPN2AT9uylX9inmbbhAaLv7ZuUSxTT1C4VUA
         wp2P2m7Ge+HuiMy4aeFrSOqDHbFxeRhMq+VqvPe1pBwpRKhKeT2B4Rh6VkfUN0aPLQ
         feC41xeWLIVMKfFT/HB0EkTaEDpyUQwnHTnqX/Y0=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AD12621F2;
        Mon, 30 Jul 2018 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532971445;
        bh=eGkFwWgTmLmb2R/W18zUWdG0bbAYBsCc7+V6EU8OSDY=;
        h=From:To:Cc:Subject:Date:From;
        b=gUVSDk8cPpjIM1uxP1oLvTTfKmPKuvPN2AT9uylX9inmbbhAaLv7ZuUSxTT1C4VUA
         wp2P2m7Ge+HuiMy4aeFrSOqDHbFxeRhMq+VqvPe1pBwpRKhKeT2B4Rh6VkfUN0aPLQ
         feC41xeWLIVMKfFT/HB0EkTaEDpyUQwnHTnqX/Y0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AD12621F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
From:   Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
To:     wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org
Subject: [PATCH v8 0/2] Introduce GENI SE Controller Driver
Date:   Mon, 30 Jul 2018 11:23:50 -0600
Message-Id: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
Wrapper is a next generation programmable module for supporting a wide
range of serial interfaces like UART, SPI, I2C, I3C, etc. A single QUP
module can provide upto 8 Serial Interfaces using its internal Serial
Engines (SE). The protocol supported by each interface is determined by
the firmware loaded to the Serial Engine.

This patch series introduces GENI SE Driver to manage the GENI based QUP
Wrapper and the common aspects of all SEs inside the QUP Wrapper. This
patch series also introduces the UART and I2C Controller drivers to
drive the SEs that are programmed with the respective protocols.

[v8]
 * Handle the error from i2c_add_adapter function
 * Drop the device tree patches that are uploaded as part of commit:
   [v2,1/2] arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes

[v7]
 * Return appropriate error codes as idenitified in i2c fault-codes
 * Add Maintainer details for I2C controller driver
 * Fix an incorrect conditional check in DMA mode
 * Drop the patches in the series that got accepted

[v6]
 * Move the I2C clock-frequency configuration to the SDM845 board file
 * Remove a redundant comment in the I2C driver

[v5]
 * Remove Linux specific property from the device tree binding
 * Clarify I2C SCL time period documentation
 * Remove redundant checks in I2C controller driver during timeout
 * Use 100kHz as the default clock frequency in the I2C controller driver
 * Disable Wrapper controller by default in the SDM845 device tree and
   enable it explicitly for SDM845 MTP
 * Specify I2C clock frequency in the SDM845 device tree
 * Remove bias configuration for I2C pins under sleep state in device tree
 * Drop the serial driver from the patch series since it is merged
 * Specify the UART port options in the SDM845 device tree

[v4]
 * Add SPI controller information in device tree binding
 * Add support for debug UART & I2C controllers in SDM845 device tree
 * Remove any unnecessary parenthesis & casting
 * Identify break character in UART line and pass it to the framework
 * Transmit data from fault handler reliably in debug UART
 * Map the register block when the UART port is requested
 * Move concise exported functions as macros or inlines in public header
 * Move the clock performance table from the wrapper to serial engines
 * Add a lock to synchronize between IRQ & error handling in I2C controller
 * Remove any compiler optimization hints like likely/unlikely
 * Update documentation to clarify tables and hardware blocks

[v3]
 * Update the driver dependencies
 * Use the SPDX License Expression
 * Squash all the controller device tree bindings together
 * Use kernel doc format for documentation
 * Add additional documentation for packing configuration
 * Use clk_bulk_* API for related clocks
 * Remove driver references to pinctrl and their states
 * Replace magic numbers with appropriate macros
 * Update memory barrier usage and associated comments
 * Reduce interlacing of register reads/writes
 * Fix poll_get_char() operation in console UART driver under polling mode
 * Address other comments from Bjorn Andersson to improve code readability

[v2]
 * Updated device tree bindings to describe the hardware
 * Updated SE DT node as child node of QUP Wrapper DT node
 * Moved common AHB clocks to QUP Wrapper DT node
 * Use the standard "clock-frequency" I2C property
 * Update compatible field in UART Controller to reflect hardware manual
 * Addressed other device tree binding specific comments from Rob Herring

Karthikeyan Ramasubramanian (2):
  i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C
    controller
  MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer

 MAINTAINERS                        |   8 +
 drivers/i2c/busses/Kconfig         |  13 +
 drivers/i2c/busses/Makefile        |   1 +
 drivers/i2c/busses/i2c-qcom-geni.c | 653 +++++++++++++++++++++++++++++++++++++
 4 files changed, 675 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

