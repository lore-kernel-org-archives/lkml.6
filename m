Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50977C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC23020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D2fY20/U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D2fY20/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC23020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbeHAHXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:23:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbeHAHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:23:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EFF5560264; Wed,  1 Aug 2018 05:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101956;
        bh=foOIv5q0/91S7srXkGglOUQ3XZa/mtw+7lPFGz+3EXg=;
        h=From:To:Cc:Subject:Date:From;
        b=D2fY20/UupElhe1QktwRWSWhImLNL/cmZ9kUoJcsn6nIUk9VGLqQcMIfDoZErB+eP
         9dAJ81JS4RpTXGzlvGklg8tjnZGzxkQtvhYh0GPSpMO9dFV4Fgjri+dwaST/a1p/S/
         FP9rv4nHHR//UyNrbkt7tFJs1HO4BepfFrr14wb0=
Received: from corebsp04-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mshettel@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 251D060264;
        Wed,  1 Aug 2018 05:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101956;
        bh=foOIv5q0/91S7srXkGglOUQ3XZa/mtw+7lPFGz+3EXg=;
        h=From:To:Cc:Subject:Date:From;
        b=D2fY20/UupElhe1QktwRWSWhImLNL/cmZ9kUoJcsn6nIUk9VGLqQcMIfDoZErB+eP
         9dAJ81JS4RpTXGzlvGklg8tjnZGzxkQtvhYh0GPSpMO9dFV4Fgjri+dwaST/a1p/S/
         FP9rv4nHHR//UyNrbkt7tFJs1HO4BepfFrr14wb0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 251D060264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mshettel@codeaurora.org
From:   Mike Shettel <mshettel@codeaurora.org>
To:     gregkh@linuxfoundation.org, boris.brezillon@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     Mike Shettel <mshettel@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH v1 0/3] Add a driver for Qualcomm GENI I3C master IP
Date:   Tue, 31 Jul 2018 23:38:59 -0600
Message-Id: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a proposal for the I3C master driver for the
Qualcomm GENI IP. This patch is to be applied on top of the I3C
subsystem patchset v6 submitted by Boris Brezillon.

Features supported:
  Regular CCC commands
  I3C private transfers
  I2C transfers

Features not yet supported:
  Hot-join
  IBI


Mike Shettel (3):
  i3c: master: Add a driver for Qualcomm GENI I3C master IP
  dt-bindings: i3c: Document Qualcomm GENI I3C master bindings
  MAINTAINERS: Add Qualcomm Generic Interface I3C driver maintainer

 .../devicetree/bindings/i3c/qcom,geni-i3c.txt      |   44 +
 MAINTAINERS                                        |    8 +
 drivers/i3c/master/Kconfig                         |   13 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-qcom-geni.c          | 1243 ++++++++++++++++++++
 5 files changed, 1309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
 create mode 100644 drivers/i3c/master/i3c-master-qcom-geni.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

