Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeEGSZj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:25:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeEGSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:25:36 -0400
Subject: Re: [PATCH bpf-next] xsk: fix 64-bit division
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>, ast@fb.com,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, magnus.karlsson@intel.com,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e9890e95-16b4-4540-301b-43f17a824808@infradead.org>
 <20180507174350.3534-1-bjorn.topel@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <baf737cf-a0c4-b542-8d37-fd9cdfe7101d@infradead.org>
Date: Mon, 7 May 2018 11:25:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507174350.3534-1-bjorn.topel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 10:43 AM, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> i386 builds report:
>   net/xdp/xdp_umem.o: In function `xdp_umem_reg':
>   xdp_umem.c:(.text+0x47e): undefined reference to `__udivdi3'
> 
> This fix uses div_u64 instead of the GCC built-in.
> 
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

I don't know why the subject says xsk (instead of xdp), but anyway:

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  net/xdp/xdp_umem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 881dfdefe235..2b47a1dd7c6c 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -209,7 +209,7 @@ int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
>  	if ((addr + size) < addr)
>  		return -EINVAL;
>  
> -	nframes = size / frame_size;
> +	nframes = (unsigned int)div_u64(size, frame_size);
>  	if (nframes == 0 || nframes > UINT_MAX)
>  		return -EINVAL;
>  
> 


-- 
~Randy
