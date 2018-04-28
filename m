Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759712AbeD1JS3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 05:18:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41502 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759620AbeD1JS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 05:18:27 -0400
X-Google-Smtp-Source: AB8JxZqjJWcu+rXiZEFYgptodkeqW3kg7eMjEpLDO2QyvfrXMTqx6dDLDb+Sq+qE/WkvpwLiSsfFFw==
Date: Sat, 28 Apr 2018 11:18:23 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD] x86: The future of MPX
Message-ID: <20180428091823.h3iajtxkqdwdcpst@gmail.com>
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Dave,
> 
> I've got the following MPX related information:
> 
>  .... But they [Intel] certainly haven't maintained the whole MPX support
>  in GCC at all since two or three years (e.g. bootstrap with MPX was broken
>  since forever), so now it's gone from GCC. ....
> 
> and I know that GCC is discussing MPX removal since May last year at least.
> To the best of my knowledge clang does not support it either.
> 
> So what's the state of this stuff? If we don't have a compiler supporting
> it how on earth is that useful or even testable for anyone who does not
> have access to some magic Intel internal compiler version?
> 
> If that's the sad state of affairs, then we just should move the whole
> stuff into staging or simply queue it for removal in 4.18.

I just tried the MPX testcases with the latest kernel:

 deimos:~/tip/tools/testing/selftests/x86> ./mpx-mini-test_64 
 XSAVE is supported by HW & OS
 XSAVE processor supported state mask: 0x21f
 XSAVE OS supported state mask: 0x21f
  BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
   BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
 mpx-mini-test_64: mpx-mini-test.c:58: write_int_to: Assertion `fd >= 0' failed.
 Aborted (core dumped)

 deimos:~/tip/tools/testing/selftests/x86> ./mpx-mini-test_32 
 XSAVE is supported by HW & OS
 XSAVE processor supported state mask: 0x21f
 XSAVE OS supported state mask: 0x21f
  BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
   BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
 mpx-mini-test_32: mpx-mini-test.c:58: write_int_to: Assertion `fd >= 0' failed.
 Aborted (core dumped)

... and both of them crashed.

The CPU has MPX support and the kernel has CONFIG_X86_INTEL_MPX=y:

 deimos:~> dmesg | grep -i mpx
 [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
 [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'

Thanks,

	Ingo
