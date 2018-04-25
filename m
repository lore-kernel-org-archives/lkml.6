Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeDYJ0M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:26:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39176 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeDYJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:26:04 -0400
X-Google-Smtp-Source: AIpwx48XIQC2IlhpK2mbdfNdnWjg99i4KmfMK6OeKUU4nXQrgcGP3+yBhNldKH6DeUBHkW6rvv3Zhg==
Date: Wed, 25 Apr 2018 17:25:47 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_jit_enable = 2 with
 BPF_JIT_ALWAYS_ON config
Message-ID: <20180425092547.GA24401@leoy-ThinkPad-X240s>
References: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
 <a90e398e-c012-2630-6909-6d413e03cc96@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90e398e-c012-2630-6909-6d413e03cc96@iogearbox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 25, 2018 at 11:12:21AM +0200, Daniel Borkmann wrote:
> On 04/25/2018 10:18 AM, Leo Yan wrote:
> > After enabled BPF_JIT_ALWAYS_ON config, bpf_jit_enable always equals to
> > 1; it is impossible to set 'bpf_jit_enable = 2' and the kernel has no
> > chance to call bpf_jit_dump().
> > 
> > This patch relaxes bpf_jit_enable range to [1..2] when kernel config
> > BPF_JIT_ALWAYS_ON is enabled so can invoke jit dump.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Is there a specific reason why you need this here instead of retrieving the
> dump from the newer interface available from bpftool (tools/bpf/bpftool/)?
> The bpf_jit_enable = 2 is not recommended these days since it dumps into the
> kernel log which is often readable from unpriv as well. bpftool makes use
> of the BPF_OBJ_GET_INFO_BY_FD interface via bpf syscall to get the JIT dump
> instead when bpf_jit_enable is set.

Thanks for reviewing.

When I read the doc Documentation/networking/filter.txt and the
section "JIT compiler" it suggests as below.  So I tried to set
'bpf_jit_enable = 2' to dump JIT code, but it failed.

If we have concern for security issue, should we remove support for
'bpf_jit_enable = 2' and modify the doc to reflect this change?

---8<---

For JIT developers, doing audits etc, each compile run can output the generated
opcode image into the kernel log via: 

  echo 2 > /proc/sys/net/core/bpf_jit_enable

Example output from dmesg:

[ 3389.935842] flen=6 proglen=70 pass=3 image=ffffffffa0069c8f
[ 3389.935847] JIT code: 00000000: 55 48 89 e5 48 83 ec 60 48 89 5d f8 44 8b 4f 68
[ 3389.935849] JIT code: 00000010: 44 2b 4f 6c 4c 8b 87 d8 00 00 00 be 0c 00 00 00
[ 3389.935850] JIT code: 00000020: e8 1d 94 ff e0 3d 00 08 00 00 75 16 be 17 00 00
[ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
[ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3

> > ---
> >  net/core/sysctl_net_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index b1a2c5e..6a39b22 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -371,7 +371,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
> >  		.proc_handler	= proc_dointvec_minmax_bpf_enable,
> >  # ifdef CONFIG_BPF_JIT_ALWAYS_ON
> >  		.extra1		= &one,
> > -		.extra2		= &one,
> > +		.extra2		= &two,
> >  # else
> >  		.extra1		= &zero,
> >  		.extra2		= &two,
> > 
> 
