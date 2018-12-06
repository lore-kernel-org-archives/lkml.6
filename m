Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEBCC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FA72146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0hU0xHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeLFFTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:19:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45238 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeLFFTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:19:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so11179494pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=S0hU0xHbgmYjkcnmpr8H/uFNsV53MrH+wcTobHSy9TwpRErn9aS4Rmk06X1kL5+O4X
         WrImjxuCxrnBsYtDjVKJbyVFC2JrmFvhBceXpLHpe5cVZ4/cIF6cy9KWGtlCRYJlTHIe
         uHukn3NFm7Tofiy6gvPylQ59pR/KyvDNNelL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=Gsk4oXcVcuGNSCLoxk5qVED63LoIlaRYeVGLslOBO31KZx4K/QxCGXwan71PCJDHOZ
         ERGNmLrl9Ps+h790WH3K10sjux0HJoBTxMViSZUTfbo/55hCj7Gw0QXj5MaXoe7fR6mf
         bOhJ3rYBtydQeSlI1s//E3dPvPComAJQNMKj/4vCebEZ25dZOfItcK6uet6jDSwckH6e
         okaNQmwekYfTuF3kqWKghZzwRonO+jJopp+5cqextV4glA96I7sm72oWhJ3XDeEGP4v5
         zIeqg3ikMbOo0Pfs0I28ey2qhQM6iRUwyhiBh3MgPvyggIDNnYWD65TuVpVUWbZloCIl
         xVjA==
X-Gm-Message-State: AA+aEWatEE5BcmqOIxz2Y5i/LHmRSHx+329kTa6oEtKvFUQkCtnExWPl
        x2qAnvp2Vqn1D8qP18BHLWS1Kw==
X-Google-Smtp-Source: AFSGD/V+fPg3hkuovp+kem+e5GDbtY6iru5/hWYu6tuBJPR6hcPqk407lXtk+ip8SNRJT6KqXvCW6A==
X-Received: by 2002:a63:680a:: with SMTP id d10mr23129623pgc.396.1544073584866;
        Wed, 05 Dec 2018 21:19:44 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r66sm32877803pfk.157.2018.12.05.21.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 21:19:44 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 5/7] mips: remove syscall table entries
Date:   Thu,  6 Dec 2018 10:48:26 +0530
Message-Id: <1544073508-13720-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config flag - CONFIG_MIPS_MT_FPAFF uses to check whether which
syscall entries need to be used in scall32-o32.S file.

One of the patch in this patch series will generate syscall table
file. But CONFIG_MIPS_MT_FPAFF flag will add more complexity in the
script to generate the syscall table file.

In order to come up with a common implementation across all archit-
ecture, we need to remove mipsmt_sys_sched_setaffinity and mipsmt-
_sys_sched_getaffinity from the table and define it in other way.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/scall32-o32.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 10f6367..43fa5cd 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -205,6 +205,18 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
 
+#ifdef CONFIG_MIPS_MT_FPAFF
+	/*
+	 * For FPU affinity scheduling on MIPS MT processors, we need to
+	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
+	 * in kernel/sched/core.c.  Considered only temporary we only support
+	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
+	 * atm.
+	 */
+#define sys_sched_setaffinity	mipsmt_sys_sched_setaffinity
+#define sys_sched_getaffinity	mipsmt_sys_sched_getaffinity
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
@@ -447,20 +459,8 @@ EXPORT(sys_call_table)
 	PTR	sys_tkill
 	PTR	sys_sendfile64
 	PTR	sys_futex
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/*
-	 * For FPU affinity scheduling on MIPS MT processors, we need to
-	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
-	 * in kernel/sched/core.c.  Considered only temporary we only support
-	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
-	 * atm.
-	 */
-	PTR	mipsmt_sys_sched_setaffinity
-	PTR	mipsmt_sys_sched_getaffinity
-#else
 	PTR	sys_sched_setaffinity
 	PTR	sys_sched_getaffinity		/* 4240 */
-#endif /* CONFIG_MIPS_MT_FPAFF */
 	PTR	sys_io_setup
 	PTR	sys_io_destroy
 	PTR	sys_io_getevents
-- 
1.9.1

