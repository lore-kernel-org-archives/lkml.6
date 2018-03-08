Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeCHUkO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:40:14 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41037 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCHUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:40:12 -0500
X-Google-Smtp-Source: AG47ELufKTeHvSUXUr+tdmOwd2mMvt36TGBqg+xl8CA8EiNp7X/1UJwALdFfEZBuCVXx+JblaLWDWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180302164317.10554-7-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-7-ilina@codeaurora.org>
Message-ID: <152054160996.219802.12202813950978900157@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Date: Thu, 08 Mar 2018 12:40:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28KeI97001474

Quoting Lina Iyer (2018-03-02 08:43:13)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 34e780d9670f..e9f5a1f387fd 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -170,6 +170,52 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>         return tcs;
>  }
>  
> +/**
> + * rpmh_rsc_invalidate - Invalidate sleep and wake TCSes
> + *
> + * @drv: the mailbox controller
> + */
> +int rpmh_rsc_invalidate(struct rsc_drv *drv)
> +{
> +       struct tcs_group *tcs;
> +       int m, type, ret = 0;
> +       int inv_types[] = { WAKE_TCS, SLEEP_TCS };
> +       unsigned long drv_flags, flags;
> +
> +       /* Lock the DRV and clear sleep and wake TCSes */
> +       spin_lock_irqsave(&drv->drv_lock, drv_flags);
> +       for (type = 0; type < ARRAY_SIZE(inv_types); type++) {
> +               tcs = get_tcs_of_type(drv, inv_types[type]);
> +               if (IS_ERR(tcs))
> +                       continue;
> +
> +               spin_lock_irqsave(&tcs->tcs_lock, flags);

Should just be a spin_lock() because we already irq saved a few lines above.

> +               if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
> +                       spin_unlock_irqrestore(&tcs->tcs_lock, flags);
> +                       continue;
> +               }
> +
> +               /* Clear the enable register for each TCS of the type */
> +               for (m = tcs->tcs_offset;
> +                   m < tcs->tcs_offset + tcs->num_tcs; m++) {
> +                       if (!tcs_is_free(drv, m)) {
> +                               spin_unlock_irqrestore(&tcs->tcs_lock, flags);
> +                               ret = -EAGAIN;
> +                               goto drv_unlock;
> +                       }
> +                       write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
> +                       /* Mark the TCS slots as free */
> +                       bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
> +               }
> +               spin_unlock_irqrestore(&tcs->tcs_lock, flags);

Maybe make another function called rpmh_tcs_invalidate(drv, enum TCS_FOO)
and put this logic inside it? And then change from a for loop to two
direct calls:

	lock()
	ret = rpmh_tcs_invalidate(drv, WAKE_TCS);
	if (!ret)
		ret = rpmh_tcs_invalidate(drv, SLEEP_TCS);
	unlock()
