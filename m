Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeEWOVS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:21:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932564AbeEWOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:21:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8B5F60213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v8 10/10] drivers: qcom: rpmh-rsc: allow active requests
 from wake TCS
To: Doug Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, msivasub@codeaurora.org,
        mkshah@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-11-ilina@codeaurora.org>
 <CAD=FV=V519eo20KpoGMm_deJ1Zv5r60bX9xGgcjtSeZPrychgw@mail.gmail.com>
From: Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <8d7f1fd2-1429-577f-309e-ffff8b7824bb@codeaurora.org>
Date: Wed, 23 May 2018 19:51:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=V519eo20KpoGMm_deJ1Zv5r60bX9xGgcjtSeZPrychgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/2018 1:47 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> Some RSCs may only have sleep and wake TCS, i.e, there is no dedicated
>> TCS for active mode request, but drivers may still want to make active
>> requests from these RSCs. In such cases re-purpose the wake TCS to send
>> active state requests.
>>
>> The requirement for this is that the driver is aware that the wake TCS
>> is being repurposed to send active request, hence the sleep and wake
>> TCSes be invalidated before the active request is sent.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>   drivers/soc/qcom/rpmh-rsc.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index 68c25ebbbe09..369b9b3eedc5 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -153,6 +153,7 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>>                                           const struct tcs_request *msg)
>>   {
>>          int type;
>> +       struct tcs_group *tcs;
>>
>>          switch (msg->state) {
>>          case RPMH_ACTIVE_ONLY_STATE:
>> @@ -168,7 +169,22 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>>                  return ERR_PTR(-EINVAL);
>>          }
>>
>> -       return get_tcs_of_type(drv, type);
>> +       /*
>> +        * If we are making an active request on a RSC that does not have a
>> +        * dedicated TCS for active state use, then re-purpose a wake TCS to
>> +        * send active votes.
>> +        * NOTE: The driver must be aware that this RSC does not have a
>> +        * dedicated AMC, and therefore would invalidate the sleep and wake
>> +        * TCSes before making an active state request.
>> +        */
>> +       tcs = get_tcs_of_type(drv, type);
>> +       if (msg->state == RPMH_ACTIVE_ONLY_STATE && IS_ERR(tcs)) {
>> +               tcs = get_tcs_of_type(drv, WAKE_TCS);
>> +               if (!IS_ERR(tcs))
>> +                       rpmh_rsc_invalidate(drv);
> 
> I noticed that rpmh_rsc_invalidate() can return -EAGAIN.  Do you need
> to deal with that here?

Yes. will add the check here.

Thanks,
Raju.

> 
> 
> -Doug
> 
