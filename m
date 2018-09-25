Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899EEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3E2208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="msjy9pVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3E2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIYXsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:48:18 -0400
Received: from mail.efficios.com ([167.114.142.138]:53946 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIYXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:48:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C1242241FD2;
        Tue, 25 Sep 2018 13:39:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id d81jQZZ39T4Z; Tue, 25 Sep 2018 13:39:37 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E2CAB241FCB;
        Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E2CAB241FCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537897176;
        bh=PPlEECebzJlVc1sGGBr4O/LggAJsKxbOSsHh5bFAhQE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=msjy9pVO5wmjzsGWnTBxQFMI8RxhrXai/0upFFI85Pz/LSvAmZPOC0Q//BYP1mo+C
         OOynroHogHD8W5YwDnfGoCF6UAQP7ObvFczkiffbAP5ni506OTuUB11g2X6fnaMK1H
         5ZlOUcpp0Ivbog7qk+UH8ku5/+/XWFxNe/Hsz2rFOIvFavPs4A13qo6eXYr06GMpyi
         bxv0JrbytdCzbcuhOUm/PQGWv2mPB6fOnaRFhGLGYMlhPojzbAhsjUVm1e0PY/BTJi
         p9sfQSoDUW+LX3ULVfG62Ghm0q9Z+n9RLjzG9iPvS25t/tWCgiCp9XaeEPRP3PPhwW
         ikzNEbTk/HFRg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id XALuaMRmPicw; Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C1A17241FC4;
        Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
Date:   Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        stable <stable@vger.kernel.org>
Message-ID: <1367962117.10271.1537897176578.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180918135328.32034-1-mathieu.desnoyers@efficios.com>
References: <20180918135328.32034-1-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rseq/selftests: fix parametrized test with -fpie
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3019)
Thread-Topic: rseq/selftests: fix parametrized test with -fpie
Thread-Index: C5x8DI+4smN7GnGfzzW4HJjJpBb8Bg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 18, 2018, at 9:53 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> On x86-64, the parametrized selftest code for rseq crashes with a
> segmentation fault when compiled with -fpie. This happens when the
> param_test binary is loaded at an address beyond 32-bit on x86-64.
> 
> The issue is caused by use of a 32-bit register to hold the address
> of the loop counter variable.
> 
> Fix this by using a 64-bit register to calculate the address of the
> loop counter variables as an offset from rip.

Should this fix go through tip or the selftests tree ?

Thanks,

Mathieu

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: <stable@vger.kernel.org> # v4.18
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Watson <davejwatson@fb.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shuah Khan <shuahkh@osg.samsung.com>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Chris Lameter <cl@linux.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Maurer <bmaurer@fb.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> tools/testing/selftests/rseq/param_test.c | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/param_test.c
> b/tools/testing/selftests/rseq/param_test.c
> index 615252331813..4bc071525bf7 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -56,15 +56,13 @@ unsigned int yield_mod_cnt, nr_abort;
> 			printf(fmt, ## __VA_ARGS__);	\
> 	} while (0)
> 
> -#if defined(__x86_64__) || defined(__i386__)
> +#ifdef __i386__
> 
> #define INJECT_ASM_REG	"eax"
> 
> #define RSEQ_INJECT_CLOBBER \
> 	, INJECT_ASM_REG
> 
> -#ifdef __i386__
> -
> #define RSEQ_INJECT_ASM(n) \
> 	"mov asm_loop_cnt_" #n ", %%" INJECT_ASM_REG "\n\t" \
> 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
> @@ -76,9 +74,16 @@ unsigned int yield_mod_cnt, nr_abort;
> 
> #elif defined(__x86_64__)
> 
> +#define INJECT_ASM_REG_P	"rax"
> +#define INJECT_ASM_REG		"eax"
> +
> +#define RSEQ_INJECT_CLOBBER \
> +	, INJECT_ASM_REG_P \
> +	, INJECT_ASM_REG
> +
> #define RSEQ_INJECT_ASM(n) \
> -	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG "\n\t" \
> -	"mov (%%" INJECT_ASM_REG "), %%" INJECT_ASM_REG "\n\t" \
> +	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG_P "\n\t" \
> +	"mov (%%" INJECT_ASM_REG_P "), %%" INJECT_ASM_REG "\n\t" \
> 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
> 	"jz 333f\n\t" \
> 	"222:\n\t" \
> @@ -86,10 +91,6 @@ unsigned int yield_mod_cnt, nr_abort;
> 	"jnz 222b\n\t" \
> 	"333:\n\t"
> 
> -#else
> -#error "Unsupported architecture"
> -#endif
> -
> #elif defined(__ARMEL__)
> 
> #define RSEQ_INJECT_INPUT \
> --
> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
