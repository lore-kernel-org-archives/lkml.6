Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203EA2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkMeJ5kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203EA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeKOQVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:21:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40545 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeKOQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:21:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so3526021pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 22:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PjaOx8k9Y2ORMGO8iIOrEj6UmDS2qPyKnJpoXrQYYCQ=;
        b=LkMeJ5kSK/Ntm3L9XDop5dxfTgCamiEZsmlEegOT40zbn4F3orX+v+HeSVTrewE7bs
         j7v4LnKSpAKH3XJ0nX5E7EQPh5BZ0cq2pYJ85sxYZuHxyv2Qpyi7J+exnM4gJnOlzNB1
         BZBsAqk8JDGQhxPHhPXsck5n52CpflvXU801o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PjaOx8k9Y2ORMGO8iIOrEj6UmDS2qPyKnJpoXrQYYCQ=;
        b=dImUYISpavGwfRKM49dYSAOeRNl59mxfTDjE+bE7X4+pB10X76wNdD59fPEwFrJnqM
         vEAl/rD6KGqGRqV2PpvFtTbLlmI4/srAnkYVGZlyyhYhfG7xbU7qu9R9MUhuWjkyV+jz
         mocXSMXx6a8+CMGNPD0ZtXiOmgf/1ICUg7u/YJDif7NxSobiNkqYJpuBZ8Qrg/lTXhko
         QnAnBHuPyTNMVo8CCA5CvL0GXLDzfcFMNE6vJY2bF/uKdb7RBHnr4gNdk2WmDTSoBroD
         bcWNiKl3RddkbhIk0DCtDVDXz3bt+0DbZ4bTZX6MrK0Yt6LvFMIgg48r2kcFvgPN+9jK
         +jWg==
X-Gm-Message-State: AGRZ1gJftXZi3jBeVHKah/bZRqRkUgTC/zGuHH9VOMgBjjYPbRST16+b
        018Bqk7LaHL+dLIk/teutXB5uA==
X-Google-Smtp-Source: AJdET5e99EtQfxuBAv04AP+XM60L7ZuS2gDU5GfZxUaBdFcUNHIEpKkerxjiapkpaqW0T2LADkHvOA==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31-v6mr4925440plf.320.1542262506014;
        Wed, 14 Nov 2018 22:15:06 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:15:05 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v2 3/5] mips: remove syscall table entries
Date:   Thu, 15 Nov 2018 11:44:19 +0530
Message-Id: <1542262461-29024-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
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
index a9b895f..4eee437 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -208,6 +208,18 @@ einval: li	v0, -ENOSYS
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
+#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
+#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
@@ -450,20 +462,8 @@ EXPORT(sys_call_table)
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

