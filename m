Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756998AbeDZSFf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:05:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37611 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756723AbeDZSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:05:31 -0400
X-Google-Smtp-Source: AIpwx4/o5ecql/q9rGZIEZ0Yhr13p29t9bDnfTtiSpOTdsFd3G+tIK6xi1pzmJ5c794MaYpwxJO6jw==
Date: Thu, 26 Apr 2018 11:05:29 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 04/10] drivers: qcom: rpmh: add RPMH helper functions
Message-ID: <20180426180529.GG243180@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-5-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419221635.17849-5-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Thu, Apr 19, 2018 at 04:16:29PM -0600, Lina Iyer wrote:
> Sending RPMH requests and waiting for response from the controller
> through a callback is common functionality across all platform drivers.
> To simplify drivers, add a library functions to create RPMH client and
> send resource state requests.
> 
> rpmh_write() is a synchronous blocking call that can be used to send
> active state requests.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v6:
> 	- replace rpmh_client with device
> 	- inline wait_for_tx_done()
> 
> Changes in v4:
> 	- use const struct tcs_cmd in API
> 	- remove wait count from this patch
> 	- changed -EFAULT to -EINVAL
> ---
>  drivers/soc/qcom/Makefile        |   4 +-
>  drivers/soc/qcom/rpmh-internal.h |   6 ++
>  drivers/soc/qcom/rpmh-rsc.c      |   8 ++
>  drivers/soc/qcom/rpmh.c          | 168 +++++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h          |  25 +++++
>  5 files changed, 210 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/qcom/rpmh.c
>  create mode 100644 include/soc/qcom/rpmh.h
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index cb6300f6a8e9..bb395c3202ca 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -7,7 +7,9 @@ obj-$(CONFIG_QCOM_PM)	+=	spm.o
>  obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
> -obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
> +obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
> +qcom_rpmh-y			+= rpmh-rsc.o
> +qcom_rpmh-y			+= rpmh.o
>  obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
>  obj-$(CONFIG_QCOM_SMEM) +=	smem.o
>  obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index cc29176f1303..d9a21726e568 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -14,6 +14,7 @@
>  #define MAX_CMDS_PER_TCS		16
>  #define MAX_TCS_PER_TYPE		3
>  #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
> +#define RPMH_MAX_CTRLR			2
>  
>  struct rsc_drv;
>  
> @@ -52,6 +53,7 @@ struct tcs_group {
>   * @tcs:        TCS groups
>   * @tcs_in_use: s/w state of the TCS
>   * @lock:       synchronize state of the controller
> + * @list:       element in list of drv
>   */
>  struct rsc_drv {
>  	const char *name;
> @@ -61,9 +63,13 @@ struct rsc_drv {
>  	struct tcs_group tcs[TCS_TYPE_NR];
>  	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
>  	spinlock_t lock;
> +	struct list_head list;
>  };
>  
> +extern struct list_head rsc_drv_list;
>  
>  int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
>  
> +void rpmh_tx_done(const struct tcs_request *msg, int r);
                                                        ~

nit: consider using a more expressive name, like status, rc, res or
err.

<snip>

> +static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
> +{
> +	int i;
> +	struct rsc_drv *p, *drv = dev_get_drvdata(dev->parent);
> +	struct rpmh_ctrlr *ctrlr = ERR_PTR(-EINVAL);
> +
> +	if (!drv)
> +		return ctrlr;
> +
> +	for (i = 0; i < RPMH_MAX_CTRLR; i++) {
> +		if (rpmh_rsc[i].drv == drv) {
> +			ctrlr = &rpmh_rsc[i];
> +			return ctrlr;
> +		}
> +	}
> +
> +	list_for_each_entry(p, &rsc_drv_list, list) {
> +		if (drv == p) {
> +			for (i = 0; i < RPMH_MAX_CTRLR; i++) {
> +				if (!rpmh_rsc[i].drv)
> +					break;
> +			}
> +			rpmh_rsc[i].drv = drv;

There is a race condition, get_rpmh_ctrlr() could be executed
simulatenously in different contexts, and select the same
controller instance for different DRVs.

It's probably an unlikely case, but to be safe you'd have to do
something like this:

retry:
for (i = 0; i < RPMH_MAX_CTRLR; i++) {
	if (!rpmh_rsc[i].drv)
		break;
}

spin_lock(&rpmh_rsc[i].lock);

if (!rpmh_rsc[i].drv) {
	rpmh_rsc[i].drv = drv;
	ctrlr = &rpmh_rsc[i];
} else {
	spin_unlock(&rpmh_rsc[i].lock);
	goto retry;
}

spin_unlock(&rpmh_rsc[i].lock);


The above code doesn't address another potential error case, where
#DRV > RPMH_MAX_CTRLR. In this case we'd access memory beyond
rpmh_rsc. This would be a configuration error, not sure if it's
strictly necessary to handle it.

<snip>

> +/**
> + * rpmh_write: Write a set of RPMH commands and block until response
> + *
> + * @rc: The RPMh handle got from rpmh_get_client
               ~~~~

nit: Other than this the driver consistently uses 'RPMH'

Matthias
