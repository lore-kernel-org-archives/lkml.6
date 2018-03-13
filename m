Return-Path: <eric.dumazet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520920257; cv=none;
        d=google.com; s=arc-20160816;
        b=rT6FC7GEVxSPJsdh5Ws8Y8uVpxSaV/l8SbFujh+yw0ttJYNOC//eVZOMnxuYWNy5lF
         QWmED52Zc2toR0Cxu0S3kBaNHgXsCpdO2UKs09mYh+HlNSy+gVAXQZcnPvXWyx3Cm8T+
         fMVbD0TspplBV2y/hx21O1sC1fKzfW6fgVRNhmqMzfsk/Lg2VWf1v32GJCfQQPyqHjvS
         RkVPUYP6WCgOLYEB9jcpedOKg8/ow0AYaeF1wQs1WB+4DZffBMviPP/k2y6AQeoxyH9M
         +QUVolpE82zDVq+Ac3iVrc3t8TfwDJPmkSnyfsSp4iKp2+FIB3aGcaW57Vn1wZSjQ+JX
         zVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=h3EyMINLDgIJ30qXzp+oT0WYRB4m/ie9bY8DM6YA7jE=;
        b=FNCWppmnhV3nNa3pcDbKs2ws5DrLmKPfhOMR35FUfrlrVFUgMMdfil2VEYbZ04xg7k
         bIkXuDsPVXTdli2URmSd0IFQSCGLrBG9Z/PzOYX8XBO8lFwv5nvYNrmo1vliuhcS9S4q
         IVUePtEKsGxCkUQW3jjofbfsuctRXj7FHz5LYOrRwPSSY6/9DwmLIlXI+nyZQNI5hqTi
         mZB0m2VeO3rewCGYIWeNGbP0cV4HGo/cjEaaTAUyJt3l0C4bmpypIg9ODGsj2aBFlNQ0
         uDbRLAAduQRc+50trHm82R1RsMCjVcE4Lkn4rftkpzPYcu3JKV5bjCVnVwaJAGkf/l5i
         Hc9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QkK+KRoh;
       spf=pass (google.com: domain of eric.dumazet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eric.dumazet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QkK+KRoh;
       spf=pass (google.com: domain of eric.dumazet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eric.dumazet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsVXAXdZ/xW98lztWeP0p152gH06o2HUOevbgJhY/rr7BKaBkfRsp925ofGy3dHws0isuMylw==
Subject: Re: [PATCH v2 1/1] net: check before dereferencing netdev_ops during
 busy poll
To: Josh Elsasser <jelsasser@appneta.com>, davem@davemloft.net
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>,
 Alexander Potapenko <glider@google.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>,
 =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180313053248.13654-1-jelsasser@appneta.com>
 <20180313053248.13654-2-jelsasser@appneta.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1e992840-bf36-aa86-791e-8910a2aab7a5@gmail.com>
Date: Mon, 12 Mar 2018 22:50:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313053248.13654-2-jelsasser@appneta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594799470799291475?=
X-GMAIL-MSGID: =?utf-8?q?1594800479974192040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/12/2018 10:32 PM, Josh Elsasser wrote:
> init_dummy_netdev() leaves its netdev_ops pointer zeroed. This leads
> to a NULL pointer dereference when sk_busy_loop fires against an iwlwifi
> wireless adapter and checks napi->dev->netdev_ops->ndo_busy_poll.
> 
> Avoid this by ensuring napi->dev->netdev_ops is valid before following
> the pointer, avoiding the following panic when busy polling on a dummy
> netdev:
>


> 
> Fixes: 060212928670 ("net: add low latency socket poll")
> Fixes: ce6aea93f751 ("net: network drivers no longer need to implement ndo_busy_poll()") - 4.9.y
> Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
> ---
>   net/core/dev.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8898618bf341..1f50c131ed15 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5042,7 +5042,10 @@ bool sk_busy_loop(struct sock *sk, int nonblock)
>   		goto out;
>   
>   	/* Note: ndo_busy_poll method is optional in linux-4.5 */
> -	busy_poll = napi->dev->netdev_ops->ndo_busy_poll;
> +	if (napi->dev->netdev_ops)
> +		busy_poll = napi->dev->netdev_ops->ndo_busy_poll;
> +	else
> +		busy_poll = NULL;
>   
>   	do {
>   		rc = 0;
> 
We could instead setup a non NULL netdev_ops pointer on these 'dummy' 
devices to not add a check in fast path, but I presume we do
not really care since this fix is for old kernels, and considering how 
long it took to discover this bug.

Reviewed-by: Eric Dumazet <edumazet@google.com>
