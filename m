Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5940FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163EE208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9ZwnBQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163EE208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeGINgW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:36:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeGINgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9w5VdgfUVYQF5yVR0r0/6fkigc8lnLuY7yqTqubQIY4=; b=o9ZwnBQ9ezXxxE9mvaV57EC1l
        zKyE5/+Ss3zZZH+qEakbABxp9mDBEq3JvTpsKouPmk1DjqJaJ++BkWR8iOHx2vaLQC2xMTFLFsNXH
        kGB9bkXTklYIEXOt9RdNs6Cc+OCGlqyC4q5CyWN1s/hM+7fQRn6RacrgfnfLkdIwj+iSt83g1ItCL
        dChCqrsVr+KoQSneRnnhLJ6wUylo3vp9HISWC0AuVTZZitlwdK8dzWEQKGdDQ1RKCeCzqB09eFp5f
        NIiZySHw6glxlZ/FoQ/x6jM0wcT6Guv84TOICECSI3epss18/M8HoRrafLfnyH1xc5aNsxtPJbM/T
        C+eEt7qsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcWKN-0003Yu-Jr; Mon, 09 Jul 2018 13:35:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F8A320289331; Mon,  9 Jul 2018 15:35:42 +0200 (CEST)
Date:   Mon, 9 Jul 2018 15:35:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Message-ID: <20180709133542.GP2476@hirez.programming.kicks-ass.net>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:47:41PM +0300, Alexey Brodkin wrote:
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 8d28eb010d0d..b94b749b5952 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -13,7 +13,7 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>  
>  typedef struct {
> -	long long counter;
> +	u64 __aligned(8) counter;
>  } atomic64_t;

The type is wrong, atomic is signed, the alignment also really doesn't
matter, generic atomic64 is utter crap.

>  #define ATOMIC64_INIT(i)	{ (i) }
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 9834e90aa010..e2f631782621 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -174,12 +174,12 @@ typedef phys_addr_t resource_size_t;
>  typedef unsigned long irq_hw_number_t;
>  
>  typedef struct {
> -	int counter;
> +	u32 __aligned(4) counter;
>  } atomic_t;

u32 is wrong, the atomic type is signed.

Also, if an architecture doesn't properly align its native machine word
size but requires alignment for atomics it's a broken architecture.

>  
>  #ifdef CONFIG_64BIT
>  typedef struct {
> -	long counter;
> +	u64 __aligned(8) counter;
>  } atomic64_t;
>  #endif
>  

Similar for this one, on 64bit archs that support atomics the native
64bit types (long included) had better already imply this alignment.
