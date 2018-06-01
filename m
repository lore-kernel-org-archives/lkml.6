Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750931AbeFAIs5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:48:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeFAIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:48:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26CBB601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
To: David Collins <collinsd@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-6-rnayak@codeaurora.org>
 <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <6817acaf-9a68-5cd5-4dd0-ebe12a9aa057@codeaurora.org>
Date: Fri, 1 Jun 2018 14:18:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <215deee5-6472-d587-9a90-f7158162ed82@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 05/26/2018 06:38 AM, David Collins wrote:
> 
>> +	[1] = &sdm845_mx,
>> +	[2] = &sdm845_mx_ao,
>> +	[3] = &sdm845_cx,
>> +	[4] = &sdm845_cx_ao,
>> +	[5] = &sdm845_lmx,
>> +	[6] = &sdm845_lcx,
>> +	[7] = &sdm845_gfx,
>> +	[8] = &sdm845_mss,
>> +};
>> +
>> +static const struct rpmhpd_desc sdm845_desc = {
>> +	.rpmhpds = sdm845_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(sdm845_rpmhpds),
>> +};
>> +
>> +static const struct of_device_id rpmhpd_match_table[] = {
>> +	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
>> +
>> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state, unsigned int corner)
>> +{
>> +	struct tcs_cmd cmd = {
>> +		.addr = pd->addr,
>> +		.data = corner,
>> +	};
>> +
>> +	return rpmh_write(pd->dev, state, &cmd, 1);
> This can be optimized by calling rpmh_write_async() whenever the corner
> being sent is smaller than the last value sent.  That way, no time is
> wasted waiting for an ACK when decreasing voltage.  Would you mind adding
> the necessary check and previous request caching for this?

is it safe to assume all sleep votes can be sent as async always? and only
active votes could be sync/async depending on the last value sent?

regards,
Rajendra

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
