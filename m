Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeEGHXF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:23:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41379 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeEGHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:22:59 -0400
X-Google-Smtp-Source: AB8JxZq3reYRf37ccEGDUHkbKGdavFVWBMny3U+en398DHyEI1TO9a5+LPyAhZQxFGKhpSIBo8vpww==
Date: Mon, 7 May 2018 15:23:05 +0800
From: Wang YanQing <udknight@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix misaligned access for BPF_PROG_TYPE_PERF_EVENT
 program type on x86_32 platform
Message-ID: <20180507072305.GA11275@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180426095749.GA29207@udknight>
 <20180427224854.2g7ximim7nwkgdpd@ast-mbp>
 <c62438dd-2e2e-8c70-aa19-37d5173d76d1@iogearbox.net>
 <20180428052917.GA1579@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428052917.GA1579@udknight>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 01:29:17PM +0800, Wang YanQing wrote:
> On Sat, Apr 28, 2018 at 01:33:15AM +0200, Daniel Borkmann wrote:
> > On 04/28/2018 12:48 AM, Alexei Starovoitov wrote:
> > > On Thu, Apr 26, 2018 at 05:57:49PM +0800, Wang YanQing wrote:
> > >> All the testcases for BPF_PROG_TYPE_PERF_EVENT program type in
> > >> test_verifier(kselftest) report below errors on x86_32:
> > >> "
> > >> 172/p unpriv: spill/fill of different pointers ldx FAIL
> > >> Unexpected error message!
> > >> 0: (bf) r6 = r10
> > >> 1: (07) r6 += -8
> > >> 2: (15) if r1 == 0x0 goto pc+3
> > >> R1=ctx(id=0,off=0,imm=0) R6=fp-8,call_-1 R10=fp0,call_-1
> > >> 3: (bf) r2 = r10
> > >> 4: (07) r2 += -76
> > >> 5: (7b) *(u64 *)(r6 +0) = r2
> > >> 6: (55) if r1 != 0x0 goto pc+1
> > >> R1=ctx(id=0,off=0,imm=0) R2=fp-76,call_-1 R6=fp-8,call_-1 R10=fp0,call_-1 fp-8=fp
> > >> 7: (7b) *(u64 *)(r6 +0) = r1
> > >> 8: (79) r1 = *(u64 *)(r6 +0)
> > >> 9: (79) r1 = *(u64 *)(r1 +68)
> > >> invalid bpf_context access off=68 size=8
> > >>
> > >> 378/p check bpf_perf_event_data->sample_period byte load permitted FAIL
> > >> Failed to load prog 'Permission denied'!
> > >> 0: (b7) r0 = 0
> > >> 1: (71) r0 = *(u8 *)(r1 +68)
> > >> invalid bpf_context access off=68 size=1
> > >>
> > >> 379/p check bpf_perf_event_data->sample_period half load permitted FAIL
> > >> Failed to load prog 'Permission denied'!
> > >> 0: (b7) r0 = 0
> > >> 1: (69) r0 = *(u16 *)(r1 +68)
> > >> invalid bpf_context access off=68 size=2
> > >>
> > >> 380/p check bpf_perf_event_data->sample_period word load permitted FAIL
> > >> Failed to load prog 'Permission denied'!
> > >> 0: (b7) r0 = 0
> > >> 1: (61) r0 = *(u32 *)(r1 +68)
> > >> invalid bpf_context access off=68 size=4
> > >>
> > >> 381/p check bpf_perf_event_data->sample_period dword load permitted FAIL
> > >> Failed to load prog 'Permission denied'!
> > >> 0: (b7) r0 = 0
> > >> 1: (79) r0 = *(u64 *)(r1 +68)
> > >> invalid bpf_context access off=68 size=8
> > >> "
> > >>
> > >> This patch fix it, the fix isn't only necessary for x86_32, it will fix the
> > >> same problem for other platforms too, if their size of bpf_user_pt_regs_t
> > >> can't divide exactly into 8.
> > >>
> > >> Signed-off-by: Wang YanQing <udknight@gmail.com>
> > >> ---
> > >>  Hi all!
> > >>  After mainline accept this patch, then we need to submit a sync patch
> > >>  to update the tools/include/uapi/linux/bpf_perf_event.h.
> > >>
> > >>  Thanks.
> > >>
> > >>  include/uapi/linux/bpf_perf_event.h | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
> > >> index eb1b9d2..ff4c092 100644
> > >> --- a/include/uapi/linux/bpf_perf_event.h
> > >> +++ b/include/uapi/linux/bpf_perf_event.h
> > >> @@ -12,7 +12,7 @@
> > >>  
> > >>  struct bpf_perf_event_data {
> > >>  	bpf_user_pt_regs_t regs;
> > >> -	__u64 sample_period;
> > >> +	__u64 sample_period __attribute__((aligned(8)));
> > > 
> > > I don't think this necessary.
> > > imo it's a bug in pe_prog_is_valid_access
> > > that should have allowed 8-byte access to 4-byte aligned sample_period.
> > > The access rewritten by pe_prog_convert_ctx_access anyway,
> > > no alignment issues as far as I can see.
> > 
> > Right, good point. Wang, could you give the below a test run:
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 56ba0f2..95b9142 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -833,8 +833,14 @@ static bool pe_prog_is_valid_access(int off, int size, enum bpf_access_type type
> >  		return false;
> >  	if (type != BPF_READ)
> >  		return false;
> > -	if (off % size != 0)
> > -		return false;
> > +	if (off % size != 0) {
> > +		if (sizeof(long) != 4)
> > +			return false;
> > +		if (size != 8)
> > +			return false;
> > +		if (off % size != 4)
> > +			return false;
> > +	}
> > 
> >  	switch (off) {
> >  	case bpf_ctx_range(struct bpf_perf_event_data, sample_period):
> Hi all!
> 
> I have tested this patch, but test_verifier reports the same errors
> for the five testcases.
> 
> The reason is they all failed to pass the test of bpf_ctx_narrow_access_ok.
> 
> Thanks.
Hi! Daniel Borkmann.

Do you have any plan to fix bpf_ctx_narrow_access_ok for these problems?

Thanks.
