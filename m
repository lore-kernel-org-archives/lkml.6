Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E36C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBBA2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/eG7dHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBBA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeK2PcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:32:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeK2PcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:32:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so387390pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 20:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
        b=H/eG7dHnYIasQsXZydOLMC1j8gdRu6lu61eyrvxTeEjmAgsC9Q2f/UA55N/VIcMbJ6
         vR+cqv6E7puAitYnn/45zmfcTo9+TzaCELBiChm/uXK2+ZpYYJ0isvp1jHjzkh8zPXR4
         B+XmjAgSEgRGIkBgajO2AFK/QUpAl2QrUixgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjj0KbdPyGPLhWFi0hQxVzhzwcqRrlCgAX7ybTH+ePE=;
        b=kYchZLDXFbRqwWVr5rZDQ7zMmEY0VmjSbH0aKDh7+LTtCasrSECLO1SZvmJBUMEk0H
         /8d55RxvaRhWHWTZbfBAkCU85mqIURw94S+GZ7yGNVGQrofBWlmhuRhWVt5xzmub8TVF
         7WZjqbVPRdIvxqBS1LWh2kvGFjy13wkdCOrK56HyZBY+LRI2X8FFCq8i9V39Crm+X1WI
         uHU1j4A2RsE62tOFsWGa41gy6g4kDj+klt/wfUyoM36L4q34qmuwzkOMtjSVTY3jivor
         tBBYA3Cyh8DhMgiYMXgcS9YNK4LQDnWuhttju5+a9opaqgc4Wi4FREAZ4YyoRBP+Ma18
         4DMQ==
X-Gm-Message-State: AA+aEWa5GsUUCsEb0vkDUZtnBCaWUAYRHaqPPtRzeML6octP3/6qsL94
        r4XpbqpwnMJn/xCQLABPmDXnSQ==
X-Google-Smtp-Source: AFSGD/W2L0FyANG5tdf6T5AYbpXgpPYzOH7PyL+sEiuBxQA4q6POygLEyjhPyj8zdUZ2vdkBJhKe7Q==
X-Received: by 2002:a63:f241:: with SMTP id d1mr4429pgk.2.1543465682219;
        Wed, 28 Nov 2018 20:28:02 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id p2sm770473pfb.28.2018.11.28.20.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 20:28:01 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 2/4] powerpc: move macro definition from asm/systbl.h
Date:   Thu, 29 Nov 2018 09:56:49 +0530
Message-Id: <1543465611-17122-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
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

