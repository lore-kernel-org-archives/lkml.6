Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeA3OJg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:09:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeA3OJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:09:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2415601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v2 2/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
To: Brian Norris <briannorris@chromium.org>,
        Philippe Cornu <philippe.cornu@st.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Mickael Reulier <mickael.reulier@st.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
 <20180125103800.1999-3-philippe.cornu@st.com>
 <20180126004628.fbrady7twf7ys2qx@ban.mtv.corp.google.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <70cae8dd-ee9e-0313-6518-504ee5ec32ca@codeaurora.org>
Date: Tue, 30 Jan 2018 19:39:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180126004628.fbrady7twf7ys2qx@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/26/2018 06:16 AM, Brian Norris wrote:
> On Thu, Jan 25, 2018 at 11:38:00AM +0100, Philippe Cornu wrote:
>> The dw_mipi_dsi_host_transfer() must return the number of
>> bytes transmitted/received on success instead of 0.
>> Note: As the read feature is not implemented, only the
>> transmitted number of bytes is returned for the moment.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Assuming we're going with the current documented semantics (where we
> return # of TX bytes for writes), then:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> I believe Archit was suggesting maybe changing that sometime, but that's
> no excuse for not matching documentation now.

Queued to drm-misc-next.

Thanks,
Archit

> 
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 72ecaeb40822..090bf62d1ea8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -419,7 +419,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   
>>   	dw_mipi_message_config(dsi, msg);
>>   
>> -	return dw_mipi_dsi_write(dsi, &packet);
>> +	ret = dw_mipi_dsi_write(dsi, &packet);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * TODO Only transmitted size is returned as actual driver does
>> +	 * not support dcs/generic reads. Please update return value when
>> +	 * delivering the read feature.
>> +	 */
>> +	return packet.size;
> 
> You're really holding my hand here, I see :) Thanks I guess.
> 
>>   }
>>   
>>   static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
>> -- 
>> 2.15.1
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
