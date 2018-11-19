Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB43BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9276D20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9276D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeKSVBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:01:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:58854 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeKSVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:01:09 -0500
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gOgwB-0003ic-UY; Mon, 19 Nov 2018 11:37:51 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gOgwB-0005yq-Ig; Mon, 19 Nov 2018 11:37:51 +0100
Subject: Re: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-2-ard.biesheuvel@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
Date:   Mon, 19 Nov 2018 11:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181117185715.25198-2-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25134/Mon Nov 19 07:16:12 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/2018 07:57 PM, Ard Biesheuvel wrote:
> Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
> allocations") added a call to bpf_jit_uncharge_modmem() to the routine
> bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
> This function is overridden by arches, some of which do not call
> bpf_jit_binary_free() to release the memory, and so the released
> memory is not accounted for, potentially leading to spurious allocation
> failures.
> 
> So replace the direct calls to module_memfree() in the arch code with
> calls to bpf_jit_binary_free().

Sorry but this patch is completely buggy, and above description on the
accounting incorrect as well. Looks like this patch was not tested at all.

The below cBPF JITs that use module_memfree() which you replace with
bpf_jit_binary_free() are using module_alloc() internally to get the JIT
image buffer ...

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/mips/net/bpf_jit.c           | 2 +-
>  arch/powerpc/net/bpf_jit_comp.c   | 2 +-
>  arch/powerpc/net/bpf_jit_comp64.c | 5 +----
>  arch/sparc/net/bpf_jit_comp_32.c  | 2 +-
>  4 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index 4d8cb9bb8365..1b69897274a1 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -1264,7 +1264,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
>  	if (fp->jited)
> -		module_memfree(fp->bpf_func);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d5bfe24bb3b5..a1ea1ea6b40d 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -683,7 +683,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
>  	if (fp->jited)
> -		module_memfree(fp->bpf_func);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 50b129785aee..84c8f013a6c6 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1024,11 +1024,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  /* Overriding bpf_jit_free() as we don't set images read-only. */
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
> -	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
> -	struct bpf_binary_header *bpf_hdr = (void *)addr;
> -
>  	if (fp->jited)
> -		bpf_jit_binary_free(bpf_hdr);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> index a5ff88643d5c..01bda6bc9e7f 100644
> --- a/arch/sparc/net/bpf_jit_comp_32.c
> +++ b/arch/sparc/net/bpf_jit_comp_32.c
> @@ -759,7 +759,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
>  	if (fp->jited)
> -		module_memfree(fp->bpf_func);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> 

