Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 69F24C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8BA208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ2Cgjck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8BA208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965924AbeFNO3n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965496AbeFNO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:29:39 -0400
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE9F20020;
        Thu, 14 Jun 2018 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528986579;
        bh=/djgnUFtlbOU+jAQGdbmm7Ws7pU/hVoCUZ4P8g+Mn/A=;
        h=From:To:Cc:Subject:Date:From;
        b=MQ2CgjckXGZXk3Wg+gNzvOeSabxUcxjho7ziIMUbrYgTkcQfKlSc99562OZGaaWWz
         M2JeijENsdRDlzSfxrXxofj6klTmjE7DPyV3UVS+tA/FWtPp+KvW72ERTIScbj1UPR
         bbdrN6shD3YXLWpVDjkq3kjLZxcBqZ860MNtSW3s=
From:   James Hogan <jhogan@kernel.org>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH v2] nds32: Fix build error caused by configuration flag rename
Date:   Thu, 14 Jun 2018 15:28:52 +0100
Message-Id: <20180614142852.22226-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fix build error on nds32 due to the merge of commit e3d5980568f ("lib:
Rename compiler intrinsic selects to GENERIC_LIB_*") during the 4.18
merge window which renames Kconfig symbols. This had raced with commit
aeaa7af744fa ("nds32: lib: To use generic lib instead of libgcc to
prevent the symbol undefined issue.") merged late in the 4.17 cycle,
which added selects to nds32 using the original Kconfig symbol names.

When they came together in merge commit 763f96944c95 ("Merge tag
'mips_4.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux") this resulted
in the following build errors:

nds32le-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
timekeeping.c:(.init.text+0x140): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x144): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x17e): undefined reference to `__lshrdi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x182): undefined reference to `__lshrdi3'
nds32le-linux-ld: drivers/clocksource/mmio.o: in function `clocksource_mmio_init':
mmio.c:(.init.text+0x54): undefined reference to `__lshrdi3'
nds32le-linux-ld: mmio.c:(.init.text+0x58): undefined reference to `__lshrdi3'

Rename all 6 selects in nds32 and adjust the ordering accordingly to be
alphabetical.

Fixes: 763f96944c95 ("Merge tag 'mips_4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[jhogan@kernel.org: Rename all 6 symbols, sort, update commit message]
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
---
Changes in v2:
 - Rename all 6 symbols, not just the 3 that caused build failures.
 - Sort selects.
 - Update commit message.
---
 arch/nds32/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 6aed974276d8..34f7222c5efe 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -12,17 +12,17 @@ config NDS32
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_NONCOHERENT_OPS
-	select GENERIC_ASHLDI3
-	select GENERIC_ASHRDI3
-	select GENERIC_LSHRDI3
-	select GENERIC_CMPDI2
-	select GENERIC_MULDI3
-	select GENERIC_UCMPDI2
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_MULDI3
+	select GENERIC_LIB_UCMPDI2
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
-- 
2.17.1

