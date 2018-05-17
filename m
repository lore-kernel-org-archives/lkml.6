Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeEQR1q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:27:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35008 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:27:45 -0400
X-Google-Smtp-Source: AB8JxZrDEUq/d2Iasxs4p00O5evl2SM0EbYa7xV7XfSJXHFNXQZy8DWljlycsGU7ZTerM+ro9N+APQ==
Subject: Re: [PATCH 1/2] bpf: sockmap, fix uninitialized variable
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1526565461.git.gustavo@embeddedor.com>
 <11073635016901e9e84c2f34f20d412073b26297.1526565461.git.gustavo@embeddedor.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <dd511eb3-abbf-1822-8bcc-7bcc6ca68b6c@gmail.com>
Date: Thu, 17 May 2018 10:27:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <11073635016901e9e84c2f34f20d412073b26297.1526565461.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 07:08 AM, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable err is
> returned without being properly initialized previously.
> 
> Fix this by initializing variable err to 0.
> 
> Addresses-Coverity-ID: 1468964 ("Uninitialized scalar variable")
> Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work
> with hashmap")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/bpf/sockmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
> index c6de139..41b41fc 100644
> --- a/kernel/bpf/sockmap.c
> +++ b/kernel/bpf/sockmap.c
> @@ -1713,7 +1713,7 @@ static int __sock_map_ctx_update_elem(struct bpf_map *map,
>  	struct smap_psock_map_entry *e = NULL;
>  	struct smap_psock *psock;
>  	bool new = false;
> -	int err;
> +	int err = 0;
>  
>  	/* 1. If sock map has BPF programs those will be inherited by the
>  	 * sock being added. If the sock is already attached to BPF programs
> 

Thanks for catching this and the quick fix. The path to hit this case
is to add a sock to a map (without a BPF program) where the sock already
has been added to another map. I don't have any tests for the case with
socks in multiple maps so I'll add some to the selftests so I remember
this case.

The alternative fix would be to always 'return 0' at the end of the
function, but I think its probably better to init err here like above.

Acked-by: John Fastabend <john.fastabend@gmail.com>
