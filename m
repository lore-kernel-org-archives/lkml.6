Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D591C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFAF2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFAF2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbeKMO5d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:57:33 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:36216 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMO5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:57:32 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 67D249E0CD923C0BCAC3;
        Tue, 13 Nov 2018 13:01:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAD50smi015127;
        Tue, 13 Nov 2018 13:00:54 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018111313010683-10345562 ;
          Tue, 13 Nov 2018 13:01:06 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        konrad.wilk@oracle.com, luto@kernel.org, thomas.lendacky@amd.com,
        pravin.shedge4linux@gmail.com, namit@vmware.com, bp@suse.de,
        jroedel@suse.de, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH] x86/process: Fix some -Wmissing-prototypes warnings
Date:   Tue, 13 Nov 2018 13:02:40 +0800
Message-Id: <1542085360-22396-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-13 13:01:06,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-13 13:00:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wAD50smi015127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when building kernel with W=1:
arch/x86/kernel/process.c:653:13: warning: no previous prototype for ‘arch_post_acpi_subsys_init’ [-Wmissing-prototypes]
arch/x86/kernel/process.c:717:15: warning: no previous prototype for ‘arch_randomize_brk’ [-Wmissing-prototypes]
arch/x86/kernel/process.c:784:6: warning: no previous prototype for ‘do_arch_prctl_common’ [-Wmissing-prototypes]

Add the missing including files to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfd..8a33d4a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -22,6 +22,8 @@
 #include <linux/utsname.h>
 #include <linux/stackprotector.h>
 #include <linux/cpuidle.h>
+#include <linux/acpi.h>
+#include <linux/elf-randomize.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
@@ -39,6 +41,7 @@
 #include <asm/desc.h>
 #include <asm/prctl.h>
 #include <asm/spec-ctrl.h>
+#include <asm/proto.h>
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
-- 
1.8.3.1

