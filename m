Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758812AbeD0Qo0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:44:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758562AbeD0QoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:44:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E383F60310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 27 Apr 2018 10:44:21 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Message-ID: <20180427164421.GB6380@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-7-ilina@codeaurora.org>
 <20180425221123.GD243180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180425221123.GD243180@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25 2018 at 16:11 -0600, Matthias Kaehlcke wrote:
>On Thu, Apr 19, 2018 at 04:16:31PM -0600, Lina Iyer wrote:
>> Allow sleep and wake commands to be cleared from the respective TCSes,
>> so that they can be re-populated.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>
>> Changes in v6:
>> 	- remove unnecessary locks around __tcs_invalidate
>> 	- rename function to tcs_invaldiate
>>
>> Changes in v4:
>> 	- refactored the rphm_rsc_invalidate()
>> ---
>>  drivers/soc/qcom/rpmh-rsc.c | 45 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index d169f7da5422..170d4a10275d 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -101,6 +101,51 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>>  	return &drv->tcs[type];
>>  }
>>
>> +static int tcs_invalidate(struct rsc_drv *drv, int type)
>> +{
>> +	int m;
>> +	struct tcs_group *tcs;
>> +
>> +	tcs = get_tcs_of_type(drv, type);
>> +	if (IS_ERR(tcs))
>> +		return PTR_ERR(tcs);
>> +
>> +	spin_lock(&tcs->lock);
>> +	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
>> +		spin_unlock(&tcs->lock);
>> +		return 0;
>> +	}
>> +
>> +	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +		if (!tcs_is_free(drv, m)) {
>> +			spin_unlock(&tcs->lock);
>> +			return -EAGAIN;
>> +		}
>> +		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
>> +		bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
>
>Shouldn't this only clear the slots corresponding to 'm'?
>
>If resetting the entire bitmap is really intended it could be done
>once after the loop, though the bitmap might be left in an
>inconsistent state if a TCS is still in use.
The TCS will not be in use, the check tcs_is_free() will ensure that. I
will move the bitmap_zero() outside the for().

Thanks,
Lina
