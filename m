Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B67C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F87520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078544;
	bh=FXWuW4BgjoGFhcHFgojwVZtMsQP8OAIXKjT8IMOSbMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fIgdx2gv2KtWNcTzNkSD74MPA7dTyqa/tfC1pbRe5WwZGnXtT64iDDMiBpVrzbRIZ
	 WQZwUGbLchgqFFq33gMJOiTW3FbFCaaFOKJ2TkrqF88TApHKpmzMDdmM8b8t5cazB6
	 E5SsXSnQ6z9Hcy3fCjpV/StA+mfMpF4VBFM7Rc2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfAUNtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbfAUNs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A36020861;
        Mon, 21 Jan 2019 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078537;
        bh=FXWuW4BgjoGFhcHFgojwVZtMsQP8OAIXKjT8IMOSbMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blvHoyYP4SL1f6e2M8kRkjPIvg7aaUnv6zLD+lZXR9ZjYWfCmCb/CGZ4JptZDWt8M
         PONKwjLGKhSLVZS+n/QombMfijtSV6WJUN6glPTUUstQzaPhYR68GM7Ks/16qCL7i+
         zfhGyfxW+GfgZ+B0I+lVmsWAEQG65UmkktBkI9Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 067/111] arm64: kaslr: ensure randomized quantities are clean to the PoC
Date:   Mon, 21 Jan 2019 14:43:01 +0100
Message-Id: <20190121122503.876631159@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 1598ecda7b239e9232dda032bfddeed9d89fab6c upstream.

kaslr_early_init() is called with the kernel mapped at its
link time offset, and if it returns with a non-zero offset,
the kernel is unmapped and remapped again at the randomized
offset.

During its execution, kaslr_early_init() also randomizes the
base of the module region and of the linear mapping of DRAM,
and sets two variables accordingly. However, since these
variables are assigned with the caches on, they may get lost
during the cache maintenance that occurs when unmapping and
remapping the kernel, so ensure that these values are cleaned
to the PoC.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/kaslr.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 
+#include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
@@ -43,7 +44,7 @@ static __init u64 get_kaslr_seed(void *f
 	return ret;
 }
 
-static __init const u8 *get_cmdline(void *fdt)
+static __init const u8 *kaslr_get_cmdline(void *fdt)
 {
 	static __initconst const u8 default_cmdline[] = CONFIG_CMDLINE;
 
@@ -109,7 +110,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * Check if 'nokaslr' appears on the command line, and
 	 * return 0 if that is the case.
 	 */
-	cmdline = get_cmdline(fdt);
+	cmdline = kaslr_get_cmdline(fdt);
 	str = strstr(cmdline, "nokaslr");
 	if (str == cmdline || (str > cmdline && *(str - 1) == ' '))
 		return 0;
@@ -169,5 +170,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
 	module_alloc_base &= PAGE_MASK;
 
+	__flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));
+	__flush_dcache_area(&memstart_offset_seed, sizeof(memstart_offset_seed));
+
 	return offset;
 }


