Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeDPJEU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:04:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:55766 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeDPJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:04:18 -0400
Subject: Re: linux-next: build failure after merge of the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20180416123000.30fd8a04@canb.auug.org.au>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f79728c9-fa0c-ad04-f5cf-578172ec1712@iogearbox.net>
Date: Mon, 16 Apr 2018 11:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180416123000.30fd8a04@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, hi John,

On 04/16/2018 04:30 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> kernel/bpf/core.o: In function `sock_map_release':
> core.c:(.text+0xd04): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> kernel/events/core.o: In function `sock_map_release':
> core.c:(.text+0x85cc): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> block/blk-core.o: In function `sock_map_release':
> blk-core.c:(.text+0x58e8): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> drivers/net/virtio_net.o: In function `sock_map_release':
> virtio_net.c:(.text+0x53ec): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> net/core/dev.o: In function `sock_map_release':
> dev.c:(.text+0x6c68): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> net/core/rtnetlink.o: In function `sock_map_release':
> rtnetlink.c:(.text+0x63e0): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> net/core/filter.o: In function `sock_map_release':
> filter.c:(.text+0x8c8c): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> net/core/sock_reuseport.o: In function `sock_map_release':
> sock_reuseport.c:(.text+0x398): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> net/bpf/test_run.o: In function `sock_map_release':
> test_run.c:(.text+0x3dc): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> net/packet/af_packet.o: In function `sock_map_release':
> af_packet.c:(.text+0x6958): multiple definition of `sock_map_release'
> kernel/sysctl.o:sysctl.c:(.text+0x1a50): first defined here
> 
> Caused by commit
> 
>   9b2e8bbc4e7a ("bpf: sockmap, map_release does not hold refcnt for pinned maps")
> 
> I applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 16 Apr 2018 12:27:24 +1000
> Subject: [PATCH] fix for "bpf: sockmap, map_release does not hold refcnt for
>  pinned maps"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f46561de5154..3b6c2b66f414 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -660,7 +660,7 @@ static inline int sock_map_prog(struct bpf_map *map,
>  	return -EOPNOTSUPP;
>  }
>  
> -void sock_map_release(struct bpf_map *map) {}
> +static inline void sock_map_release(struct bpf_map *map) {}
>  #endif
>  
>  /* verifier prototypes for helper functions called from eBPF programs */

Sigh, yeah, that's buggy. Thanks for catching it!

John, given bpf tree hasn't been pushed out, I'm considering to drop the
series from the bpf tree so we can have a clean respin of it with this fixed
initially and not as follow-up churn.

While you're at it, can you just make this a bpf callback, so we have the
'clear' handlers private in prog array and sockmap respectively? This would
also have avoided the bug in the first place.

Thanks,
Daniel
