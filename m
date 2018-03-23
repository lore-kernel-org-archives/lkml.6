Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeCWSai (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:30:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38774 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCWSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:30:36 -0400
X-Google-Smtp-Source: AG47ELsZ+fmVrUzEiY+lRlLHV0N8Kgvs9ctUObMWEwPTuy7HFe4j3vN0in7IINAVUrd0J3O0TapCNwRqqidOqDRdvfk=
MIME-Version: 1.0
In-Reply-To: <1521829277-9398-2-git-send-email-okaya@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org> <1521829277-9398-2-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 23 Mar 2018 11:30:34 -0700
Message-ID: <CAKgT0Udx=VCjfuWhdcL1Yht1JoPrR3EDt4hacWvkb6zV-nmpfA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v6 1/7] i40e/i40evf: Eliminate duplicate
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
> Code includes wmb() followed by writel(). writel() already has a barrier
> on some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 24 ++++++++++++++++++++----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  9 +++++++--
>  2 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index c6972bd..fc10cc0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -186,7 +186,13 @@ static int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data,
>         /* Mark the data descriptor to be watched */
>         first->next_to_watch = tx_desc;
>
> -       writel(tx_ring->next_to_use, tx_ring->tail);
> +       writel_relaxed(tx_ring->next_to_use, tx_ring->tail);
> +
> +       /* We need this if more than one processor can write to our tail
> +        * at a time, it synchronizes IO on IA64/Altix systems
> +        */
> +       mmiowb();
> +
>         return 0;
>

The addition of mmiowb here is valid. All of the others in this patch
are invalid.

>  dma_fail:
> @@ -1529,7 +1535,12 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>          * such as IA-64).
>          */
>         wmb();
> -       writel(val, rx_ring->tail);
> +       writel_relaxed(val, rx_ring->tail);
> +
> +       /* We need this if more than one processor can write to our tail
> +        * at a time, it synchronizes IO on IA64/Altix systems
> +        */
> +       mmiowb();
>  }
>
>  /**
> @@ -2412,7 +2423,12 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                  */
>                 wmb();
>
> -               writel(xdp_ring->next_to_use, xdp_ring->tail);
> +               writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
> +
> +               /* We need this if more than one processor can write to our tail
> +                * at a time, it synchronizes IO on IA64/Altix systems
> +                */
> +               mmiowb();
>         }
>
>         rx_ring->skb = skb;
> @@ -3437,7 +3453,7 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
>
>         /* notify HW of packet */
>         if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
> -               writel(i, tx_ring->tail);
> +               writel_relaxed(i, tx_ring->tail);
>
>                 /* we need this if more than one processor can write to our tail
>                  * at a time, it synchronizes IO on IA64/Altix systems
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> index 1ae112f..ca02762 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> @@ -810,7 +810,12 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>          * such as IA-64).
>          */
>         wmb();
> -       writel(val, rx_ring->tail);
> +       writel_relaxed(val, rx_ring->tail);
> +
> +       /* We need this if more than one processor can write to our tail
> +        * at a time, it synchronizes IO on IA64/Altix systems
> +        */
> +       mmiowb();
>  }
>
>  /**
> @@ -2379,7 +2384,7 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
>
>         /* notify HW of packet */
>         if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
> -               writel(i, tx_ring->tail);
> +               writel_relaxed(i, tx_ring->tail);
>
>                 /* we need this if more than one processor can write to our tail
>                  * at a time, it synchronizes IO on IA64/Altix systems
> --
> 2.7.4
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
