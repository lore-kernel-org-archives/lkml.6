Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D6A2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfBVMF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:05:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56460 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:05:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2E36F263947
Subject: Re: [PATCH v5 5/6] mfd: add EC host command support using rpmsg.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190221084729.101784-1-pihsun@chromium.org>
 <20190221084729.101784-6-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <27a8e94d-10fe-9d30-96e7-72416784e314@collabora.com>
Date:   Fri, 22 Feb 2019 13:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221084729.101784-6-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Only some few comments, most of them nits that I'd be happy if you can apply as
you should probably send another version because the documentation of the
binding is missing.

On 21/2/19 9:47, Pi-Hsun Shih wrote:
> Add EC host command support through rpmsg.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v4:
>  - Change from work queue to completion.
>  - Change from matching using rpmsg id to device tree compatible, to
>    support EC subdevices.
> 
> Changes from v3:
>  - Add host event support by adding an extra bytes at the start of IPC
>    message to indicate the type of the message (host event or host
>    command), since there's no additional irq that can be used for host
>    event.
> 
> Changes from v2:
>  - Wait for ipi ack instead of depends on the behavior in mtk-rpmsg.
> 
> Changes from v1:
>  - Code format fix based on feedback for cros_ec_rpmsg.c.
>  - Extract feature detection for SCP into separate patch (Patch 6).
> ---
>  drivers/platform/chrome/Kconfig         |   9 +
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_rpmsg.c | 248 ++++++++++++++++++++++++

Instead of

'mfd: add EC host command support using rpmsg.'

use

'platform/chrome: cros_ec: add EC host command support using rpmsg.'

as this is platform chrome related patch not MFD.

>  3 files changed, 258 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 7f08bae19e7815..5cf12e9399f3b1 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -69,6 +69,15 @@ config CROS_EC_SPI
>  	  response time cannot be guaranteed, we support ignoring
>  	  'pre-amble' bytes before the response actually starts.
>  
> +config CROS_EC_RPMSG
> +	tristate "ChromeOS Embedded Controller (rpmsg)"
> +	depends on MFD_CROS_EC && RPMSG && OF
> +	help
> +	  If you say Y here, you get support for talking to the ChromeOS EC
> +	  through rpmsg. This uses a simple byte-level protocol with a
> +	  checksum. Also since there's no addition EC-to-host interrupt, this
> +	  use a byte in message to distinguish host event from host command.
> +

I know that actually is not in alphabetical order, but let's try to add the new
entries in alphabetial order if it's possible.

so between

config CROS_EC_I2C
...

+config CROS_EC_RPMSG
+ ...

config CROS_EC_SPI
...

>  config CROS_EC_LPC
>          tristate "ChromeOS Embedded Controller (LPC)"
>          depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 1e2f0029b5971f..949b5c5afa1bdb 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
>  obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
> +obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o

I know that actually is not in alphabetical order, but let's try to add the new
entries in alphabetial order if it's possible.

obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
+obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o


>  cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> new file mode 100644
> index 00000000000000..7c28735c23347e
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright 2018 Google LLC.
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rpmsg.h>
> +#include <linux/slab.h>
> +
> +#define EC_MSG_TIMEOUT_MS 200
> +#define HOST_COMMAND_MARK 1
> +#define HOST_EVENT_MARK 2
> +
> +struct cros_ec_rpmsg_response {
As you documented some functions it would be great if you could also document
this struct
> +	uint8_t type;
> +	uint8_t data[];

In kernel u8 is preferred, s/uint8_t/u8/

> +};
> +
> +struct cros_ec_rpmsg {
As you documented all the functions it would be great if you could also document
this struct
> +	struct rpmsg_device *rpdev;
> +
No empty space unless you want to add some comment
> +	struct completion xfer_ack;
> +
No empty space unlees you want to add some comment
> +	struct work_struct host_event_work;
> +};
> +
> +/**
> + * cros_ec_cmd_xfer_rpmsg - Transfer a message over rpmsg and receive the reply
> + *
> + * This is only used for old EC proto version, and is not supported for this
> + * driver.
> + *
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + */

As you are using kernel-doc format, run

$ scripts/kernel-doc -v -none drivers/platform/chrome/cros_ec_rpmsg.c

and fix all the warnings, please.

