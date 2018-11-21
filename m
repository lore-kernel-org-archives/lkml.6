Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27616C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC6C206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC6C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeKVJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:56:52 -0500
Received: from www62.your-server.de ([213.133.104.62]:51836 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbeKVJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:56:52 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gPbmu-0005Zw-61; Thu, 22 Nov 2018 00:20:04 +0100
Received: from [178.197.249.20] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gPbmt-0007pZ-Sa; Thu, 22 Nov 2018 00:20:03 +0100
Subject: Re: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
 <20181121131733.14910-3-ard.biesheuvel@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <945415e1-0ff8-65ce-15fa-33cea0a7d1c9@iogearbox.net>
Date:   Thu, 22 Nov 2018 00:20:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181121131733.14910-3-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25141/Wed Nov 21 23:16:24 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2018 02:17 PM, Ard Biesheuvel wrote:
> The arm64 module region is a 128 MB region that is kept close to
> the core kernel, in order to ensure that relative branches are
> always in range. So using the same region for programs that do
> not have this restriction is wasteful, and preferably avoided.
> 
> Now that the core BPF JIT code permits the alloc/free routines to
> be overridden, implement them by simple vmalloc_exec()/vfree()
> calls, which can be served from anywere. This also solves an
> issue under KASAN, where shadow memory is needlessly allocated for
> all BPF programs (which don't require KASAN shadow pages since
> they are not KASAN instrumented)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a6fdaea07c63..f91b7c157841 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -940,3 +940,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  					   tmp : orig_prog);
>  	return prog;
>  }
> +
> +void *bpf_jit_alloc_exec(unsigned long size)
> +{
> +	return vmalloc_exec(size);
> +}
> +
> +void bpf_jit_free_exec(const void *addr)
> +{
> +	return vfree(size);
> +}

Hmm, could you elaborate in the commit log on the potential performance
regression for JITed progs on arm64 after this change?

I think this change would also break JITing of BPF to BPF calls. You might
have the same issue as ppc64 folks where the offset might not fit into imm
anymore and would have to transfer it via fp->aux->func[off]->bpf_func
instead.
