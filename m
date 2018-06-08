Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KospNsmMGltTOwAAmS7hNA
	; Fri, 08 Jun 2018 14:04:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98909607E4; Fri,  8 Jun 2018 14:04:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 26CA660290;
	Fri,  8 Jun 2018 14:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26CA660290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeFHOE0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:04:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:1081 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeFHOEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:04:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 07:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62422209"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Jun 2018 07:04:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Jun 2018 17:04:20 +0300
Date: Fri, 8 Jun 2018 17:04:20 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 6/8] usb: typec: Add driver for DisplayPort
 alternate mode
Message-ID: <20180608140420.GE17155@kuha.fi.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-7-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608112941.26332-7-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:29:39PM +0300, Heikki Krogerus wrote:
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> new file mode 100644
> index 000000000000..a5054d86a4d9
> --- /dev/null
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * USB Typec-C DisplayPort Alternate Mode driver
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + *
> + * DisplayPort is trademark of VESA (www.vesa.org)
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_dp.h>
> +
> +#define DP_HEADER(cmd)			(VDO(USB_TYPEC_DP_SID, 1, cmd) | \
> +					 VDO_OPOS(USB_TYPEC_DP_MODE))
> +
> +/* DisplayPort alt mode specific commands */
> +#define DP_CMD_STATUS_UPDATE		VDO_CMD_VENDOR(0)
> +#define DP_CMD_CONFIGURE		VDO_CMD_VENDOR(1)
> +
> +enum {
> +	DP_CONF_USB,
> +	DP_CONF_DFP_D,
> +	DP_CONF_UFP_D,
> +	DP_CONF_DUAL_D,
> +};
> +
> +/* DisplayPort Capabilities VDO bits */
> +#define DP_CAP_CAPABILITY(_cap_)	((_cap_) & 3)
> +#define   DP_CAP_UFP_D			1
> +#define   DP_CAP_DFP_D			2
> +#define   DP_CAP_DFP_D_AND_UFP_D	3
> +#define DP_CAP_DP_SIGNALING		BIT(2) /* Always set */
> +#define DP_CAP_GEN2			BIT(3) /* Reserved after v1.0b */
> +#define DP_CAP_RECEPTACLE		BIT(6)
> +#define DP_CAP_USB			BIT(7)
> +#define DP_CAP_DFP_D_PIN_ASSIGN(_cap_)	(((_cap_) & GENMASK(15, 8)) >> 8)
> +#define DP_CAP_UFP_D_PIN_ASSIGN(_cap_)	(((_cap_) & GENMASK(23, 16)) >> 16)
> +
> +enum {
> +	DP_PIN_ASSIGN_A, /* Not supported after v1.0b */
> +	DP_PIN_ASSIGN_B, /* Not supported after v1.0b */
> +	DP_PIN_ASSIGN_C,
> +	DP_PIN_ASSIGN_D,
> +	DP_PIN_ASSIGN_E,
> +	DP_PIN_ASSIGN_F, /* Not supported after v1.0b */
> +};
> +
> +/* Helper for setting/getting the pin assignement value to the configuration */
> +#define DP_CONF_SET_PIN_ASSIGN(_a_)	((_a_) << 8)
> +#define DP_CONF_GET_PIN_ASSIGN(_conf_)	(((_conf_) & GENMASK(15, 8)) >> 8)
> +
> +/* Pin assignments that use USB3.1 Gen2 signaling to carry DP protocol */
> +#define DP_PIN_ASSIGN_GEN2_BR_MASK	(BIT(DP_PIN_ASSIGN_A) | \
> +					 BIT(DP_PIN_ASSIGN_B))
> +
> +/* Pin assignments that use DP v1.3 signaling to carry DP protocol */
> +#define DP_PIN_ASSIGN_DP_BR_MASK	(BIT(DP_PIN_ASSIGN_C) | \
> +					 BIT(DP_PIN_ASSIGN_D) | \
> +					 BIT(DP_PIN_ASSIGN_E) | \
> +					 BIT(DP_PIN_ASSIGN_F))
> +
> +/* DP only pin assignments */
> +#define DP_PIN_ASSIGN_DP_ONLY_MASK	(BIT(DP_PIN_ASSIGN_A) | \
> +					 BIT(DP_PIN_ASSIGN_C) | \
> +					 BIT(DP_PIN_ASSIGN_E))
> +
> +/* Pin assignments where one channel is for USB */
> +#define DP_PIN_ASSIGN_MULTI_FUNC_MASK	(BIT(DP_PIN_ASSIGN_B) | \
> +					 BIT(DP_PIN_ASSIGN_D) | \
> +					 BIT(DP_PIN_ASSIGN_F))
> +
> +enum dp_state {
> +	DP_STATE_NONE,
> +	DP_STATE_ENTER,
> +	DP_STATE_UPDATE,
> +	DP_STATE_CONFIGURE,
> +	DP_STATE_EXIT,
> +};
> +
> +struct dp_altmode {
> +	struct typec_displayport_data data;
> +
> +	enum dp_state state;
> +
> +	struct mutex lock;
> +	struct work_struct work;
> +	struct typec_altmode *alt;
> +	const struct typec_altmode *port;
> +};
> +
> +static int dp_altmode_configure(struct dp_altmode *dp, u8 con)
> +{
> +	u32 conf = DP_CONF_SIGNALING_DP; /* Only DP signaling supported */
> +	u8 pin_assign = 0;
> +
> +	switch (con) {
> +	case DP_STATUS_CON_DISABLED:
> +		dp->data.conf = 0;
> +		return 0;
> +	case DP_STATUS_CON_DFP_D:
> +		conf |= DP_CONF_UFP_U_AS_DFP_D;
> +		pin_assign = DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo) &
> +			     DP_CAP_DFP_D_PIN_ASSIGN(dp->port->vdo);
> +		break;
> +	case DP_STATUS_CON_UFP_D:
> +	case DP_STATUS_CON_BOTH: /* NOTE: First acting as DP source */
> +		conf |= DP_CONF_UFP_U_AS_UFP_D;
> +		pin_assign = DP_CAP_DFP_D_PIN_ASSIGN(dp->alt->vdo) &
> +			     DP_CAP_UFP_D_PIN_ASSIGN(dp->port->vdo);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* Determining the initial pin assignment. */
> +	if (!DP_CONF_GET_PIN_ASSIGN(dp->data.conf)) {
> +		/* Is USB together with DP preferred */
> +		if (dp->data.status & DP_STATUS_PREFER_MULTI_FUNC &&
> +		    pin_assign & DP_PIN_ASSIGN_MULTI_FUNC_MASK)
> +			pin_assign &= DP_PIN_ASSIGN_MULTI_FUNC_MASK;
> +		else
> +			pin_assign &= DP_PIN_ASSIGN_DP_ONLY_MASK;
> +
> +		if (!pin_assign)
> +			return -EINVAL;
> +
> +		conf |= DP_CONF_SET_PIN_ASSIGN(pin_assign);
> +	}
> +
> +	dp->data.conf |= conf;
> +
> +	return 0;
> +}
> +
> +static int dp_altmode_status_update(struct dp_altmode *dp)
> +{
> +	bool configured = !!DP_CONF_GET_PIN_ASSIGN(dp->data.conf);
> +	u8 con = DP_STATUS_CONNECTION(dp->data.status);
> +	int ret = 0;
> +
> +	if (configured && (dp->data.status & DP_STATUS_SWITCH_TO_USB)) {
> +		dp->data.conf = 0;
> +		dp->state = DP_STATE_CONFIGURE;
> +	} else if (dp->data.status & DP_STATUS_EXIT_DP_MODE) {
> +		dp->state = DP_STATE_EXIT;
> +	} else if (!(con & DP_CONF_CURRENTLY(dp->data.conf))) {
> +		ret = dp_altmode_configure(dp, con);
> +		if (!ret)
> +			dp->state = DP_STATE_CONFIGURE;
> +	}
> +
> +	return ret;
> +}
> +
> +static int dp_altmode_configured(struct dp_altmode *dp)
> +{
> +	u8 state;
> +	int ret;
> +
> +	sysfs_notify(&dp->alt->dev.kobj, "displayport", "configuration");
> +
> +	if (!dp->data.conf)
> +		return typec_altmode_notify(dp->alt, TYPEC_STATE_USB,
> +					    &dp->data);
> +
> +	state = get_count_order(DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
> +	ret = typec_altmode_notify(dp->alt, TYPEC_MODAL_STATE(state),
> +				   &dp->data);
> +	if (ret)
> +		return ret;
> +
> +	sysfs_notify(&dp->alt->dev.kobj, "displayport", "pin_assignment");
> +
> +	return 0;
> +}
> +
> +static void dp_altmode_work(struct work_struct *work)
> +{
> +	struct dp_altmode *dp = container_of(work, struct dp_altmode, work);
> +	u32 header = 0;
> +	u32 vdo;
> +	int ret;
> +
> +	mutex_lock(&dp->lock);
> +
> +	switch (dp->state) {
> +	case DP_STATE_ENTER:
> +		ret = typec_altmode_enter(dp->alt);
> +		if (ret)
> +			dev_err(&dp->alt->dev, "failed to enter mode\n");
> +		break;
> +	case DP_STATE_UPDATE:
> +		header = DP_HEADER(DP_CMD_STATUS_UPDATE);
> +		vdo = 1;
> +		break;
> +	case DP_STATE_CONFIGURE:
> +		ret = typec_altmode_notify(dp->alt, TYPEC_STATE_SAFE,
> +					   &dp->data);
> +		if (ret) {
> +			dev_err(&dp->alt->dev,
> +				"unable to put to connector to safe mode\n");
> +			break;
> +		}
> +		header = DP_HEADER(DP_CMD_CONFIGURE);
> +		vdo = dp->data.conf;
> +		break;
> +	case DP_STATE_EXIT:
> +		if (typec_altmode_exit(dp->alt))
> +			dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (header) {
> +		if (typec_altmode_vdm(dp->alt, header, &vdo, 2))
> +			dev_err(&dp->alt->dev, "unable to send VDM\n");
> +	}
> +
> +	mutex_unlock(&dp->lock);
> +}

FYI. Currently this little state machine is horribly racy. It needs to
be fixed.

> +static void dp_altmode_attention(struct typec_altmode *alt, const u32 vdo)
> +{
> +	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
> +	u8 state;
> +
> +	mutex_lock(&dp->lock);
> +
> +	dp->state = DP_STATE_NONE;
> +	dp->data.status = vdo;
> +	dp_altmode_status_update(dp);
> +
> +	if (dp->state == DP_STATE_NONE) {
> +		state = get_count_order(DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
> +		if (typec_altmode_notify(dp->alt, TYPEC_MODAL_STATE(state),
> +					 &dp->data))
> +			dev_err(&alt->dev, "%s: notification failed\n",
> +				__func__);
> +	} else {
> +		schedule_work(&dp->work);
> +	}
> +
> +	mutex_unlock(&dp->lock);
> +}
> +
> +static int dp_altmode_vdm(struct typec_altmode *alt,
> +			  const u32 hdr, const u32 *vdo, int count)
> +{
> +	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
> +	int cmd_type = PD_VDO_CMDT(hdr);
> +	int cmd = PD_VDO_CMD(hdr);
> +	int ret = 0;
> +
> +	mutex_lock(&dp->lock);
> +
> +	dp->state = DP_STATE_NONE;
> +
> +	switch (cmd_type) {
> +	case CMDT_RSP_ACK:
> +		switch (cmd) {
> +		case CMD_ENTER_MODE:
> +			dp->state = DP_STATE_UPDATE;
> +			break;
> +		case CMD_EXIT_MODE:
> +			dp->data.status = 0;
> +			dp->data.conf = 0;
> +			break;
> +		case DP_CMD_STATUS_UPDATE:
> +			dp->data.status = *vdo;
> +			ret = dp_altmode_status_update(dp);
> +			break;
> +		case DP_CMD_CONFIGURE:
> +			ret = dp_altmode_configured(dp);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case CMDT_RSP_NAK:
> +		switch (cmd) {
> +		case DP_CMD_CONFIGURE:
> +			dp->data.conf = 0;
> +			ret = dp_altmode_configured(dp);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (dp->state != DP_STATE_NONE)
> +		schedule_work(&dp->work);
> +
> +	mutex_unlock(&dp->lock);
> +	return ret;
> +}
> +
> +static int dp_altmode_activate(struct typec_altmode *alt, int activate)
> +{
> +	return activate ? typec_altmode_enter(alt) : typec_altmode_exit(alt);
> +}
> +
> +static const struct typec_altmode_ops dp_altmode_ops = {
> +	.attention = dp_altmode_attention,
> +	.vdm = dp_altmode_vdm,
> +	.activate = dp_altmode_activate,
> +};
> +
> +static const char * const configurations[] = {
> +	[DP_CONF_USB]	= "USB",
> +	[DP_CONF_DFP_D]	= "source",
> +	[DP_CONF_UFP_D]	= "sink",
> +};
> +
> +static ssize_t
> +configuration_store(struct device *dev, struct device_attribute *attr,
> +		    const char *buf, size_t size)
> +{
> +	struct dp_altmode *dp = dev_get_drvdata(dev);
> +	int conf;
> +	int ret;
> +
> +	conf = sysfs_match_string(configurations, buf);
> +	if (conf < 0)
> +		return conf;
> +
> +	mutex_lock(&dp->lock);
> +
> +	ret = dp_altmode_configure(dp, conf);
> +	if (!ret && dp->alt->active) {
> +		dp->state = DP_STATE_CONFIGURE;
> +		schedule_work(&dp->work);
> +	}
> +
> +	mutex_unlock(&dp->lock);
> +
> +	return ret ? ret : size;
> +}
> +
> +static ssize_t configuration_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct dp_altmode *dp = dev_get_drvdata(dev);
> +	int len;
> +	u8 cap;
> +	u8 cur;
> +	int i;
> +
> +	mutex_lock(&dp->lock);
> +
> +	cap = DP_CAP_CAPABILITY(dp->alt->vdo);
> +	cur = DP_CONF_CURRENTLY(dp->data.conf);
> +
> +	len = sprintf(buf, "%s ", cur ? "USB" : "[USB]");
> +
> +	for (i = 1; i < ARRAY_SIZE(configurations); i++) {
> +		if (i == cur)
> +			len += sprintf(buf + len, "[%s] ", configurations[i]);
> +		else if ((i == DP_CONF_DFP_D && cap & DP_CAP_DFP_D) ||
> +			 (i == DP_CONF_UFP_D && cap & DP_CAP_UFP_D))
> +			len += sprintf(buf + len, "%s ", configurations[i]);
> +	}
> +
> +	mutex_unlock(&dp->lock);
> +
> +	buf[len - 1] = '\n';
> +	return len;
> +}
> +static DEVICE_ATTR_RW(configuration);
> +
> +static const char * const pin_assignments[] = {
> +	[DP_PIN_ASSIGN_A] = "A",
> +	[DP_PIN_ASSIGN_B] = "B",
> +	[DP_PIN_ASSIGN_C] = "C",
> +	[DP_PIN_ASSIGN_D] = "D",
> +	[DP_PIN_ASSIGN_E] = "E",
> +	[DP_PIN_ASSIGN_F] = "F",
> +};
> +
> +static ssize_t
> +pin_assignment_store(struct device *dev, struct device_attribute *attr,
> +		     const char *buf, size_t size)
> +{
> +	struct dp_altmode *dp = dev_get_drvdata(dev);
> +	u8 assignments;
> +	u32 conf;
> +	int ret;
> +
> +	ret = sysfs_match_string(pin_assignments, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	conf = DP_CONF_SET_PIN_ASSIGN(BIT(ret));
> +	ret = 0;
> +
> +	mutex_lock(&dp->lock);
> +
> +	if (conf & dp->data.conf)
> +		goto out_unlock;
> +
> +	if (DP_CONF_CURRENTLY(dp->data.conf) == DP_CONF_DFP_D)
> +		assignments = DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo);
> +	else
> +		assignments = DP_CAP_DFP_D_PIN_ASSIGN(dp->alt->vdo);
> +
> +	if (!(DP_CONF_GET_PIN_ASSIGN(conf) & assignments)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/* Only send Configure command if a configuration has been set */
> +	if (dp->alt->active && DP_CONF_CURRENTLY(dp->data.conf)) {
> +		dp->state = DP_STATE_CONFIGURE;
> +		schedule_work(&dp->work);
> +	}
> +
> +	dp->data.conf &= ~DP_CONF_PIN_ASSIGNEMENT_MASK;
> +	dp->data.conf |= conf;
> +
> +out_unlock:
> +	mutex_unlock(&dp->lock);
> +
> +	return ret ? ret : size;
> +}
> +
> +static ssize_t pin_assignment_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct dp_altmode *dp = dev_get_drvdata(dev);
> +	u8 assignments;
> +	int len = 0;
> +	u8 cur;
> +	int i;
> +
> +	mutex_lock(&dp->lock);
> +
> +	cur = get_count_order(DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
> +
> +	if (DP_CONF_CURRENTLY(dp->data.conf) == DP_CONF_DFP_D)
> +		assignments = DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo);
> +	else
> +		assignments = DP_CAP_DFP_D_PIN_ASSIGN(dp->alt->vdo);
> +
> +	for (i = 0; assignments; assignments >>= 1, i++) {
> +		if (assignments & 1) {
> +			if (i == cur)
> +				len += sprintf(buf + len, "[%s] ",
> +					       pin_assignments[i]);
> +			else
> +				len += sprintf(buf + len, "%s ",
> +					       pin_assignments[i]);
> +		}
> +	}
> +
> +	mutex_unlock(&dp->lock);
> +
> +	buf[len - 1] = '\n';
> +	return len;
> +}
> +static DEVICE_ATTR_RW(pin_assignment);
> +
> +static struct attribute *dp_altmode_attrs[] = {
> +	&dev_attr_configuration.attr,
> +	&dev_attr_pin_assignment.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group dp_altmode_group = {
> +	.name = "displayport",
> +	.attrs = dp_altmode_attrs,
> +};
> +
> +static int dp_altmode_probe(struct typec_altmode *alt)
> +{
> +	const struct typec_altmode *port = typec_altmode_get_partner(alt);
> +	struct dp_altmode *dp;
> +	int ret;
> +
> +	/* FIXME: Port can only be DFP_U. */
> +
> +	/* Make sure we have compatiple pin configurations */
> +	if (!(DP_CAP_DFP_D_PIN_ASSIGN(port->vdo) &
> +	      DP_CAP_UFP_D_PIN_ASSIGN(alt->vdo)) &&
> +	    !(DP_CAP_UFP_D_PIN_ASSIGN(port->vdo) &
> +	      DP_CAP_DFP_D_PIN_ASSIGN(alt->vdo)))
> +		return -ENODEV;
> +
> +	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
> +	if (ret)
> +		return ret;
> +
> +	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
> +	if (!dp)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&dp->work, dp_altmode_work);
> +	mutex_init(&dp->lock);
> +	dp->port = port;
> +	dp->alt = alt;
> +
> +	alt->desc = "DisplayPort";
> +	alt->ops = &dp_altmode_ops;
> +
> +	typec_altmode_set_drvdata(alt, dp);
> +
> +	dp->state = DP_STATE_ENTER;
> +	schedule_work(&dp->work);
> +
> +	return 0;
> +}
> +
> +static void dp_altmode_remove(struct typec_altmode *alt)
> +{
> +	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
> +}
> +
> +static const struct typec_device_id dp_typec_id[] = {
> +	{ USB_TYPEC_DP_SID, USB_TYPEC_DP_MODE },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(typec, dp_typec_id);
> +
> +static struct typec_altmode_driver dp_altmode_driver = {
> +	.id_table = dp_typec_id,
> +	.probe = dp_altmode_probe,
> +	.remove = dp_altmode_remove,
> +	.driver = {
> +		.name = "typec_displayport",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +module_typec_altmode_driver(dp_altmode_driver);
> +
> +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("DisplayPort Alternate Mode");


Br,

-- 
heikki
