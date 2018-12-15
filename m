Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5320645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HoNDns9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeLOFWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39014 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeLOFW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so3623111pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1NoMrt07YnmAoRot0iG3Ze4/SAslanmuFjK56MTzqwk=;
        b=HoNDns9DTxGEqYkcTxzTtIyMuBzggaZGSJSR5BkGXe7L8u5mckollV3qSgK8mAD44b
         4iDmcgS3i1ebZ9L3IS1IBG04Y6Q2HCO4taMkOHu7KdPoZPYZacy9qpDpQ+A7FKNlK/Xn
         NXc1xgKTjkGxGD3q4vRHuIHkVfqBN1DuSlJFAcehOzCk4syCh0sEwRQWebqS+Sby1gpl
         CkoN5g/4mPuxtfZyW17EGax2auDo/fBjvW9fAnZRMqKw9K2XwoE5bJ1h01D3GAnQ6SPd
         og9zZ52Yp+JOx0t5umozxSfrFEZJikwPYgNhu2Z/8eLf6CjAEA2wST13y91WUKIqScFV
         t1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1NoMrt07YnmAoRot0iG3Ze4/SAslanmuFjK56MTzqwk=;
        b=RUAhX7wyo9BlpUXTjpBvgEuKFdZHm68yu8F+3lTyY7ZxJV+lIV50F+iQ2bmEVgb8l1
         6mlhOMdW4zPX0ouyw8kI0E33z3L3NXcSoQK5XShVsxhbYMuji57rJKLWT4/1bO+tLsuX
         L1aTyHbV9svPBSG+1aPdei3Xgy6rmdWU9AovPJwQLcb0I5/jsOmoQ3dVFSOZRDryZREo
         vOg8a3W9pyn+2JIXtVdZD1ME8JWj6makzu7CveTFMWZn9iK0jIN5xiV5UMijTyxNOUdI
         WGWMS4fLURUQSCvwI6DT0U3Pfu1xxbhdbY52A6O9R56Qe2A1PHmVn4uy7NTvxS3WPADW
         LQfw==
X-Gm-Message-State: AA+aEWaDhmCS7r3fd2pR/z4kxdIRa5vO+5YnWP8dU6SRFnyMnwOz/pm0
        Tad1vcTRD84NQr2jcDzG9tUpBPdm+q0=
X-Google-Smtp-Source: AFSGD/VQKLlEzrJZBZyQhnX6BTba9Y8g+LpF2AaT2R3uiD52OqwGnZ2pu2pTv1GKoGNNiZmcbN17Zg==
X-Received: by 2002:a63:f811:: with SMTP id n17mr5244556pgh.23.1544851348131;
        Fri, 14 Dec 2018 21:22:28 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:27 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/7] arch: riscv: add support for building DTB files from DT source data
Date:   Fri, 14 Dec 2018 21:21:48 -0800
Message-Id: <20181215052154.24347-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to what's implemented for ARM64, add support for building
DTB files from DT source data for RISC-V boards.

This patch starts with the infrastructure needed for SiFive boards.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/riscv/Kconfig           | 2 ++
 arch/riscv/Kconfig.platforms | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/riscv/Kconfig.platforms

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55da93f4e818..dc9f1afa4ad9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -121,6 +121,8 @@ config ARCH_RV64I
 
 endchoice
 
+source "arch/riscv/Kconfig.platforms"
+
 # We must be able to map all physical memory into the kernel, but the compiler
 # is still a bit more efficient when generating code if it's setup in a manner
 # such that it can only map 2GiB of memory.
diff --git a/arch/riscv/Kconfig.platforms b/arch/riscv/Kconfig.platforms
new file mode 100644
index 000000000000..bd3d2642bcff
--- /dev/null
+++ b/arch/riscv/Kconfig.platforms
@@ -0,0 +1,8 @@
+menu "Platform selection"
+
+config ARCH_SIFIVE
+        bool "SiFive platforms"
+        help
+          This enables direct support for SiFive SoC platform hardware.
+
+endmenu
-- 
2.20.0

