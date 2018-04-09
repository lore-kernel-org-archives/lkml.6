Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDIIlu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:41:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:41:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09B5960540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 3/3] clk: qcom: gdsc: Add support to poll CFG register to
 check GDSC state
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1522665945-28147-1-git-send-email-tdas@codeaurora.org>
 <1522665945-28147-4-git-send-email-tdas@codeaurora.org>
 <152303280515.143116.7021012753371503067@swboyd.mtv.corp.google.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <530d64eb-a161-1f68-7725-1a52ab1dd999@codeaurora.org>
Date: Mon, 9 Apr 2018 14:11:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152303280515.143116.7021012753371503067@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the review comments.

On 4/6/2018 10:10 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-04-02 03:45:45)
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index e89584e..e0c83ba 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -83,6 +88,38 @@ static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
>>          return -ETIMEDOUT;
>>   }
>>
>> +static int gdsc_is_enabled_by_poll_cfg_reg(struct gdsc *sc, bool en)
>> +{
>> +       u32 val;
>> +       int ret;
>> +
>> +       ret = regmap_read(sc->regmap, sc->gdscr + CFG_GDSCR_OFFSET, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (en)
>> +               return !!(val & GDSC_POWER_UP_COMPLETE);
>> +       else
>> +               return !(val & GDSC_POWER_DOWN_COMPLETE);
> 
> Make this into
> 
> 	if (en)
> 		return ...
> 
> 	return ...
> 

Will fix this in the next series.

>> +}
>> +
>> +static int gdsc_poll_cfg_status(struct gdsc *sc, bool en)
>> +{
>> +       ktime_t start = ktime_get();
>> +       ktime_t timeout =
>> +               (sc->flags & GDS_TIMEOUT) ? TIMEOUT_US_GDS : TIMEOUT_US;
>> +
>> +       do {
>> +               if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
>> +                       return 0;
>> +       } while (ktime_us_delta(ktime_get(), start) < timeout);
>> +
>> +       if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
>> +               return 0;
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>>   static int gdsc_toggle_logic(struct gdsc *sc, bool en)
>>   {
>>          int ret;
>> @@ -106,6 +143,9 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
>>                  return 0;
>>          }
>>
>> +       if (sc->flags & POLL_CFG_GDSCR)
>> +               return gdsc_poll_cfg_status(sc, en);
>> +
>>          if (sc->gds_hw_ctrl) {
>>                  status_reg = sc->gds_hw_ctrl;
>>                  /*
>> @@ -258,8 +298,12 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>>                   */
>>                  udelay(1);
>>
>> -               reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
>> -               ret = gdsc_poll_status(sc, reg, true);
>> +               if (sc->flags & POLL_CFG_GDSCR) {
>> +                       ret = gdsc_poll_cfg_status(sc, true);
>> +               } else {
>> +                       reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
>> +                       ret = gdsc_poll_status(sc, reg, true);
>> +               }
> 
> Maybe this can be pushed into the gdsc_poll_status() function so that
> we can keep the "how do we poll status bit" logic in one place.
> 

Yes, I will push the logic in the gdsc_poll_status() in the next series.

>>                  if (ret)
>>                          return ret;
>>          }

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
