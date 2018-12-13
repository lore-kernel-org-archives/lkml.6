Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9E20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZPHVZFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE9E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeLMM34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:29:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43449 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:29:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so1591211ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7v+eyqie2cB1+vf39GL9pAK9Ipawgsoh7U/TPnLRuMk=;
        b=NZPHVZFat3PN86WLABijEXcEmnku+kVZgAqWvZz2xTLqo8GcFjpAdu56s3fu49PUGo
         kZMkh41Wb25B5gWhtZAVJ9pi88GG+jJriOgvsydeeLCQtanhIh19PCeGmlczE1Y+viQb
         LL2+HWUW8TBGl4A5IpUIu3T3o8rQRKb417/CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v+eyqie2cB1+vf39GL9pAK9Ipawgsoh7U/TPnLRuMk=;
        b=T3j2BTLeYSxY+LegQhu83f6fvO4YhhwUI9++Tzfj5jFyz6TJXE5qS/nuQNg7GdG7wL
         voc9vdvK3KmNrf7owNEb83V0SXN2blaAjrTQFdHu8tmsDHHiWprJIgNlahI+qVu/X1Dm
         gsSQUljGosKyxZkqCS5wOP+jic60QcLSmR3VL9i2p1h2DtqI5KMJ3eYEnRyFa4nPdK8k
         OJLeU49SGU6mBqKmwx4WV88cGGSt3WS7X7ETumKk8gtGH4qo4VQiBeKn6LQtGXNqipJM
         LmBrUJ/7o91uQ8zDUEvT+F2Qa4euRH5FBfurly5rO0O4CyOeC6o1ff6v9kifQwGKfq91
         I+xA==
X-Gm-Message-State: AA+aEWYadUtdGGeD+rWPwWaRl5qKIQ985rHY0A3kI6eVJYxi48MX4ib1
        SDUae9022rezSUcW51C2Kz2L38UulLxEcw==
X-Google-Smtp-Source: AFSGD/XwznRxjHG0ls0YGvgxq45TP9zUY7oexe0pKfKcG7Vd5URtXEUoKRqW4LfXEObe5FbMAU/q1g==
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr14743517lje.62.1544704192110;
        Thu, 13 Dec 2018 04:29:52 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id o17sm312349lff.77.2018.12.13.04.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 04:29:51 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org,
        broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH 3/3] arm64: add a new config option KTEST_RUNNABLE
Date:   Thu, 13 Dec 2018 13:29:10 +0100
Message-Id: <20181213122910.24193-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213122910.24193-1-anders.roxell@linaro.org>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this new config option, we can boot a allmodconfig kernel in qemu.
Config options SERIAL_AMBA_PL011, SERIAL_AMBA_PL011_CONSOLE, UNIX needs
to be enabled in order to get a console. Options like CPU_BIG_ENDIAN,
CMDLINE_FORCE, CMDLINE_OVERRIDE and HVC_DCC needs to be disabled.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig      | 8 ++++++++
 drivers/tty/hvc/Kconfig | 1 +
 init/Kconfig            | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f52362f8d99..bb17ccb7bab2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -292,6 +292,12 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config KTEST_RUNNABLE
+	bool "Test build kernels that run in qemu for ktest"
+	select SERIAL_AMBA_PL011
+	select SERIAL_AMBA_PL011_CONSOLE
+	select UNIX
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
@@ -773,6 +779,7 @@ config ARM64_PA_BITS
 
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
+	depends on !KTEST_RUNNABLE
        help
          Say Y if you plan on running a kernel in big-endian mode.
 
@@ -1381,6 +1388,7 @@ config CMDLINE
 
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
+	depends on !KTEST_RUNNABLE
 	help
 	  Always use the default kernel command string, even if the boot
 	  loader passes other arguments to the kernel.
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4293c172e120..44e23c2388bd 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -82,6 +82,7 @@ config HVC_UDBG
 config HVC_DCC
        bool "ARM JTAG DCC console"
        depends on ARM || ARM64
+	depends on !KTEST_RUNNABLE
        select HVC_DRIVER
        help
          This console uses the JTAG DCC on ARM to create a console under the HVC
diff --git a/init/Kconfig b/init/Kconfig
index b633716e48f5..3ea5297b7305 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1844,6 +1844,7 @@ config CMDLINE_PREPEND
 config CMDLINE_OVERRIDE
 	bool "Built-in command line overrides boot loader arguments"
 	depends on CMDLINE_BOOL
+	depends on !KTEST_RUNNABLE
 	help
 	  Set this option to 'Y' to have the kernel ignore the boot loader
 	  command line, and use ONLY the built-in command line. In this case
-- 
2.19.2

