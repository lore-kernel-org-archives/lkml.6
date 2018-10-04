Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B3C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325521473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CYAEsR8h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XVeIAhaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C325521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJDSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:55:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:55:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 891C260C87; Thu,  4 Oct 2018 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538654561;
        bh=wYIC7V7w4Skp1yOqpWIBeaZXF8NchgfN5sqHHtIl7gc=;
        h=From:To:Cc:Subject:Date:From;
        b=CYAEsR8huGVp8ooRGm+TeG0PwOOqtP+Eo7dSRqoMB6bjgijxwi0mSdFA7paPre2xJ
         juMhggpWxR9qO+RqT/9nxSZJ9X4q51MDGaEgA1mX4035IM6LC8w1/LS0lz+ndyjR2p
         P6qeW0fM1bleP17u347AESqHRZ28VqFCAXaccZbA=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25D0360C62;
        Thu,  4 Oct 2018 12:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538654560;
        bh=wYIC7V7w4Skp1yOqpWIBeaZXF8NchgfN5sqHHtIl7gc=;
        h=From:To:Cc:Subject:Date:From;
        b=XVeIAhaD2HaDbHgHhh0AgbLTrG65+H2uxHs+rVaTA2a4W5JCXCk4eMycesfkhDDXl
         xo+iyMdsE1zO52reEtPpCiiEu/peVzm+40fenyA2FoUDZrUdGtkN7MW6Fr3x5jm/8R
         K70OXBnPnM5UpNdJd3C9o04Ztxee9CeVxiKE/qNo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25D0360C62
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
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v6] Add support for LPASS clock controller for SDM845
Date:   Thu,  4 Oct 2018 17:32:25 +0530
Message-Id: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Taniya Das (1):
  clk: qcom: Add lpass clock controller driver for SDM845

 drivers/clk/qcom/Kconfig          |   9 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/gcc-sdm845.c     |  35 +++++++
 drivers/clk/qcom/lpasscc-sdm845.c | 201 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

