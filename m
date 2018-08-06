Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3582CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE267219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oWYC13MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE267219C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbeHGB27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:28:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51936 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbeHGB26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533597457; x=1565133457;
  h=from:to:cc:subject:date:message-id;
  bh=ipv6tWgq6qAfG/G5bk1aSzdm0trGXlzAS8On7sGDFEQ=;
  b=oWYC13MAOmKRgs/Xc2iWmJIWEw1+GqNl/Y5FN3ifLS6dzFfXB8Ul2gZP
   TY3/XFf9lie+paR0fTq5sDs4dt97VcKLuBfPL4Z9V0BhLw2juYV389otD
   BBn9QbivIj2tGaTxUV9libwGBeJ24NWMgloXNKmG3IyWx5aeFHd+Afo26
   +f12guABJW1SLTxQoFfNIvjc0ocF1Du7WLYiFq/nw53+H5mKBhNnVMvOG
   2niYl76ghH6C1pKlAH/TwvrXJ5WRXFvEEDxGVG3D5R5cE3WJwWmocRsF0
   NTO4TOBOJsb9d2roL7ZN4JZyTMgZJ9hE2HHVEoP4/n9XEz0bJznQ54gme
   A==;
X-IronPort-AV: E=Sophos;i="5.51,452,1526313600"; 
   d="scan'208";a="90476811"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2018 07:17:37 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 06 Aug 2018 16:05:53 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Aug 2018 16:17:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        alankao@andestech.com, sols@sifive.com
Cc:     peterz@infradead.org, nickhu@andestech.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [RFC] RISC-V: Fix !CONFIG_SMP compilation error
Date:   Mon,  6 Aug 2018 16:17:36 -0700
Message-Id: <1533597456-245169-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling both CONFIG_PERF_EVENTS without !CONFIG_SMP
generates following compilation error.

arch/riscv/include/asm/perf_event.h:80:2: error: expected
specifier-qualifier-list before 'irqreturn_t'

  irqreturn_t (*handle_irq)(int irq_num, void *dev);
  ^~~~~~~~~~~

Include interrupt.h in proper place to avoid compilation
error.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/perf_event.h | 1 +
 arch/riscv/kernel/perf_event.c      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index 0e638a0c..aefbfaa6 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -10,6 +10,7 @@
 
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
+#include <linux/interrupt.h>
 
 #define RISCV_BASE_COUNTERS	2
 
diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
index b0e10c4e..a243fae1 100644
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -27,7 +27,6 @@
 #include <linux/mutex.h>
 #include <linux/bitmap.h>
 #include <linux/irq.h>
-#include <linux/interrupt.h>
 #include <linux/perf_event.h>
 #include <linux/atomic.h>
 #include <linux/of.h>
-- 
2.7.4

