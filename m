Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83188C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4936220673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N/s+zrrE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gP5C76mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4936220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeLAFbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:31:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:31:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6859060B13; Fri, 30 Nov 2018 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543602102;
        bh=/gtaOjR5PCp9AK9CkJIEvF1Iqbzvr1WhbhTsclF8SmA=;
        h=From:To:Cc:Subject:Date:From;
        b=N/s+zrrEgepAHkauMcCoFy9MZPQD0TZuakJc/YvKVzFRxzc3pie/iVQeB4hu5N3M+
         m+hKvqmJFQNojAmDptg9wcSrkCY29JoBMJlWWaDcLfWoQQMTBmH3ZHEvcFiWE6mm5a
         tp5UyA1+tMVEwNAtB9+Ds4hStQtqHh7whRqmjC8M=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CCB5602BD;
        Fri, 30 Nov 2018 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543602101;
        bh=/gtaOjR5PCp9AK9CkJIEvF1Iqbzvr1WhbhTsclF8SmA=;
        h=From:To:Cc:Subject:Date:From;
        b=gP5C76mqqV5NTJOQ1xYyKSxQPGWjnBPqcXDTUhapDl4mSziyf6Q5CLXLvQw82eEtR
         gzkkO94Gc9U76cdWl2Aj44caVSkRnrK42v9no4yLs1/TekKv01cy9TK4b8wvaWbc4u
         wdIm4mEsrmXfr8SdLfMIou5eDqSWNbAgPyI+oNwQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CCB5602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v11 0/3]  Add support for LPASS clock controller for SDM845
Date:   Fri, 30 Nov 2018 23:51:26 +0530
Message-Id: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v11]
  * Add the GCC LPASS clocks only if LPASSCC config is present.
  * Update the comment in lpasscc driver.

 [v10]
  * Separate change to add  protected-clocks list in GCC binding.
  * Remove the clock support 'LPASS_AUDIO_WRAPPER_AON_CLK' as it is always ON
  clock.
  * Add few comments for module description and match table.

 [v9]
  * Update GCC documentation binding with the protected-clocks list.
  * Update the GCC code to add the GCC lpass clocks.
  * This depends on the acceptance of
  https://lore.kernel.org/lkml/20181105194011.43770-1-swboyd@chromium.org/

 [v8]
  * Add CLK_IS_CRITICAL for GCC lpass clocks for lpass clocks access to go
  through always.

 [v7]
  * Cleanup header file inclusions.
  * Move the comments along with the flags.
  * Update the commit with details for CLK_IGNORE_UNUSED.

 [v6]
  * Update the logic to register the lpass clocks when the device tree property
   is not present.
  * Add the CLK_IGNORE_UNUSED flag for the lpass clocks to not gate the clocks
   at late_init.

 [v5]
  * Address the comments in device tree binding to update the reg-names,
    update the unit address in lpass clock node example and also
    add reg property for the gcc clock node.
  * Update the lpass driver to take care of the reg-names.

 [v4]
  * Update the description in GCC Documentation binding for
  'qcom,lpass-protected'.
  * Remove 'qcom,lpass-protected' from LPASS Documentation binding.
  * Update KConfig to use Low Power Audio Subsystem.
  * Add module_exit() and also update return value for
    devm_ioremap_resource failure.

 [v3]
  * Add a device tree property to identify lpass protected GCC clocks.
  * Update the GCC driver code to register the lpass clocks when the flag is
   defined.
  * Add comment for clocks using the BRANCH_HALT_SKIP flag.
  * Use platform APIs instead of of_address_to_resource.
  * Replace devm_ioremap with devm_ioremap_resource.
  * Use fixed index for 'lpass_cc' & 'lpass_qdsp6ss' in probe.

 [v2]
  * Make gcc_lpass_sway_clk static.
  * Remove using child nodes and use reg-names to differentiate various
    domains of LPASS CC.

Add support for the lpass clock controller found on SDM845 based devices.
This would allow lpass peripheral loader drivers to control the clocks to
bring the subsystem out of reset.

Taniya Das (3):
  dt-bindings: clock: Update GCC bindings for protected-clocks
  dt-bindings: clock: Introduce QCOM LPASS clock bindings
  clk: qcom: Add lpass clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,gcc.txt         |  16 ++
 .../devicetree/bindings/clock/qcom,lpasscc.txt     |  26 +++
 drivers/clk/qcom/Kconfig                           |   9 ++
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/gcc-sdm845.c                      |  32 ++++
 drivers/clk/qcom/lpasscc-sdm845.c                  | 179 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |   2 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |  15 ++
 8 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

