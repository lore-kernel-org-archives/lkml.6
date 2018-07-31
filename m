Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FDFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2223820844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UCNNSgjf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UCNNSgjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2223820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbeGaUA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:00:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeGaUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:00:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A1DA606DD; Tue, 31 Jul 2018 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533061138;
        bh=JpnJcP0xCof96NyGvBR2LJKbq8U2GHGCoXMACvcuNRA=;
        h=From:To:Cc:Subject:Date:From;
        b=UCNNSgjfwWqo8V7S+8GnNcIzOQ/9IhPvyXZK3fJRdmqHw3Y1t9P9gXQ7cs18wOhVU
         tDJ2/OzMmo/16MuRG+xmJSBvPl2nwF0VWWmdiEIQsh8trpizufRRuKJwvnDE/jRcZZ
         Ddk78/EBaXr6GCKtzEaL2ZhUbdOWiJcpwU2CWVQg=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B47CA602D7;
        Tue, 31 Jul 2018 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533061138;
        bh=JpnJcP0xCof96NyGvBR2LJKbq8U2GHGCoXMACvcuNRA=;
        h=From:To:Cc:Subject:Date:From;
        b=UCNNSgjfwWqo8V7S+8GnNcIzOQ/9IhPvyXZK3fJRdmqHw3Y1t9P9gXQ7cs18wOhVU
         tDJ2/OzMmo/16MuRG+xmJSBvPl2nwF0VWWmdiEIQsh8trpizufRRuKJwvnDE/jRcZZ
         Ddk78/EBaXr6GCKtzEaL2ZhUbdOWiJcpwU2CWVQg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B47CA602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org
Subject: [PATCH 0/2] Add Embedded USB Debugger (EUD) driver
Date:   Tue, 31 Jul 2018 11:18:47 -0700
Message-Id: <1533061129-6539-1-git-send-email-pheragu@codeaurora.org>
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

Prakruthi Deepak Heragu (2):
  dt-bindings: Documentation for qcom,eud
  Embedded USB Debugger (EUD) driver

 .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  |  32 ++
 drivers/soc/qcom/Kconfig                           |  11 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/eud.c                             | 340 +++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
 create mode 100644 drivers/soc/qcom/eud.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

