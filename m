Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89311ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF3121527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DFLcAl3E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cj3F+cp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF3121527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJQXOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:14:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:14:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 67E676136C; Wed, 17 Oct 2018 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539789511;
        bh=aR1hrk68+imRuz/m2DzgC3I1gP1ePPSzXCnBXbigPfo=;
        h=From:To:Cc:Subject:Date:From;
        b=DFLcAl3E8IQTbVZo7+K3LWkrLUoJzOgPC0ObMPrCHIXAx+bG5GtlyAE1DA1sabKhN
         DpILCEKbhXUQc5tPu9iPCc+EAc3iSW9I6E+IGtQN5akEkNvh2tG3DB9B7CA8BRuQO+
         Zb0YmUfwzw3GPXrqT8W6w6rko79STOXwqFYxFx/8=
Received: from hydsecbld01.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 654496024C;
        Wed, 17 Oct 2018 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539789510;
        bh=aR1hrk68+imRuz/m2DzgC3I1gP1ePPSzXCnBXbigPfo=;
        h=From:To:Cc:Subject:Date:From;
        b=Cj3F+cp0B78WxNbMx+tNc7220oAYbHEVOodV0XScIRL90GN7DxZPYK0AYTla1cPsP
         cwY1MQYLqtNcqOqlJKTGBHkoNZgX6dqcjSZ08vIjtFnF4OLPgf5dTVhBRaHOZ+V6Ga
         0OgIWcD6T009+4XZYLhr1RCtRbNJwbyasqRaoWZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 654496024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        AnilKumar Chimata <anilc@codeaurora.org>
Subject: [PATCH 0/3] Add Inline Crypto Engine (ICE) driver
Date:   Wed, 17 Oct 2018 20:47:53 +0530
Message-Id: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for QualComm ICE driver which
is embedded in storage device such as UFS/eMMC.

ICE HW provides high throughputs, which meets the line speed
of storage devices. ICE works in bypass or non-bypass mode,
during bypass mode ICE does not perform any crypto operations
but in non-bypass mode ICE will perform encryption/decryption
based on the configuration.

ICE HW supports AES128/256 bit ECB & XTS mode algorithms, which
is used on many SoCs like msm8916, msm8996, msm8953, sdm845 and
many more MTPs from QualComm.

Also adds new functions to firmware driver which are needed to
request secure OS to restore ICE key config when device reset.

These patches have been tested on sdm845 MTP using some additional
patches (a) interconnect changes (b) ufs-ice interface driver
(c) dtsi changes for device init (d) kernel config changes. Once
these patches are accepted rest will be posted.

AnilKumar Chimata (3):
  firmware: qcom: scm: Update qcom_scm_call signature
  dt-bindings: Add ICE device specific parameters
  crypto: qce: ice: Add support for Inline Crypto Engine

 Documentation/crypto/msm/ice.txt                   |  235 +++
 .../devicetree/bindings/crypto/msm/ice.txt         |   34 +
 drivers/crypto/Kconfig                             |   10 +
 drivers/crypto/qce/Makefile                        |    1 +
 drivers/crypto/qce/ice.c                           | 1613 ++++++++++++++++++++
 drivers/crypto/qce/iceregs.h                       |  159 ++
 drivers/firmware/qcom_scm-32.c                     |   30 +-
 drivers/firmware/qcom_scm-64.c                     |   77 +-
 drivers/firmware/qcom_scm.c                        |    8 +-
 drivers/firmware/qcom_scm.h                        |    5 +-
 include/crypto/ice.h                               |   80 +
 include/linux/qcom_scm.h                           |    5 +
 12 files changed, 2213 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/crypto/msm/ice.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/msm/ice.txt
 create mode 100644 drivers/crypto/qce/ice.c
 create mode 100644 drivers/crypto/qce/iceregs.h
 create mode 100644 include/crypto/ice.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

