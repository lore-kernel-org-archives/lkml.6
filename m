Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6EAECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C920868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ltQgFUQz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tt0Tt/lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108C920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGUTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:08:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeGUTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:08:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9F7B56021A; Sat, 21 Jul 2018 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196915;
        bh=qWB+6F+5j4ioDrNIoZqItS1A/kRvlZVocpg8Abk/Gsw=;
        h=From:To:Cc:Subject:Date:From;
        b=ltQgFUQzH9RW9Pp5VQZdek5T8beg9/JLKMIDym5f59/3DzbyWrnQjr+XIbgJ0w1dt
         i57lBy05bYBE7EuNRfmWBmwK26sDKLg/r/wNN9NWc+qxIOWEYzMEVJC1yuP5wwI9Vw
         FGVzolkofCW1+Kk4IYO1B74OdjcOYV80Kt+RTTzY=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 675166021A;
        Sat, 21 Jul 2018 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196914;
        bh=qWB+6F+5j4ioDrNIoZqItS1A/kRvlZVocpg8Abk/Gsw=;
        h=From:To:Cc:Subject:Date:From;
        b=Tt0Tt/lhkFzewTCmUh9j1WDxjYyGYWZpCva4ePl3BkNNFC0ePCjBNPsVS7sj273ou
         th8YnDZfNW/E4EgNrt38yv3BGeRQr+vEbEnusRbBauD6BjjRK3O8NBA8g25hRPS2vI
         7oYTfakdsjK9PctdS5+f+BEcRahEidPaDUxHNI5Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 675166021A
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
        grahamr@qti.qualcomm.com, Taniya Das <tdas@codeaurora.org>
Subject: [RFC PATCH 0/4] clk: qcom: Add support to vote to genpd
Date:   Sat, 21 Jul 2018 23:44:58 +0530
Message-Id: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A clock controller could be connected to single or multiple power domains. Add
support for powerdomain_class which would help associate these power domains to
the RCGs and PLLs in the clock controller. Map the domain and the corresponding
frequencies to the clock(RCG/PLL). The clock frequency request from a consumer
would be mapped to the corresponding performance corner, aggregated at the
clock driver and would be vote/unvoted to the genpd framework for the desired
performance state.

This series add an example of power domain class for sdm845 RCG/PLLs and the
corresponding frequency mappings. This depends on power domain drivers of
SDM845 https://lkml.org/lkml/2018/6/27/7.

Taniya Das (4):
  clk: qcom: Add support to request power domain state
  clk: qcom: Initialize the power domain class for each clock
  clk: qcom: Add prepare/unprepare clock ops for PLL/RCG
  clk: qcom: sdm845: Add Power Domain to RCGs and PLL

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   2 +
 drivers/clk/qcom/Makefile            |   1 +
 drivers/clk/qcom/clk-alpha-pll.c     |  52 ++++++++--
 drivers/clk/qcom/clk-pd.c            | 193 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-pd.h            |  55 ++++++++++
 drivers/clk/qcom/clk-rcg2.c          |  61 +++++++++--
 drivers/clk/qcom/clk-regmap.h        |   5 +
 drivers/clk/qcom/common.c            |  17 ++-
 drivers/clk/qcom/gcc-sdm845.c        |  83 ++++++++++++---
 9 files changed, 427 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-pd.c
 create mode 100644 drivers/clk/qcom/clk-pd.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

