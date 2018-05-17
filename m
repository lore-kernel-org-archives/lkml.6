Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQR0j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:26:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40199 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeEQR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:26:37 -0400
X-Google-Smtp-Source: AB8JxZqqjECIOSF3We96W2mfP4YOWF9kGNRL607sCgSon1vAcjy7o6NKOaW2DQs7FlP4CaYi+JMIqg==
Subject: Re: [PATCH 2/2] bpf: sockmap, fix double-free
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1526565461.git.gustavo@embeddedor.com>
 <96e7f5e59eacddc5e32abb72b7686c3e9163a410.1526565461.git.gustavo@embeddedor.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <0a882ea0-9a08-eb1b-4a01-ff1ed8858243@gmail.com>
Date: Thu, 17 May 2018 10:26:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <96e7f5e59eacddc5e32abb72b7686c3e9163a410.1526565461.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 07:11 AM, Gustavo A. R. Silva wrote:
> `e' is being freed twice.
> 
> Fix this by removing one of the kfree() calls.
> 
> Addresses-Coverity-ID: 1468983 ("Double free")
> Fixes: 81110384441a ("bpf: sockmap, add hash map support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/bpf/sockmap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
> index 41b41fc..c682669 100644
> --- a/kernel/bpf/sockmap.c
> +++ b/kernel/bpf/sockmap.c
> @@ -1823,7 +1823,6 @@ static int __sock_map_ctx_update_elem(struct bpf_map *map,
>  	write_unlock_bh(&sock->sk_callback_lock);
>  	return err;
>  out_free:
> -	kfree(e);
>  	smap_release_sock(psock, sock);
>  out_progs:
>  	if (verdict)
> 

Thanks. This can happen when a user tries to add a kTLS socket to a
sockmap. We need to add some tests for kTLS + sockmap cases.

Acked-by: John Fastabend <john.fastabend@gmail.com>
