Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeDYJMn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:12:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:34254 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeDYJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:12:26 -0400
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_jit_enable = 2 with
 BPF_JIT_ALWAYS_ON config
To: Leo Yan <leo.yan@linaro.org>, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a90e398e-c012-2630-6909-6d413e03cc96@iogearbox.net>
Date: Wed, 25 Apr 2018 11:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 10:18 AM, Leo Yan wrote:
> After enabled BPF_JIT_ALWAYS_ON config, bpf_jit_enable always equals to
> 1; it is impossible to set 'bpf_jit_enable = 2' and the kernel has no
> chance to call bpf_jit_dump().
> 
> This patch relaxes bpf_jit_enable range to [1..2] when kernel config
> BPF_JIT_ALWAYS_ON is enabled so can invoke jit dump.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Is there a specific reason why you need this here instead of retrieving the
dump from the newer interface available from bpftool (tools/bpf/bpftool/)?
The bpf_jit_enable = 2 is not recommended these days since it dumps into the
kernel log which is often readable from unpriv as well. bpftool makes use
of the BPF_OBJ_GET_INFO_BY_FD interface via bpf syscall to get the JIT dump
instead when bpf_jit_enable is set.

> ---
>  net/core/sysctl_net_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index b1a2c5e..6a39b22 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -371,7 +371,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
>  		.proc_handler	= proc_dointvec_minmax_bpf_enable,
>  # ifdef CONFIG_BPF_JIT_ALWAYS_ON
>  		.extra1		= &one,
> -		.extra2		= &one,
> +		.extra2		= &two,
>  # else
>  		.extra1		= &zero,
>  		.extra2		= &two,
> 
