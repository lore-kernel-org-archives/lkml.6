Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925922081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VVIwL3Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfBDXQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:16:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfBDXQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:16:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so591102pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FZYrLK/lxLuywQHDGfBDjGukG0xlqWSO2TkmX/SQd+s=;
        b=VVIwL3QbFwtTS0T2mgVOi+oqUYxwM0BBwHnGVgrh/rnXnSwWNYCr/zUSfTwSQKAk4Q
         quLZPy29dj4jhP+VMetYuOVmVzyr+aJ7h0K6j+93cVmr2poiwY4CeJhShnjAhsa5SJF1
         O59uYVMx7fm/npMFW9yYyGvEd9jg3BjmK6aNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZYrLK/lxLuywQHDGfBDjGukG0xlqWSO2TkmX/SQd+s=;
        b=Ey/ksKghak8pFdne5EFpbVfADgEBWlY6+sURete6OboSPR3kiiphKYH6d1Upj67i3P
         jsnitCts6QuvLXsof7aCNhEWTVYgq0BlZ1jNOBOOsIYZxvRYvi2GNgDcipTRsZXSA5/Q
         KQDyc5T/F6zNDg/l8cP2OIQwCQ+aPySl8u6bbbaYfpatY63SVk2agG0t9hszq900fCmj
         WtlvXrv7KRBvpa6NKuz2SCToFN34FJUEOhpZSzhzvSB8UvUtVk5XamZ6VEefRTqyi11/
         7H+MojB7r7QEFFd7fxl0hju60nqoioI167u4r0quQZXgydTzOhzUHS1QAMDUh+unauoD
         Pg3Q==
X-Gm-Message-State: AHQUAubCVIuv1Rv7RRB7ZYWwYYwPsg2U1giBlSCNhaVTsew10JW1/Psc
        GxHV0KTHIA2//mVG2dBOJD+KAQ==
X-Google-Smtp-Source: AHgI3IbzaRDM4alCNgc8KJ7fBr/RZWgIcUT3a9RT8PD7dPte4mk1c9vCj93bbbVoObiFdVDwLS6zGg==
X-Received: by 2002:a63:d90b:: with SMTP id r11mr1705354pgg.5.1549322165006;
        Mon, 04 Feb 2019 15:16:05 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:16:04 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 0/8] iProc I2C slave mode and NIC mode
Date:   Mon,  4 Feb 2019 15:15:46 -0800
Message-Id: <20190204231554.87666-1-ray.jui@broadcom.com>
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
branch: i2c-slave-v4

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

 .../bindings/i2c/brcm,iproc-i2c.txt           |  15 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 661 insertions(+), 131 deletions(-)

-- 
2.17.1

