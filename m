Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933144AbeCBUzM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:55:12 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39477 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932896AbeCBUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:55:10 -0500
X-Google-Smtp-Source: AG47ELv+MqTOjbc64mFG8JmZ4Mej4kZexmUtGhsJmfRx695wxEkYb8WxFpcB5A9/JSYzpiLE9O8m+qogcLr6dKU+Ot4=
MIME-Version: 1.0
In-Reply-To: <20180228231745.366681-1-arnd@arndb.de>
References: <20180228231745.366681-1-arnd@arndb.de>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Mar 2018 12:55:09 -0800
Message-ID: <CAKgT0UcgjKeFoy0nm70CP+EshSccGgAqsq6gtwsMqdvqM6CSWg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [net-next PATCH] ixgbevf: fix unused variable warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 3:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The new ixgbevf_set_rx_buffer_len() function causes a harmless warnings
> in configurations with large page size:
>
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_set_rx_buffer_len':
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1758:15: error: unused variable 'max_frame' [-Werror=unused-variable]
>
> This rephrases the code so that the compiler can see the use of that
> variable, making it slightly easier to read in the process.
>
> Fixes: f15c5ba5b6cd ("ixgbevf: add support for using order 1 pages to receive large frames")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index f37307131eb6..4da449e0a4ba 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -1766,12 +1766,12 @@ static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
>
>         set_ring_build_skb_enabled(rx_ring);
>
> -#if (PAGE_SIZE < 8192)
> -       if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
> -               return;
> +       if (PAGE_SIZE < 8192) {
> +               if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
> +                       return;
>
> -       set_ring_uses_large_buffer(rx_ring);
> -#endif
> +               set_ring_uses_large_buffer(rx_ring);
> +       }
>  }
>
>  /**

The fix looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
