Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150CAC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFDD20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxOzaXWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFDD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLGGMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:12:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40531 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLGGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:12:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1413948pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
        b=hxOzaXWnpR/CWtOGR+Cfrzu5RjQW2/sTKcSx+4jTa2/lG+yOhjzJzEFTVhyv71mMT7
         5TGx5TE+d8IZlCTcGoqQkNgrKVi3G/fGVtE+iGsiKWYet6JfLrBnE9fB2aJfWX+a34QK
         9XJjzVXRnsGz4cUWdIiN1uBX8U7f0x+EYj0jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
        b=WCnant2jk7XxNVfAJ/dBUjJ/PSh488nfjukrmTCQY/p4oHxb7BZkGgKbhSviKOpVmQ
         ciMp6PUEm9e8QJZ0nyUY/WB4Z/eV79OlsHxuiOSej5MgN4v0ihhDumQgl592Oz5z93ZO
         +7NguZOQfmw3DZ3Yk3XT38vDPeUMocnu8V3n5u2DK0MiQD6fU9/n5I+R6yvNjMAXNWOv
         Dy0b0/XNWDXBmgUQ3gpHMp6wTX0++VA6X+JoJGzAUtHDrYShqUVBR1LkQwDrrVfIJepN
         HhVaB7URpPRcpdub39IEBxZSG0hOmoR+zRHF4zz4mmGO17kacNYTne0SNx1+ACC52SAU
         DgRA==
X-Gm-Message-State: AA+aEWYPpt37sjeNykZg2U1Hx1fArQllotclvorAN3bRtFFRuqOnAZrj
        wsU89OzUBZ9sqnkwJo1eGs+MEg==
X-Google-Smtp-Source: AFSGD/Wxxq+0GgsKXcjEEsKDpmADbAPOWkuU8gUE37rYoADE0Tc+SOfiv2oJSfO0yvbOlQbJAKcxvg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr981796pfi.75.1544163139282;
        Thu, 06 Dec 2018 22:12:19 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.25])
        by smtp.gmail.com with ESMTPSA id r4sm5719862pgn.54.2018.12.06.22.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 22:12:18 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 2/5] powerpc: move macro definition from asm/systbl.h
Date:   Fri,  7 Dec 2018 11:41:37 +0530
Message-Id: <1544163100-15510-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
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
 arch/powerpc/include/asm/systbl.h | 1 -
 arch/powerpc/kernel/systbl.S      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.9.1

