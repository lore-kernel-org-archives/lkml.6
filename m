Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A020858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RcZG8Q+o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HcA6kZjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbeGWGvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:51:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387811AbeGWGvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:51:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F9F9608C8; Mon, 23 Jul 2018 05:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325137;
        bh=sdtyi+FEgIxfQd1fPvkzHHhzNwpAOFkml30+JcldwCc=;
        h=From:To:Cc:Subject:Date:From;
        b=RcZG8Q+o0xnQNxJs9/S3aAoWEnleLO/xpelx1oZg2XJiQQ8jsG8seeSEcPaPGzjZv
         07IsHR9EeP1NwEJiEGQZtJ46rD1Xdptow1xcZMK9P1VP8wV3BOhq+qI2bVCy99YyVb
         SsPZkzzq7aAu13aeA+SVJYJdg0sHPf7pqqW10VAQ=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72CBB605FD;
        Mon, 23 Jul 2018 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325136;
        bh=sdtyi+FEgIxfQd1fPvkzHHhzNwpAOFkml30+JcldwCc=;
        h=From:To:Cc:Subject:Date:From;
        b=HcA6kZjIM0PZiLKUvjqqFwHoWkA0N9vqD1Pm1JrbIQwCTvYdef2XNbT1hdAt+Dvcj
         JEqIgRCXdiIwWGI6+4mlWqsgu+SEnBX5G34iQoX+h3z8xzUZhZfoE3ZIQuKwhl9LBH
         kmKdXQTgKrp02TK2bt/o9nnfOVNbmes7dJatIURI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72CBB605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v4] Add display clock controller driver for SDM845
Date:   Mon, 23 Jul 2018 11:22:02 +0530
Message-Id: <1532325123-28067-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v4]
  * Add comments for the RCGs/CBCRs using the CLK_GET_RATE_NOCACHE flag.

 [v3]
  * Move frequency table macro to common file,
    add the patch along to maintain dependency.

 [v2]
  * Removed unused header file includes.
  * Moved the frequency table macro to a common file [1].
  * Move to pll config to probe.
  * Update SoC name in device tree binding and
    also update the Kconfig.

Add support for the display clock controller found on SDM845
based devices. This would allow display drivers to probe and
control their clocks.

Taniya Das (1):
  clk: qcom: Add display clock controller driver for SDM845

 drivers/clk/qcom/Kconfig         |  10 +
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/dispcc-sdm845.c | 686 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 697 insertions(+)
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

