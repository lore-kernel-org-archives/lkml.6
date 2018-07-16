Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE32ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7928020852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7928020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeGPTxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:53:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52550 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeGPTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:53:00 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ff96E-0002mY-GE; Mon, 16 Jul 2018 21:23:58 +0200
Date:   Mon, 16 Jul 2018 21:23:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     mingo@kernel.org, mingo@redhat.com, andy.shevchenko@gmail.com,
        arnd@arndb.de, aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        peterz@infradead.org, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 02/12] atomics/x86: reduce arch_cmpxchg64*()
 instrumentation
In-Reply-To: <20180716113017.3909-3-mark.rutland@arm.com>
Message-ID: <alpine.DEB.2.21.1807162123380.1693@nanos.tec.linutronix.de>
References: <20180716113017.3909-1-mark.rutland@arm.com> <20180716113017.3909-3-mark.rutland@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Mark Rutland wrote:
> Currently x86's arch_cmpxchg64() and arch_cmpxchg64_local() are
> instrumented twice, as they call into instrumented atomics rather than
> their arch_ equivalents.
> 
> A call to cmpxchg64() results in:
> 
>   cmpxchg64()
>     kasan_check_write()
>     arch_cmpxchg64()
>       cmpxchg()
>         kasan_check_write()
>         arch_cmpxchg()
> 
> Let's fix this up and call the arch_ equivalents, resulting in:
> 
>   cmpxchg64()
>     kasan_check_write()
>     arch_cmpxchg64()
>       arch_cmpxchg()
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Will Deacon <will.deacon@arm.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
