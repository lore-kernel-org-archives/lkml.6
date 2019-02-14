Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1788EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6B021928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IYppTwn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437702AbfBNR5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:57:41 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39139 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437678AbfBNR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:57:41 -0500
Received: by mail-it1-f195.google.com with SMTP id l15so3673471iti.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gAwFmaS66KcV1AlrCQXElQUh5BqKBi7qdQSZ0HpMOj0=;
        b=IYppTwn2yxx9bvqMj0vHkrH6ay+c729O4b4HFCMPg9MtT/IlB7+Bn7hBnC7k3DN56X
         BLaAW56nWMRg1Nzu7XCm43F1cZjHu21eav2duukIekjhLylVo1/R3G15yrcrNCNMs8+c
         1UA4GPqC7XbiVnpCVbCwxTHDAyDPmbVUSlK70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gAwFmaS66KcV1AlrCQXElQUh5BqKBi7qdQSZ0HpMOj0=;
        b=SNHaiGfZlG5Q1+FPrcxIVSAma6WtSP7u9uPdnn9Z59eKw9vZcTPI/8ljbP3/p3EZ3H
         VjnOskm9wPgGuUcn9OEVEGwOb0gUL+rkdWmxT5LQrOoEQCxrcal8dAICiLhi7zqOTFML
         H9jSL8vbCCK+RGMw1BhNvKXJs6KGgUEcW2lHdmhgpZFozS+JUAsT8AnIXZ2dOSmifdbD
         t4CxxwRXLlrO0JVyuchMh9uRYfgjUWlbAZK3LoY7A1OQhV7RdFeWy0ahwhj2uArtHWmk
         fodKnpcRAH6G67VZa6Znamj/nxB2SNisqbynDlD0lH52inBeAb7++Hv0/p7r1MXMW2vM
         lzmQ==
X-Gm-Message-State: AHQUAuYDq8vo3ekMhsqsSXMhIWB23UTmI12FzK4lJF4QX/6Rw/Zlambt
        tXGosaqyXj8mYeujHjo2tcylS4GqBfLE/oGm
X-Google-Smtp-Source: AHgI3IZ0UJKa0urRxDtp7uZXRXOr0T5H9GHJdvZ5xph16p6bBS9JhD6nz5rLvAVsJbgJOz7XasF5Rw==
X-Received: by 2002:a5e:870c:: with SMTP id y12mr2689241ioj.280.1550167060031;
        Thu, 14 Feb 2019 09:57:40 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:57:39 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Date:   Thu, 14 Feb 2019 09:57:17 -0800
Message-Id: <20190214175725.60462-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the following support to the iProc I2C driver:
- Increase maximum read transfer size to 255 bytes
- I2C slave mode
- Polling mode
- NIC I2C mode

This patch series is based on kernel v5.0-rc3 and available at:
https://github.com/Broadcom/arm64-linux.git
branch: i2c-slave-v5

Changes from v4:
 - Add more detailed explanations in the device tree binding document
   changes, to address Rob's review comments

Changes from v3:
 - Various minor fixes on commit messages and commits
 - Rebased to v5.0-rc3

Changes from v2:
 - Address Ray's review comments.

Changes from v1:
 - Rebased to Linux v5.0.0-rc2

Ray Jui (1):
  dt-bindings: i2c: iproc: make 'interrupts' optional

Rayagonda Kokatanur (5):
  i2c: iproc: add polling support
  i2c: iproc: use wrapper for read/write access
  dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
  i2c: iproc: add NIC I2C support
  arm64: dts: Stingray: Add NIC i2c device node

Shreesha Rajashekar (2):
  i2c: iproc: Extend I2C read up to 255 bytes
  i2c: iproc: Add slave mode support

 .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 663 insertions(+), 131 deletions(-)

-- 
2.17.1

