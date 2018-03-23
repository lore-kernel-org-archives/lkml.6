Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeCWSZ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:25:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44861 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCWSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:25:26 -0400
X-Google-Smtp-Source: AG47ELv6xyY9WCjGDfOvhk+Cf2n64tH1SwWtkVWZT8FcXT8wuiyNCj9lJX767TtRwGZg/eI0e+9WrKns+nGLy8Yef6E=
MIME-Version: 1.0
In-Reply-To: <1521829277-9398-8-git-send-email-okaya@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org> <1521829277-9398-8-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 23 Mar 2018 11:25:24 -0700
Message-ID: <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v6 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, sulrich@codeaurora.org,
        Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 11:21 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 815cb1a..9e684b1 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -725,7 +725,12 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
>                  * such as IA-64).
>                  */
>                 wmb();
> -               writel(i, rx_ring->tail);
> +               writel_relaxed(i, rx_ring->tail);
> +
> +               /* We need this if more than one processor can write to our tail
> +                * at a time, it synchronizes IO on IA64/Altix systems
> +                */
> +               mmiowb();
>         }

The mmiowb shouldn't be needed for Rx. Only one CPU will be running
NAPI for the queue and we will synchronize this with a full writel
anyway when we re-enable the interrupts.

>  }
>
> @@ -1232,7 +1237,12 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>                  * know there are new descriptors to fetch.
>                  */
>                 wmb();
> -               writel(xdp_ring->next_to_use, xdp_ring->tail);
> +               writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
> +
> +               /* We need this if more than one processor can write to our tail
> +                * at a time, it synchronizes IO on IA64/Altix systems
> +                */
> +               mmiowb();
>         }
>
>         u64_stats_update_begin(&rx_ring->syncp);
> @@ -4004,7 +4014,12 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
>         tx_ring->next_to_use = i;
>
>         /* notify HW of packet */
> -       writel(i, tx_ring->tail);
> +       writel_relaxed(i, tx_ring->tail);
> +
> +       /* We need this if more than one processor can write to our tail
> +        * at a time, it synchronizes IO on IA64/Altix systems
> +        */
> +       mmiowb();
>
>         return;
>  dma_error:
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
