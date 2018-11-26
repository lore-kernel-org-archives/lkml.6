Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFFEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60142082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQR5kBI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeK0JtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:49:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43727 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeK0JtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:49:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so13411803qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNXQazqtwLAEPT7yGKdIR+2AxZuQpxFBdO6FmYo9ZiY=;
        b=LQR5kBI0fEDyzPLjKGlv5mlhPpaSghZStSEUcPoPH231GBF3swKb081AKSCQ78ADEh
         JRbJGAg3GXxUWfV/k14a5eylCR3gG8ft0nltQsNenjTxt7k/JkkWDDfwwpfIGB6iVc/n
         PxJd8vn8zNaOJFQXkLuOSIpbvFYMfK5I393zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNXQazqtwLAEPT7yGKdIR+2AxZuQpxFBdO6FmYo9ZiY=;
        b=MRP8A9/WOEovGHeWkzhP39j8HVr2dqbjTLf3sCFtHC6W10s3pHmhRPFRa/D9v/ZmE/
         Wxp3o7n/QpRGPq3rJqE+JXmETZ6tDq3Zo1xelgtSS305PeXSn7SCvgwGVqgOQ3nmuUSZ
         8fKbPFtyf1m/TttTbA/JAAok/wm0JcWlX5+tYESQYjw8LIBQ+0FeuDhebEXbsT/feM9U
         labrrUQAb3Lki72WwhPAMeFuyFEL8MPs+Q6fQagRFSL8z7g1dQxB7rObBxww4q3RNr9h
         xxScrRSWEpJAF2bxstCGSRfaqBS2xg+OY8JhbFGhq0T0Tf/EzvrU0k5iqwxSTt0OQhmQ
         pwbA==
X-Gm-Message-State: AA+aEWZKDRikg178pLdeaClmzuOlvTAl8iQ/kWn7Ctd4+g6d+1Jw7KF1
        MPnIwYBg3TggD7/Iv3acIbtAEQ==
X-Google-Smtp-Source: AFSGD/V5KyETLYrfWvrSQQVbSpIHLBwp/gqggIJCapcxomnOyXjmn487SHOUzooajnFsgb5+oG+Beg==
X-Received: by 2002:a37:4792:: with SMTP id u140mr28058241qka.301.1543272821113;
        Mon, 26 Nov 2018 14:53:41 -0800 (PST)
Received: from workstation.celeiro.br ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id h25sm1337681qtc.49.2018.11.26.14.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 14:53:40 -0800 (PST)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] arm: always update thread_info->syscall
Date:   Mon, 26 Nov 2018 20:53:35 -0200
Message-Id: <20181126225335.10477-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, only way for task->thread_info->syscall to be updated is if
if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
(similar to what has_syscall_work() checks for arm64).

This means that "->syscall" will only be updated if we are tracing the
syscalls through ptrace, for example. This is NOT the same behavior as
arm64, when pt_regs->syscallno is updated in the beginning of svc0
handler for *every* syscall entry.

This patch fixes the issue since this behavior is needed for
/proc/<pid>/syscall 1st argument to be correctly updated.

Link: https://bugs.linaro.org/show_bug.cgi?id=3783
Cc: <stable@vger.kernel.org> # v4.4 v4.9 v4.14 v4.19
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 arch/arm/kernel/asm-offsets.c  | 1 +
 arch/arm/kernel/entry-common.S | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 3968d6c22455..bfe68a98e1c6 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -64,6 +64,7 @@ int main(void)
   DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
+  DEFINE(TI_SYSCALL,		offsetof(struct thread_info, syscall));
 #ifdef CONFIG_VFP
   DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
 #ifdef CONFIG_SMP
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 0465d65d23de..557e2add4e83 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -257,6 +257,8 @@ local_restart:
 	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
 	bne	__sys_trace
 
+	str	r7, [tsk, #TI_SYSCALL]		@ update thread_info->syscall
+
 	invoke_syscall tbl, scno, r10, __ret_fast_syscall
 
 	add	r1, sp, #S_OFF
-- 
2.20.0.rc1

