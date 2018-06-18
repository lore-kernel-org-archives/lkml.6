Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC20C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E603208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E603208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935420AbeFRITQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeFRITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5646BAD;
        Mon, 18 Jun 2018 08:19:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 092/279] RISC-V: build vdso-dummy.o with -no-pie
Date:   Mon, 18 Jun 2018 10:11:17 +0200
Message-Id: <20180618080612.610346402@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Jarno <aurelien@aurel32.net>

[ Upstream commit 85602bea297fc4e5223adbf7006dcce9aa694f17 ]

Debian toolcahin defaults to PIE, and I guess that will also be the case
of most distributions. This causes the following build failure:

  AS      arch/riscv/kernel/vdso/getcpu.o
  AS      arch/riscv/kernel/vdso/flush_icache.o
  VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
  OBJCOPY arch/riscv/kernel/vdso/vdso.so
  AS      arch/riscv/kernel/vdso/vdso.o
  VDSOLD  arch/riscv/kernel/vdso/vdso-dummy.o
  LD      arch/riscv/kernel/vdso/vdso-syms.o
riscv64-linux-gnu-ld: attempted static link of dynamic object `arch/riscv/kernel/vdso/vdso-dummy.o'
make[2]: *** [arch/riscv/kernel/vdso/Makefile:43: arch/riscv/kernel/vdso/vdso-syms.o] Error 1
make[1]: *** [scripts/Makefile.build:575: arch/riscv/kernel/vdso] Error 2
make: *** [Makefile:1018: arch/riscv/kernel] Error 2

While the root Makefile correctly passes "-fno-PIE" to build individual
object files, the RISC-V kernel also builds vdso-dummy.o as an
executable, which is therefore linked as PIE. Fix that by updating this
specific link rule to also include "-no-pie".

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/vdso/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -52,7 +52,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Add -lgcc so rv32 gets static muldi3 and lshrdi3 definitions.
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(CC) $(KCFLAGS) -nostdlib $(SYSCFLAGS_$(@F)) \
+      cmd_vdsold = $(CC) $(KCFLAGS) $(call cc-option, -no-pie) -nostdlib $(SYSCFLAGS_$(@F)) \
                            -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp -lgcc && \
                    $(CROSS_COMPILE)objcopy \
                            $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@


