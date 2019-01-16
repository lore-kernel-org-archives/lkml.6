Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3981EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062B3206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="izsIo0mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405861AbfAPRMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:12:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40620 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfAPRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i0R9Pyl8Fwj4O6eHKdmuHQPN6jDUZhDFCD/Kk+G3QhY=; b=izsIo0mfQF0FRN0ByWmjIJsDN3
        rBP6gEFpTO04ImKLTwiuuawjSCzMLPzxV4NTCXcwDsu7igDCpswnqasTgZXFUCfJ4oymfkixcojRp
        m7WEdGRhB9DeAUq1zqhYC++ABWw49z4Fl4XENxER/a1ULzdzlhxNeQawRYuZVQANaTcxNl4brIfCM
        yZODGXM5IOD3uU9R3oOrBMtkxHyYaex727uqp6haIpavzztNXAUT24WXUn2ZMaM6+F4I1tcbuBOen
        Ep9Jdqw59orXCJFDPqR6MG3ItCsOBU+fo9rSTH8pTGHL+ja01HvkjCMJmLYLXxprCfOdXOf0RZ+GM
        RRF4oh6Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjoje-0002cn-65; Wed, 16 Jan 2019 17:12:14 +0000
Subject: Re: [PATCH v2] x86/pgtable: Always inline p4d_index
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181210234538.5405-1-natechancellor@gmail.com>
 <20190116134158.344-1-natechancellor@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6cbf31b-b0f8-5787-61be-86b22b6b8d98@infradead.org>
Date:   Wed, 16 Jan 2019 09:12:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190116134158.344-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 5:41 AM, Nathan Chancellor wrote:
> When building an allyesconfig build with Clang, the kernel fails to link
> arch/x86/platform/efi/efi_64.o because of a failed BUILD_BUG_ON:
> 
> ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> (.text+0x8e5): undefined reference to `__compiletime_assert_277'
> 
> Since there are several BUILD_BUG_ONs in efi_64.c, I isolated it down to
> the following:
> 
>     BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> 
> After some research, it turns out that there is a new config option
> called NO_AUTO_INLINE, which adds '-fno-inline-functions' to
> KBUILD_CFLAGS so that the compiler does not auto inline small functions,
> which causes this BUILD_BUG_ON to fail because p4d_index is no longer an
> integer constant expression.
> 
> According to the help text of the config, functions explicitly marked
> inline should still be inlined. As it turns out, GCC and Clang both
> support '-fno-inline-functions' but Clang only inlines functions when
> they are marked with an always inline annotation[1].
> 
> Since it's expected that p4d_index should always be inlined so that its
> value can be evaluated at build time, mark it as __always_inline.
> 
> [1]: https://github.com/llvm/llvm-project/blob/84cecfcb3db7/clang/lib/Frontend/CompilerInvocation.cpp#L638-L657
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/256
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Hi,
I see the same build error when using gcc 4.8.5 (SUSE Linux).
This patch fixes that build error.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> 
> v1 -> v2:
> 
> * Add Nick's Reviewed-by tag.
> 
> * Update the GitHub URL to use the official LLVM repository and pin to a
>   SHA so that it is always valid, as suggested by Nick.
> 
>  arch/x86/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 40616e805292..f78e53382498 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -918,7 +918,7 @@ static inline int p4d_bad(p4d_t p4d)
>  }
>  #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
>  
> -static inline unsigned long p4d_index(unsigned long address)
> +static __always_inline unsigned long p4d_index(unsigned long address)
>  {
>  	return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
>  }
> 


-- 
~Randy
