Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB1C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE5420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE5420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeLMRXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:23:30 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39472 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeLMRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:23:29 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AFD4072CC6C;
        Thu, 13 Dec 2018 20:23:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A7279964E82; Thu, 13 Dec 2018 20:23:26 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:23:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Max Filippov <jcmvbkbc@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 20/27] Move EM_XTENSA to uapi/linux/elf-em.h
Message-ID: <20181213172326.GT6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should never have been defined in the arch tree to begin with,
and now uapi/linux/audit.h header is going to use EM_XTENSA
in order to define AUDIT_ARCH_XTENSA which is needed to implement
syscall_get_arch() which in turn is required to extend
the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v6: there is an earlier revision of this patch in xtensa tree where
        EM_XTENSA is added to uapi/linux/elf-em.h but arch/xtensa/include/asm/elf.h
        remains unchanged
    v5: move EM_XTENSA to elf-em.h instead of adding,
        I didn't realize it was already defined in the arch tree
    v2: added Reviewed-by

 arch/xtensa/include/asm/elf.h | 2 +-
 include/uapi/linux/elf-em.h   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/elf.h b/arch/xtensa/include/asm/elf.h
index eacb25a41718..344f1c6a546e 100644
--- a/arch/xtensa/include/asm/elf.h
+++ b/arch/xtensa/include/asm/elf.h
@@ -15,10 +15,10 @@
 
 #include <asm/ptrace.h>
 #include <asm/coprocessor.h>
+#include <linux/elf-em.h>
 
 /* Xtensa processor ELF architecture-magic number */
 
-#define EM_XTENSA	94
 #define EM_XTENSA_OLD	0xABC7
 
 /* Xtensa relocations defined by the ABIs */
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index d8695ad90f6b..f392dd9d07f7 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -35,6 +35,7 @@
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_OPENRISC     92     /* OpenRISC 32-bit embedded processor */
 #define EM_ARCOMPACT	93	/* ARCompact processor */
+#define EM_XTENSA	94	/* Tensilica Xtensa Architecture */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
-- 
ldv
