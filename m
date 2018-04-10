Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754407AbeDJPZS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:25:18 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41004 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbeDJPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:25:16 -0400
X-Google-Smtp-Source: AIpwx4/xvlxmSvFXJTb0Wq9VjiN+H8yDkedlKssGtvG0Q2IUCNNCcVWzxkGDMwj67esD/QD3nfgeF+jAuHbOF3Fxb20=
MIME-Version: 1.0
In-Reply-To: <1523365076-31461-1-git-send-email-baijiaju1990@gmail.com>
References: <1523365076-31461-1-git-send-email-baijiaju1990@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Apr 2018 18:25:15 +0300
Message-ID: <CAHp75Vf9_mvXk3B0h4FhC=SOEdxSqW2ZyJVUHuLABrtvpfx5zg@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: intel_scu_ipc: Replace mdelay with
 usleep_range in intel_scu_ipc_i2c_cntrl
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 3:57 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> intel_scu_ipc_i2c_cntrl() calls mutex_lock(), which indicates
> this function is not called in atomic context.
>
> Despite never getting called from atomic context,
> intel_scu_ipc_i2c_cntrl() calls mdelay to busily wait.
> This is not necessary and can be replaced with usleep_range to
> avoid busy waiting.
>
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.

I'm not sure we even need that delay at all.
Anyway, pushed to my review and testing queue, thanks!

>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 2c85f75..75c8fef 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -584,11 +584,11 @@ int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data)
>         if (cmd == IPC_I2C_READ) {
>                 writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
>                 /* Write not getting updated without delay */
> -               mdelay(1);
> +               usleep_range(1000, 2000);
>                 *data = readl(scu->i2c_base + I2C_DATA_ADDR);
>         } else if (cmd == IPC_I2C_WRITE) {
>                 writel(*data, scu->i2c_base + I2C_DATA_ADDR);
> -               mdelay(1);
> +               usleep_range(1000, 2000);
>                 writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
>         } else {
>                 dev_err(scu->dev,
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
