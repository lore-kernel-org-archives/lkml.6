Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D151C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C104208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="dXsEfLIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C104208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJBAiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:38:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45558 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJBAiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:38:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so9979921pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+sf2qpwdduLxk0SLY+c4uiB9i35zOOSrTwM5H0xSWcU=;
        b=dXsEfLItOcXZI+xJxEme8AJSk/3ZR+BBd/1aFRrbU+4UO0fHSElUuUwN7varuyVVVr
         3zoQtHrGP0zQOICSIBVPvCWLlBz1SGlxMEnrSRhLaEhRQ5im+HcT7ed3orVwmWBAh6eC
         QbecpcjtDSq6fZRL/l/L6tAAkOYXLo0RkmMtNwWWcslrrfPxRlXtdkL7CV9/4XJtnNcm
         eH4KBhGzLcK13FTiBXkv+/Ys0oCih4rvomQcORyk3k5TZctzHLxrXEeDdXpNJboTap/i
         h5tsuwW8zqqv2dvDn/EYSwEtrM1/PNP95GGHqiuEju+CT3hrhn+4DhVsk0OU4BcmICgF
         nbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+sf2qpwdduLxk0SLY+c4uiB9i35zOOSrTwM5H0xSWcU=;
        b=K3QrBrTIdU08NBNu7AwOIpmEMjgzGMw8Rp2uQr+mfv8V6HeOVp1+Hj68xJxMZaRGtV
         zXnk4/UjlhdyBmU/X7fbHp1l6MWv2VUsg3cCJNKS+tLO1nWnsf49EgcWgBeW92cuH+7y
         1jz23DpnKz10i9OKlbyyl77N07NW2dli4NND+G1LGrRYErkn36Z/zvtL5cx3hGbW0dKb
         VC4ZAD45aPjYbtmj8Zeb6y6eivD94RST0FdfcgHTGAJzRzO6bQ8IG1ULBfrv4hlVqOaY
         0iV1cINOmnb9+vZOeUPk0b3S4E1DJ6s9bti8dOA9Q0iTYXW2UgBGZR3kiPPkrRwxPYQ2
         u93g==
X-Gm-Message-State: ABuFfoj2CqKeLP0BjcQzvry5gSj/tc/qLDMfytZJfncQfhG1NOEVMEr/
        3GLOWJI3ScHcsRSkO2l4RLIY8PhzoZw=
X-Google-Smtp-Source: ACcGV60NXiO9DTZ1EFFLtjQK/1HEb528gUIAlE5uSB3tsl4gCSkovx1WRfivqt20CR7dhidYGcDvvA==
X-Received: by 2002:a62:985a:: with SMTP id q87-v6mr12650755pfd.64.1538416743123;
        Mon, 01 Oct 2018 10:59:03 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.10.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:59:02 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
Date:   Mon,  1 Oct 2018 10:58:20 -0700
Message-Id: <20181001175845.168430-1-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last sent 23 Nov 2016.

The following 23 patches are rebased and resent, and represent a
rewrite of the arm and arm64 vDSO into C, adding support for arch32
(32-bit user space hosted 64-bit kernels) and into a common library
that other (arm, or non-arm) architectures may utilize.

[PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
[PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
[PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
[PATCH v5 04/12] arm: vdso: do calculations outside reader loops
[PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
[PATCH v5 06/12] arm: vdso: add support for clock_getres
[PATCH v5 07/12] arm: vdso: disable profiling
[PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
[PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
[PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
[PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
[PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
[PATCH] lib: vdso: add support for time
[PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
[PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
[PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
[PATCH] arm64: compat: Expose offset to registers in sigframes
[PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
[PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
[PATCH 3/6] arm64: Refactor vDSO init/setup
[PATCH v2 4/6] arm64: compat: Add a 32-bit vDSO
[PATCH 5/6] arm64: compat: 32-bit vDSO setup
[PATCH 6/6] arm64: Wire up and expose the new compat vDSO

This patch series' above has been applied to the latest Pixel phones
and resulted in a 0.4% battery improvement.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com
