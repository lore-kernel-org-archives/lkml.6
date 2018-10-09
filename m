Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F1C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E22086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GLLjUqLX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F8qak1QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74E22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJIVPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:15:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:15:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50F9660C4D; Tue,  9 Oct 2018 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539093482;
        bh=vfmRSyuMaC9KPoj3dlp9r/t6HWXV2U4+tB3C6onk0/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=GLLjUqLXOngYJDy3KuBoCsgrFZeU203C/32XL6XZK15xb5Z5K/fjllIlBlQUdInTh
         e1IraR1PNEB3cw6EYFNUSG3/XV7hQ2wFTofR4m3fJNb7c2SgYaB9ElYSoMSUtzSk1T
         VYMP2fmAHyTdvi05s1vivmU6VzYhaiChmmkPjEQA=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B6EA60866;
        Tue,  9 Oct 2018 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539093480;
        bh=vfmRSyuMaC9KPoj3dlp9r/t6HWXV2U4+tB3C6onk0/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=F8qak1QOqkSSf26JHRyHmn6mvV9EJ810BaPzpnfp3ZdGSUW0PF0jiFX7x8UbakX5c
         Mg6sIecfy7Eu7OQKftXR4HXzXd0bb/3p2IEKlXpCxnw73eNKOi0nWs2tUjvA14XUFi
         TTO0s5VtPGNnOP7rpoJaTTTRKiqKdOSKbADIinN8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B6EA60866
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
        chandanu@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 0/2] Add support for display port clocks and clock ops
Date:   Tue,  9 Oct 2018 19:27:45 +0530
Message-Id: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New display port clock ops supported for display port clocks.
Also add support for the display port related branches and RCGs.


Taniya Das (2):
  clk: qcom: rcg2: Add support for display port clock ops
  clk: qcom : dispcc: Add support for display port clocks

 drivers/clk/qcom/clk-rcg.h                     |   1 +
 drivers/clk/qcom/clk-rcg2.c                    |  86 +++++++++
 drivers/clk/qcom/dispcc-sdm845.c               | 232 +++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,dispcc-sdm845.h |  11 ++
 4 files changed, 330 insertions(+)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

