Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758852AbeD0Rjs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:39:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeD0Rjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:39:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D75086019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 27 Apr 2018 11:39:43 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180427173943.GD6380@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-6-ilina@codeaurora.org>
 <20180425214111.GC243180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180425214111.GC243180@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25 2018 at 15:41 -0600, Matthias Kaehlcke wrote:
>On Thu, Apr 19, 2018 at 04:16:30PM -0600, Lina Iyer wrote:
>> Sleep and wake requests are sent when the application processor
>> subsystem of the SoC is entering deep sleep states like in suspend.
>> These requests help lower the system power requirements when the
>> resources are not in use.
>>
>> Sleep and wake requests are written to the TCS slots but are not
>> triggered at the time of writing. The TCS are triggered by the firmware
>> after the last of the CPUs has executed its WFI. Since these requests
>> may come in different batches of requests, it is the job of this
>> controller driver to find and arrange the requests into the available
>> TCSes.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Reviewed-by: Evan Green <evgreen@chromium.org>
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |   8 +++
>>  drivers/soc/qcom/rpmh-rsc.c      | 120 +++++++++++++++++++++++++++++++
>>  2 files changed, 128 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> index d9a21726e568..6e19fe458c31 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>
><snip>
>
>> +static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
>> +		      int len)
>> +{
>> +	int i, j;
>> +
>> +	/* Check for already cached commands */
>> +	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
>> +		for (j = 0; j < len; j++) {
>> +			if (tcs->cmd_cache[i] != cmd[0].addr) {
>
>Shouldn't the condition be 'tcs->cmd_cache[i + j] != cmd[j].addr'?
>
Here, we are trying to find the first address from the request and its
position 'i' in the cmd_cache.

>Otherwise the code below the following if branch will never be
>executed. Either the 'tcs->cmd_cache[i] != cmd[0].addr' branch isn't
>entered because the addresses match, or the addresses don't match
>and the inner loop is aborted after the first iteration.
>
>> +				if (j == 0)
>> +					break;
>> +				WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
>> +				     "Message does not match previous sequence.\n");
We now check for the sequence using the iterator 'j' only after we have
found 'i' (the beginning of our request).

I hope that helps clear the concern.

-- Lina

>> +				return -EINVAL;
>> +			} else if (j == len - 1) {
>> +				return i;
>> +			}
>> +		}
>> +	}
>> +
>> +	return -ENODATA;
>> +}
