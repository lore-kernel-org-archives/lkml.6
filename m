Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB6DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968782145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrJJrhEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968782145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbeKNUGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:06:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35939 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNUGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:06:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so839327pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBOiHjj1Vb9CM2P9BbAhEtmK+gIGLynoLuGXLaiP/cg=;
        b=NrJJrhEbSERnmq+rxVaUBy/OVX7rGBE4Gde01GM49QoeOfXyZaEWdAZxnSHXkYpBzQ
         rcYdEyz/C4LGFMHKZMcP9o78GWdyQkUrCTEIFfRWVdVpYkNWwtjxcSe4g8mMul+OwoOX
         4KieTnH/cbOq6aDn8FSE2/7dx1hs+yv6Wwuhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBOiHjj1Vb9CM2P9BbAhEtmK+gIGLynoLuGXLaiP/cg=;
        b=tHIzTWjDtV2QtKgDZobnVnVf2fE79jUJyQVTegx1+kyYmeu/cYXTFaN3pJ9eSNMfJH
         w/uC2kJT2Or8zEIk54WR4EhMy2UVhnlco+7pN32h5eQZ9erLo8M8vEMCaQ4lMdycHn3q
         Is0WGHeE75hAXXY8TqStvXRmK5YiQ77rBUm6aMH8k2YynEmrYpk3W+YNxM2ZS8vWDeT2
         sa+hNCWm3v1yz8sJH9gkKdoOfMQWfo0ltkKpu3P1oIBQ35NQ2w/5wIOFsc/Ty3W1jMHy
         /h9Ph7X+1oP5P9x529vimhyXiigqphIau0NIz9DPqOR6U/6W3PHAeEiA1Lx/PeeJqxpc
         jzjQ==
X-Gm-Message-State: AGRZ1gIKndB0F5sWpPwHkXGFYvz9m9Bt5C4mVvbQqGXp9skI8N56iLis
        75a4DNfNCuZ5hSLYqVXqKCzttg==
X-Google-Smtp-Source: AJdET5errrOXabnhrhN0ZzOmW/eV0Uk8AQQALCk7VW0DxRFFgukmiE/nS69/nlq632zwpm9hDV6Aog==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr1118400pgt.137.1542189839712;
        Wed, 14 Nov 2018 02:03:59 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id g15sm21633873pfj.131.2018.11.14.02.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 02:03:59 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 2/4] powerpc: move macro definition from asm/systbl.h
Date:   Wed, 14 Nov 2018 15:33:16 +0530
Message-Id: <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the macro definition for compat_sys_sigsuspend from
asm/systbl.h to the file which it is getting included.

One of the patch in this patch series is generating uapi
header and syscall table files. In order to come up with
a common implimentation across all architecture, we need
to do this change.

This change will simplify the implementation of system
call table generation script and help to come up a common
implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/systbl.h           | 1 -
 arch/powerpc/kernel/systbl.S                | 1 +
 arch/powerpc/kernel/systbl_chk.c            | 1 +
 arch/powerpc/platforms/cell/spu_callbacks.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171..c4321b9 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -76,7 +76,6 @@
 SYSCALL_SPU(ssetmask)
 SYSCALL_SPU(setreuid)
 SYSCALL_SPU(setregid)
-#define compat_sys_sigsuspend sys_sigsuspend
 SYS32ONLY(sigsuspend)
 SYSX(sys_ni_syscall,compat_sys_sigpending,sys_sigpending)
 SYSCALL_SPU(sethostname)
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 919a327..9ff1913 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -47,4 +47,5 @@
 .globl sys_call_table
 sys_call_table:
 
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 4653258..db97da7 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -56,5 +56,6 @@
 #define getrlimit		ugetrlimit
 
 START_TABLE
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
 END_TABLE NR_syscalls
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 8ae8620..7517a43 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -47,6 +47,7 @@
 #define COMPAT_SPU_NEW(func)	sys_##func,
 #define SYSX_SPU(f, f3264, f32)	f,
 
+#define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
 };
 
-- 
1.9.1

