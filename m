Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76197C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDA720861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pu760xFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDA720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502946AbeKWUZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:25:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35488 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502909AbeKWUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:25:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so11696441wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FZtp+WXIrWPYt8EjDM1rtXxepFRMgUFwF+TZbJBkLuY=;
        b=Pu760xFIdN/tXkp+smjkn0yaErdBYOCiDJ6RqziXPEQhRdsBdUQ8pULamUlIUj22C7
         9dPTBQCuCo1J1XKzg6vCWn7MN4Os+Vleo6veNmejfirWF2uKmuYM++V1Ja6IvV4dgQno
         HTXu10ci/RLgxmigtL6038I1vN5AYImEmSgXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FZtp+WXIrWPYt8EjDM1rtXxepFRMgUFwF+TZbJBkLuY=;
        b=syjsGwobRT2zuIsY5VgI8/Xi2Hu8N0LGucXc0msbofyvGbgmRatFKSogD8S15IG5EJ
         KyHPnpVHGguPXUJ+LXgscX0dyGrA1zv/wSzXocJbVjjCoWu0XRJIBgPaP2H7xKQuPQjO
         KLK2tp9OTXnxCnosdZnu+b5zWi3UBBXXzidMegKE+Xp0WZtyD2gVC33Kb28DHZ74SPqi
         HwlwGeUZ4lxAu7sE6B3I6kKTVNz7j6BVuiorsf8rlZUT3//+5oxQv/1/Z15bk0WlVp9T
         vrg9HpJ91RTxeCjNqORzxDn/AO9lmaxW9NdwwRi+QZ2Ho7ulviarug2XDPxhqnbeuVOH
         cjIg==
X-Gm-Message-State: AA+aEWYdEAU6Nm1/ecWk3xQhndYvR7cClxXuzv/n+ome9DUcSnVXqNTx
        aOImOziJJCyY8Tfcq5/EcN/dqjZrpxh3tg==
X-Google-Smtp-Source: AFSGD/VYscSU8ZOnMn8atC2Ygp2bqfVKColmpKFiFdhsRXdAJb3+bwltYkgVpe5fisn+V+wW4HPN3A==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr13937475wrr.67.1542966130787;
        Fri, 23 Nov 2018 01:42:10 -0800 (PST)
Received: from mba13.wifi.ns.nl (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id k7sm35489897wrl.51.2018.11.23.01.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:42:10 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v3 2/2] arm64/bpf: don't allocate BPF JIT programs in module memory
Date:   Fri, 23 Nov 2018 10:41:52 +0100
Message-Id: <20181123094152.21368-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by vmalloc()/vfree() calls from a
dedicated 128 MB region set aside for BPF programs. This ensures
that BPF programs are still in branching range of each other, which
is something the JIT currently depends upon (and is not guaranteed
when using module_alloc() on KASLR kernels like we do currently).
It also ensures that placement of BPF programs does not correlate
with the placement of the core kernel or modules, making it less
likely that leaking the former will reveal the latter.

This also solves an issue under KASAN, where shadow memory is
needlessly allocated for all BPF programs (which don't require KASAN
shadow pages since they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h  |  3 +++
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/net/bpf_jit_comp.c    | 13 +++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..506e319da98f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -69,6 +69,9 @@
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
+#define BPF_JIT_REGION_BASE	(VMALLOC_END)
+#define BPF_JIT_REGION_SIZE	(SZ_128M)
+#define BPF_JIT_REGION_END	(BPF_JIT_REGION_BASE + BPF_JIT_REGION_SIZE)
 
 #define KERNEL_START      _text
 #define KERNEL_END        _end
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 50b1ef8584c0..9db98a4cd9b4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -31,7 +31,7 @@
  *	and fixed mappings
  */
 #define VMALLOC_START		(MODULES_END)
-#define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
+#define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - BPF_JIT_REGION_SIZE - SZ_64K)
 
 #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..298beba29fa5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_BASE,
+				    BPF_JIT_REGION_END, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void bpf_jit_free_exec(const void *addr)
+{
+	return vfree(addr);
+}
-- 
2.17.1

