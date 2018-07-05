Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E42C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF98824116
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VnO/abMf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="klkskZGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF98824116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeGEGzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:55:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeGEGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:55:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B57B860B28; Thu,  5 Jul 2018 06:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530773734;
        bh=oih9bRWFgQbXmwqTMMjI8Ta/OmLEOoeZvW5xgj0TIms=;
        h=From:To:Cc:Subject:Date:From;
        b=VnO/abMfqjAgZNDmCJ3nwgBZjNI+41cwX1tL+rZfX21Q81XpiXLJUhhpwNsJ+Uhxx
         lMZiNDCfNCmOHhiIgwUi1kJNMB98umtmvhiOlS0sQCu8uFrIAEWVLEFtPf6IMCw0pi
         53M77Wazihs7U+U5O6TV/I3jpwDHsBBCsRDDy2wU=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5009D606AC;
        Thu,  5 Jul 2018 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530773733;
        bh=oih9bRWFgQbXmwqTMMjI8Ta/OmLEOoeZvW5xgj0TIms=;
        h=From:To:Cc:Subject:Date:From;
        b=klkskZGnPEorl3BkFopDBYYZbtDGlNoje+F+oFRqgMZfHaenr1/xydR27y57BW2HP
         xrxqV3gRegQ2LiXj8C8+2E/0tZxtT2I9yTM4lqgSFANXdrm/CXOfa1kcZ9K03FoOzt
         n6WlOSWNaCjeJPJ704c3BdrWSOwWSrTWEruRkBKY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5009D606AC
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
        rohitkr@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] Add support for LPASS clock controller for SDM845
Date:   Thu,  5 Jul 2018 12:25:19 +0530
Message-Id: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../devicetree/bindings/clock/qcom,lpasscc.txt     |  31 +++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/lpasscc-sdm845.c                  | 243 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |  18 ++
 4 files changed, 301 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

