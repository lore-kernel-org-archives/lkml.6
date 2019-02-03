Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C927C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4946A218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfBCNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54038 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728437AbfBCNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:05 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003wG-IG; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9j-0007Fr-LC; Sun, 03 Feb 2019 14:49:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paul Burton" <paul.burton@mips.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Elvira Khabirova" <lineprinter@altlinux.org>,
        "James Hogan" <jhogan@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.513046058@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 218/305] mips: fix mips_get_syscall_arg o32 check
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Dmitry V. Levin" <ldv@altlinux.org>

commit c50cbd85cd7027d32ac5945bb60217936b4f7eaf upstream.

When checking for TIF_32BIT_REGS flag, mips_get_syscall_arg() should
use the task specified as its argument instead of the current task.

This potentially affects all syscall_get_arguments() users
who specify tasks different from the current.

Fixes: c0ff3c53d4f99 ("MIPS: Enable HAVE_ARCH_TRACEHOOK.")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21185/
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -57,7 +57,7 @@ static inline unsigned long mips_get_sys
 #ifdef CONFIG_64BIT
 	case 4: case 5: case 6: case 7:
 #ifdef CONFIG_MIPS32_O32
-		if (test_thread_flag(TIF_32BIT_REGS))
+		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 			return get_user(*arg, (int *)usp + n);
 		else
 #endif

