Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161106AbeBNRVT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:21:19 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161093AbeBNRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:21:17 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Richard Weinberger <richard@sigma-star.at>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <2050418.Dl5pXkWGsk@blindfold>
 <4f620eb7-c00c-487b-2e06-8cc4c97af38c@metux.net>
 <60748622.exvCVAzLTp@blindfold>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e924b563-44c6-d678-a6cc-1181f4b820d5@metux.net>
Date: Wed, 14 Feb 2018 18:21:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <60748622.exvCVAzLTp@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+Btept7qdhBPCSZwkxTWEtMGu4JndZEprukOQcwS4+K+3jRrkmN
 WIbWdoI/pn1oHYTtry1qEzO8RRwnBMVHWIT5stSEMlDg0GXbpjE7EBE3jpdh2BqCg5IeKSj
 bq+B0yg55tb6mYQ9P9n0UoKNGPHnDarzl+1f+TwBP59IfXnCZJEmuu+6j+KBiXyiHt5X1QB
 Je85C/YcPp37pNP+Q+JhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SxQT+zPhRO0=:X87v9YJLCGXnR6GmxSl+xN
 daDs8L5TwVTEPEIzxxBu8d6pgbAsL2Hps1iDSx61v+m3+D3pE0mrgBGs/GLuJjCwvx3HTY36Y
 xH+QHbLL9aFwXoHYBF5SWFwQMxiPB/Z0Vmw38F0tdcyiRaTKVbPJeRkwfWlxXxqNuyYuGtfac
 QeNLMkLCbRpRU7zEVgqCigIqi2Ju6IjOcCTpcJ/IQKt+hchcj/u7OiXq4IULl4l/mq8gVPm7d
 YOd7SpQf/UavV5wcDjQWqXWbjqXD3/fucXG8LLQr3wMtFJx/muiAac0cjaL5MSd1keFcBNXKe
 dIzXQLiLUObeFL6F1s5+Wn/Ae1Q/aWE8lBC8oaqM/jQb+VUQGVZcsFjljQdF9QiMUNQjEnuip
 84KLoyAxmeKVDiKpwCOeSlYF/KDUWucd5qHWBiUk2Tb7xzpYqkVZfB3aUlF91wzhWLDENxrT0
 ks59h2q+HfgLNAPJZ/hbKOolVTxE/a7Cd/mZTW6CSrL67hBK6sRik9prB5E6Ryvd7h0yFy0vy
 00peXH92OAqbglLk6b8GokebhebwfFn9tTvdEQIws5gzaIEVipzQ/cNOB5EnqMomQuR1T7xOX
 ahSGNpUvloswe3WtWFkGIfLcZlz9ZaA/FmLAfPlGoHoRLriBcUAq0wPwrN0j+1s3aR4BmQH3p
 XTjqUEZ4C32uGf6TGq2nxSq6eeSw9FjBXQwLOTAn3pg4izVpIvXDJ20Pj92SiQe8tzBCT3Idq
 FQhzJMtMW1Edw6HJU9sVeBy34M4IoBn8NRjqEXJ8xe4ldMzyHnN6HkHhAwk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 16:17, Richard Weinberger wrote:

>  From taking a *very* quick look into busybox source, I suspect this should fix
> it:
> 
> diff --git a/util-linux/unshare.c b/util-linux/unshare.c
> index 875e3f86e304..3f59cf4d27c2 100644
> --- a/util-linux/unshare.c
> +++ b/util-linux/unshare.c
> @@ -350,9 +350,9 @@ int unshare_main(int argc UNUSED_PARAM, char **argv)
>   		 * in that user namespace.
>   		 */
>   		xopen_xwrite_close(PATH_PROC_SETGROUPS, "deny");
> -		sprintf(uidmap_buf, "%u 0 1", (unsigned)reuid);
> +		sprintf(uidmap_buf, "0 %u 1", (unsigned)reuid);
>   		xopen_xwrite_close(PATH_PROC_UIDMAP, uidmap_buf);
> -		sprintf(uidmap_buf, "%u 0 1", (unsigned)regid);
> +		sprintf(uidmap_buf, "0 %u 1", (unsigned)regid);
>   		xopen_xwrite_close(PATH_PROC_GIDMAP, uidmap_buf);
>   	} else
>   	if (setgrp_str) {
> 

hmm, now it works, but only when strace'ing it.
that's really strange.

But still I wonder whether user_ns really solves my problem, as I don't
want to create sandboxed users, but only private namespaces just like
on Plan9.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
