Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7454C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516FB2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WvZeDXOO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HvS/m7rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516FB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeIKWAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:00:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeIKWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:00:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3831608C9; Tue, 11 Sep 2018 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536685218;
        bh=/MQkdo2QRyByMj+/neT0jHqjaGXurA4PrWH1WRJBUjk=;
        h=From:To:Cc:Subject:Date:From;
        b=WvZeDXOOKLoCLbw4n343NgIF6qYYJfL3MA5IdiYT7LWUBLd02Br3xBs38wAlKsrrZ
         OxZVgDM/Lz5OLXB11e+xra5PF9RCTuWwCkFggPSjYsk76y3jp64/Fdn5LIRJmrAJD9
         J5c2TyWXFjcCii8+qT3JS6e+UT5t9nO0KYm9c2dQ=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 785AD606DD;
        Tue, 11 Sep 2018 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536685217;
        bh=/MQkdo2QRyByMj+/neT0jHqjaGXurA4PrWH1WRJBUjk=;
        h=From:To:Cc:Subject:Date:From;
        b=HvS/m7rl+QuUfVY5P2l/Fpdncy0hlvimxWDNvpbDF5Ynb4OZy3CpiafI4+rp60vYq
         xlwplc7Ump5pTiGSTp6/c6+Cc0ur9ko00vEggiO6j0kIxne2h0Jfcme6iC3/jUUhoM
         dG1x+6E3dDex3GbEbLjiLC/SZhkmD5Zz/7v+zlWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 785AD606DD
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
Subject: [PATCH v4 0/2]  Add support for LPASS clock controller for SDM845
Date:   Tue, 11 Sep 2018 22:30:04 +0530
Message-Id: <1536685206-12239-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Taniya Das (2):
  dt-bindings: clock: Introduce QCOM LPASS clock bindings
  clk: qcom: Add lpass clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,gcc.txt         |   2 +
 .../devicetree/bindings/clock/qcom,lpasscc.txt     |  31 ++++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/gcc-sdm845.c                      |  35 ++++
 drivers/clk/qcom/lpasscc-sdm845.c                  | 195 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |   2 +
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |  16 ++
 8 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

