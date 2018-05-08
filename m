Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeEHQQU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:16:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeEHQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:16:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 10:16:16 -0600
From: ilina@codeaurora.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v7 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
In-Reply-To: <20180503213539.GA19594@google.com>
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-6-ilina@codeaurora.org>
 <20180503213539.GA19594@google.com>
Message-ID: <462ea6c6f62f5480f17ce7bf81ff5db1@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 15:35, Matthias Kaehlcke wrote:
> Hi Lina,
> 
> On Wed, May 02, 2018 at 01:37:44PM -0600, Lina Iyer wrote:
>> Sleep and wake requests are sent when the application processor
>> subsystem of the SoC is entering deep sleep states like in suspend.
>> These requests help lower the system power requirements when the
>> resources are not in use.
>> 
>> Sleep and wake requests are written to the TCS slots but are not
>> triggered at the time of writing. The TCS are triggered by the 
>> firmware
>> after the last of the CPUs has executed its WFI. Since these requests
>> may come in different batches of requests, it is the job of this
>> controller driver to find and arrange the requests into the available
>> TCSes.
>> 
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Reviewed-by: Evan Green <evgreen@chromium.org>
>> 
>> ---
>> 
>> Changes in v7:
>> 	- Bug fix in find_match()
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |   8 +++
>>  drivers/soc/qcom/rpmh-rsc.c      | 118 
>> +++++++++++++++++++++++++++++++
>>  2 files changed, 126 insertions(+)
>> 
>> diff --git a/drivers/soc/qcom/rpmh-internal.h 
>> b/drivers/soc/qcom/rpmh-internal.h
>> index d9a21726e568..6e19fe458c31 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> @@ -14,6 +14,7 @@
>>  #define MAX_CMDS_PER_TCS		16
>>  #define MAX_TCS_PER_TYPE		3
>>  #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
>> +#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
>>  #define RPMH_MAX_CTRLR			2
>> 
>>  struct rsc_drv;
>> @@ -30,6 +31,8 @@ struct rsc_drv;
>>   * @ncpt:      number of commands in each TCS
>>   * @lock:      lock for synchronizing this TCS writes
>>   * @req:       requests that are sent from the TCS
>> + * @cmd_cache: flattened cache of cmds in sleep/wake TCS
>> + * @slots:     indicates which of @cmd_addr are occupied
>>   */
>>  struct tcs_group {
>>  	struct rsc_drv *drv;
>> @@ -40,6 +43,8 @@ struct tcs_group {
>>  	int ncpt;
>>  	spinlock_t lock;
>>  	const struct tcs_request *req[MAX_TCS_PER_TYPE];
>> +	u32 *cmd_cache;
>> +	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
>>  };
>> 
>>  /**
>> @@ -69,6 +74,9 @@ struct rsc_drv {
>>  extern struct list_head rsc_drv_list;
>> 
>>  int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request 
>> *msg);
>> +int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>> +			     const struct tcs_request *msg);
>> +int rpmh_rsc_invalidate(struct rsc_drv *drv);
>> 
>>  void rpmh_tx_done(const struct tcs_request *msg, int r);
>> 
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index 33270b1d5991..4e2144a14c31 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -113,6 +113,12 @@ static struct tcs_group *get_tcs_for_msg(struct 
>> rsc_drv *drv,
>>  	case RPMH_ACTIVE_ONLY_STATE:
>>  		type = ACTIVE_TCS;
>>  		break;
>> +	case RPMH_WAKE_ONLY_STATE:
>> +		type = WAKE_TCS;
>> +		break;
>> +	case RPMH_SLEEP_STATE:
>> +		type = SLEEP_TCS;
>> +		break;
>>  	default:
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> @@ -353,6 +359,105 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, 
>> const struct tcs_request *msg)
>>  }
>>  EXPORT_SYMBOL(rpmh_rsc_send_data);
>> 
>> +static int find_match(const struct tcs_group *tcs, const struct 
>> tcs_cmd *cmd,
>> +		      int len)
>> +{
>> +	int i, j;
>> +
>> +	/* Check for already cached commands */
>> +	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
>> +		if (tcs->cmd_cache[i] != cmd[0].addr)
>> +			continue;
>> +		for (j = 0; j < len; j++) {
>> +			if (tcs->cmd_cache[i + j] != cmd[j].addr) {
> 
> As mentioned in the review of v6, the code could read memory beyond
> tcs->cmd_cache if 'i + len > ARRAY_SIZE(tcs->cmd_cache)'
> 
Ok. Will add it.

>> +				WARN(1, "Message does not match previous sequence.\n");
>> +				return -EINVAL;
>> +			}
>> +		}
>> +		return i;
>> +	}
>> +
>> +	return -ENODATA;
>> +}
>> +
>> +static int find_slots(struct tcs_group *tcs, const struct tcs_request 
>> *msg,
>> +		      int *tcs_id, int *cmd_id)
> 
> The change from m/n => tcs_id/cmd_id in v7 greatly improves
> readability, thanks!
> 
> Matthias
> 
> PS: Please remember to include reviewers of earlier revisions to cc:
Sure.

Thanks,
Lina
