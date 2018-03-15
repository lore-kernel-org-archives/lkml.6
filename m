Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeCOBlz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:41:55 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34682 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCOBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:41:53 -0400
X-Google-Smtp-Source: AG47ELv/C4ZKMvL/qAGhth3x+VAWvY/rv3mMG/Mvu7te8iq6KE7vTkq1KYKe6ClU63tuHGH5/S95CvQ9GbVYHFwI5fI=
MIME-Version: 1.0
In-Reply-To: <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org> <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 18:41:51 -0700
Message-ID: <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered archs
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
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 3dd4aeb..e0e583a 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -4573,7 +4573,7 @@ e1000_alloc_jumbo_rx_buffers(struct e1000_adapter *adapter,
>                  * such as IA-64).
>                  */
>                 wmb();
> -               writel(i, adapter->hw.hw_addr + rx_ring->rdt);
> +               writel_relaxed(i, adapter->hw.hw_addr + rx_ring->rdt);
>         }
>  }
>
> @@ -4688,7 +4688,7 @@ static void e1000_alloc_rx_buffers(struct e1000_adapter *adapter,
>                  * such as IA-64).
>                  */
>                 wmb();
> -               writel(i, hw->hw_addr + rx_ring->rdt);
> +               writel_relaxed(i, hw->hw_addr + rx_ring->rdt);
>         }
>  }
>

So you missed the writel in e1000_xmit_frame. You should probably get
that one too while you are doing these updates. The wmb() is in
e1000_tx_queue().