> +static int cros_ec_cmd_xfer_rpmsg(struct cros_ec_device *ec_dev,
> +				  struct cros_ec_command *ec_msg)
> +{
> +	return -EINVAL;
> +}
> +
> +/**
> + * cros_ec_pkt_xfer_rpmsg - Transfer a packet over rpmsg and receive the reply
> + *
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + */
> +static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
> +				  struct cros_ec_command *ec_msg)
> +{
> +	struct ec_host_response *response;
> +	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
> +	struct rpmsg_device *rpdev = ec_rpmsg->rpdev;
> +	int len;
> +	u8 sum;
> +	int ret;
> +	int i;
> +	unsigned long timeout;
> +
> +	ec_msg->result = 0;
> +	len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
> +
> +	reinit_completion(&ec_rpmsg->xfer_ack);
> +	ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
> +	if (ret) {
> +		dev_err(ec_dev->dev, "rpmsg send failed\n");
> +		return ret;
> +	}
> +
> +	timeout = msecs_to_jiffies(EC_MSG_TIMEOUT_MS);
> +	ret = wait_for_completion_timeout(&ec_rpmsg->xfer_ack, timeout);
> +	if (!ret) {
> +		dev_err(ec_dev->dev, "rpmsg send timeout\n");
> +		return -EIO;
> +	}
> +
> +	/* check response error code */
> +	response = (struct ec_host_response *)ec_dev->din;
> +	ec_msg->result = response->result;
> +
> +	ret = cros_ec_check_result(ec_dev, ec_msg);
> +	if (ret)
> +		goto exit;
> +
> +	if (response->data_len > ec_msg->insize) {
> +		dev_err(ec_dev->dev, "packet too long (%d bytes, expected %d)",
> +			response->data_len, ec_msg->insize);
> +		ret = -EMSGSIZE;
> +		goto exit;
> +	}
> +
> +	/* copy response packet payload and compute checksum */
> +	memcpy(ec_msg->data, ec_dev->din + sizeof(*response),
> +	       response->data_len);
> +
> +	sum = 0;
> +	for (i = 0; i < sizeof(*response) + response->data_len; i++)
> +		sum += ec_dev->din[i];
> +
> +	if (sum) {
> +		dev_err(ec_dev->dev, "bad packet checksum, calculated %x\n",
> +			sum);
> +		ret = -EBADMSG;
> +		goto exit;
> +	}
> +
> +	ret = response->data_len;
> +exit:
> +	if (ec_msg->command == EC_CMD_REBOOT_EC)
> +		msleep(EC_REBOOT_DELAY_MS);
> +
> +	return ret;
> +}
> +
> +static void
> +cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
> +{
> +	struct cros_ec_rpmsg *ec_rpmsg = container_of(
> +		host_event_work, struct cros_ec_rpmsg, host_event_work);
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(&ec_rpmsg->rpdev->dev);
> +	bool wake_event = true;
> +	int ret;
> +
> +	ret = cros_ec_get_next_event(ec_dev, &wake_event);
> +
> +	/*
> +	 * Signal only if wake host events or any interrupt if
> +	 * cros_ec_get_next_event() returned an error (default value for
> +	 * wake_event is true)
> +	 */
> +	if (wake_event && device_may_wakeup(ec_dev->dev))
> +		pm_wakeup_event(ec_dev->dev, 0);
> +
> +	if (ret > 0)
> +		blocking_notifier_call_chain(&ec_dev->event_notifier,
> +					     0, ec_dev);
> +}
> +
> +static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> +				  int len, void *priv, u32 src)
> +{
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
> +	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
> +	struct cros_ec_rpmsg_response *resp;
> +
> +	if (!len) {
> +		dev_warn(ec_dev->dev, "rpmsg received empty response");
> +		return -EINVAL;
> +	}
> +
> +	resp = data;
> +	len--;
> +	if (resp->type == HOST_COMMAND_MARK) {
> +		if (len > ec_dev->din_size) {
> +			dev_warn(
> +				ec_dev->dev,
> +				"received length %d > din_size %d, truncating",
> +				len, ec_dev->din_size);
> +			len = ec_dev->din_size;
> +		}
> +
> +		memcpy(ec_dev->din, resp->data, len);
> +		complete(&ec_rpmsg->xfer_ack);
> +	} else if (resp->type == HOST_EVENT_MARK) {
> +		schedule_work(&ec_rpmsg->host_event_work);
> +	} else {
> +		dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
> +			 resp->type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +	struct device *dev = &rpdev->dev;
> +	struct cros_ec_device *ec_dev;
> +	struct cros_ec_rpmsg *ec_rpmsg;
> +	int ret;
> +
> +	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> +	if (!ec_dev)
> +		return -ENOMEM;
> +
> +	ec_rpmsg = devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL);
> +	if (!ec_rpmsg)
> +		return -ENOMEM;
> +
> +	ec_dev->dev = dev;
> +	ec_dev->priv = ec_rpmsg;
> +	ec_dev->cmd_xfer = cros_ec_cmd_xfer_rpmsg;
> +	ec_dev->pkt_xfer = cros_ec_pkt_xfer_rpmsg;
> +	ec_dev->phys_name = dev_name(&rpdev->dev);
> +	ec_dev->din_size = sizeof(struct ec_host_response) +
> +			   sizeof(struct ec_response_get_protocol_info);
> +	ec_dev->dout_size = sizeof(struct ec_host_request);
> +	dev_set_drvdata(dev, ec_dev);
> +
> +	ec_rpmsg->rpdev = rpdev;
> +	init_completion(&ec_rpmsg->xfer_ack);
> +	INIT_WORK(&ec_rpmsg->host_event_work,
> +		  cros_ec_rpmsg_host_event_function);
> +
> +	ret = cros_ec_register(ec_dev);
> +	if (ret) {
> +		dev_err(dev, "cannot register EC\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
> +{
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
> +	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
> +
> +	cancel_work_sync(&ec_rpmsg->host_event_work);
> +}
> +
> +static const struct of_device_id cros_ec_rpmsg_of_match[] = {
> +	{ .compatible = "google,cros-ec-rpmsg", },

I don't see the documentation binding. Could you add the info in
Documentation/devicetree/bindings/mfd/cros-ec.txt

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_rpmsg_of_match);
> +
> +static struct rpmsg_driver cros_ec_driver_rpmsg = {
> +	.drv = {
> +		.name   = KBUILD_MODNAME,
> +		.of_match_table = of_match_ptr(cros_ec_rpmsg_of_match),

That's DT-only, don't need to use of_match_ptr.

> +	},
> +	.probe		= cros_ec_rpmsg_probe,
> +	.remove		= cros_ec_rpmsg_remove,
> +	.callback	= cros_ec_rpmsg_callback,
> +};
> +
> +module_rpmsg_driver(cros_ec_driver_rpmsg);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
> 
