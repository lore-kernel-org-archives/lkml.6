Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30D2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w3rSSaJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD30D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJKWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeJKWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:38:30 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009642085B;
        Thu, 11 Oct 2018 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539270654;
        bh=dxwHW/mRe2dpJw+U/etCCqU9iGn4rgbrWvEag2i327g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w3rSSaJOfoopVC4wg+ucyYhx+lig8AcnTicNLpUUAcOjb8n6YRy9AFv5LepW4HVr3
         fWn4Uv9M0X7l/U3hdxisiQPb4Nuk0zh9KOxuUVO5Q7n0rj9jTdEhBb2xGI5dHiWn1G
         C8BW56wge7zklTAy2WYGss7ZohP4deBmiT1WOQr4=
Date:   Thu, 11 Oct 2018 17:10:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Cc:     stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Gleb Natapov <gleb@kernel.org>,
        yu-cheng yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 4.4.y 1/3] x86/fpu: Remove use_eager_fpu()
Message-ID: <20181011151052.GB31502@kroah.com>
References: <1531270120-19068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
 <1531270120-19068-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531270120-19068-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:48:38AM +0900, Daniel Sangorrin wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> commit c592b57347069abfc0dcad3b3a302cf882602597 upstream
> 
> This removes all the obvious code paths that depend on lazy FPU mode.
> It shouldn't change the generated code at all.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: pbonzini@redhat.com
> Link: http://lkml.kernel.org/r/1475627678-20788-5-git-send-email-riel@redhat.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  arch/x86/crypto/crc32c-intel_glue.c | 17 ++++-------------
>  arch/x86/include/asm/fpu/internal.h | 34 +--------------------------------
>  arch/x86/kernel/fpu/core.c          | 38 +++++--------------------------------
>  arch/x86/kernel/fpu/signal.c        |  8 +++-----
>  arch/x86/kvm/cpuid.c                |  4 +---
>  arch/x86/kvm/x86.c                  | 10 ----------
>  6 files changed, 14 insertions(+), 97 deletions(-)

This does not apply to the current 4.4.y tree.  Can you rebase this
series and resend it?

thanks,

greg k-h
