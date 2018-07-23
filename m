Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B94ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE94B20891
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cy0OvDdG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IeQlnQIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE94B20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbeGWLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:55:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:55:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5331D60B19; Mon, 23 Jul 2018 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532343296;
        bh=JYn7jtcE9s+XP0jYbhmJKnS4JI3Wf3sKOONAkWmd64c=;
        h=From:To:Cc:Subject:Date:From;
        b=cy0OvDdGat+Nn5lZ7ac1CvfkOSwKYfa3RF/JMYgm06zhVowL8oJBLczlQXUj2pTL/
         RrJEytZI7oI7Z+May5PLEUv57Q4sZptFWGa9yLknI2waBhVTEfWqOT1L8urMrgrbZu
         vwfBd4RPoM8yRz58MUCokbk4TnVv9GLoFadkNP5I=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C3C560B15;
        Mon, 23 Jul 2018 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532343287;
        bh=JYn7jtcE9s+XP0jYbhmJKnS4JI3Wf3sKOONAkWmd64c=;
        h=From:To:Cc:Subject:Date:From;
        b=IeQlnQIohjspQK0v+ekHXENSvNw+iZtuij8QgLXfV/CHI+oPXJWG3g1DZT+zw+2Hz
         7qUlXhyOVIGOahcHeCyWhzO0G3ffaqYiMWn82I3lyWoq05VDEDEm0hgpN780EF3tDZ
         fFWTSqjlz8/XaNZkzQO8B13sEyT00K4ZdfBRTPJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C3C560B15
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
Subject: [PATCH v5] Add display clock controller driver for SDM845
Date:   Mon, 23 Jul 2018 16:24:34 +0530
Message-Id: <1532343275-7027-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v5]
  * Initialize pll config before assigining l/alpha values for
    pll configure.
  * Add module description.

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
 drivers/clk/qcom/dispcc-sdm845.c | 687 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 698 insertions(+)
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

