Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeBHOX2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:23:28 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36291 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:23:27 -0500
X-Google-Smtp-Source: AH8x226uCd1Mek0fUoCLhm8g4IL4S7/0PU+65jXKCmrPXFm2D9OjyOICWEobaS4kRCXflp/HcK3LahpO9GqMDKOXCo4=
MIME-Version: 1.0
In-Reply-To: <20180208064714.6042-2-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com> <20180208064714.6042-2-bpoirier@suse.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 8 Feb 2018 06:23:25 -0800
Message-ID: <CAKgT0Ud24GKtxcePETap8ECxhjGE0OOaZYb0G_cyY1XKp22X_Q@mail.gmail.com>
Subject: Re: [PATCH net-queue 2/3] e1000e: Fix queue interrupt re-raising in
 Other interrupt.
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 10:47 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> restores the ICS write for rx/tx queue interrupts which was present before
> commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt",
> v4.5-rc1) but was not restored in commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts", v4.15-rc1).
>
> This re-raises the queue interrupts in case the txq or rxq bits were set in
> ICR and the Other interrupt handler read and cleared ICR before the queue
> interrupt was raised.
>
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 3b36efa6228d..2c9609bee2ae 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1919,6 +1919,9 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>         icr = er32(ICR);
>         ew32(ICR, E1000_ICR_OTHER);
>
> +       if (icr & adapter->eiac_mask)
> +               ew32(ICS, (icr & adapter->eiac_mask));
> +
>         if (icr & E1000_ICR_LSC) {
>                 ew32(ICR, E1000_ICR_LSC);
>                 hw->mac.get_link_status = true;
> --
> 2.16.1
>
