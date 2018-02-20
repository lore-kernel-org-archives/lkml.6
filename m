Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeBTVon (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:44:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:40702 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBTVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:38 -0500
Subject: Re: [PATCH] bpf: hide a possibly unused variable
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180220211658.2653840-1-arnd@arndb.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <824bfc29-d6e8-9d7d-9307-79bf0097ce8e@iogearbox.net>
Date: Tue, 20 Feb 2018 22:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180220211658.2653840-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 02/20/2018 10:16 PM, Arnd Bergmann wrote:
> The only user of this variable is inside of an #ifdef, causing
> a warning without CONFIG_INET:
> 
> net/core/filter.c: In function '____bpf_sock_ops_cb_flags_set':
> net/core/filter.c:3382:6: error: unused variable 'val' [-Werror=unused-variable]
>   int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> 
> This adds the same #ifdef around the declaration.
> 
> Fixes: b13d88072172 ("bpf: Adds field bpf_sock_ops_cb_flags to tcp_sock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 08ab4c65a998..c3dc6d60b4bb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3379,7 +3379,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
>  	   int, argval)
>  {
>  	struct sock *sk = bpf_sock->sk;
> +#ifdef CONFIG_INET
>  	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +#endif

Looks good, thanks for the fix!

Could you move the existing '#ifdef CONFIG_INET' to the beginning of
the function given the only error in case of !CONFIG_INET is -EINVAL
anyway? That would at least not increase the ifdef ugliness further.

Thanks a lot,
Daniel

>  	if (!sk_fullsock(sk))
>  		return -EINVAL;
> 
