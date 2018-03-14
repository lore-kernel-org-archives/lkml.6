Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeCNOLs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:11:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44966 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:11:46 -0400
X-Google-Smtp-Source: AG47ELun70W0lgyi+OJhaKFvi2lx8KB8eoBuE7954+DJhsNuyGA4ZEy0VxRPMISizlXWPPsqTVpP9+5GscZhKR7Hqz4=
MIME-Version: 1.0
In-Reply-To: <20180314140322.233047-1-glider@google.com>
References: <20180314140322.233047-1-glider@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Mar 2018 07:11:43 -0700
Message-ID: <CANn89iL8gWYReSPRfhHdyYT1+TC+GwxTD45SG+zjCMBEYjY3KQ@mail.gmail.com>
Subject: Re: [PATCH] netlink: make sure nladdr has correct size in netlink_connect()
To: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 7:03 AM, Alexander Potapenko <glider@google.com> wrote:
> KMSAN reports use of uninitialized memory in the case when |alen| is
> smaller than sizeof(struct netlink_sock), and therefore |nladdr| isn't
> fully copied from the userspace.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
> ---
>  net/netlink/af_netlink.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 07e8478068f0..5d49b39e81c3 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1085,6 +1085,9 @@ static int netlink_connect(struct socket *sock, struct sockaddr *addr,
>         if (addr->sa_family != AF_NETLINK)
>                 return -EINVAL;
>
> +       if (alen < sizeof(struct netlink_sock))
> +               return -EINVAL;
> +
>

Hmmm. How was this patch tested exactly ?

Thanks.
