Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDJBFP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:05:15 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:52135 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeDJBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:05:13 -0400
X-Google-Smtp-Source: AIpwx4/SP8dWAliai6sAESbnWA5xhIXvZWpQGWRjs9PFosM6GnSGSsTWKVFngsG+XM+gP5SMvjeWalmozPP2G0Kqug8=
MIME-Version: 1.0
In-Reply-To: <20180409174731-mutt-send-email-mst@kernel.org>
References: <20180409131021.5132-1-stefanha@redhat.com> <20180409174731-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 10 Apr 2018 09:05:11 +0800
Message-ID: <CAJSP0QXn2jfScW0TYU89792x7jjaPBQjTgQXeGO0nVmKVG1z1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND net] vhost: fix vhost_vq_access_ok() log check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 3:40 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log
> when IOTLB is enabled") introduced a regression.  The logic was
> originally:
>
>   if (vq->iotlb)
>       return 1;
>   return A && B;
>
> After the patch the short-circuit logic for A was inverted:
>
>   if (A || vq->iotlb)
>       return A;
>   return B;
>
> The correct logic is:
>
>   if (!A || vq->iotlb)
>       return A;
>   return B;
>
> Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NACK

I will send a v2 with cleaner logic as suggested by Linus.

Stefan
