Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C6FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56742075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YBoiyPdC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YBoiyPdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56742075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIECCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:02:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIECCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:02:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 707C96034F; Tue,  4 Sep 2018 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536096943;
        bh=IKS+c0VD0lEcZjTtdAy7fcfc1V7M4yOJ6jYoE19hJdY=;
        h=From:To:Cc:Subject:Date:From;
        b=YBoiyPdCGLrLNJ8RqWZcgLZZhwG/kGH+PCPtaoi91g9YM/uLlDTaejRMYctWH4qzp
         qUpr/7NGp1/GGc5VCyyaR22hlQL6iO4DgIywtYyUh38QKddAozz79f2led/JocoDrp
         r2T0BqcO6fnN171zT6nfeqvEQvQQa2eU0Ftx3EPY=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B29C26034F;
        Tue,  4 Sep 2018 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536096943;
        bh=IKS+c0VD0lEcZjTtdAy7fcfc1V7M4yOJ6jYoE19hJdY=;
        h=From:To:Cc:Subject:Date:From;
        b=YBoiyPdCGLrLNJ8RqWZcgLZZhwG/kGH+PCPtaoi91g9YM/uLlDTaejRMYctWH4qzp
         qUpr/7NGp1/GGc5VCyyaR22hlQL6iO4DgIywtYyUh38QKddAozz79f2led/JocoDrp
         r2T0BqcO6fnN171zT6nfeqvEQvQQa2eU0Ftx3EPY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B29C26034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v2 0/2] Add Embedded USB Debugger (EUD) driver
Date:   Tue,  4 Sep 2018 14:34:11 -0700
Message-Id: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches that implements a driver for the control
peripheral, EUD (Embedded USB Debugger). The EUD is a mini-USB hub 
implemented on chip to support the USB-based debug and trace capabilities.
Apart from debug capabilities, EUD has a control peripheral. Control 
Peripheral is on when EUD is on and gets signals like USB attach, pet EUD,
charge phone etc. EUD driver listens to events like USB attach or detach 
and charger enable or disable and then notifies the USB driver or PMIC 
driver respectively about these events via EXTCON. At regular intervals, 
the EUD driver receives an interrupt to pet the driver indicating that 
the software is functional.

Changes since v1:
- Remove EUD_NR as it is an unused macro
Changes since v0:
- Remove select SERIAL_CORE from Kconfig as this patch doesn't involve
  anything related to serial console
- Changed the dt-bindings to remove extcon and replace it with graphs
  to represent a connection with client

Prakruthi Deepak Heragu (2):
  dt-bindings: Documentation for qcom,eud
  Embedded USB Debugger (EUD) driver

 .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  |  41 +++
 drivers/soc/qcom/Kconfig                           |  12 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/eud.c                             | 338 +++++++++++++++++++++
 4 files changed, 392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
 create mode 100644 drivers/soc/qcom/eud.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

