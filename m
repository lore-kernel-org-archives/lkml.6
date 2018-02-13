Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeBMCeq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:34:46 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34157 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933199AbeBMCep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:34:45 -0500
X-Google-Smtp-Source: AH8x2260VZ/Jy8S0QWV/QZ0WZLPGF3AyFdq++efSrYo/epW7toiIsWsSgjr6Z4ORV3HTMg46ntEkeg==
MIME-Version: 1.0
In-Reply-To: <20180212210723.20919-1-embed3d@gmail.com>
References: <20180212210723.20919-1-embed3d@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 13 Feb 2018 10:34:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v64L_xsU4US-Pi3cNPyfeADfhpXfPo=OcZ_x9F=5GehjCQ@mail.gmail.com>
Message-ID: <CAGb2v64L_xsU4US-Pi3cNPyfeADfhpXfPo=OcZ_x9F=5GehjCQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: ac100: Fix ac100 determine rate bug
To: Philipp Rossak <embed3d@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 5:07 AM, Philipp Rossak <embed3d@gmail.com> wrote:
> This patch fixes a bug, that prevents the Allwinner A83T and the A80
> from a successful boot. You can find the shortend trace below:
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

Please add the tag:

Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")

> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/rtc/rtc-ac100.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index 8ff9dc3fe5bf..820ce6fb9d34 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -183,7 +183,12 @@ static int ac100_clkout_determine_rate(struct clk_hw *hw,
>
>         for (i = 0; i < num_parents; i++) {
>                 struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> -               unsigned long tmp, prate = clk_hw_get_rate(parent);
> +               unsigned long tmp, prate;
> +
> +               if (!parent)
> +                       continue;

There should be a comment on why this is happening, i.e. we purposefully
left open the possibility of the clock from the codec side missing.
Otherwise I think the clk subsystem doesn't expect this to happen,
which is why there are no checks like this anywhere.

ChenYu

> +
> +               prate = clk_hw_get_rate(parent);
>
>                 tmp = ac100_clkout_round_rate(hw, req->rate, prate);
>
> --
> 2.11.0
>
