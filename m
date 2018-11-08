Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23680C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA920857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bChDUMU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFA920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeKIHjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbeKIHjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:39:17 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C27208E3;
        Thu,  8 Nov 2018 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714508;
        bh=tZxv+KaOyiGHq5qWK+Ccv4oFJku2+/pF55clW50yChk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bChDUMU8iLkZgO4t36IB1sJL38qK8V1NWZHbAFQUesfl4lAuxiCQEJD28+mduC2j3
         UN+C/XyeNNj3u+CdSU1NrE2zPJEGTJJmJVeUkVI7wW41dBG3JeidGx7J/yElkKUJ4T
         hm9UEIbODFAwkn4Z8jyXI8/OT0+U2Ef9tsd8y5Os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        eric.dumazet@gmail.com, bp@alien8.de
Subject: [PATCH 4.4 113/114] x86/percpu: Fix this_cpu_read()
Date:   Thu,  8 Nov 2018 13:52:08 -0800
Message-Id: <20181108215111.026443173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit b59167ac7bafd804c91e49ad53c6d33a7394d4c8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/percpu.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -184,22 +184,22 @@ do {									\
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


