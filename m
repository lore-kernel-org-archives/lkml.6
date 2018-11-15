Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590AB2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oxauPVpA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oxauPVpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590AB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbeKPFmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:42:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:42:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DD62E60591; Thu, 15 Nov 2018 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542310382;
        bh=qYs4IoEqgQawc1eY/ZOr/BTEa3/G6umwSXFET7yXgqY=;
        h=From:To:Cc:Subject:Date:From;
        b=oxauPVpAkbRWPsUM8J8Bnb06RaqfS+mEMqduinB7IVkkjpAZKe1k27vR/Ec/CwfA8
         9t41uurVu1PnEq3GuGAD7yr2A1Iubf4febIbHLLoXRl4Ckh/r5soQkfUpK2nRhg00H
         w2/TKYGcy+pj2HyKw/AeVef4L58gagyBCUJweyas=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2316C60251;
        Thu, 15 Nov 2018 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542310382;
        bh=qYs4IoEqgQawc1eY/ZOr/BTEa3/G6umwSXFET7yXgqY=;
        h=From:To:Cc:Subject:Date:From;
        b=oxauPVpAkbRWPsUM8J8Bnb06RaqfS+mEMqduinB7IVkkjpAZKe1k27vR/Ec/CwfA8
         9t41uurVu1PnEq3GuGAD7yr2A1Iubf4febIbHLLoXRl4Ckh/r5soQkfUpK2nRhg00H
         w2/TKYGcy+pj2HyKw/AeVef4L58gagyBCUJweyas=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2316C60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org, rnayak@codeaurora.org
Subject: [PATCH v3 0/2] Add Embedded USB Debugger (EUD) driver
Date:   Thu, 15 Nov 2018 11:32:52 -0800
Message-Id: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
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

Changes since v2:
- Remove module_param and add sysfs support instead
- Simplify if-else condition
- Change if-elseif to switch case
- Return -ENOMEM
- Got rid of unnecessary checks in sysfs store function
- Updated the dt-binding
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

