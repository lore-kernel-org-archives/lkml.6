Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCOBxj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:53:39 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34498 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCOBxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:53:37 -0400
X-Google-Smtp-Source: AG47ELtpaGjuMlvYh3PG/4awwuVjfJfvQqG/DIxwPj4M0Br+t2n7qlF96H0r4DSPCr72vZnRTyVmZag1GzXImv3U+48=
MIME-Version: 1.0
In-Reply-To: <1520997599-17298-1-git-send-email-okaya@codeaurora.org>
References: <1520997599-17298-1-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 18:53:35 -0700
Message-ID: <CAKgT0Ud8jhDKCggC8hN5xF-twLc7sycNh8R0pcLvayY2-5b+Cg@mail.gmail.com>
Subject: Re: [PATCH 1/7] i40e/i40evf: Eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:19 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
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
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index e554aa6cf..7028516 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1375,7 +1375,7 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>          * such as IA-64).
>          */
>         wmb();
> -       writel(val, rx_ring->tail);
> +       writel_relaxed(val, rx_ring->tail);
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> index 357d605..2d323fc 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> @@ -667,7 +667,7 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>          * such as IA-64).
>          */
>         wmb();
> -       writel(val, rx_ring->tail);
> +       writel_relaxed(val, rx_ring->tail);
>  }
>

So this one missed writel calls in:
i40e:
  i40e_program_fdir_filter
  i40e_clean_rx_irq
  i40e_tx_map
i40evf:
  i40e_clean_rx_irq
  i40e_tx_map
