Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbeCHTmM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeCHTlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:41:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385DF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180302164317.10554-6-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-6-ilina@codeaurora.org>
Message-ID: <152053809443.219802.15873554351627646762@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to
 TCS
Date: Thu, 08 Mar 2018 11:41:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-03-02 08:43:12)
> Sleep and wake requests are sent when the application processor
> subsystem of the SoC is entering deep sleep states like in suspend.
> These requests help lower the system power requirements when the
> resources are not in use.
> 
> Sleep and wake requests are written to the TCS slots but are not
> triggered at the time of writing. The TCS are triggered by the firmware
> after the last of the CPUs has executed its WFI. Since these requests
> may come in different batches of requests, it is job of this controller

it is the job?

> driver to find arrange the requests into the available TCSes.

find and arrange?

> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-internal.h |   7 +++
>  drivers/soc/qcom/rpmh-rsc.c      | 128 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 1442a64ac4c5..65dfe1716265 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -13,6 +13,7 @@
>  #define MAX_CMDS_PER_TCS               16
>  #define MAX_TCS_PER_TYPE               3
>  #define MAX_TCS_NR                     (MAX_TCS_PER_TYPE * TCS_TYPE_NR)
> +#define MAX_TCS_SLOTS                  (MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
>  
>  struct rsc_drv;
>  
> @@ -44,6 +45,8 @@ struct tcs_response {
>   * @ncpt: number of commands in each TCS
>   * @tcs_lock: lock for synchronizing this TCS writes
>   * @responses: response objects for requests sent from each TCS
> + * @cmd_addr: flattened cache of cmds in sleep/wake TCS

Maybe 'cmds' or 'cmd_cache'?

> + * @slots: indicates which of @cmd_addr are occupied
>   */
>  struct tcs_group {
>         struct rsc_drv *drv;
> @@ -54,6 +57,9 @@ struct tcs_group {
>         int ncpt;
>         spinlock_t tcs_lock;
>         struct tcs_response *responses[MAX_TCS_PER_TYPE];
> +       u32 *cmd_addr;
> +       DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
> +

Drop the newline please.

>  };
>  
>  /**
> @@ -450,6 +457,114 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_request *msg)
>  }
>  EXPORT_SYMBOL(rpmh_rsc_send_data);
>  
> +static int find_match(struct tcs_group *tcs, struct tcs_cmd *cmd, int len)

const tcs and cmd?

> +{
> +       bool found = false;

Drop.

> +       int i = 0, j;
> +
> +       /* Check for already cached commands */
> +       while ((i = find_next_bit(tcs->slots, MAX_TCS_SLOTS, i)) <

for_each_set_bit(... ?

> +             MAX_TCS_SLOTS) {
> +               if (tcs->cmd_addr[i] != cmd[0].addr) {
> +                       i++;
> +                       continue;
> +               }
> +               /* sanity check to ensure the seq is same */
> +               for (j = 1; j < len; j++) {
> +                       WARN((tcs->cmd_addr[i + j] != cmd[j].addr),
> +                           "Message does not match previous sequence.\n");
> +                       return -EINVAL;
> +               }

Can you fold the if and for loop together? 

		for (j = 0; j < len; j++) {
			if (tcs->cmd_addr[i + j] != cmd[j].addr) {
				if (j == 0)
					break; /* Try another slot */
				WARN("Message doesn't match previous sequence\n");
				return -EINVAL;
			} else if (j == len - 1) {
				return i;
			}
		}
	}

	return -ENODATA;

> +               found = true;
> +               break;
> +       }
> +
> +       return found ? i : -1;

Is there space between slots? Just trying to understand how we
differentiate two adjacent cmd buffers with the bitmap scheme if this
loop is looking for free bits to find slots. Or maybe we need two
bitmaps where one is the allocated region and the other is something
indicating the start bit of a message

> +}
> +
> +static int find_slots(struct tcs_group *tcs, struct tcs_request *msg,
> +                    int *m, int *n)
> +{
> +       int slot, offset;
> +       int i = 0;
> +
> +       /* Find if we already have the msg in our TCS */
> +       slot = find_match(tcs, msg->payload, msg->num_payload);
> +       if (slot >= 0)
> +               goto copy_data;

Shouldn't this goto skip setting the bits in tcs->slots?

> +
> +       /* Do over, until we can fit the full payload in a TCS */
> +       do {
> +               slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
> +                                                i, msg->num_payload, 0);
> +               if (slot == MAX_TCS_SLOTS)
> +                       break;
> +               i += tcs->ncpt;
> +       } while (slot + msg->num_payload - 1 >= i);
> +
> +       if (slot == MAX_TCS_SLOTS)
> +               return -ENOMEM;

Would be nice to remove this duplicate condition somehow. Maybe a goto?

> +
> +copy_data:
> +       bitmap_set(tcs->slots, slot, msg->num_payload);
> +       /* Copy the addresses of the resources over to the slots */
> +       if (tcs->cmd_addr) {

find_match() above didn't check for tcs->cmd_addr. Does this ever happen
to fail?

> +               for (i = 0; i < msg->num_payload; i++)
> +                       tcs->cmd_addr[slot + i] = msg->payload[i].addr;
> +       }
> +
> +       offset = slot / tcs->ncpt;
> +       *m = offset + tcs->tcs_offset;
> +       *n = slot % tcs->ncpt;
> +
> +       return 0;
> +}
> +
> +static int tcs_ctrl_write(struct rsc_drv *drv, struct tcs_request *msg)
> +{
> +       struct tcs_group *tcs;
> +       int m = 0, n = 0;
> +       unsigned long flags;
> +       int ret = 0;

Drop initial assignment please.

> +
> +       tcs = get_tcs_for_msg(drv, msg);
> +       if (IS_ERR(tcs))
> +               return PTR_ERR(tcs);
> +
> +       spin_lock_irqsave(&tcs->tcs_lock, flags);
> +       /* find the m-th TCS and the n-th position in the TCS to write to */
> +       ret = find_slots(tcs, msg, &m, &n);
> +       if (!ret)
> +               __tcs_buffer_write(drv, m, n, msg);
> +       spin_unlock_irqrestore(&tcs->tcs_lock, flags);
> +
> +       return ret;
> +}
> +
[...]
> @@ -530,6 +645,19 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
>                 tcs->tcs_mask = ((1 << tcs->num_tcs) - 1) << st;
>                 tcs->tcs_offset = st;
>                 st += tcs->num_tcs;
> +
> +               /*
> +                * Allocate memory to cache sleep and wake requests to
> +                * avoid reading TCS register memory.
> +                */
> +               if (tcs->type == ACTIVE_TCS)
> +                       continue;
> +
> +               tcs->cmd_addr = devm_kzalloc(&pdev->dev,

devm_kcalloc(&pdev->dev, tcs->num_tcs * ncpt, sizeof(u32) ?

> +                                           sizeof(u32) * tcs->num_tcs * ncpt,
> +                                           GFP_KERNEL);
> +               if (!tcs->cmd_addr)
> +                       return -ENOMEM;
