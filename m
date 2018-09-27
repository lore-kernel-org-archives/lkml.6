Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37940C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE12821564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbZniIcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE12821564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeI0X1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:27:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35086 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0X1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:27:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so2428927pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vKGPIxqgacOa94qwSx7BPL0/0l+95a3GRnNZnbNJLNg=;
        b=bbZniIcvbOJBPgtRuaGPJ/pSIOOmOVoKrFXPJ1t5/qO7qomgkASRPh4HixM0SCMLmn
         cXmQwgYR2bWtHdmJPRHcFU3sD+1SlHObstpgAQogeqnaJ6GU2k0RIOQwFeLot0NI7pVN
         Z9vLQrzDqORpWdp6pxdBJOG3ib4X8qgbi/w78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKGPIxqgacOa94qwSx7BPL0/0l+95a3GRnNZnbNJLNg=;
        b=j32niCa62lVyD4wsaRiqsUknXFpxcj/OG0NcT7RstPuLfsF6uwoTNRHYooLcfZgvRL
         74ww+RhLucxDCzbwN16zQUuw0K8BsMbS4VHWnBI/GHCjHKMkKhWyKsvUpCy8A/l+j35u
         1TMhYOaYRfqe3B/s0mN6CqsF050evNHNCZWA9i/Hgx7zjBAy7HW4bRGBKJghWzT6nOyS
         0KdMur0HZW7zLtEGBlTSfVSgLbBPvPogmwlmBezUDrWc4LZUio7LCxIClH2YjXZuvN0D
         U0DNwI7wM+67kmzAqpDJwBjAySXwSyLxnSGLVHDGzQxags9OFpwKvgnDylxrtTr5NDFl
         vA3A==
X-Gm-Message-State: ABuFfohm2hyI88sdptXTsIewUoQqTNA4YGHCTCwx3eW6nzelxrduKWJQ
        gTD/w+izXLZGlVkrCMm+XzngBw==
X-Google-Smtp-Source: ACcGV63w1LgMcfQn7ncZB23ATaFOedPIspbmgWEgfQRFN/9pLdteugWdB04g3SxG91UhA74jPyv3ow==
X-Received: by 2002:a17:902:7c83:: with SMTP id y3-v6mr4645053pll.330.1538068114553;
        Thu, 27 Sep 2018 10:08:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15-v6sm4617046pfh.30.2018.09.27.10.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:08:33 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:08:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 08/16] stm class: Add MIPI SyS-T protocol
 support
Message-ID: <20180927170831.GD7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
 <20180920124553.56978-9-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920124553.56978-9-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:45:45PM +0300, Alexander Shishkin wrote:
> This adds support for MIPI SyS-T protocol as specified in an open
> standard [1]. In additional to marking message boundaries, it also

s/additional/addition

