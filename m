Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C8A20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C8A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeKXHxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:53:10 -0500
Received: from www62.your-server.de ([213.133.104.62]:35094 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeKXHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:53:10 -0500
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gQIfR-0002Lt-12; Fri, 23 Nov 2018 22:07:13 +0100
Received: from [178.197.248.22] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gQIfQ-0003QC-NP; Fri, 23 Nov 2018 22:07:12 +0100
Subject: Re: [PATCH v3 1/2] bpf: add __weak hook for allocating executable
 memory
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
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
 <20181123094152.21368-2-ard.biesheuvel@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a3e95c22-fcae-3550-2d3c-4d07eaad95ae@iogearbox.net>
Date:   Fri, 23 Nov 2018 22:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181123094152.21368-2-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25146/Fri Nov 23 15:18:52 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2018 10:41 AM, Ard Biesheuvel wrote:
> By default, BPF uses module_alloc() to allocate executable memory,
> but this is not necessary on all arches and potentially undesirable
> on some of them.
> 
> So break out the module_alloc() and module_memfree() calls into __weak
> functions to allow them to be overridden in arch code.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  kernel/bpf/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1a796e0799ec..572dd74c26e3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -609,6 +609,16 @@ static void bpf_jit_uncharge_modmem(u32 pages)
>  	atomic_long_sub(pages, &bpf_jit_current);
>  }
>  
> +void *__weak bpf_jit_alloc_exec(unsigned long size)
> +{
> +	return module_alloc(size);
> +}
> +
> +void __weak bpf_jit_free_exec(const void *addr)
> +{
> +	module_memfree(addr);
> +}
> +
>  struct bpf_binary_header *
>  bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>  		     unsigned int alignment,
> @@ -626,7 +636,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>  
>  	if (bpf_jit_charge_modmem(pages))
>  		return NULL;
> -	hdr = module_alloc(size);
> +	hdr = bpf_jit_alloc_exec(size);
>  	if (!hdr) {
>  		bpf_jit_uncharge_modmem(pages);
>  		return NULL;
> @@ -650,7 +660,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
>  	u32 pages = hdr->pages;
>  
> -	module_memfree(hdr);
> +	bpf_jit_free_exec(hdr);
>  	bpf_jit_uncharge_modmem(pages);

The const needs to be removed, this generates the following warning:

# make -j8 kernel/bpf/
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  CC      kernel/bpf/core.o
  CC      kernel/bpf/syscall.o
  CC      kernel/bpf/verifier.o
  CC      kernel/bpf/hashtab.o
  CC      kernel/bpf/helpers.o
  CC      kernel/bpf/inode.o
  CC      kernel/bpf/arraymap.o
  CC      kernel/bpf/lpm_trie.o
kernel/bpf/core.c: In function ‘bpf_jit_free_exec’:
kernel/bpf/core.c:619:17: warning: passing argument 1 of ‘module_memfree’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  module_memfree(addr);
                 ^~~~
In file included from kernel/bpf/core.c:28:0:
./include/linux/moduleloader.h:30:6: note: expected ‘void *’ but argument is of type ‘const void *’
 void module_memfree(void *module_region);
      ^~~~~~~~~~~~~~
  CC      kernel/bpf/local_storage.o
[...]

Please respin with that fixed.

Thanks,
Daniel
