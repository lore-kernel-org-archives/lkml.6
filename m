Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B44EC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E1D2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJNQ5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:57:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeJNQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:57:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9E9Gb6u3116981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Oct 2018 02:16:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9E9GXZu3116954;
        Sun, 14 Oct 2018 02:16:33 -0700
Date:   Sun, 14 Oct 2018 02:16:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-b59167ac7bafd804c91e49ad53c6d33a7394d4c8@git.kernel.org>
Cc:     hpa@zytor.com, edumazet@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org
Reply-To: edumazet@google.com, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181011104019.748208519@infradead.org>
References: <20181011104019.748208519@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/percpu: Fix this_cpu_read()
Git-Commit-ID: b59167ac7bafd804c91e49ad53c6d33a7394d4c8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b59167ac7bafd804c91e49ad53c6d33a7394d4c8
Gitweb:     https://git.kernel.org/tip/b59167ac7bafd804c91e49ad53c6d33a7394d4c8
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Oct 2018 12:38:27 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Oct 2018 11:11:22 +0200

x86/percpu: Fix this_cpu_read()

Eric reported that a sequence count loop using this_cpu_read() got
optimized out. This is wrong, this_cpu_read() must imply READ_ONCE()
because the interface is IRQ-safe, therefore an interrupt can have
changed the per-cpu value.

Fixes: 7c3576d261ce ("[PATCH] i386: Convert PDA into the percpu section")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Eric Dumazet <edumazet@google.com>
Cc: hpa@zytor.com
Cc: eric.dumazet@gmail.com
Cc: bp@alien8.de
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181011104019.748208519@infradead.org

---
 arch/x86/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e9202a0de8f0..1a19d11cfbbd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -185,22 +185,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(1)",%0"		\
+		asm volatile(op "b "__percpu_arg(1)",%0"\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(1)",%0"		\
+		asm volatile(op "w "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(1)",%0"		\
+		asm volatile(op "l "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(1)",%0"		\
+		asm volatile(op "q "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
