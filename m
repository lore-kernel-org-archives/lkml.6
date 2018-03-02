Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428314AbeCBNst (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:48:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425014AbeCBNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:48:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE293601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shajit@codeaurora.org
Subject: Re: [PATCH v5 4/5] remoteproc: qcom: Introduce sysmon
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20171205174310.15799-1-bjorn.andersson@linaro.org>
 <20171205174310.15799-5-bjorn.andersson@linaro.org>
From: Jitendra Sharma <shajit@codeaurora.org>
Message-ID: <7f153e40-93a7-d43e-3947-c09d2ac28ce2@codeaurora.org>
Date: Fri, 2 Mar 2018 19:18:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171205174310.15799-5-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On 12/5/2017 11:13 PM, Bjorn Andersson wrote:
> The sysmon client communicates either via a dedicated SMD/GLINK channel
> or via QMI encoded messages over IPCROUTER with remote processors in
> order to perform graceful shutdown and inform about other remote
> processors shutting down.
>
> Acked-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v4:
> - SPDX header
>
> Changes since v3:
> - Kerneldoc updates
> - Style fixes
>
> Changes since v2:
> - Checkpatch fixes
>
> Changes since v1:
> - New patch
>
>   drivers/remoteproc/Kconfig         |  17 ++
>   drivers/remoteproc/Makefile        |   1 +
>   drivers/remoteproc/qcom_adsp_pil.c |  12 +
>   drivers/remoteproc/qcom_common.h   |  21 ++
>   drivers/remoteproc/qcom_q6v5_pil.c |   3 +
>   drivers/remoteproc/qcom_sysmon.c   | 579 +++++++++++++++++++++++++++++++++++++
>   drivers/remoteproc/qcom_wcnss.c    |   4 +
>   7 files changed, 637 insertions(+)
>   create mode 100644 drivers/remoteproc/qcom_sysmon.c
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index b609e1d3654b..6556df21318e 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -90,6 +90,7 @@ config QCOM_ADSP_PIL
>   	depends on QCOM_SMEM
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> +	depends on QCOM_SYSMON || QCOM_SYSMON=n
>   	select MFD_SYSCON
>   	select QCOM_MDT_LOADER
>   	select QCOM_RPROC_COMMON
> @@ -107,6 +108,7 @@ config QCOM_Q6V5_PIL
>   	depends on QCOM_SMEM
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> +	depends on QCOM_SYSMON || QCOM_SYSMON=n
>   	select MFD_SYSCON
>   	select QCOM_RPROC_COMMON
>   	select QCOM_SCM
> @@ -114,12 +116,27 @@ config QCOM_Q6V5_PIL
>   	  Say y here to support the Qualcomm Peripherial Image Loader for the
>   	  Hexagon V5 based remote processors.
>   
> +config QCOM_SYSMON
> +	tristate "Qualcomm sysmon driver"
> +	depends on RPMSG
> +	depends on ARCH_QCOM
> +	select QCOM_QMI_HELPERS
> +	help
> +	  The sysmon driver implements a sysmon QMI client and a handler for
> +	  the sys_mon SMD and GLINK channel, which are used for graceful
> +	  shutdown, retrieving failure information and propagating information
> +	  about other subsystems being shut down.
> +
> +	  Say y here if your system runs firmware on any other subsystems, e.g.
> +	  modem or DSP.
> +
>   config QCOM_WCNSS_PIL
>   	tristate "Qualcomm WCNSS Peripheral Image Loader"
>   	depends on OF && ARCH_QCOM
>   	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>   	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>   	depends on QCOM_SMEM
> +	depends on QCOM_SYSMON || QCOM_SYSMON=n
>   	select QCOM_MDT_LOADER
>   	select QCOM_RPROC_COMMON
>   	select QCOM_SCM
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 6e16450ce11f..02627ede8d4a 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
>   obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
>   obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>   obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
> +obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
>   obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
>   qcom_wcnss_pil-y			+= qcom_wcnss.o
>   qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
> index 3f6af54dbc96..45e7e66604d4 100644
> --- a/drivers/remoteproc/qcom_adsp_pil.c
> +++ b/drivers/remoteproc/qcom_adsp_pil.c
> @@ -38,7 +38,10 @@ struct adsp_data {
>   	const char *firmware_name;
>   	int pas_id;
>   	bool has_aggre2_clk;
> +
>   	const char *ssr_name;
> +	const char *sysmon_name;
> +	int ssctl_id;
>   };
>   
>   struct qcom_adsp {
> @@ -75,6 +78,7 @@ struct qcom_adsp {
>   	struct qcom_rproc_glink glink_subdev;
>   	struct qcom_rproc_subdev smd_subdev;
>   	struct qcom_rproc_ssr ssr_subdev;
> +	struct qcom_sysmon *sysmon;
>   };
>   
>   static int adsp_load(struct rproc *rproc, const struct firmware *fw)
> @@ -404,6 +408,9 @@ static int adsp_probe(struct platform_device *pdev)
>   	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
>   	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
>   	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
> +	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
> +					      desc->sysmon_name,
> +					      desc->ssctl_id);
>   
>   	ret = rproc_add(rproc);
>   	if (ret)
> @@ -425,6 +432,7 @@ static int adsp_remove(struct platform_device *pdev)
>   	rproc_del(adsp->rproc);
>   
>   	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
> +	qcom_remove_sysmon_subdev(adsp->sysmon);
>   	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
>   	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
>   	rproc_free(adsp->rproc);
> @@ -438,6 +446,8 @@ static const struct adsp_data adsp_resource_init = {
>   		.pas_id = 1,
>   		.has_aggre2_clk = false,
>   		.ssr_name = "lpass",
> +		.sysmon_name = "adsp",
> +		.ssctl_id = 0x14,
>   };
>   
>   static const struct adsp_data slpi_resource_init = {
> @@ -446,6 +456,8 @@ static const struct adsp_data slpi_resource_init = {
>   		.pas_id = 12,
>   		.has_aggre2_clk = true,
>   		.ssr_name = "dsps",
> +		.sysmon_name = "slpi",
> +		.ssctl_id = 0x16,
>   };
>   
>   static const struct of_device_id adsp_of_match[] = {
> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index 832e20271664..541586e528b3 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -4,6 +4,9 @@
>   
>   #include <linux/remoteproc.h>
>   #include "remoteproc_internal.h"
> +#include <linux/soc/qcom/qmi.h>
> +
> +struct qcom_sysmon;
>   
>   struct qcom_rproc_glink {
>   	struct rproc_subdev subdev;
> @@ -41,4 +44,22 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
>   			 const char *ssr_name);
>   void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr);
>   
> +#if IS_ENABLED(CONFIG_QCOM_SYSMON)
> +struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
> +					   const char *name,
> +					   int ssctl_instance);
> +void qcom_remove_sysmon_subdev(struct qcom_sysmon *sysmon);
> +#else
> +static inline struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
> +							 const char *name,
> +							 int ssctl_instance)
> +{
> +	return NULL;
> +}
> +
> +static inline void qcom_remove_sysmon_subdev(struct qcom_sysmon *sysmon)
> +{
> +}
> +#endif
> +
>   #endif
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index 8a3fa2bcc9f6..342d5eb5d6ed 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -168,6 +168,7 @@ struct q6v5 {
>   
>   	struct qcom_rproc_subdev smd_subdev;
>   	struct qcom_rproc_ssr ssr_subdev;
> +	struct qcom_sysmon *sysmon;
>   	bool need_mem_protection;
>   	int mpss_perm;
>   	int mba_perm;
> @@ -1231,6 +1232,7 @@ static int q6v5_probe(struct platform_device *pdev)
>   	qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
>   	qcom_add_smd_subdev(rproc, &qproc->smd_subdev);
>   	qcom_add_ssr_subdev(rproc, &qproc->ssr_subdev, "mpss");
> +	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12);
>   
>   	ret = rproc_add(rproc);
>   	if (ret)
> @@ -1250,6 +1252,7 @@ static int q6v5_remove(struct platform_device *pdev)
>   
>   	rproc_del(qproc->rproc);
>   
> +	qcom_remove_sysmon_subdev(qproc->sysmon);
>   	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
>   	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
>   	rproc_free(qproc->rproc);
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> new file mode 100644
> index 000000000000..210914814654
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + */
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/notifier.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc/qcom_rproc.h>
> +#include <linux/rpmsg.h>
> +
> +#include "qcom_common.h"
> +
> +static BLOCKING_NOTIFIER_HEAD(sysmon_notifiers);
> +
> +struct qcom_sysmon {
> +	struct rproc_subdev subdev;
> +	struct rproc *rproc;
> +
> +	struct list_head node;
> +
> +	const char *name;
> +
> +	int ssctl_version;
> +	int ssctl_instance;
> +
> +	struct notifier_block nb;
> +
> +	struct device *dev;
> +
> +	struct rpmsg_endpoint *ept;
> +	struct completion comp;
> +	struct mutex lock;
> +
> +	bool ssr_ack;
> +
> +	struct qmi_handle qmi;
> +	struct sockaddr_qrtr ssctl;
> +};
> +
> +static DEFINE_MUTEX(sysmon_lock);
> +static LIST_HEAD(sysmon_list);
> +
> +/**
> + * sysmon_send_event() - send notification of other remote's SSR event
> + * @sysmon:	sysmon context
> + * @name:	other remote's name
> + */
> +static void sysmon_send_event(struct qcom_sysmon *sysmon, const char *name)
> +{
> +	char req[50];
> +	int len;
> +	int ret;
> +
> +	len = snprintf(req, sizeof(req), "ssr:%s:before_shutdown", name);
> +	if (len >= sizeof(req))
> +		return;
> +
> +	mutex_lock(&sysmon->lock);
> +	reinit_completion(&sysmon->comp);
> +	sysmon->ssr_ack = false;
> +
> +	ret = rpmsg_send(sysmon->ept, req, len);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "failed to send sysmon event\n");
> +		goto out_unlock;
> +	}
> +
> +	ret = wait_for_completion_timeout(&sysmon->comp,
> +					  msecs_to_jiffies(5000));
> +	if (!ret) {
> +		dev_err(sysmon->dev, "timeout waiting for sysmon ack\n");
> +		goto out_unlock;
> +	}
> +
> +	if (!sysmon->ssr_ack)
> +		dev_err(sysmon->dev, "unexpected response to sysmon event\n");
> +
> +out_unlock:
> +	mutex_unlock(&sysmon->lock);
> +}
> +
> +/**
> + * sysmon_request_shutdown() - request graceful shutdown of remote
> + * @sysmon:	sysmon context
> + */
> +static void sysmon_request_shutdown(struct qcom_sysmon *sysmon)
> +{
> +	char *req = "ssr:shutdown";
> +	int ret;
> +
> +	mutex_lock(&sysmon->lock);
> +	reinit_completion(&sysmon->comp);
> +	sysmon->ssr_ack = false;
> +
> +	ret = rpmsg_send(sysmon->ept, req, strlen(req) + 1);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "send sysmon shutdown request failed\n");
> +		goto out_unlock;
> +	}
> +
> +	ret = wait_for_completion_timeout(&sysmon->comp,
> +					  msecs_to_jiffies(5000));
> +	if (!ret) {
> +		dev_err(sysmon->dev, "timeout waiting for sysmon ack\n");
> +		goto out_unlock;
> +	}
> +
> +	if (!sysmon->ssr_ack)
> +		dev_err(sysmon->dev,
> +			"unexpected response to sysmon shutdown request\n");
> +
> +out_unlock:
> +	mutex_unlock(&sysmon->lock);
> +}
> +
> +static int sysmon_callback(struct rpmsg_device *rpdev, void *data, int count,
> +			   void *priv, u32 addr)
> +{
> +	struct qcom_sysmon *sysmon = priv;
> +	const char *ssr_ack = "ssr:ack";
> +	const int ssr_ack_len = strlen(ssr_ack) + 1;
> +
> +	if (!sysmon)
> +		return -EINVAL;
> +
> +	if (count >= ssr_ack_len && !memcmp(data, ssr_ack, ssr_ack_len))
> +		sysmon->ssr_ack = true;
> +
> +	complete(&sysmon->comp);
> +
> +	return 0;
> +}
> +
> +#define SSCTL_SHUTDOWN_REQ		0x21
> +#define SSCTL_SUBSYS_EVENT_REQ		0x23
> +
> +#define SSCTL_MAX_MSG_LEN		7
> +
> +#define SSCTL_SUBSYS_NAME_LENGTH	15
> +
> +enum {
> +	SSCTL_SSR_EVENT_BEFORE_POWERUP,
> +	SSCTL_SSR_EVENT_AFTER_POWERUP,
> +	SSCTL_SSR_EVENT_BEFORE_SHUTDOWN,
> +	SSCTL_SSR_EVENT_AFTER_SHUTDOWN,
> +};
> +
> +enum {
> +	SSCTL_SSR_EVENT_FORCED,
> +	SSCTL_SSR_EVENT_GRACEFUL,
> +};
> +
> +struct ssctl_shutdown_resp {
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +static struct qmi_elem_info ssctl_shutdown_resp_ei[] = {
> +	{
> +		.data_type	= QMI_STRUCT,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(struct qmi_response_type_v01),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x02,
> +		.offset		= offsetof(struct ssctl_shutdown_resp, resp),
> +		.ei_array	= qmi_response_type_v01_ei,
> +	},
> +	{}
> +};
> +
> +struct ssctl_subsys_event_req {
> +	u8 subsys_name_len;
> +	char subsys_name[SSCTL_SUBSYS_NAME_LENGTH];
> +	u32 event;
> +	u8 evt_driven_valid;
> +	u32 evt_driven;
> +};
> +
> +static struct qmi_elem_info ssctl_subsys_event_req_ei[] = {
> +	{
> +		.data_type	= QMI_DATA_LEN,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(uint8_t),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x01,
> +		.offset		= offsetof(struct ssctl_subsys_event_req,
> +					   subsys_name_len),
> +		.ei_array	= NULL,
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_1_BYTE,
> +		.elem_len	= SSCTL_SUBSYS_NAME_LENGTH,
> +		.elem_size	= sizeof(char),
> +		.array_type	= VAR_LEN_ARRAY,
> +		.tlv_type	= 0x01,
> +		.offset		= offsetof(struct ssctl_subsys_event_req,
> +					   subsys_name),
> +		.ei_array	= NULL,
> +	},
> +	{
> +		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(uint32_t),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x02,
> +		.offset		= offsetof(struct ssctl_subsys_event_req,
> +					   event),
> +		.ei_array	= NULL,
> +	},
> +	{
> +		.data_type	= QMI_OPT_FLAG,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(uint8_t),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x10,
> +		.offset		= offsetof(struct ssctl_subsys_event_req,
> +					   evt_driven_valid),
> +		.ei_array	= NULL,
> +	},
> +	{
> +		.data_type	= QMI_SIGNED_4_BYTE_ENUM,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(uint32_t),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x10,
> +		.offset		= offsetof(struct ssctl_subsys_event_req,
> +					   evt_driven),
> +		.ei_array	= NULL,
> +	},
> +	{}
> +};
> +
> +struct ssctl_subsys_event_resp {
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +static struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
> +	{
> +		.data_type	= QMI_STRUCT,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(struct qmi_response_type_v01),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x02,
> +		.offset		= offsetof(struct ssctl_subsys_event_resp,
> +					   resp),
> +		.ei_array	= qmi_response_type_v01_ei,
> +	},
> +	{}
> +};
> +
> +/**
> + * ssctl_request_shutdown() - request shutdown via SSCTL QMI service
> + * @sysmon:	sysmon context
> + */
> +static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
> +{
> +	struct ssctl_shutdown_resp resp;
> +	struct qmi_txn txn;
> +	int ret;
> +
> +	ret = qmi_txn_init(&sysmon->qmi, &txn, ssctl_shutdown_resp_ei, &resp);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "failed to allocate QMI txn\n");
> +		return;
> +	}
> +
> +	ret = qmi_send_request(&sysmon->qmi, &sysmon->ssctl, &txn,
> +			       SSCTL_SHUTDOWN_REQ, 0, NULL, NULL);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "failed to send shutdown request\n");
> +		qmi_txn_cancel(&txn);
> +		return;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, 5 * HZ);
> +	if (ret < 0)
> +		dev_err(sysmon->dev, "failed receiving QMI response\n");
> +	else if (resp.resp.result)
> +		dev_err(sysmon->dev, "shutdown request failed\n");
> +	else
> +		dev_dbg(sysmon->dev, "shutdown request completed\n");
> +}
> +
> +/**
> + * ssctl_send_event() - send notification of other remote's SSR event
> + * @sysmon:	sysmon context
> + * @name:	other remote's name
> + */
> +static void ssctl_send_event(struct qcom_sysmon *sysmon, const char *name)
> +{
> +	struct ssctl_subsys_event_resp resp;
> +	struct ssctl_subsys_event_req req;
> +	struct qmi_txn txn;
> +	int ret;
> +
> +	memset(&resp, 0, sizeof(resp));
> +	ret = qmi_txn_init(&sysmon->qmi, &txn, ssctl_subsys_event_resp_ei, &resp);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "failed to allocate QMI txn\n");
> +		return;
> +	}
> +
> +	memset(&req, 0, sizeof(req));
> +	strlcpy(req.subsys_name, name, sizeof(req.subsys_name));
> +	req.subsys_name_len = strlen(req.subsys_name);
> +	req.event = SSCTL_SSR_EVENT_BEFORE_SHUTDOWN;
> +	req.evt_driven_valid = true;
> +	req.evt_driven = SSCTL_SSR_EVENT_FORCED;
> +
> +	ret = qmi_send_request(&sysmon->qmi, &sysmon->ssctl, &txn,
> +			       SSCTL_SUBSYS_EVENT_REQ, 40,
> +			       ssctl_subsys_event_req_ei, &req);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "failed to send shutdown request\n");
> +		qmi_txn_cancel(&txn);
> +		return;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, 5 * HZ);
> +	if (ret < 0)
> +		dev_err(sysmon->dev, "failed receiving QMI response\n");
> +	else if (resp.resp.result)
> +		dev_err(sysmon->dev, "ssr event send failed\n");
> +	else
> +		dev_dbg(sysmon->dev, "ssr event send completed\n");
> +}
> +
> +/**
> + * ssctl_new_server() - QMI callback indicating a new service
> + * @qmi:	QMI handle
> + * @svc:	service information
> + *
> + * Return: 0 if we're interested in this service, -EINVAL otherwise.
> + */
> +static int ssctl_new_server(struct qmi_handle *qmi, struct qmi_service *svc)
> +{
> +	struct qcom_sysmon *sysmon = container_of(qmi, struct qcom_sysmon, qmi);
> +
> +	switch (svc->version) {
> +	case 1:
> +		if (svc->instance != 0)
> +			return -EINVAL;
> +		if (strcmp(sysmon->name, "modem"))
> +			return -EINVAL;
> +		break;
> +	case 2:
> +		if (svc->instance != sysmon->ssctl_instance)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	sysmon->ssctl_version = svc->version;
> +
> +	sysmon->ssctl.sq_family = AF_QIPCRTR;
> +	sysmon->ssctl.sq_node = svc->node;
> +	sysmon->ssctl.sq_port = svc->port;
> +
> +	svc->priv = sysmon;
> +
> +	return 0;
> +}
> +
> +/**
> + * ssctl_del_server() - QMI callback indicating that @svc is removed
> + * @qmi:	QMI handle
> + * @svc:	service information
> + */
> +static void ssctl_del_server(struct qmi_handle *qmi, struct qmi_service *svc)
> +{
> +	struct qcom_sysmon *sysmon = svc->priv;
> +
> +	sysmon->ssctl_version = 0;
> +}
> +
> +static const struct qmi_ops ssctl_ops = {
> +	.new_server = ssctl_new_server,
> +	.del_server = ssctl_del_server,
> +};
> +
> +static int sysmon_start(struct rproc_subdev *subdev)
> +{
> +	return 0;
> +}
> +
> +static void sysmon_stop(struct rproc_subdev *subdev, bool graceful)
> +{
> +	struct qcom_sysmon *sysmon = container_of(subdev, struct qcom_sysmon, subdev);
> +
> +	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)sysmon->name);
> +
> +	/* Don't request graceful shutdown if we've crashed */
> +	if (!graceful)
> +		return;
> +
> +	if (sysmon->ssctl_version)
> +		ssctl_request_shutdown(sysmon);
> +	else if (sysmon->ept)
> +		sysmon_request_shutdown(sysmon);
> +}
> +
> +/**
> + * sysmon_notify() - notify sysmon target of another's SSR
> + * @nb:		notifier_block associated with sysmon instance
> + * @event:	unused
> + * @data:	SSR identifier of the remote that is going down
> + */
> +static int sysmon_notify(struct notifier_block *nb, unsigned long event,
> +			 void *data)
> +{
> +	struct qcom_sysmon *sysmon = container_of(nb, struct qcom_sysmon, nb);
> +	struct rproc *rproc = sysmon->rproc;
> +	const char *ssr_name = data;
> +
> +	/* Skip non-running rprocs and the originating instance */
> +	if (rproc->state != RPROC_RUNNING || !strcmp(data, sysmon->name)) {
> +		dev_dbg(sysmon->dev, "not notifying %s\n", sysmon->name);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Only SSCTL version 2 supports SSR events */
> +	if (sysmon->ssctl_version == 2)
> +		ssctl_send_event(sysmon, ssr_name);
> +	else if (sysmon->ept)
> +		sysmon_send_event(sysmon, ssr_name);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/**
> + * qcom_add_sysmon_subdev() - create a sysmon subdev for the given remoteproc
> + * @rproc:	rproc context to associate the subdev with
> + * @name:	name of this subdev, to use in SSR
> + * @ssctl_instance: instance id of the ssctl QMI service
> + *
> + * Return: A new qcom_sysmon object, or NULL on failure
> + */
> +struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
> +					   const char *name,
> +					   int ssctl_instance)
> +{
> +	struct qcom_sysmon *sysmon;
> +	int ret;
> +
> +	sysmon = kzalloc(sizeof(*sysmon), GFP_KERNEL);
> +	if (!sysmon)
> +		return NULL;
> +
> +	sysmon->dev = rproc->dev.parent;
> +	sysmon->rproc = rproc;
> +
> +	sysmon->name = name;
> +	sysmon->ssctl_instance = ssctl_instance;
> +
> +	init_completion(&sysmon->comp);
> +	mutex_init(&sysmon->lock);
> +
> +	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops, NULL);
> +	if (ret < 0) {
> +		dev_err(sysmon->dev, "failed to initialize qmi handle\n");
> +		kfree(sysmon);
> +		return NULL;
> +	}
> +
> +	qmi_add_lookup(&sysmon->qmi, 43, 0, 0);
> +
> +	rproc_add_subdev(rproc, &sysmon->subdev, sysmon_start, sysmon_stop);
> +
> +	sysmon->nb.notifier_call = sysmon_notify;
> +	blocking_notifier_chain_register(&sysmon_notifiers, &sysmon->nb);
> +
> +	mutex_lock(&sysmon_lock);
> +	list_add(&sysmon->node, &sysmon_list);
> +	mutex_unlock(&sysmon_lock);
> +
> +	return sysmon;
> +}
> +EXPORT_SYMBOL_GPL(qcom_add_sysmon_subdev);
> +
> +/**
> + * qcom_remove_sysmon_subdev() - release a qcom_sysmon
> + * @sysmon:	sysmon context, as retrieved by qcom_add_sysmon_subdev()
> + */
> +void qcom_remove_sysmon_subdev(struct qcom_sysmon *sysmon)
> +{
> +	if (!sysmon)
> +		return;
> +
> +	mutex_lock(&sysmon_lock);
> +	list_del(&sysmon->node);
> +	mutex_unlock(&sysmon_lock);
> +
> +	blocking_notifier_chain_unregister(&sysmon_notifiers, &sysmon->nb);
> +
> +	rproc_remove_subdev(sysmon->rproc, &sysmon->subdev);
> +
> +	qmi_handle_release(&sysmon->qmi);
> +
> +	kfree(sysmon);
> +}
> +EXPORT_SYMBOL_GPL(qcom_remove_sysmon_subdev);
> +
> +/**
> + * sysmon_probe() - probe sys_mon channel
> + * @rpdev:	rpmsg device handle
> + *
> + * Find the sysmon context associated with the ancestor remoteproc and assign
> + * this rpmsg device with said sysmon context.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int sysmon_probe(struct rpmsg_device *rpdev)
> +{
> +	struct qcom_sysmon *sysmon;
> +	struct rproc *rproc;
> +
> +	rproc = rproc_get_by_child(&rpdev->dev);
> +	if (!rproc) {
> +		dev_err(&rpdev->dev, "sysmon device not child of rproc\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&sysmon_lock);
> +	list_for_each_entry(sysmon, &sysmon_list, node) {
> +		if (sysmon->rproc == rproc)
> +			goto found;
> +	}
> +	mutex_unlock(&sysmon_lock);
> +
> +	dev_err(&rpdev->dev, "no sysmon associated with parent rproc\n");
> +
> +	return -EINVAL;
> +
> +found:
> +	mutex_unlock(&sysmon_lock);
> +
> +	rpdev->ept->priv = sysmon;
> +	sysmon->ept = rpdev->ept;
> +
> +	return 0;
> +}
> +
> +/**
> + * sysmon_remove() - sys_mon channel remove handler
> + * @rpdev:	rpmsg device handle
> + *
> + * Disassociate the rpmsg device with the sysmon instance.
> + */
> +static void sysmon_remove(struct rpmsg_device *rpdev)
> +{
> +	struct qcom_sysmon *sysmon = rpdev->ept->priv;
> +
> +	sysmon->ept = NULL;
> +}
> +
> +static const struct rpmsg_device_id sysmon_match[] = {
> +	{ "sys_mon" },
> +	{}
> +};
> +
> +static struct rpmsg_driver sysmon_driver = {
> +	.probe = sysmon_probe,
> +	.remove = sysmon_remove,
> +	.callback = sysmon_callback,
> +	.id_table = sysmon_match,
> +	.drv = {
> +		.name = "qcom_sysmon",
> +	},
> +};
> +
> +module_rpmsg_driver(sysmon_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm sysmon driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index c7686393d505..dc79239c43f9 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -40,6 +40,7 @@
>   #define WCNSS_CRASH_REASON_SMEM		422
>   #define WCNSS_FIRMWARE_NAME		"wcnss.mdt"
>   #define WCNSS_PAS_ID			6
> +#define WCNSS_SSCTL_ID			0x13
>   
>   #define WCNSS_SPARE_NVBIN_DLND		BIT(25)
>   
> @@ -98,6 +99,7 @@ struct qcom_wcnss {
>   	size_t mem_size;
>   
>   	struct qcom_rproc_subdev smd_subdev;
> +	struct qcom_sysmon *sysmon;
>   };
>   
>   static const struct wcnss_data riva_data = {
> @@ -557,6 +559,7 @@ static int wcnss_probe(struct platform_device *pdev)
>   	}
>   
>   	qcom_add_smd_subdev(rproc, &wcnss->smd_subdev);
> +	wcnss->sysmon = qcom_add_sysmon_subdev(rproc, "wcnss", WCNSS_SSCTL_ID);
>   
>   	ret = rproc_add(rproc);
>   	if (ret)
> @@ -579,6 +582,7 @@ static int wcnss_remove(struct platform_device *pdev)
>   	qcom_smem_state_put(wcnss->state);
>   	rproc_del(wcnss->rproc);
>   
> +	qcom_remove_sysmon_subdev(wcnss->sysmon);
>   	qcom_remove_smd_subdev(wcnss->rproc, &wcnss->smd_subdev);
>   	rproc_free(wcnss->rproc);
>   
Is this patch approved? And is expected to come in next kernel 
releases.. As for sending remote processor notification to other client 
drivers, this might be needed
