Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBHOXF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:23:05 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44492 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:23:02 -0500
X-Google-Smtp-Source: AH8x225HNbkFwR21by5kEOcRhDnOyLziBRnbxaWAlgcV1HGl9hDTKys9qUWDPb8YfLDNppdtPgcZ2efdmYkuX2MB1Fc=
MIME-Version: 1.0
In-Reply-To: <20180208064714.6042-1-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 8 Feb 2018 06:23:00 -0800
Message-ID: <CAKgT0Ufykm7gxLSNmnAixKw4qfhvumoymcY5q=E46bRa9+MYOw@mail.gmail.com>
Subject: Re: [PATCH net-queue 1/3] Partial revert "e1000e: Avoid receiver
 overrun interrupt bursts"
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 10:47 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> This partially reverts commit 4aea7a5c5e940c1723add439f4088844cd26196d.
>
> We keep the fix for the first part of the problem (1) described in the log
> of that commit, that is to read ICR in the other interrupt handler. We
> remove the fix for the second part of the problem (2), Other interrupt
> throttling.
>
> Bursts of "Other" interrupts may once again occur during rxo (receive
> overflow) traffic conditions. This is deemed acceptable in the interest of
> avoiding unforeseen fallout from changes that are not strictly necessary.
> As discussed, the e1000e driver should be in "maintenance mode".
>
> Link: https://www.spinics.net/lists/netdev/msg480675.html
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 153ad406c65e..3b36efa6228d 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1915,21 +1915,10 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>         struct e1000_adapter *adapter = netdev_priv(netdev);
>         struct e1000_hw *hw = &adapter->hw;
>         u32 icr;
> -       bool enable = true;
>
>         icr = er32(ICR);
>         ew32(ICR, E1000_ICR_OTHER);
>
> -       if (icr & E1000_ICR_RXO) {
> -               ew32(ICR, E1000_ICR_RXO);
> -               enable = false;
> -               /* napi poll will re-enable Other, make sure it runs */
> -               if (napi_schedule_prep(&adapter->napi)) {
> -                       adapter->total_rx_bytes = 0;
> -                       adapter->total_rx_packets = 0;
> -                       __napi_schedule(&adapter->napi);
> -               }
> -       }
>         if (icr & E1000_ICR_LSC) {
>                 ew32(ICR, E1000_ICR_LSC);
>                 hw->mac.get_link_status = true;
> @@ -1938,7 +1927,7 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>                         mod_timer(&adapter->watchdog_timer, jiffies + 1);
>         }
>
> -       if (enable && !test_bit(__E1000_DOWN, &adapter->state))
> +       if (!test_bit(__E1000_DOWN, &adapter->state))
>                 ew32(IMS, E1000_IMS_OTHER);
>
>         return IRQ_HANDLED;
> @@ -2708,8 +2697,7 @@ static int e1000e_poll(struct napi_struct *napi, int weight)
>                 napi_complete_done(napi, work_done);
>                 if (!test_bit(__E1000_DOWN, &adapter->state)) {
>                         if (adapter->msix_entries)
> -                               ew32(IMS, adapter->rx_ring->ims_val |
> -                                    E1000_IMS_OTHER);
> +                               ew32(IMS, adapter->rx_ring->ims_val);
>                         else
>                                 e1000_irq_enable(adapter);
>                 }
> --
> 2.16.1
>
