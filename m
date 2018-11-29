Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00006C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70A520863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6KuxEJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70A520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeK2TtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:49:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38079 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeK2TtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:49:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so676020pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=I6KuxEJcuwNeGPJjY2lgWumxqYUkkEh7Fg7DnYJSet12289NwLHveMP3NpcO0poyib
         Zbkyfcr7pFzlM6c/mE76P+hFFogxGE/ec8bXGHT80Z8kSg6XjQP/Se6VmnBd+sfvzEuZ
         f0NU/Of0dT3Kr0AtWM3/BgDGCdnVL7G7WjRl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebvja7ppkTsEwfDofOxrBD+NfckjZ0iQFP4vJ8R1TQI=;
        b=ZWv1dOxo0eeNsTpyvwQ4vfBfWobjC365pXYbukLPhzH5Kgl9lcolsfPPBayk/2h1pT
         BKskXEoRZ7o9ImwutuBSuDmXFqj2bN71mNwETLbjc2Inn/yJd36pojjb05fNIeK5liew
         NsRpedKBTriOTsBE1g8ZprkDCvHSdpvXNU7aXrv24sJ1J+jKfM0csi9cZio5A5M4JrqL
         tSVzyxtgBwGzIj3fHRU5pWNHiB115xCetJy1zw7zi2J13fyBNul6B876YmxS8vsIvJDn
         7Mfvh/Ao0JpxpKrkePyEusxn8RL9FfZSFbS1uz7KJztEItrtMzGFLzMdjasCcUV0vzfp
         3thg==
X-Gm-Message-State: AA+aEWaF5rOPAYPwvpixrlRALDe+PB7CsCAMCz87I3y5J59y2Pe2epWA
        6o2rHqnZnApbnsBR+oaDop4ghw==
X-Google-Smtp-Source: AFSGD/VBobjmhYHkrBHvaIGHNNaNy0pGaPBMBEG+VvEQ6tcCEl/O+7JEsnb52tOza6fdn5hACbtoTA==
X-Received: by 2002:a63:2406:: with SMTP id k6mr455347pgk.229.1543481085000;
        Thu, 29 Nov 2018 00:44:45 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:44 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 4/6] mips: remove syscall table entries
Date:   Thu, 29 Nov 2018 14:13:34 +0530
Message-Id: <1543481016-18500-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
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

