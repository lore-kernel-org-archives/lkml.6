Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FFC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2893E24C69
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzYVNLJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2893E24C69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeFWQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:12:07 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41186 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeFWQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:12:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so4248397pgl.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fBrpQaiYQ2DtPDmg28kYi4QnQLndlnI0R46Io1LHIwI=;
        b=CzYVNLJWqYA2HxwdFzTnEKXMRW7JaKNeS5sTzV7z7WjmD/l34eDAtpT2WPw8DkYG1b
         vymoF6iITY1ScCvl3pXz2r/4i1KHPLdsNL6H4lnuwW1Y5faBgvpXiVp51l6T0YOxpd3v
         Kdr9MXVuzmZnCZ3xkbYMzpobDkDAGBsbEgrsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fBrpQaiYQ2DtPDmg28kYi4QnQLndlnI0R46Io1LHIwI=;
        b=Y3caPHeSSD7k+/NRPLT1VcTZudNi5RLH6T6QhWbfTdTcUum6phVdeuTQv72flmxuIT
         3Spa/urzTE3Kh7BfUQS5E0/xJBx/T3FTK4rRdzq/UVO0znxLyQwFzViTJN2qa2suP5Ny
         eBnLgPtlGKPCWdTQUl85dDIkQE6R8mMLktRHPlltNhzsYbMFqczJJWFYZC+Mu+ARwdOM
         f1YXGf/doXCvGXvAdXsCpfvfGCHuu9Ty4q+DVHJ5LER6/0upxGJTwKwJUhIQDgUD6+Nt
         r3lk5GwaA5ZxkEdBgF7dCNWpi8FcvoP28MR9zFD1qCw37DKwTyo4ITC2OBRthHWdmx5a
         BN8w==
X-Gm-Message-State: APt69E2KXDaCZTzQY9gVrHYxWSwK+G6rLzfrzYdEMnLTJjuT7IqUzQym
        Ll5yR8caBs169OAAsGDzMYwZ
X-Google-Smtp-Source: ADUXVKKGin8Pg7TxyDkN/2alGZr1UMBzr5O4Uiy8g1VLn7hHDrntmgsB5OtKuYDQK5CwfhaRoz/kWQ==
X-Received: by 2002:a62:8995:: with SMTP id n21-v6mr6335266pfk.83.1529770324084;
        Sat, 23 Jun 2018 09:12:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:100:fa16:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id n26-v6sm2732745pfi.168.2018.06.23.09.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:12:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add Actions Semi S900 I2C support
Date:   Sat, 23 Jun 2018 21:41:42 +0530
Message-Id: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds I2C controller support for Actions Semi S900 SoC.
This driver has been structured in a way such that there will be only
one controller driver for the whole OWL family series (S500, S700 and
S900 SoCs).

There are 6 I2C controllers with separate memory mapped register space.
The I2C controller can handle atmost two messages concatenated by a
repeated start via its internal address feature. Hence the driver
uses this feature for messages of length greater than 1. In those cases,
the first message of the combined message should be a `write` with maximum
message length 6 and the second message's maximum length should be 240 bytes.

As far as the bus speed is concerned, this driver only supports
Standard (100KHz) and High speed (400KHz) for now.

The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
With the mux option available only for I2C0.

For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
are exposed on the Low speed expansion connector are enabled.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
  arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
  i2c: Add Actions Semi OWL family S900 I2C driver

 .../devicetree/bindings/i2c/i2c-owl.txt       |  27 ++
 .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 ++
 .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
 drivers/i2c/busses/Kconfig                    |   7 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-owl.c                  | 459 ++++++++++++++++++
 7 files changed, 594 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
 create mode 100644 drivers/i2c/busses/i2c-owl.c

-- 
2.17.1

