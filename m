Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966833AbeEJSIb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:08:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41369 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966673AbeEJSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:08:29 -0400
X-Google-Smtp-Source: AB8JxZqG8WuOVpUhIoG5zHK5wZv/RakJj7UZxVLGhLarRBLfxF5H+nijElPibOye2Ky1hwNbvv2ihxJ3EqM4AxYOlTI=
MIME-Version: 1.0
In-Reply-To: <1525849198-9786-1-git-send-email-jasowang@redhat.com>
References: <1525849198-9786-1-git-send-email-jasowang@redhat.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 10 May 2018 11:08:08 -0700
Message-ID: <CAM_iQpUVFZ-4EFeGM6eKyOrJzc2=5uu7b81d3Rf5Pf7TgZw38Q@mail.gmail.com>
Subject: Re: [PATCH net] tun: fix use after free for ptr_ring
To: Jason Wang <jasowang@redhat.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 11:59 PM, Jason Wang <jasowang@redhat.com> wrote:
> We used to initialize ptr_ring during TUNSETIFF, this is because its
> size depends on the tx_queue_len of netdevice. And we try to clean it
> up when socket were detached from netdevice. A race were spotted when
> trying to do uninit during a read which will lead a use after free for
> pointer ring. Solving this by always initialize a zero size ptr_ring
> in open() and do resizing during TUNSETIFF, and then we can safely do
> cleanup during close(). With this, there's no need for the workaround
> that was introduced by commit 4df0bfc79904 ("tun: fix a memory leak
> for tfile->tx_array").
>

Ah, I didn't know ptr_ring_init(0) could work... Nice patch!
Except one thing below.


> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ef33950..298cb96 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -681,15 +681,6 @@ static void tun_queue_purge(struct tun_file *tfile)
>         skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
>
> -static void tun_cleanup_tx_ring(struct tun_file *tfile)
> -{
> -       if (tfile->tx_ring.queue) {
> -               ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
> -               xdp_rxq_info_unreg(&tfile->xdp_rxq);
> -               memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
> -       }
> -}


I don't think you can totally remove ptr_ring_cleanup(), it should be
called unconditionally with your ptr_ring_init(0) trick, right?
