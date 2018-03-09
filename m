Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932169AbeCIQlh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:41:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeCIQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:41:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA2BD6038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 9 Mar 2018 09:41:34 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Message-ID: <20180309164134.GE3577@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-7-ilina@codeaurora.org>
 <152054160996.219802.12202813950978900157@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152054160996.219802.12202813950978900157@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08 2018 at 13:40 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-03-02 08:43:13)
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index 34e780d9670f..e9f5a1f387fd 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -170,6 +170,52 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>>         return tcs;
>>  }
>>
>> +/**
>> + * rpmh_rsc_invalidate - Invalidate sleep and wake TCSes
>> + *
>> + * @drv: the mailbox controller
>> + */
>> +int rpmh_rsc_invalidate(struct rsc_drv *drv)
>> +{
>> +       struct tcs_group *tcs;
>> +       int m, type, ret = 0;
>> +       int inv_types[] = { WAKE_TCS, SLEEP_TCS };
>> +       unsigned long drv_flags, flags;
>> +
>> +       /* Lock the DRV and clear sleep and wake TCSes */
>> +       spin_lock_irqsave(&drv->drv_lock, drv_flags);
>> +       for (type = 0; type < ARRAY_SIZE(inv_types); type++) {
>> +               tcs = get_tcs_of_type(drv, inv_types[type]);
>> +               if (IS_ERR(tcs))
>> +                       continue;
>> +
>> +               spin_lock_irqsave(&tcs->tcs_lock, flags);
>
>Should just be a spin_lock() because we already irq saved a few lines above.
>
Agreed.
>> +               if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
>> +                       spin_unlock_irqrestore(&tcs->tcs_lock, flags);
>> +                       continue;
>> +               }
>> +
>> +               /* Clear the enable register for each TCS of the type */
>> +               for (m = tcs->tcs_offset;
>> +                   m < tcs->tcs_offset + tcs->num_tcs; m++) {
>> +                       if (!tcs_is_free(drv, m)) {
>> +                               spin_unlock_irqrestore(&tcs->tcs_lock, flags);
>> +                               ret = -EAGAIN;
>> +                               goto drv_unlock;
>> +                       }
>> +                       write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
>> +                       /* Mark the TCS slots as free */
>> +                       bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
>> +               }
>> +               spin_unlock_irqrestore(&tcs->tcs_lock, flags);
>
>Maybe make another function called rpmh_tcs_invalidate(drv, enum TCS_FOO)
>and put this logic inside it? And then change from a for loop to two
>direct calls:
>
>	lock()
>	ret = rpmh_tcs_invalidate(drv, WAKE_TCS);
>	if (!ret)
>		ret = rpmh_tcs_invalidate(drv, SLEEP_TCS);
>	unlock()
>
Agreed. That will be better. Will fix.

-- Lina
