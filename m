Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C692C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2083E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="QlQTyt7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2083E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935597AbeFRPIV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:08:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42454 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965477AbeFRPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so8318947pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDT3d1VxBK0YiBEZ1hS7fYSLK7481fKshItjGaWAOGs=;
        b=QlQTyt7b8pqu8WG/lziJBb3L6OdVoEzKHbanvYqjAVMaQvw87kHx286Wq7BIijhU+b
         oHeA7Vdnno8pXhL6pK6xQONn98AfViOg0VQS0trWSiUnAyxXV0Cb/7JbV3vR4ymu9ewM
         xMZLpdLWeugjE5xIg2AGN0C1/RxpaM5rgjgMWPHXwK7ECE3P0atp49apKnPAeJ4/YqNu
         AUYGxIHWFx4PRb9oDJXSFLSBRtl7u5dn2rcv/0DZQPRK9jHycQhot1tkgQFsn+CKg4Nk
         FwPVD/zF5YerARHJT/PDpVRH5EWBC/yYXITpxfmuSYN0iI9aZIhAePP+kTxLx85eKfyx
         Nk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDT3d1VxBK0YiBEZ1hS7fYSLK7481fKshItjGaWAOGs=;
        b=uVy72S1c2B2fuiWNnKNr0+yTukN/pcTErGzzceRU3rLncadJKH6XLJsQJcOmjwRNyh
         afCxMxj5tYoqdBqcdusdNIwSK4RidMc+wSvIGow0nMCg5tJxJqnpT28IxuOdWQvJBtSy
         w9VzTmBjlxXcRnRn3UWiSBS5HsFhYSHqK1Jva+LYsiapAHH9uGu+IjWbQOSGAzHGpzcR
         zi5AL+nHfnRV8xBSQ1VCeuROeCkdAPv8Y23GwT3Kg2CWlju0AJIafVU9xLjDbUrVi7tW
         SH5Rd584fmUFk4ioGzD/gUnSw+o6i1dPBcuzEXGN+AlWJUB/q5GGgQCFTg1W3Uc6gGZa
         AmJg==
X-Gm-Message-State: APt69E02C3smbG8U5aTcVcOoOr7zpEK73E6jvIhXHgoTObvzVCi4zjZI
        ZDMF4uwpskxgMGdib8WmzF2jlfKQoDE=
X-Google-Smtp-Source: ADUXVKKB9Nvlsind6+J0LMB0V0c1G08BiNJoiu4EydI8Gx4TfPHeS/11WDro8Hvex3gZnOTubP3TQQ==
X-Received: by 2002:a62:84e:: with SMTP id c75-v6mr14022815pfd.35.1529334449699;
        Mon, 18 Jun 2018 08:07:29 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:07:29 -0700 (PDT)
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
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: RESEND [PATCH v5 07/12] arm: vdso: disable profiling
Date:   Mon, 18 Jun 2018 08:05:53 -0700
Message-Id: <20180618150613.10322-8-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take an effort to recode the arm64 vdso code from assembler to C
previously submitted by Andrew Pinski <apinski@cavium.com>, rework
it for use in both arm and arm64, overlapping any optimizations
for each architecture. But instead of landing it in arm64, land the
result into lib/vdso and unify both implementations to simplify
future maintenance.

Make sure kasan and ubsan profiling, and kcov instrumentation,
is turned off for VDSO code.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
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

v2:
- Added this to the split up of first CL, based on comments in second CL

v4:
- update commit message to reflect overall reasoning

v5:
- rebase
---
 arch/arm/vdso/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index f4efff9d3afb..1125e3fb8006 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -27,8 +27,11 @@ CFLAGS_REMOVE_vdso.o = -pg
 CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
 CFLAGS_vgettimeofday.o = -O2
 
-# Disable gcov profiling for VDSO code
+# Disable gcov, kasan, ubsan and kcov profiling for VDSO code
 GCOV_PROFILE := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT := n
-- 
2.18.0.rc1.244.gcf134e6275-goog

