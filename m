Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeCOBuI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:50:08 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39264 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCOBuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:50:06 -0400
X-Google-Smtp-Source: AG47ELtgqkUwrGfReEZsIxX9gTjYzxiajE7vU4NGDWAUiUmPRn5xhmLedUF6oJGBILVGtT6ve9nF2sJAIdG9PYgbZqo=
MIME-Version: 1.0
In-Reply-To: <1520997629-17361-5-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org> <1520997629-17361-5-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 18:50:05 -0700
Message-ID: <CAKgT0UfE0vvpOLaA0at=YPQDLpqC0yvKUdFb2hKi7P8fr0ZOcw@mail.gmail.com>
Subject: Re: [PATCH 5/7] igb: eliminate duplicate barriers on weakly-ordered archs
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
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b88fae7..ba8ccb5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8072,7 +8072,7 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
>                  * such as IA-64).
>                  */
>                 wmb();
> -               writel(i, rx_ring->tail);
> +               writel_relaxed(i, rx_ring->tail);
>         }
>  }
>

This one missed the writel at the end of igb_tx_map().
