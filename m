Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeCUVXI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:23:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40910 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:23:04 -0400
X-Google-Smtp-Source: AG47ELvFyeSEGakJ57UXJA66KjL7pugGT+63aUy4V5HiDbi5mxinau/m6FMRMoL7LNkiP1f171MlRim4mEEcBP1C840=
MIME-Version: 1.0
In-Reply-To: <20180321193458.4451-1-colin.king@canonical.com>
References: <20180321193458.4451-1-colin.king@canonical.com>
From: William Tu <u9012063@gmail.com>
Date: Wed, 21 Mar 2018 14:22:23 -0700
Message-ID: <CALDO+SYL=TpwG68cYp2UeopW+P-p5P5H0mXQk9-JySxS47TO4g@mail.gmail.com>
Subject: Re: [PATCH][next] gre: fix TUNNEL_SEQ bit check on sequence numbering
To: Colin King <colin.king@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:34 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The current logic of flags | TUNNEL_SEQ is always non-zero and hence
> sequence numbers are always incremented no matter the setting of the
> TUNNEL_SEQ bit.  Fix this by using & instead of |.
>
> Detected by CoverityScan, CID#1466039 ("Operands don't affect result")
>
> Fixes: 77a5196a804e ("gre: add sequence number for collect md mode.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the fix!
btw, how can I access the CoverityScan result with this CID?

Acked-by: William Tu <u9012063@gmail.com>


> ---
>  net/ipv4/ip_gre.c  | 2 +-
>  net/ipv6/ip6_gre.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 2fa2ef2e2af9..9ab1aa2f7660 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -550,7 +550,7 @@ static void gre_fb_xmit(struct sk_buff *skb, struct net_device *dev,
>                 (TUNNEL_CSUM | TUNNEL_KEY | TUNNEL_SEQ);
>         gre_build_header(skb, tunnel_hlen, flags, proto,
>                          tunnel_id_to_key32(tun_info->key.tun_id),
> -                        (flags | TUNNEL_SEQ) ? htonl(tunnel->o_seqno++) : 0);
> +                        (flags & TUNNEL_SEQ) ? htonl(tunnel->o_seqno++) : 0);
>
>         df = key->tun_flags & TUNNEL_DONT_FRAGMENT ?  htons(IP_DF) : 0;
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 0bcefc480aeb..3a98c694da5f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -725,7 +725,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
>                 gre_build_header(skb, tunnel->tun_hlen,
>                                  flags, protocol,
>                                  tunnel_id_to_key32(tun_info->key.tun_id),
> -                                (flags | TUNNEL_SEQ) ? htonl(tunnel->o_seqno++)
> +                                (flags & TUNNEL_SEQ) ? htonl(tunnel->o_seqno++)
>                                                       : 0);
>
>         } else {
> --
> 2.15.1
>
