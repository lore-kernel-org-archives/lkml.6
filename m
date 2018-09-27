Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AC1215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AC1215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeI1Bcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:32:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60649 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbeI1Bcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2A5CBC1E08;
        Thu, 27 Sep 2018 19:12:55 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wvin8f7mqBzE; Thu, 27 Sep 2018 19:12:55 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B5777C1E11;
        Thu, 27 Sep 2018 19:12:12 +0000 (UTC)
Subject: Re: [PATCH v2] rseq/selftests: fix parametrized test with -fpie
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20180927183919.7461-1-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <34c0750c-bf39-267c-e1e4-38bbbf77305c@kernel.org>
Date:   Thu, 27 Sep 2018 13:12:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927183919.7461-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 12:39 PM, Mathieu Desnoyers wrote:
> On x86-64, the parametrized selftest code for rseq crashes with a
> segmentation fault when compiled with -fpie. This happens when the
> param_test binary is loaded at an address beyond 32-bit on x86-64.
> 
> The issue is caused by use of a 32-bit register to hold the address
> of the loop counter variable.
> 
> Fix this by using a 64-bit register to calculate the address of the
> loop counter variables as an offset from rip.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org> # v4.18
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Watson <davejwatson@fb.com>
> Cc: Will Deacon <will.deacon@arm.com>
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
> Changes since v1:
> - Update email address for Shuah Khan based on updated MAINTAINERS
>   email address,
> - Rebase on v4.19-rc5.
> ---
>  tools/testing/selftests/rseq/param_test.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
> index 642d4e12abea..eec2663261f2 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -56,15 +56,13 @@ unsigned int yield_mod_cnt, nr_abort;
>  			printf(fmt, ## __VA_ARGS__);	\
>  	} while (0)
>  
> -#if defined(__x86_64__) || defined(__i386__)
> +#ifdef __i386__
>  
>  #define INJECT_ASM_REG	"eax"
>  
>  #define RSEQ_INJECT_CLOBBER \
>  	, INJECT_ASM_REG
>  
> -#ifdef __i386__
> -
>  #define RSEQ_INJECT_ASM(n) \
>  	"mov asm_loop_cnt_" #n ", %%" INJECT_ASM_REG "\n\t" \
>  	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
> @@ -76,9 +74,16 @@ unsigned int yield_mod_cnt, nr_abort;
>  
>  #elif defined(__x86_64__)
>  
> +#define INJECT_ASM_REG_P	"rax"
> +#define INJECT_ASM_REG		"eax"
> +
> +#define RSEQ_INJECT_CLOBBER \
> +	, INJECT_ASM_REG_P \
> +	, INJECT_ASM_REG
> +
>  #define RSEQ_INJECT_ASM(n) \
> -	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG "\n\t" \
> -	"mov (%%" INJECT_ASM_REG "), %%" INJECT_ASM_REG "\n\t" \
> +	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG_P "\n\t" \
> +	"mov (%%" INJECT_ASM_REG_P "), %%" INJECT_ASM_REG "\n\t" \
>  	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
>  	"jz 333f\n\t" \
>  	"222:\n\t" \
> @@ -86,10 +91,6 @@ unsigned int yield_mod_cnt, nr_abort;
>  	"jnz 222b\n\t" \
>  	"333:\n\t"
>  
> -#else
> -#error "Unsupported architecture"
> -#endif
> -
>  #elif defined(__s390__)
>  
>  #define RSEQ_INJECT_INPUT \
> 

Applied now to linux-kselftest fixes. I will get this into the next rc

thanks,
-- Shuah
