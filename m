Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B18C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E662064D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsFG8G5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E662064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIHW3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 18:29:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40410 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeIHW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 18:29:54 -0400
Received: by mail-io1-f67.google.com with SMTP id l14-v6so3914068iob.7;
        Sat, 08 Sep 2018 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A+2gXfU2scg1uYgLrqDaR72TXvKgyRgebXD7Vt0DpEo=;
        b=JsFG8G5R39C8jBRmiO8lOWDBYdFtwunjDHtRB032HTSAu1XLuMnEBK4MNJWHbnKZNu
         28r89FeNdulLnrTRngZjhA5p2zlI8282p7BxWcFOqBpsBYoKSnLFt9QgHOLeX4DE5HAh
         8uRbilWVvrCxcubS4NOnSpm/K6WJugyATpPULV9wAuGd9kxs/Go4ryzBVLjXFk3mL2gP
         HylpUanychOzYeLPewSYDT+asxtHi775N2KSP2YGPjbOYOY0F1qBqDJVdSngozqXR5cd
         E7JkCe1BviTyloGLl+1mAcBunz1N/ckkM64AF5eaUIqN4WDIXtKkDNHXf+c8RvzgGWGb
         FGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A+2gXfU2scg1uYgLrqDaR72TXvKgyRgebXD7Vt0DpEo=;
        b=f/q9rPQq9DitYeiIyh1ovOBSZBGgnx29foCB9lomWuffLcUaguiKazH36j8CMOWhIN
         6Uf1LvBksOOe4VykjSbBlS3rUCnE2315ap4jmJxQwJmatvJTVv1tgO8a3o7uD6jsWol2
         CqUDoMBZG9ErT7CSWcv14bmXbgt2J53FSiKxgA7PDWKbcpWo/25hj88TVqs1n6GUvTSA
         DYJTzE68u72J/TLoDnchIQ7+jTch+ztM1R/EsBbb08KsBPFKKsUXv+cSNZI7gv66s7xx
         wa/lPe2FaTpFL6g/m7Lx7LJvIufPwdnfhwBMpDhA6qjRdWPT6j+PrSU2WZ2qYvLDoyNB
         g1gg==
X-Gm-Message-State: APzg51AoIn0XhzTB9q7Uw651KzZZc22Wg9Wm7Tbk6NSZhTrvgC2y4pQu
        HEnaiQdxexWQ6eti/t8YbQWjxCy+WvFt9wwfBms=
X-Google-Smtp-Source: ANB0VdZ8kAPGc5NyW6QQLlXirGJJJhpLMrAQkbqBw7gF1EZRtfxIRLEEOy37Unrip/AbdRoc4Clre2h+/Ha4yAF5j4w=
X-Received: by 2002:a6b:c694:: with SMTP id w142-v6mr10150895iof.142.1536428600818;
 Sat, 08 Sep 2018 10:43:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7315:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 10:42:40 -0700 (PDT)
In-Reply-To: <1536425898-12059-1-git-send-email-laoar.shao@gmail.com>
References: <1536425898-12059-1-git-send-email-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 9 Sep 2018 01:42:40 +0800
Message-ID: <CALOAHbC4vZvpoGaNfOsox5L72QTz0OiaXerH6UVBnNNHjWONbQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: show number of network segments in some
 SNMP counters
To:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 12:58 AM, Yafang Shao <laoar.shao@gmail.com> wrote:
> It is better to show the number of network segments in bellow SNMP
> counters, because that could be more useful for the user.
> For example, the user could easily figure out how mant packets are
> dropped and how many packets are queued in the out-of-oder queue.
>
> - LINUX_MIB_TCPRCVQDROP
> - LINUX_MIB_TCPZEROWINDOWDROP
> - LINUX_MIB_TCPBACKLOGDROP
> - LINUX_MIB_TCPMINTTLDROP
> - LINUX_MIB_TCPOFODROP
> - LINUX_MIB_TCPOFOQUEUE
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 18 ++++++++++++------
>  net/ipv4/tcp_ipv4.c  |  9 ++++++---
>  net/ipv6/tcp_ipv6.c  |  6 ++++--
>  3 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 62508a2..90f449b 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4496,7 +4496,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
>         tcp_ecn_check_ce(sk, skb);
>
>         if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
> -               NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
> +               NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP,
> +                             tcp_skb_pcount(skb));
>                 tcp_drop(sk, skb);
>                 return;
>         }
> @@ -4505,7 +4506,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
>         tp->pred_flags = 0;
>         inet_csk_schedule_ack(sk);
>
> -       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE);
> +       NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE,
> +                     tcp_skb_pcount(skb));
>         seq = TCP_SKB_CB(skb)->seq;
>         end_seq = TCP_SKB_CB(skb)->end_seq;
>         SOCK_DEBUG(sk, "out of order segment: rcv_next %X seq %X - %X\n",
> @@ -4666,7 +4668,8 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
>         skb->len = size;
>
>         if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
> -               NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
> +               NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP,
> +                             tcp_skb_pcount(skb));
>                 goto err_free;
>         }
>
> @@ -4725,7 +4728,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>          */
>         if (TCP_SKB_CB(skb)->seq == tp->rcv_nxt) {
>                 if (tcp_receive_window(tp) == 0) {
> -                       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
> +                       NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP,
> +                                     tcp_skb_pcount(skb));
>                         goto out_of_window;
>                 }
>
> @@ -4734,7 +4738,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>                 if (skb_queue_len(&sk->sk_receive_queue) == 0)
>                         sk_forced_mem_schedule(sk, skb->truesize);
>                 else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
> -                       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
> +                       NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP,
> +                                     tcp_skb_pcount(skb));
>                         goto drop;
>                 }
>
> @@ -4796,7 +4801,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>                  * remembering D-SACK for its head made in previous line.
>                  */
>                 if (!tcp_receive_window(tp)) {
> -                       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
> +                       NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP,
> +                                     tcp_skb_pcount(skb));
>                         goto out_of_window;
>                 }
>                 goto queue_and_out;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 09547ef..f2fe14b 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -475,7 +475,8 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 info)
>                 goto out;
>
>         if (unlikely(iph->ttl < inet_sk(sk)->min_ttl)) {
> -               __NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
> +               __NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
> +                               tcp_skb_pcount(skb));
>                 goto out;
>         }
>
> @@ -1633,7 +1634,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
>
>         if (unlikely(sk_add_backlog(sk, skb, limit))) {
>                 bh_unlock_sock(sk);
> -               __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
> +               __NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP,
> +                               tcp_skb_pcount(skb));
>                 return true;
>         }
>         return false;
> @@ -1790,7 +1792,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
>                 }
>         }
>         if (unlikely(iph->ttl < inet_sk(sk)->min_ttl)) {
> -               __NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
> +               __NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
> +                               tcp_skb_pcount(skb));
>                 goto discard_and_relse;
>         }
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 03e6b7a..97dfc16 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -391,7 +391,8 @@ static void tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
>                 goto out;
>
>         if (ipv6_hdr(skb)->hop_limit < inet6_sk(sk)->min_hopcount) {
> -               __NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
> +               __NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
> +                               tcp_skb_pcount(skb));
>                 goto out;
>         }
>
> @@ -1523,7 +1524,8 @@ static int tcp_v6_rcv(struct sk_buff *skb)
>                 }
>         }
>         if (hdr->hop_limit < inet6_sk(sk)->min_hopcount) {
> -               __NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
> +               __NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
> +                               tcp_skb_pcount(skb));
>                 goto discard_and_relse;
>         }
>
> --
> 1.8.3.1
>

Seems it is not proper to use tcp_skb_pcount(skb). Will send V2.
Sorry about the noise.


Thanks
Yafang
