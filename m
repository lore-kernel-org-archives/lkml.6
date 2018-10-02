Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA1CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4F72064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ID1pJ2/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4F72064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJCCAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61582 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeJCCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507713; x=1570043713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QoJF+zxi71e6lxam6xbMcJHOAzHqmAmlkJMulFCOr4w=;
  b=ID1pJ2/b39CibvuouxVToaen7R+9ScjMyMWbs2r++KKzzYxvSJrqpsml
   eTCU079JCjOGK5GiDVLflTml45zms2bmzST51baXO0QaydcPqWKSh+0md
   zGHQjkzz/frUoUGamNPghfR90+bJqt3oxpY9kVsFCvXGM1FjHqj2RwSUH
   /zRY6JVIms24ICwYoHNg+mfMnQZeHE+NhjcJ9N8fLeeNHoUyGW2EBrD5o
   FONL0rO0LQp80bVVBqb94fyrdttBmfHIkK7kwO3zJkaRg5h0mKOWjmNgy
   SH225pK370t6Ym8ww89rp3mU1qt/e9HhESczxq2I1KhTCGtOlk3izq68r
   g==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076764"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:51 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 13/14] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
Date:   Tue,  2 Oct 2018 12:15:06 -0700
Message-Id: <1538507707-22299-14-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup@brainfault.org>

Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
is in-correct. This patch shows CPU ID and Hart ID separately
in /proc/cpuinfo using cpuid_to_hardid_map().

With this patch, contents of /proc/cpuinfo looks as follows:
processor	: 0
hart		: 1
isa		: rv64imafdc
mmu		: sv48

processor	: 1
hart		: 0
isa		: rv64imafdc
mmu		: sv48

processor	: 2
hart		: 2
isa		: rv64imafdc
mmu		: sv48

processor	: 3
hart		: 3
isa		: rv64imafdc
mmu		: sv48

Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index cccc6f61..3a5a2ee3 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -81,7 +81,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 #endif
 
 	/* Print the base ISA, as we already know it's legal. */
-	seq_puts(f, "isa\t: ");
+	seq_puts(f, "isa\t\t: ");
 	seq_write(f, isa, 5);
 	isa += 5;
 
@@ -96,6 +96,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 			isa++;
 		}
 	}
+	seq_puts(f, "\n");
 
 	/*
 	 * If we were given an unsupported ISA in the device tree then print
@@ -116,7 +117,7 @@ static void print_mmu(struct seq_file *f, const char *mmu_type)
 		return;
 #endif
 
-	seq_printf(f, "mmu\t: %s\n", mmu_type+6);
+	seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
@@ -144,14 +145,15 @@ static int c_show(struct seq_file *m, void *v)
 						   NULL);
 	const char *compat, *isa, *mmu;
 
-	seq_printf(m, "hart\t: %lu\n", cpu_id);
+	seq_printf(m, "processor\t: %lu\n", cpu_id);
+	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
 		print_isa(m, isa);
 	if (!of_property_read_string(node, "mmu-type", &mmu))
 		print_mmu(m, mmu);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
-		seq_printf(m, "uarch\t: %s\n", compat);
+		seq_printf(m, "uarch\t\t: %s\n", compat);
 	seq_puts(m, "\n");
 
 	return 0;
-- 
2.7.4

