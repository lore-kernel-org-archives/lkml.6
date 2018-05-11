Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEKRjy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:39:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34477 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEKRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:39:50 -0400
X-Google-Smtp-Source: AB8JxZqXZZ8qYGGlduMvMZ24P70SiD1AUGOZC9nmhp/wIKoEY6ZY+uMGpF6S38/MWORL5QgYf7Lny2TiOWGHYic13ZA=
MIME-Version: 1.0
In-Reply-To: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
References: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 11 May 2018 10:39:28 -0700
Message-ID: <CAM_iQpU4YCrcp2XfAyFaUNtjLUi7SyoQ8exzMV7XnoW-=LV3sg@mail.gmail.com>
Subject: Re: [PATCH net V2] tun: fix use after free for ptr_ring
To: Jason Wang <jasowang@redhat.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 7:49 PM, Jason Wang <jasowang@redhat.com> wrote:
>  static void __tun_detach(struct tun_file *tfile, bool clean)
>  {
>         struct tun_file *ntfile;
> @@ -736,7 +727,8 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>                             tun->dev->reg_state == NETREG_REGISTERED)
>                                 unregister_netdevice(tun->dev);
>                 }
> -               tun_cleanup_tx_ring(tfile);
> +               if (tun)
> +                       xdp_rxq_info_unreg(&tfile->xdp_rxq);
>                 sock_put(&tfile->sk);
>         }
>  }
> @@ -783,14 +775,14 @@ static void tun_detach_all(struct net_device *dev)
>                 tun_napi_del(tun, tfile);
>                 /* Drop read queue */
>                 tun_queue_purge(tfile);
> +               xdp_rxq_info_unreg(&tfile->xdp_rxq);
>                 sock_put(&tfile->sk);
> -               tun_cleanup_tx_ring(tfile);
>         }
>         list_for_each_entry_safe(tfile, tmp, &tun->disabled, next) {
>                 tun_enable_queue(tfile);
>                 tun_queue_purge(tfile);
> +               xdp_rxq_info_unreg(&tfile->xdp_rxq);
>                 sock_put(&tfile->sk);
> -               tun_cleanup_tx_ring(tfile);

Are you sure this is safe?

xdp_rxq_info_unreg() can't be called more than once either,
please make sure the warning that commit c13da21cdb80
("tun: avoid calling xdp_rxq_info_unreg() twice") fixed will not
show up again.
