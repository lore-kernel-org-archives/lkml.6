Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D93C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524362087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HablBo4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524362087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeJIB6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F892064A;
        Mon,  8 Oct 2018 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024341;
        bh=4OsRXEhzVZN1STz+wYgU8HzMCkdRqr6QQW7bmIonO24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HablBo4sh/vnprSIWEIRq36yf9gyu86XlCOuCmfhMaUZQXXfdgTOKSZg8JYeDQ0xi
         L3RAy+JoHTknUfmDbFeo59CSTV98ec07aWpMU1i+9yTFez5/bsDe1Mcbq4VpMS7D+t
         FXROU+fVIyMc+0t0uPEkse5tA2hMirp7nx1n6sAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 001/168] rseq/selftests: fix parametrized test with -fpie
Date:   Mon,  8 Oct 2018 20:29:41 +0200
Message-Id: <20181008175620.096912313@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit ce01a1575f45bf319e374592656441021a7f5823 upstream.

On x86-64, the parametrized selftest code for rseq crashes with a
segmentation fault when compiled with -fpie. This happens when the
param_test binary is loaded at an address beyond 32-bit on x86-64.

The issue is caused by use of a 32-bit register to hold the address
of the loop counter variable.

Fix this by using a 64-bit register to calculate the address of the
loop counter variables as an offset from rip.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> # v4.18
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 tools/testing/selftests/rseq/param_test.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -56,15 +56,13 @@ unsigned int yield_mod_cnt, nr_abort;
 			printf(fmt, ## __VA_ARGS__);	\
 	} while (0)
 
-#if defined(__x86_64__) || defined(__i386__)
+#ifdef __i386__
 
 #define INJECT_ASM_REG	"eax"
 
 #define RSEQ_INJECT_CLOBBER \
 	, INJECT_ASM_REG
 
-#ifdef __i386__
-
 #define RSEQ_INJECT_ASM(n) \
 	"mov asm_loop_cnt_" #n ", %%" INJECT_ASM_REG "\n\t" \
 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
@@ -76,9 +74,16 @@ unsigned int yield_mod_cnt, nr_abort;
 
 #elif defined(__x86_64__)
 
+#define INJECT_ASM_REG_P	"rax"
+#define INJECT_ASM_REG		"eax"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG_P \
+	, INJECT_ASM_REG
+
 #define RSEQ_INJECT_ASM(n) \
-	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG "\n\t" \
-	"mov (%%" INJECT_ASM_REG "), %%" INJECT_ASM_REG "\n\t" \
+	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG_P "\n\t" \
+	"mov (%%" INJECT_ASM_REG_P "), %%" INJECT_ASM_REG "\n\t" \
 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
 	"jz 333f\n\t" \
 	"222:\n\t" \
@@ -86,10 +91,6 @@ unsigned int yield_mod_cnt, nr_abort;
 	"jnz 222b\n\t" \
 	"333:\n\t"
 
-#else
-#error "Unsupported architecture"
-#endif
-
 #elif defined(__ARMEL__)
 
 #define RSEQ_INJECT_INPUT \


