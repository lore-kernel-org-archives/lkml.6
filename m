Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B11C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9622505
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="B3VGkaJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA9622505
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeKMCzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:55:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37803 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMCzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:55:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so8779656wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2sX+hDQ3Df81Enc00bH7e6G7yh2CFtnAPDDDHGXYwQ=;
        b=B3VGkaJ08XpgpuGafm+ayVvlR4ORrKc6bhVJEN7pyOkfJT4TiriuxqVpWS98QQjQBU
         nAsADKcv8yun9D4Ozp3CHwpG6KFOO5s/EtJvwPMkc9SnG1lSjLP6Dr5V9tje0/A9sC0S
         c2FHoobH7NOy7yqWfHEhSifFgdGrAVVUwZUI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2sX+hDQ3Df81Enc00bH7e6G7yh2CFtnAPDDDHGXYwQ=;
        b=kHmmzghWMSnoPdsTc/8JBp+QfgvFjlmoN7GV7CSJU9bmbyebj0qDIy8uH/K/XOCOFl
         jITUHUHKwzIv1VLpMXg5BEM9iN+E9SNBcQWLqzQkz90hxbpRyY+77YvF8Hp4LD+sAxjW
         aP1lJNOWpe9xkPWU9HscaZtKP8/cc5l7VhS2m4ZJwELJctyJyOKiY2cITYbXwLX5zuG0
         w2Nj4xdig38Zf53lWXU6PKA7iLnOnCmRXDUsc/BBNWynf0gO4bSKsT9EV11RUHgVVuyP
         AFf523zYEtqfT+wB1OA3lQxNYglJLTaLBA3dTJkDriH9jm+pwicptmVM2pThDQ4Lej/0
         Hk2Q==
X-Gm-Message-State: AGRZ1gL25JKK8rzMfH49G5N421dptJdtkP2ofltj7xJGCByyaqH2pdAF
        xBXcjgJqzJKXYYiB5SBpPJ1lALgDZ8vRGg==
X-Google-Smtp-Source: AJdET5dNNcKoWQCY84GuyCSuaEFRfCoBglFN9SKKZ22zgzRsLdk9GZjh9lBWNR4ReNL3akS+mcc9fw==
X-Received: by 2002:a1c:2104:: with SMTP id h4-v6mr372217wmh.130.1542042068219;
        Mon, 12 Nov 2018 09:01:08 -0800 (PST)
Received: from max-pc.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id u13-v6sm11835344wrn.11.2018.11.12.09.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:01:07 -0800 (PST)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>
Subject: [PATCH v2 2/2] mips: sort list of configs for Malta
Date:   Mon, 12 Nov 2018 19:00:59 +0200
Message-Id: <20181112170059.7199-2-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
References: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort configs in menu "Machine selection" under MIPS_MALTA.

Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
---
 arch/mips/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fe4c28275271..2ac32dac90b7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -494,22 +494,23 @@ config MIPS_MALTA
 	select BOOT_RAW
 	select BUILTIN_DTB
 	select CEVT_R4K
-	select CSRC_R4K
 	select CLKSRC_MIPS_GIC
 	select COMMON_CLK
+	select CSRC_R4K
 	select DMA_MAYBE_COHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
-	select IRQ_MIPS_CPU
-	select MIPS_GIC
 	select HW_HAS_PCI
 	select I8253
 	select I8259
+	select IRQ_MIPS_CPU
+	select LIBFDT
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
+	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_6
-	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
+	select PCI_GT64XXX_PCI0
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
@@ -528,16 +529,15 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MICROMIPS
+	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MIPS_CPS
-	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_SUPPORTS_ZBOOT
-	select SYS_SUPPORTS_RELOCATABLE
 	select USE_OF
-	select LIBFDT
 	select ZONE_DMA32 if 64BIT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
-- 
2.19.1

