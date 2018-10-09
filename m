Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63076ECDFDF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B13A214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Aq6Ge7iA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YpcYeuT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B13A214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJJBq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:46:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:46:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 607DE60BFA; Tue,  9 Oct 2018 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539109692;
        bh=lym95mBTK0ZnJR1Fe11vXF21lQfkdSpE8hFmmFOskds=;
        h=From:To:Cc:Subject:Date:From;
        b=Aq6Ge7iAptvgBD7DDWNlULuf/UnoJfE9P3W+MB+CQHvl8XTCcRl17S9WgPaELcgeH
         rJwhMPq4r3ahMW0cW86zbPZjFCUrBhZNIh05YrY3W4l+Eq/JQUzLB6wHK+lIlAcXpM
         pmOwHt90Fxp5hQIk3XVoBmcbpWRJAAF1g8sD3+lc=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C3FA60265;
        Tue,  9 Oct 2018 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539109691;
        bh=lym95mBTK0ZnJR1Fe11vXF21lQfkdSpE8hFmmFOskds=;
        h=From:To:Cc:Subject:Date:From;
        b=YpcYeuT+nTaAwIvR0J4dgizh0uYHuGrr3jcm6U7nRqqnnFyTcKjtniJ+XcJarwD6n
         tW+FwHQMuBct4+GMfYRsbx1mg38EXJoUo4G/b8OABv9s+pxGDLRbC62DK6hOKuo6Mb
         bBZxS9JPzz1Un3IY3qde7ASpEsAbW2CRLJkEiA/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C3FA60265
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
Subject: [PATCH v7] Add support for LPASS clock controller for SDM845
Date:   Tue,  9 Oct 2018 23:57:58 +0530
Message-Id: <1539109679-8964-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Taniya Das (1):
  clk: qcom: Add lpass clock controller driver for SDM845

 drivers/clk/qcom/Kconfig          |   9 ++
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/gcc-sdm845.c     |  35 +++++++
 drivers/clk/qcom/lpasscc-sdm845.c | 198 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

