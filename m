Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15150C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19F9208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19F9208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933777AbeGJPRD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:17:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53122 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933359AbeGJPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:17:02 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LcKBC-1gKFYc10FC-00jtcC; Tue, 10 Jul 2018 17:16:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Nikunj Kela <nkela@cisco.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: make flatmem depend on !NUMA
Date:   Tue, 10 Jul 2018 17:16:27 +0200
Message-Id: <20180710151639.2184213-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:EbLMfbAruLMS4LOXW/AMlCy9LVL6iNsHIoOI1VuwuOi1SzbgZxR
 3YYFyBiWm4MjBUXj6xc9lqluaL30QJ8JIPXl7Iv0R6YTTWss9k+joPLqS9zg9IIYSS0HN+W
 ceIh7BbuhabfZv27l/JEPKnpo8ON2wCjnpsOzUrqUsJXIq6yF3J5T6xTciP/kkG0ejUJ7x3
 ZQebNdTvPyFviGgv2A2bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UsLc3jTikeI=:V/BaPXcvEV9PCIkWrGl+yo
 1qUJqdO9eMjqK28KH/6Sp3d1I/5RrhHaoMdtP+c1c5JYTHvgSZ1IZrD+dMhNaWO87WIljr/Ro
 qQ56PiCtQ14wdn/DvG9eZsrT43hM8l7+w6KW/EtZlxftHO5fc6eU9sNQOLoH9tQLZftjObS50
 m8ys1azgR5uf1a02NVc/FJiZGgaNTX81bv9tx5nVEE0nnSnZ4yVaWTJnMRnbpN9Nz2GbFrziU
 KkxZ5ZhOzxDGEPqEghK+G8THyhk0z8NIUYNdNuSrraDM6Zf8i4W52zaGlc9a3SuWdny8fXTOy
 220lbuGFFAYgGKU3iOC1uoPCdNu5VYUjfTPd+HGcIOWLgEiZ1FkUVjFNiSCDtF5l0JLro+Lzr
 81cDTkupiOtw++XET+Z6i0Xx6U00zwWBB1D0Eq489PL9OIxl4SyrsOsrafoDCoJy3doG9ys8c
 Qhy5g8jjFGSJyCvVQBmKs3RpE1oQ0w/3E6gFOQ+EUBT/3aYuDOBrbWy5JUcul/JUxG6Ya86Gs
 gDafUYo/twvHQBaXumzyLb52s7lgVj0abax8aVAKyE2FTtKOW0VZutVuuryTv+xjHUeuByHda
 dzDY8J2bKbotMsxADcDgDXwavr0kaoHv5iOiAoUjPUWAEIDG/XDFQVHTETSHbSsO6ACUXaEE/
 +MYowiYfZRa2h+FeTgCvhGc3mQu7Mw+o/OfpCgpuvoAnwCRLEP1AuvuIt0y5J76dO5+8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without NUMA but with FLATMEM results in a link error
because mem_map[] is not available:

aarch64-linux-ld -EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic --no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T ./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a --end-group
init/do_mounts.o: In function `mount_block_root':
do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
arch/arm64/kernel/vdso.o: In function `vdso_init':
vdso.c:(.init.text+0xb4): undefined reference to `mem_map'

This uses the same trick as the other architectures, making flatmem
depend on !NUMA to avoid the broken configuration.

Fixes: e7d4bac428ed ("arm64: add ARM64-specific support for flatmem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1dd68d973704..ba19f03bc327 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -787,7 +787,7 @@ config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
 config ARCH_FLATMEM_ENABLE
-	def_bool y
+	def_bool !NUMA
 
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
-- 
2.9.0

