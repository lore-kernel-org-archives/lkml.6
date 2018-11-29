Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676ECC07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D11F20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh6mVg/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D11F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeK3EJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46660 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbeK3EJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:09:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so2481620edt.13;
        Thu, 29 Nov 2018 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QYekYkCJ9va5Ej26Sb6KIQZPO7Q+xaS5+xjZEy20tc4=;
        b=eh6mVg/LYJw6o/mAWEkZdphZPeE8VBn6DYjUkeeyfJfXJACrbjd4I1QwFlAKoT69ig
         yyzLYZ0zBVACwztxvgi9toEf6T6Y1wIXOBnCB2Le1Ki+L3uKpOUTT5jhXzsIguMT7+hP
         qzrxLqtWKFVNI2VjV/wIEv1kT/2rQjTIFd1LKlijseEmpd/kRmSnJAdu9JKAmczLGeZR
         XEfmRmjel2tlCIlDgm+FpPOUX6f944IpQiqOhRvIwEqrYNGXDXY7cn0LRzDojR/0VVci
         pWOjefeZKuMEcFnshnHwqIsjCcxGzykYDLQmEtQp84hNR0aswX4WUAFM5DUlB4qmS8AK
         kGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QYekYkCJ9va5Ej26Sb6KIQZPO7Q+xaS5+xjZEy20tc4=;
        b=f4xlLnumwW8txR6oIw83ehnNeKbSACxc0MGOXtwgljwu1irlR9Vbg1CpnzDkijY7us
         pK++gR8YThuq5O2CfF9QPYYEbCwM2MjjugUbB3AZCevPb6oC5n4rfCoacEQ+P3P6FJSV
         u/jI6ZEnHEGe7gsspcICsnKFiJrCNb+q3HfBhvsvwBf77HM09c66xgTMJs6AYcExHeP8
         phTCc/9K6dmhsoNj9/tj8VDg3hXJvlFDkcnkV/ITMSOnGi2GfPU4H/uqDRt4LY0o/Vzl
         ntsZfndoFRN+7ja7v/UTLU1uT9AXefG3x9JsH9jR/IA8J5DWi9Rpn9v5ZbQRjTe3QnPR
         hFtg==
X-Gm-Message-State: AA+aEWayTlAeNYA650HBy+tI4qAPov278btRfzdIYrFKy/E2lXdSydR3
        yiITr1Ef0mtT1UTTpU15guQ=
X-Google-Smtp-Source: AFSGD/XsPpRoT8gAS70tgIytqiDaZ+znh1+PSeHmvoEpN38aPJUPhU2QhvSfmjJfYoNVzoUeIjvMlQ==
X-Received: by 2002:a05:6402:1299:: with SMTP id w25mr2211657edv.237.1543510994441;
        Thu, 29 Nov 2018 09:03:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 13-v6sm417496ejx.39.2018.11.29.09.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:03:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Implement wake event support on Tegra186 and later
Date:   Thu, 29 Nov 2018 18:03:07 +0100
Message-Id: <20181129170312.23625-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

The following is a set of patches that allow certain interrupts to be
used as wakeup sources on Tegra186 and later. To implement this, each
of the GPIO controllers' IRQ domain needs to become hierarchical, and
parented to the PMC domain. The PMC domain in turn implements a new
IRQ domain that is a child to the GIC IRQ domain.

The above ensures that the interrupt chip implementation of the PMC is
called at the correct time. The ->irq_set_type() and ->irq_set_wake()
implementations program the PMC wake registers in a way to enable the
given interrupts as wakeup sources.

This is based on a suggestion from Thomas Gleixner that resulted from
the following thread:

        https://lkml.org/lkml/2018/9/13/1042

Changes in v2:
- dropped the Tegra PMC specific patches to simplify the series
- drop wakeup-parent usage, lookup up PMC by compatible
- convert Tegra186 GPIO driver to use valid mask
- move hierarchy support code into gpiolib core

Linus, this contains the conversion patch to use a valid mask instead of
the sparse number space that you requested. I've kept it in a separate
commit because I'm still hoping that you may decide that it's okay to
have the sparse number space. The delta is just 53 lines of code, which
I think is small enough to warrant the extra code. But if you insist on
having the core take care of everything and that the Tegra GPIO driver
should be over-allocating GPIO and IRQ descriptors in order to make it
look more like other drivers, then so be it. In either case, the series
now has gpiolib core support for hierarchies and Tegra works with it in
both the sparse number space and valid mask cases.

Thomas, patch 2 is required in order to avoid build failures when the
Tegra186 GPIO driver is built as a module. Since there's a build
dependency on that from patch 4, I think it'd be easiest if this could
go in via Linus' tree with your Acked-by. Would you mind providing one?

Thierry

Thierry Reding (5):
  gpio: Add support for hierarchical IRQ domains
  genirq: Export irq_chip_set_wake_parent()
  gpio: tegra186: Rename flow variable to type
  gpio: tegra186: Implement wake event support
  gpio: tegra186: Use valid mask instead of sparse number space

 drivers/gpio/Kconfig         |   2 +-
 drivers/gpio/gpio-tegra186.c | 220 ++++++++++++++++++++---------------
 drivers/gpio/gpiolib.c       |  33 +++++-
 include/linux/gpio/driver.h  |   6 +
 kernel/irq/chip.c            |   1 +
 5 files changed, 161 insertions(+), 101 deletions(-)

-- 
2.19.1

