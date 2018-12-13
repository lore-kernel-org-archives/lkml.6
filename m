Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E350EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92E320645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4bQeLgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92E320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeLMM3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:29:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44526 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:29:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so1587963lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUnSajOnB2yzE0EVCtojf34x+xnTvDA+87TAkD8K13g=;
        b=N4bQeLgrubPrWjBAsMpwBbZm9eO1rGYGpdZfZSivuWd56bhcuqYj7ORKVQ6irLZcdo
         FMqfix/ATKE79PDj/8yxPm9vR9qrqgexYjLJ7r2gdb6YA1YAZ8GlvmD/+OVvkUk7GNA+
         Rub0RZ1ar2FvyOsNA8xfXiX2RBEF+wc/dK85U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUnSajOnB2yzE0EVCtojf34x+xnTvDA+87TAkD8K13g=;
        b=WaHC5EKkXhfo79Y4axRoUUrXB28NfdLkedbCE8UYG4ulPKMvhSH/CX4YTTSiFuKv6m
         CRaUOax+7fYwfqR6Q59a/Gcll6IANnFbd8YGVmc/O4C290xBeqiQcjx3st5nw7yT8lEc
         VbDc/2RnD4j/VNDCA+lgxrmIf9LRS6b6L1GFmw9v4zNWib7EbtbLfq2uxnt6NRk+ktaj
         t/SBrqYyxgmjyaftynllOz3nyUiPxW2SGdQ2ZTTeER3UumoBzCMniEVeLRFGBc+wIpEo
         QxC3sMiE+w8J0D+jL/SeK4+C22HrWm4cEEcnyR1vctPKlBTrg0fxVlXqpbiNUI+mOZ2g
         okzg==
X-Gm-Message-State: AA+aEWYBonXvFlBZiwbOtpqK3zhW2ZelIigN6Djui11XTmiI2hzimm/O
        EMSDPVt0v1NpjRbWVu+gPcMk/sSDcdt5ig==
X-Google-Smtp-Source: AFSGD/VvuOlNMPf+wKFguznTwQ2JDYTPqjtE1/hHrcBtp9oqLpRdgx9w4QnyenuevQ0vXDVaoOc76A==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr16225731ljj.158.1544704179918;
        Thu, 13 Dec 2018 04:29:39 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id q20sm325513lfj.20.2018.12.13.04.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 04:29:38 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org,
        broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH 0/3] Make allmodconfig boot in qemu-arm64
Date:   Thu, 13 Dec 2018 13:29:07 +0100
Message-Id: <20181213122910.24193-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With this patch set I've been able to get a allmodconfig kernel to boot
under qemu-system-aarch64.

The patch "config: provide a fragment to enable gdb for qemu" I found
useful when trying to figure out how it fall over. So when I have to
debug a kernel with gdb I just ran this:
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -skj$(getconf
_NPROCESSORS_ONLN) O=obj-arm64-next-20181213 allmodconfig
kvm_guest.config qemu-gdb.config
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -skj$(getconf
_NPROCESSORS_ONLN) O=obj-arm64-next-20181213 Image

Before we do the same job on other architectures we wanted to reach out
and ask to see if this seams a reasonable way forward ?

The end goal would be to be able to run test suites on a allmodconfig
kernel. We may end up with another fragment that turn off/on a lot of
debug options and selftests during boot up since that may cause issues
for other test suites like kseftest, LTP and so on.

Cheers,
Anders

Anders Roxell (3):
  config: provide a fragment to enable gdb for qemu
  lib/ubsan: default UBSAN_ALIGNMENT to not set
  arm64: add a new config option KTEST_RUNNABLE

 arch/arm64/Kconfig             |  8 ++++++++
 drivers/tty/hvc/Kconfig        |  1 +
 init/Kconfig                   |  1 +
 kernel/configs/qemu-gdb.config |  7 +++++++
 lib/Kconfig.ubsan              | 14 +++++++++-----
 5 files changed, 26 insertions(+), 5 deletions(-)
 create mode 100644 kernel/configs/qemu-gdb.config

-- 
2.19.2

