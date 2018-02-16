Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeBPWoc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:44:32 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46544 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeBPWoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:44:30 -0500
X-Google-Smtp-Source: AH8x227PcnIER/DZMsZUXy/3UOoLSWz+1xKGQIRiKV/ykEItNGu+HLDt8n0Aqkes21+bJ6IkGT7ZWFcD1dQHaa9meaA=
MIME-Version: 1.0
In-Reply-To: <1518819115-13507-1-git-send-email-khoroshilov@ispras.ru>
References: <1518819115-13507-1-git-send-email-khoroshilov@ispras.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2018 14:44:27 -0800
Message-ID: <CANn89iLqG7+i5fPb+E8BXMth0dK8HeKXRp6Uh6gThCY8DWN=6g@mail.gmail.com>
Subject: Re: [PATCH] tun: fix mismatch in mutex lock-unlock in tun_get_user()
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
        Jason Wang <jasowang@redhat.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 2:11 PM, Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> There is a single error path where tfile->napi_mutex is left unlocked.
> It can lead to a deadlock.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/net/tun.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 81e6cc951e7f..0072a9832532 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1879,6 +1879,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                         default:
>                                 this_cpu_inc(tun->pcpu_stats->rx_dropped);
>                                 kfree_skb(skb);
> +                               if (frags) {
> +                                       tfile->napi.skb = NULL;
> +                                       mutex_unlock(&tfile->napi_mutex);
> +                               }
>                                 return -EINVAL;


I do not believe this can happen for IFF_TUN

IFF_NAPI_FRAGS can only be set for IFF_TAP
