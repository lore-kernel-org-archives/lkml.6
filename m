Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCOBpv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:45:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45063 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeCOBpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:45:49 -0400
X-Google-Smtp-Source: AG47ELu8tk35WpObBxZGLlEsBX5QsNoD/cFDLWk8s3hwoqCFVmzRjF/Opgozu08bFkMstTYH3y1Jj5rxbpg9sqrSxfM=
MIME-Version: 1.0
In-Reply-To: <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org> <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 18:45:47 -0700
Message-ID: <CAKgT0Uf+1U6tBFTFO=c_4AgEDwqkB=hvAFk4b0G+_-mMLtZ5Mg@mail.gmail.com>
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
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

On Tue, Mar 13, 2018 at 8:20 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
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
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 ++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 7 +++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index f695242..64d0e0b 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -244,9 +244,12 @@ static inline u16 ixgbevf_desc_unused(struct ixgbevf_ring *ring)
>         return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
>  }
>
> +/* Assumes caller has executed a write barrier to order memory and device
> + * requests.
> + */
>  static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32 value)
>  {
> -       writel(value, ring->tail);
> +       writel_relaxed(value, ring->tail);
>  }
>
>  #define IXGBEVF_RX_DESC(R, i)  \
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 9b3d43d..0ba7f59 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3643,6 +3643,13 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
>
>         tx_ring->next_to_use = i;
>
> +       /* Force memory writes to complete before letting h/w
> +        * know there are new descriptors to fetch.  (Only
> +        * applicable for weak-ordered memory model archs,
> +        * such as IA-64).
> +        */
> +       wmb();

This memory barrier is redundant. There is a wmb() that is called
about 10 lines before this.

> +
>         /* notify HW of packet */
>         ixgbevf_write_tail(tx_ring, i);
>
> --
> 2.7.4
>
