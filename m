Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DE9C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543842183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="C2NFECgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfAGQLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:11:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:11:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so339394plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8xgFTF0trh6SGkurGKzpWNhAcRz6eK6HX/JkCyedrQ=;
        b=C2NFECgvWtYo2Ag+3cL5Wmnikf66jtfVuNcqQHM3c5GN2Yy0fqZqMDp8v0an/H9uhh
         Pqm0J1k5WdvFs/d5UfppZjGE7g2ePu2sDg3nj6CEIGoP+Bm590MPcq602qu0bqGvSa5F
         /xT6sxCDQvIGKfSqYmXjs97AyLOdaP9VLsImipt4FHIAnDshZFOhAZv4YndfJtDiHAqQ
         qNxOSHdNNUitjC3zwXw8crz67+jh9GLs1f0I8d5MCdxAB4sm9Iay2jX10iW2NW2JHbNT
         GweghlwVn1HEqMH64x1gwVJdSQzYL9+aDqFC08HvFb6nituWnjaiW4U1T+utnM/5xXZR
         vFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8xgFTF0trh6SGkurGKzpWNhAcRz6eK6HX/JkCyedrQ=;
        b=ntrvahKoy1LHNR8q8T9V0ERRZDajKGlIpVq0SgAGoF+z0aiKaB9edQfBKYrCVezSpz
         N7kDWOd9ZTEuafh95hEn5NE/E2UfGemViTvnwEC9/uQubS9gmRfU3W8p8FccfMrgAneH
         byK5ahGzZnd7YiXEoi0ILfXaqQ/dOn80DYRpL8lPd7jdVtzMJCCvCs92jH8iWFmM2WAI
         8aT4xzGd/nQzTctGb/Nd28VrCUrTJK3RGcsr6UbGHI7OLbUwh+hsAv+8Cq+7Im+6C+Ah
         j4D7TOribop2VCt+WJ6HWAHQWbknfW+yOMO4//VF+dlFddsjAV/hL/EcyJ04HQAylit3
         mohA==
X-Gm-Message-State: AJcUukfv2v0vcYHxlsTOwxZzHvpqYSjAF81Wu48g04OclmtCprw2t8Ce
        dvOFRHYnXrj8dFt2tJ+0lGttwQ==
X-Google-Smtp-Source: ALg8bN6NOdOb4IsHwjeBH1UbimT0TibP73NfLcbOyU6fCVQavsFWayomdqq5olLc6MzG2fwwgelkmw==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr61033475plp.334.1546877478097;
        Mon, 07 Jan 2019 08:11:18 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.214])
        by smtp.gmail.com with ESMTPSA id a10sm93243512pfi.138.2019.01.07.08.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:11:17 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 2/5] RISC-V: Setup init_mm before parse_early_param()
Date:   Mon,  7 Jan 2019 21:40:44 +0530
Message-Id: <20190107161047.10516-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107161047.10516-1-anup@brainfault.org>
References: <20190107161047.10516-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

We should setup init_mm before doing parse_early_param()
in setup_arch() to be consistent with setup_arch() of
other architectures such as x86, ARM, and ARM64.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/setup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 64646d0b4d53..f7132547b8b3 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -201,15 +201,15 @@ static void __init setup_bootmem(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	*cmdline_p = boot_command_line;
-
-	parse_early_param();
-
 	init_mm.start_code = (unsigned long) _stext;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
 	init_mm.brk        = (unsigned long) _end;
 
+	*cmdline_p = boot_command_line;
+
+	parse_early_param();
+
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
@@ -228,4 +228,3 @@ void __init setup_arch(char **cmdline_p)
 
 	riscv_fill_hwcap();
 }
-
-- 
2.17.1

