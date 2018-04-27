Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759415AbeD0WtB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 18:49:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38432 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD0WtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 18:49:00 -0400
X-Google-Smtp-Source: AB8JxZpt1cnHuynq+/Z5JLzvNTrSItw7HKLdQ+N8+zeiARVjkK4SOkv1ej+ggg9zf9sUlBffJmyqIw==
Date: Fri, 27 Apr 2018 15:48:56 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Wang YanQing <udknight@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix misaligned access for BPF_PROG_TYPE_PERF_EVENT
 program type on x86_32 platform
Message-ID: <20180427224854.2g7ximim7nwkgdpd@ast-mbp>
References: <20180426095749.GA29207@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426095749.GA29207@udknight>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 05:57:49PM +0800, Wang YanQing wrote:
> All the testcases for BPF_PROG_TYPE_PERF_EVENT program type in
> test_verifier(kselftest) report below errors on x86_32:
> "
> 172/p unpriv: spill/fill of different pointers ldx FAIL
> Unexpected error message!
> 0: (bf) r6 = r10
> 1: (07) r6 += -8
> 2: (15) if r1 == 0x0 goto pc+3
> R1=ctx(id=0,off=0,imm=0) R6=fp-8,call_-1 R10=fp0,call_-1
> 3: (bf) r2 = r10
> 4: (07) r2 += -76
> 5: (7b) *(u64 *)(r6 +0) = r2
> 6: (55) if r1 != 0x0 goto pc+1
> R1=ctx(id=0,off=0,imm=0) R2=fp-76,call_-1 R6=fp-8,call_-1 R10=fp0,call_-1 fp-8=fp
> 7: (7b) *(u64 *)(r6 +0) = r1
> 8: (79) r1 = *(u64 *)(r6 +0)
> 9: (79) r1 = *(u64 *)(r1 +68)
> invalid bpf_context access off=68 size=8
> 
> 378/p check bpf_perf_event_data->sample_period byte load permitted FAIL
> Failed to load prog 'Permission denied'!
> 0: (b7) r0 = 0
> 1: (71) r0 = *(u8 *)(r1 +68)
> invalid bpf_context access off=68 size=1
> 
> 379/p check bpf_perf_event_data->sample_period half load permitted FAIL
> Failed to load prog 'Permission denied'!
> 0: (b7) r0 = 0
> 1: (69) r0 = *(u16 *)(r1 +68)
> invalid bpf_context access off=68 size=2
> 
> 380/p check bpf_perf_event_data->sample_period word load permitted FAIL
> Failed to load prog 'Permission denied'!
> 0: (b7) r0 = 0
> 1: (61) r0 = *(u32 *)(r1 +68)
> invalid bpf_context access off=68 size=4
> 
> 381/p check bpf_perf_event_data->sample_period dword load permitted FAIL
> Failed to load prog 'Permission denied'!
> 0: (b7) r0 = 0
> 1: (79) r0 = *(u64 *)(r1 +68)
> invalid bpf_context access off=68 size=8
> "
> 
> This patch fix it, the fix isn't only necessary for x86_32, it will fix the
> same problem for other platforms too, if their size of bpf_user_pt_regs_t
> can't divide exactly into 8.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  Hi all!
>  After mainline accept this patch, then we need to submit a sync patch
>  to update the tools/include/uapi/linux/bpf_perf_event.h.
> 
>  Thanks.
> 
>  include/uapi/linux/bpf_perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
> index eb1b9d2..ff4c092 100644
> --- a/include/uapi/linux/bpf_perf_event.h
> +++ b/include/uapi/linux/bpf_perf_event.h
> @@ -12,7 +12,7 @@
>  
>  struct bpf_perf_event_data {
>  	bpf_user_pt_regs_t regs;
> -	__u64 sample_period;
> +	__u64 sample_period __attribute__((aligned(8)));

I don't think this necessary.
imo it's a bug in pe_prog_is_valid_access
that should have allowed 8-byte access to 4-byte aligned sample_period.
The access rewritten by pe_prog_convert_ctx_access anyway,
no alignment issues as far as I can see.
