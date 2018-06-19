Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFAAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FsnHvUB8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FsnHvUB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B9F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937680AbeFSLON (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:14:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936108AbeFSLOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:14:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA613607EB; Tue, 19 Jun 2018 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406850;
        bh=MuskvV6khywYLtLnU121Z7eBZ3h6bgbi44BzFFlaDOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FsnHvUB8CwH6/tcq1ylb444oec81o19S979NyAvHZCOIoUhWSsloMTL7/pYOjg+qW
         tj0nP/UpggmZ8bBLqPYpsTeSMLj2SsroF9IOlDrkDfda2ArlcQs/XDGN+TKA0VIBOa
         +2DGxymttfOXd5I7Fo+DpXXipuH9t21V4v8lvIu0=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A122A60558;
        Tue, 19 Jun 2018 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406850;
        bh=MuskvV6khywYLtLnU121Z7eBZ3h6bgbi44BzFFlaDOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FsnHvUB8CwH6/tcq1ylb444oec81o19S979NyAvHZCOIoUhWSsloMTL7/pYOjg+qW
         tj0nP/UpggmZ8bBLqPYpsTeSMLj2SsroF9IOlDrkDfda2ArlcQs/XDGN+TKA0VIBOa
         +2DGxymttfOXd5I7Fo+DpXXipuH9t21V4v8lvIu0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A122A60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V3 0/7] backlight: qcom-wled: Support for QCOM wled driver
Date:   Tue, 19 Jun 2018 16:43:35 +0530
Message-Id: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series renames the pm8941-wled.c driver to qcom-wled.c to add
the support for multiple PMICs supported by qualcomm. This patch series
supports both PM8941 and PMI8998 WLED. The PMI8998 WLED has the support
to handle the OVP (over voltage protection) and the SC (short circuit protection)
interrupts. It also has the auto string detection algorithm support to
configure the right strings if the user specified string configuration
is in-correct. These three features are added in this series for PMI8998.

changes from v1:
    Fixed the commit message for
    backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c

Changes from v2:
    Fixed bjorn and other reviewer's comments
    Seperated the device tree bindings
    Splitted out the WLED4 changes in seperate patch
    Merged OVP and auto string detection patch

Kiran Gunda (7):
  backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
  backlight: qcom-wled: restructure the qcom-wled bindings
  backlight: qcom-wled: Add new properties for PMI8998
  backlight: qcom-wled: Rename PM8941* to WLED3
  backlight: qcom-wled: Add support for WLED4 peripheral
  backlight: qcom-wled: add support for short circuit handling
  backlight: qcom-wled: Add auto string detection logic

 .../bindings/leds/backlight/pm8941-wled.txt        |   42 -
 .../bindings/leds/backlight/qcom-wled.txt          |  172 +++
 drivers/video/backlight/Kconfig                    |    8 +-
 drivers/video/backlight/Makefile                   |    2 +-
 drivers/video/backlight/pm8941-wled.c              |  432 -------
 drivers/video/backlight/qcom-wled.c                | 1327 ++++++++++++++++++++
 6 files changed, 1504 insertions(+), 479 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
 delete mode 100644 drivers/video/backlight/pm8941-wled.c
 create mode 100644 drivers/video/backlight/qcom-wled.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

