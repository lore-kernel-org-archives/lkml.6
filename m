Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDNtz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:49:55 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41114 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDDNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:49:53 -0400
X-Google-Smtp-Source: AIpwx49m4JjRvI2BIPJSKmgtocdjmFYr1JJaBIS6uNs05kUUskDHXcna6zHoDcIYUJgjQSW7qFGXcaE5L0DcXErsvZE=
MIME-Version: 1.0
In-Reply-To: <20180403215526.15934-1-jrosen@cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 4 Apr 2018 15:49:11 +0200
Message-ID: <CAF=yD-L8DaS7LW4SAaTRd2RPxVnfrdiVLCdWJxxaTu3Hn8ORSA@mail.gmail.com>
Subject: Re: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock to
 prevent RX ring overrun
To: Jon Rosen <jrosen@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Maloney <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 11:55 PM, Jon Rosen <jrosen@cisco.com> wrote:
> Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
> casues the ring to get corrupted by allowing multiple kernel threads
> to claim ownership of the same ring entry, Mark the ring entry as
> already being used within the spin_lock to prevent other kernel
> threads from reusing the same entry before it's fully filled in,
> passed to user space, and then eventually passed back to the kernel
> for use with a new packet.
>
> Note that the proposed change may modify the semantics of the
> interface between kernel space and user space in a way which may cause
> some applications to no longer work properly.

As long as TP_STATUS_USER (1) is not set, userspace should ignore
the slot..

>    One issue with the above proposed change to use TP_STATUS_IN_PROGRESS
>    is that the documentation of the tp_status field is somewhat
>    inconsistent.  In some places it's described as TP_STATUS_KERNEL(0)
>    meaning the entry is owned by the kernel and !TP_STATUS_KERNEL(0)
>    meaning the entry is owned by user space.  In other places ownership
>    by user space is defined by the TP_STATUS_USER(1) bit being set.

But indeed this example in packet_mmap.txt is problematic

    if (status == TP_STATUS_KERNEL)
        retval = poll(&pfd, 1, timeout);

It does not really matter whether the docs are possibly inconsistent and
which one is authoritative. Examples like the above make it likely that
some user code expects such code to work.

> +++ b/net/packet/af_packet.c
> @@ -2287,6 +2287,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>                 if (po->stats.stats1.tp_drops)
>                         status |= TP_STATUS_LOSING;
>         }
> +
> +        /*
> +         * Mark this entry as TP_STATUS_IN_PROGRESS to prevent other
> +         * kernel threads from re-using this same entry.
> +         */
> +#define TP_STATUS_IN_PROGRESS TP_STATUS_LOSING

No need to reinterpret existing flags. tp_status is a u32 with
sufficient undefined bits.

> +       if (po->tp_version <= TPACKET_V2)
> +            __packet_set_status(po, h.raw, TP_STATUS_IN_PROGRESS);
> +
>         po->stats.stats1.tp_packets++;
>         if (copy_skb) {
>                 status |= TP_STATUS_COPY;
> --
> 2.10.3.dirty
>
