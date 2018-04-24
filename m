Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756253AbeDXIBL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:01:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDXIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:01:09 -0400
Subject: Re: [PATCH 6/6] devfreq: rk3399_dmc: register devfreq notification to
 dmc driver.
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groek@google.com" <groek@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Lin Huang <hl@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20180419104019.24406-7-enric.balletbo@collabora.com>
 <20180419104019.24406-1-enric.balletbo@collabora.com>
 <CGME20180419104059epcas2p3fe5aba95859e02307556200a42bc1ac2@epcms1p7>
 <20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4@epcms1p7>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a213bb68-2a47-b7b9-d35f-cc5355f9c1be@collabora.com>
Date: Tue, 24 Apr 2018 10:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4@epcms1p7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 24/04/18 06:22, MyungJoo Ham wrote:
>> From: Lin Huang <hl@rock-chips.com>
>>
>> Because dmc may also access the PMU_BUS_IDLE_REQ register, we need to
>> ensure that the pd driver and the dmc driver will not access at this
>> register at the same time.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> drivers/devfreq/rk3399_dmc.c      | 47 +----------------------
>> drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++
>> include/soc/rockchip/rk3399_dmc.h | 63 +++++++++++++++++++++++++++++++
>> 3 files changed, 96 insertions(+), 45 deletions(-)
>> create mode 100644 include/soc/rockchip/rk3399_dmc.h
>>
>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>> index 5bfca028eaaf..a1f320634d69 100644
>> --- a/drivers/devfreq/rk3399_dmc.c
>> +++ b/drivers/devfreq/rk3399_dmc.c
> []
>> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
>> index 53efc386b1ad..7acc836e7eb7 100644
>> --- a/drivers/soc/rockchip/pm_domains.c
>> +++ b/drivers/soc/rockchip/pm_domains.c
> []
>> +static int dmc_notify(struct notifier_block *nb, unsigned long event,
>> +		      void *data)
>> +{
>> +	if (event == DEVFREQ_PRECHANGE)
>> +		mutex_lock(&dmc_pmu->mutex);
>> +	else if (event == DEVFREQ_POSTCHANGE)
>> +		mutex_unlock(&dmc_pmu->mutex);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
> 
> Doesn't this incur a deadlock?
> 
> 1. devfreq.c:update_freq calls devfreq_notify_transition(DEVFREQ_PRECHANGE)
> 2. pm_domain.c:dmc_notify calls mutex_lock(dmc_pmu->mutex)
> 3. devfreq.c:update_freq calls target callback
> 4. rk3399_dmc.c:rk3399_dmcfreq_target calls mutex_lock(&dmcfreq->lock)
>    >>>>>> update_freq cannot proceed. <<<<
> 

Mmm, makes sense, but I did not detect this deadlock.

As this patch is controversial let me remove this patch from these series and
I'll send again with the other series that applies on top of these, the series I
am working on are to add ddrfreq support in the drm rockchip driver. Thinking
about it I guess makes more sense as 1-5 are just cleanups, 6 is a bit
different, maybe more related to the work I am doing.

Best regards,
  Enric

> 
> Cheers,
> MyungJoo
> 
