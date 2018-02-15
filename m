Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033133AbeBOOHE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:07:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36072 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032953AbeBOOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:07:02 -0500
X-Google-Smtp-Source: AH8x2255y4kqEIeQQxz2SBzjD8QZDRDQRj7ydNcUELqBanMaQ1/9GqFFwbDUnrTYHoO8A7kRhW7jhYt/okPKSRkhDxc=
MIME-Version: 1.0
In-Reply-To: <20180214135612.21356-1-embed3d@gmail.com>
References: <20180214135612.21356-1-embed3d@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 16 Feb 2018 01:06:40 +1100
Message-ID: <CAGRGNgX_9Hw6guN-TbANfDdH4jAjLBSRZdD9WtFcB-F+E-3GfA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
To: embed3d@gmail.com
Cc: Chen-Yu Tsai <wens@csie.org>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillipp,

On Thu, Feb 15, 2018 at 12:56 AM, Philipp Rossak <embed3d@gmail.com> wrote:
> This patch fixes a bug, that prevents the Allwinner A83T and the A80
> from a successful boot.
>
> The bug is there since v4.16-rc1 and appeared after the clk branch was
> merged.
>
> You can find the shortend trace below:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> pgd = (ptrval)
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be #2
> Hardware name: Allwinner sun8i Family
> Workqueue: events deferred_probe_work_func
> PC is at clk_hw_get_rate+0x0/0x34
> LR is at ac100_clkout_determine_rate+0x48/0x19c
>
> [ ... ]
>
> (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
> (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
> (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
> (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
> (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
>
> To fix that bug, we first check if the return of the
> clk_hw_get_parent_by_index is non zero. If it is zero we skip that
> clock parent.
>
> The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198
>
> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
>
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>
> Changes in v3:
>         * add information when the bug appeared
>         * make the comment more clear
> Changes in v2:
>         * add tag Fixes: ... to commit message
>         * add comment to if statement why we are doing this check
>
>  drivers/rtc/rtc-ac100.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index 8ff9dc3fe5bf..2412aa2e8399 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -183,7 +183,24 @@ static int ac100_clkout_determine_rate(struct clk_hw *hw,
>
>         for (i = 0; i < num_parents; i++) {
>                 struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> -               unsigned long tmp, prate = clk_hw_get_rate(parent);
> +               unsigned long tmp, prate;
> +
> +               /*
> +                * The clock has two parents, one is a fixed clock which is
> +                * internally registered by the ac100 driver. The other parent
> +                * is a clock from the codec side of the chip, which we
> +                * properly declare and reference in the devicetree and is
> +                * not implemented in any driver right now.
> +                * If the clock core looks for the parent of that second
> +                * missing clock, it can't one that is registered and

You've missed the word "find" between "it can't" and "one that is registered".

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
