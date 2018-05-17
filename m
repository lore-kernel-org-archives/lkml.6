Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEQX07 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:26:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38015 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeEQX05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:26:57 -0400
X-Google-Smtp-Source: AB8JxZqyCA6pHn5UQC0nCy9Jaq5Jx273wz1h6dkDqIWySupo/NhqHm+q4pzkXgpa/AScbAeRiVYPfMn7QLFXzHWLG20=
MIME-Version: 1.0
References: <20180517231512.13085-1-niklas.cassel@linaro.org>
In-Reply-To: <20180517231512.13085-1-niklas.cassel@linaro.org>
From: Adrian Chadd <adrian.chadd@gmail.com>
Date: Thu, 17 May 2018 15:26:25 -0700
Message-ID: <CAJ-Vmon1ybhWs_8Nv=w62pmhSizDdDeYCgK8_HTTwPZ=EEC46g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: transmit queued frames after waking queues
To: niklas.cassel@linaro.org
Cc: Kalle Valo <kvalo@qca.qualcomm.com>,
        David Miller <davem@davemloft.net>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 at 16:16, Niklas Cassel <niklas.cassel@linaro.org>
wrote:

> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c
b/drivers/net/wireless/ath/ath10k/txrx.c
> index cda164f6e9f6..1d3b2d2c3fee 100644
> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> @@ -95,6 +95,9 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>                  wake_up(&htt->empty_tx_wq);
>          spin_unlock_bh(&htt->tx_lock);

> +       if (htt->num_pending_tx <= 3 && !list_empty(&ar->txqs))
> +               ath10k_mac_tx_push_pending(ar);
> +

Just sanity checking - what's protecting htt->num_pending_tx? or is it
serialised some other way?

>          dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);

>          ath10k_report_offchan_tx(htt->ar, msdu);
> --
> 2.17.0
