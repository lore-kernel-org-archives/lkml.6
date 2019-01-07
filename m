Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3AEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2F321736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867354;
	bh=PZa/bK/dLS+WkzTC9uN26VClCD8IJPAtjhm3utKQYFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fY1RwCJNgFYfLcXVN+3s94cT3LVFqokYQIfN9RAVmvPgn2QeAZN7EimfVu9QEkOKW
	 iKpEtzIqpKtivT53Xj/emwxYp3jUo46LPrY0JPmjiKfGDCcJvidGbPoXcJbaWbMR5B
	 XynAAV+X1QmB2Ztw0FrFmWeqbfZvYB3WINdThWNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfAGNWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbfAGMnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BBA2183E;
        Mon,  7 Jan 2019 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865033;
        bh=PZa/bK/dLS+WkzTC9uN26VClCD8IJPAtjhm3utKQYFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U20jzQJXZriHTSl5YGW3FVnwFIrHFY1XiPZa5upmpQaZxeTuSup6nQwt6iXMlNoeI
         eyypVanQ+rmxA4C1moGqxBSqq+gYkCWfgbXqzHuwfG8uY2TwkMKix8xR+IP+u1zl2M
         3tP3M87Ao07+ncZKz3RYodnJY2tWfPM1MyMsZKOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: [PATCH 4.20 123/145] MIPS: Align kernel load address to 64KB
Date:   Mon,  7 Jan 2019 13:32:40 +0100
Message-Id: <20190107104453.291058387@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Huacai Chen <chenhc@lemote.com>

commit bec0de4cfad21bd284dbddee016ed1767a5d2823 upstream.

KEXEC needs the new kernel's load address to be aligned on a page
boundary (see sanity_check_segment_list()), but on MIPS the default
vmlinuz load address is only explicitly aligned to 16 bytes.

Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
the alignment calculated by calc_vmlinuz_load_addr to 64KB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21131/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@mips.com>
Cc: Steven J . Hill <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: <stable@vger.kernel.org> # 2.6.36+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -13,6 +13,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "../../../../include/linux/sizes.h"
 
 int main(int argc, char *argv[])
 {
@@ -45,11 +46,11 @@ int main(int argc, char *argv[])
 	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
 
 	/*
-	 * Align with 16 bytes: "greater than that used for any standard data
-	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+	 * Align with 64KB: KEXEC needs load sections to be aligned to PAGE_SIZE,
+	 * which may be as large as 64KB depending on the kernel configuration.
 	 */
 
-	vmlinuz_load_addr += (16 - vmlinux_size % 16);
+	vmlinuz_load_addr += (SZ_64K - vmlinux_size % SZ_64K);
 
 	printf("0x%llx\n", vmlinuz_load_addr);
 


