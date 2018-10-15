Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A10EC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE842064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhoK4P32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE842064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJOTBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:01:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38092 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:01:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id v7-v6so17121680ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KapoO5oMlMVFKcdCw43NU78fcYlzzKItuvdaDSjvtEY=;
        b=jhoK4P329uM4OgPNBuc+W4XSTNdyijGPQ7tYXpsRzwvnf5sOZn/JeUQlKJbUcBStJC
         p/KX2drpls/0XTsbU1BTUYGyxuilNKYAC03yGhrOyAD34HGaFqh/sSi6WwkPghYr/IaU
         kObhyOVBHUK8Wl3202Elwoa4wUyTLHttFT9S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KapoO5oMlMVFKcdCw43NU78fcYlzzKItuvdaDSjvtEY=;
        b=lZJFW3QzmrsUXTI5SSuEDxre7fVWMN4L/TnDRFZmCEAjF5pssW/4Zxsr+4QBNr2H7s
         Z19Ne02YTEdQJBccAAtkXkjrYxzuj+lV4n9RkUfdnRfFKxxg+/8sd5GbqetOiExe1ctv
         3ZQ1H3LaP0lSHjP/qKB2/ZL+sfHjSKyLjZ00u44KKyaQcHy5gvh5CQF7NB3d5bZcNHgV
         JoKie3insVnXnjF5MNlYDXL9Ydq0cytQtLf4YdyQSYdAf/YsuB/aW0Xm8BvHXeJpw8/t
         7Q99ByPLhUPmJqTXbFjj9Cs3zwGpQVUWUOiJNc/DihdXBJzsiiZhofrBd6lHXYxQ+Zm8
         vRNg==
X-Gm-Message-State: ABuFfohZc8Q+uyaYJlx7lrvl1nrEdqCetZcYfUIwsCwP7R5KkKYtCTFR
        jj/D8pfNAMkZiQtqLlRbeHbpLzic17Q=
X-Google-Smtp-Source: ACcGV62H04Q0o2Qc3YYrRBzFf9KX/YYxPs4WhluwQ8LWQ6bTZrj77XjSAR1Fcuy+bc+Hf0AgwIlLUQ==
X-Received: by 2002:a2e:8606:: with SMTP id a6-v6mr9222957lji.43.1539602175125;
        Mon, 15 Oct 2018 04:16:15 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id l9-v6sm2277055ljb.70.2018.10.15.04.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 04:16:14 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH] arm64: kprobe: make page to RO mode when allocate it
Date:   Mon, 15 Oct 2018 13:16:00 +0200
Message-Id: <20181015111600.5479-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
has successfully identified code that leaves a page with W+X
permissions.

[    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
[    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
[    3.246141] Modules linked in:
[    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
[    3.247008] Hardware name: linux,dummy-virt (DT)
[    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    3.247623] pc : note_page+0x410/0x420
[    3.247898] lr : note_page+0x410/0x420
[    3.248071] sp : ffff00000804bcd0
[    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
[    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
[    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
[    3.249109] x23: 0000000000000004 x22: ffff000000d91000
[    3.249396] x21: ffff000000d90000 x20: 0000000000000000
[    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
[    3.249924] x17: 0000000000000000 x16: 0000000000000000
[    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
[    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
[    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
[    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
[    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
[    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
[    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
[    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
[    3.252664] Call trace:
[    3.252953]  note_page+0x410/0x420
[    3.253186]  walk_pgd+0x12c/0x238
[    3.253417]  ptdump_check_wx+0x68/0xf8
[    3.253637]  mark_rodata_ro+0x68/0x98
[    3.253847]  kernel_init+0x38/0x160
[    3.254103]  ret_from_fork+0x10/0x18

Reworked to that when allocate a page it sets mode RO. Inspired by
commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 9b65132e789a..b842e908b423 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -23,7 +23,9 @@
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
 #include <linux/sched/debug.h>
+#include <linux/set_memory.h>
 #include <linux/stringify.h>
+#include <linux/vmalloc.h>
 #include <asm/traps.h>
 #include <asm/ptrace.h>
 #include <asm/cacheflush.h>
@@ -42,10 +44,21 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
 
+static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
+{
+	void *addrs[1];
+	u32 insns[1];
+
+	addrs[0] = (void *)addr;
+	insns[0] = (u32)opcode;
+
+	return aarch64_insn_patch_text(addrs, insns, 1);
+}
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	/* prepare insn slot */
-	p->ainsn.api.insn[0] = cpu_to_le32(p->opcode);
+	patch_text(p->ainsn.api.insn, p->opcode);
 
 	flush_icache_range((uintptr_t) (p->ainsn.api.insn),
 			   (uintptr_t) (p->ainsn.api.insn) +
@@ -118,15 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
-static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
+void *alloc_insn_page(void)
 {
-	void *addrs[1];
-	u32 insns[1];
+	void *page;
 
-	addrs[0] = (void *)addr;
-	insns[0] = (u32)opcode;
+	page = vmalloc_exec(PAGE_SIZE);
+	if (page)
+		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
 
-	return aarch64_insn_patch_text(addrs, insns, 1);
+	return page;
 }
 
 /* arm kprobe: install breakpoint in text */
-- 
2.19.1