> supports tagging messages with the source UUID, to provide better
> distinction between trace sources, including payload length and
> timestamp in the message's metadata.
> 
> This driver adds attributes to STP policy nodes to control/configure
> these metadata features.
> 
> [1] https://www.mipi.org/specifications/sys-t
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/stm/Kconfig   |  14 ++
>  drivers/hwtracing/stm/Makefile  |   2 +
>  drivers/hwtracing/stm/p_sys-t.c | 301 ++++++++++++++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 drivers/hwtracing/stm/p_sys-t.c
> 
> diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
> index 262e7891fb97..752dd66742bf 100644
> --- a/drivers/hwtracing/stm/Kconfig
> +++ b/drivers/hwtracing/stm/Kconfig
> @@ -26,6 +26,20 @@ config STM_PROTO_BASIC
>  	  If you want to be able to use the basic protocol or want the
>  	  backwards compatibility for your existing setup, say Y.
>  
> +config STM_PROTO_SYS_T
> +	tristate "MIPI SyS-T STM framing protocol driver"
> +	default CONFIG_STM
> +	help
> +	  This is an implementation of MIPI SyS-T protocol to be used
> +	  over the STP transport. In addition to the data payload, it
> +	  also carries additional metadata for time correlation, better
> +	  means of trace source identification, etc.
> +
> +	  The receiving side must be able to decode this protocol in
> +	  addition to the MIPI STP, in order to extract the data.
> +
> +	  If you don't know what this is, say N.
> +
>  config STM_DUMMY
>  	tristate "Dummy STM driver"
>  	help
> diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
> index 1571de66eca4..1692fcd29277 100644
> --- a/drivers/hwtracing/stm/Makefile
> +++ b/drivers/hwtracing/stm/Makefile
> @@ -4,8 +4,10 @@ obj-$(CONFIG_STM)	+= stm_core.o
>  stm_core-y		:= core.o policy.o
>  
>  obj-$(CONFIG_STM_PROTO_BASIC) += stm_p_basic.o
> +obj-$(CONFIG_STM_PROTO_SYS_T) += stm_p_sys-t.o
>  
>  stm_p_basic-y		:= p_basic.o
> +stm_p_sys-t-y		:= p_sys-t.o
>  
>  obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
>  
> diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
> new file mode 100644
> index 000000000000..8f3066ff1b7b
> --- /dev/null
> +++ b/drivers/hwtracing/stm/p_sys-t.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MIPI SyS-T framing protocol for STM devices.
> + * Copyright (c) 2018, Intel Corporation.
> + */
> +
> +#include <linux/configfs.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/uuid.h>
> +#include <linux/stm.h>
> +#include "stm.h"
> +
> +enum sys_t_message_type {
> +	MIPI_SYST_TYPE_BUILD	= 0,
> +	MIPI_SYST_TYPE_SHORT32,
> +	MIPI_SYST_TYPE_STRING,
> +	MIPI_SYST_TYPE_CATALOG,
> +	MIPI_SYST_TYPE_RAW	= 6,
> +	MIPI_SYST_TYPE_SHORT64,
> +	MIPI_SYST_TYPE_CLOCK,
> +};
> +
> +enum sys_t_message_severity {
> +	MIPI_SYST_SEVERITY_MAX	= 0,
> +	MIPI_SYST_SEVERITY_FATAL,
> +	MIPI_SYST_SEVERITY_ERROR,
> +	MIPI_SYST_SEVERITY_WARNING,
> +	MIPI_SYST_SEVERITY_INFO,
> +	MIPI_SYST_SEVERITY_USER1,
> +	MIPI_SYST_SEVERITY_USER2,
> +	MIPI_SYST_SEVERITY_DEBUG,
> +};
> +
> +enum sys_t_message_build_subtype {
> +	MIPI_SYST_BUILD_ID_COMPACT32 = 0,
> +	MIPI_SYST_BUILD_ID_COMPACT64,
> +	MIPI_SYST_BUILD_ID_LONG,
> +};
> +
> +enum sys_t_message_clock_subtype {
> +	MIPI_SYST_CLOCK_TRANSPORT_SYNC = 1,
> +};
> +
> +enum sys_t_message_string_subtype {
> +	MIPI_SYST_STRING_GENERIC	= 1,
> +	MIPI_SYST_STRING_FUNCTIONENTER,
> +	MIPI_SYST_STRING_FUNCTIONEXIT,
> +	MIPI_SYST_STRING_INVALIDPARAM	= 5,
> +	MIPI_SYST_STRING_ASSERT		= 7,
> +	MIPI_SYST_STRING_PRINTF_32	= 11,
> +	MIPI_SYST_STRING_PRINTF_64	= 12,
> +};
> +
> +#define MIPI_SYST_TYPE(t)		((u32)(MIPI_SYST_TYPE_ ## t))
> +#define MIPI_SYST_SEVERITY(s)		((u32)(MIPI_SYST_SEVERITY_ ## s) << 4)
> +#define MIPI_SYST_OPT_LOC		BIT(8)
> +#define MIPI_SYST_OPT_LEN		BIT(9)
> +#define MIPI_SYST_OPT_CHK		BIT(10)
> +#define MIPI_SYST_OPT_TS		BIT(11)
> +#define MIPI_SYST_UNIT(u)		((u32)(u) << 12)
> +#define MIPI_SYST_ORIGIN(o)		((u32)(o) << 16)
> +#define MIPI_SYST_OPT_GUID		BIT(23)
> +#define MIPI_SYST_SUBTYPE(s)		((u32)(MIPI_SYST_ ## s) << 24)
> +#define MIPI_SYST_UNITLARGE(u)		(MIPI_SYST_UNIT(u & 0xf) | \
> +					 MIPI_SYST_ORIGIN(u >> 4))
> +#define MIPI_SYST_TYPES(t, s)		(MIPI_SYST_TYPE(t) | \
> +					 MIPI_SYST_SUBTYPE(t ## _ ## s))
> +
> +#define DATA_HEADER	(MIPI_SYST_TYPES(STRING, GENERIC)	| \
> +			 MIPI_SYST_SEVERITY(INFO)		| \
> +			 MIPI_SYST_OPT_GUID)
> +
> +struct sys_t_policy_node {
> +	uuid_t		uuid;
> +	bool		do_len;
> +	unsigned long	ts_interval;
> +};
> +
> +struct sys_t_output {
> +	struct sys_t_policy_node	node;
> +	unsigned long	ts_jiffies;
> +};
> +
> +static void sys_t_policy_node_init(void *priv)
> +{
> +	struct sys_t_policy_node *pn = priv;
> +
> +	generate_random_uuid(pn->uuid.b);
> +}
> +
> +static int sys_t_output_open(void *priv, struct stm_output *output)
> +{
> +	struct sys_t_policy_node *pn = priv;
> +	struct sys_t_output *opriv;
> +
> +	opriv = kzalloc(sizeof(*opriv), GFP_ATOMIC);
> +	if (!opriv)
> +		return -ENOMEM;
> +
> +	memcpy(&opriv->node, pn, sizeof(opriv->node));
> +	output->pdrv_private = opriv;
> +
> +	return 0;
> +}
> +
> +static void sys_t_output_close(struct stm_output *output)
> +{
> +	kfree(output->pdrv_private);
> +}
> +
> +static ssize_t sys_t_policy_uuid_show(struct config_item *item,
> +				      char *page)
> +{
> +	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
> +
> +	return sprintf(page, "%pU\n", &pn->uuid);
> +}
> +
> +static ssize_t
> +sys_t_policy_uuid_store(struct config_item *item, const char *page,
> +			size_t count)
> +{
> +	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
> +	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
> +	int ret;
> +
> +	mutex_lock(mutexp);
> +	ret = uuid_parse(page, &pn->uuid);
> +	mutex_unlock(mutexp);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
> +CONFIGFS_ATTR(sys_t_policy_, uuid);
> +
> +static ssize_t sys_t_policy_do_len_show(struct config_item *item,
> +				      char *page)
> +{
> +	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
> +
> +	return sprintf(page, "%d\n", pn->do_len);
> +}
> +
> +static ssize_t
> +sys_t_policy_do_len_store(struct config_item *item, const char *page,
> +			size_t count)
> +{
> +	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
> +	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
> +	int ret;
> +
> +	mutex_lock(mutexp);
> +	ret = kstrtobool(page, &pn->do_len);
> +	mutex_unlock(mutexp);
> +
> +	return ret ? ret : count;
> +}
> +
> +CONFIGFS_ATTR(sys_t_policy_, do_len);
> +
> +static ssize_t sys_t_policy_ts_interval_show(struct config_item *item,
> +					     char *page)
> +{
> +	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
> +
> +	return sprintf(page, "%u\n", jiffies_to_msecs(pn->ts_interval));
> +}
> +
> +static ssize_t
> +sys_t_policy_ts_interval_store(struct config_item *item, const char *page,
> +			       size_t count)
> +{
> +	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
> +	struct sys_t_policy_node *pn = to_pdrv_policy_node(item);
> +	unsigned int ms;
> +	int ret;
> +
> +	mutex_lock(mutexp);
> +	ret = kstrtouint(page, 10, &ms);
> +	mutex_unlock(mutexp);
> +
> +	if (!ret) {
> +		pn->ts_interval = msecs_to_jiffies(ms);
> +		return count;
> +	}
> +
> +	return ret;
> +}
> +
> +CONFIGFS_ATTR(sys_t_policy_, ts_interval);
> +
> +static struct configfs_attribute *sys_t_policy_attrs[] = {
> +	&sys_t_policy_attr_uuid,
> +	&sys_t_policy_attr_do_len,
> +	&sys_t_policy_attr_ts_interval,
> +	NULL,
> +};
> +
> +static inline bool sys_t_need_ts(struct sys_t_output *op)
> +{
> +	if (op->node.ts_interval &&
> +	    time_after(op->ts_jiffies + op->node.ts_interval, jiffies)) {
> +		op->ts_jiffies = jiffies;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
> +			   unsigned int chan, const char *buf, size_t count)
> +{
> +	struct sys_t_output *op = output->pdrv_private;
> +	unsigned int c = output->channel + chan;
> +	unsigned int m = output->master;
> +	u32 header = DATA_HEADER;
> +	ssize_t sz;
> +
> +	/* We require an existing policy node to proceed */
> +	if (!op)
> +		return -EINVAL;
> +
> +	if (op->node.do_len)
> +		header |= MIPI_SYST_OPT_LEN;
> +	if (sys_t_need_ts(op))
> +		header |= MIPI_SYST_OPT_TS;
> +
> +	/*
> +	 * STP framing rules for SyS-T frames:
> +	 *   * the first packet of the SyS-T frame is timestamped;
> +	 *   * the last packet is a FLAG.
> +	 */
> +	/* Message layout: HEADER / GUID / [LENGTH /][TIMESTAMP /] DATA */
> +	/* HEADER */
> +	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_TIMESTAMPED,
> +			  4, (u8 *)&header);
> +	if (sz <= 0)
> +		return sz;
> +
> +	/* GUID */
> +	sz = stm_data_write(data, m, c, false, op->node.uuid.b, UUID_SIZE);
> +	if (sz <= 0)
> +		return sz;
> +
> +	/* [LENGTH] */
> +	if (op->node.do_len) {
> +		u16 length = count;
> +
> +		sz = data->packet(data, m, c, STP_PACKET_DATA, 0, 2,
> +				  (u8 *)&length);
> +		if (sz <= 0)
> +			return sz;
> +	}
> +
> +	/* [TIMESTAMP] */
> +	if (header & MIPI_SYST_OPT_TS) {
> +		u64 ts = ktime_get_real_ns();
> +
> +		sz = stm_data_write(data, m, c, false, &ts, sizeof(ts));
> +		if (sz <= 0)
> +			return sz;
> +	}
> +
> +	/* DATA */
> +	sz = stm_data_write(data, m, c, false, buf, count);
> +	if (sz > 0)
> +		data->packet(data, m, c, STP_PACKET_FLAG, 0, 0, buf);
> +
> +	return sz;
> +}
> +
> +static const struct stm_protocol_driver sys_t_pdrv = {
> +	.owner			= THIS_MODULE,
> +	.name			= "p_sys-t",
> +	.priv_sz		= sizeof(struct sys_t_policy_node),
> +	.write			= sys_t_write,
> +	.policy_attr		= sys_t_policy_attrs,
> +	.policy_node_init	= sys_t_policy_node_init,
> +	.output_open		= sys_t_output_open,
> +	.output_close		= sys_t_output_close,
> +};
> +
> +static int sys_t_stm_init(void)
> +{
> +	return stm_register_protocol(&sys_t_pdrv);
> +}
> +
> +static void sys_t_stm_exit(void)
> +{
> +	stm_unregister_protocol(&sys_t_pdrv);
> +}
> +
> +module_init(sys_t_stm_init);
> +module_exit(sys_t_stm_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MIPI SyS-T STM framing protocol driver");
> +MODULE_AUTHOR("Alexander Shishkin <alexander.shishkin@linux.intel.com>");
> -- 
> 2.18.0
> 
