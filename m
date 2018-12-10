Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF62C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A5220672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPBrgJfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A5220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbeLJTCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:02:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39027 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:02:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so5385854pgl.6;
        Mon, 10 Dec 2018 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8oG/Oz+0rPtwgD26eScLADlzA7tapZA0+jrWLDrd3cA=;
        b=lPBrgJfOFiijD+1d6BtdVV9yGQ6YkFqmyHu1bmBPnm1IPwuD+xhm/+ktS8UzumYdNt
         hBJjtGhLj2V2KOondzYldi2Rh/21sD6zvPurN9ML1e0vo6g5fKFbf1vAN4drtW3sde48
         QCX+V85/9h7j0vlwguBYQClknpXt25INcIntJ6VOzFJDHZisCKhss+KSxjJf7nH97Wx0
         QHQjKwpRQ9V1fULDbhPEN61n+MEDFLxpKaIazgjLZ+JSEw5aFbVRyWONliHUgdaYow2Q
         o0+bmodX4mLhz7izzO5jchp4ITqVsFoTc4LQwxur1PxeHvwrUNST2/wkPdIEstrQp/t2
         qcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8oG/Oz+0rPtwgD26eScLADlzA7tapZA0+jrWLDrd3cA=;
        b=hrZn2bcXSoLylC7OOy3Ti7ZBrHnge7n7v0FmqUt0tqGHm0yrqSFb0kPhU72kTAia6d
         PQgyJlqf53EbhtJ6GsbjBLGY4HK8LJn7YakmX/kboGbG9bswLSLW4wcBMJ3ZGzDELRzc
         3ofPwREPRq7BG0n957E7qD1r8MRz19mjDrY27hmuyLrghzsGAfQ/vvXeQd3vn51FNg/g
         5G40pZ7c83dWst08CoMqFmFeEGmURJwYAaGxv9x4oybQP6C0pdW8taG0hd7942XCyci2
         DXyv4KONmjv5Z087334qqrSM8DbkBV19fbtQAUU9XUq9ymPuCpVmK7DNnYjrR/QsYrt7
         3Slg==
X-Gm-Message-State: AA+aEWZLuVriXNIJ0iVshlFzLr2MPcGVlRCCfcJnb4ZZnYr5MeRUvUni
        UeSm/y8Ta0ot6AB2KhCi12s=
X-Google-Smtp-Source: AFSGD/UTq45c5aGJH4frR7pXzNDd0tdUEgB7Ixo7GIzIW5h24FX0CfAbFgLpF6jSB4gAzD1y7ipLqg==
X-Received: by 2002:a63:111c:: with SMTP id g28mr11742334pgl.85.1544468535110;
        Mon, 10 Dec 2018 11:02:15 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n66sm19511553pfk.19.2018.12.10.11.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 11:02:14 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:02:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, agraf@suse.de,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] input: add official Raspberry Pi's touchscreen driver
Message-ID: <20181210190211.GA66699@dtor-ws>
References: <20181210163036.24813-1-nsaenzjulienne@suse.de>
 <20181210163036.24813-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210163036.24813-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Mon, Dec 10, 2018 at 05:30:20PM +0100, Nicolas Saenz Julienne wrote:
> Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> conventional bus all information is copied into a memory mapped area by
> RPi's firmware.
> 
> Based on the driver found in RPi's kernel repository.

I believe we are almost there, just a couple of nits.

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/input/touchscreen/Kconfig          |  12 ++
>  drivers/input/touchscreen/Makefile         |   1 +
>  drivers/input/touchscreen/raspberrypi-ts.c | 223 +++++++++++++++++++++
>  3 files changed, 236 insertions(+)
>  create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2a80675cfd94..a9be434de738 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -696,6 +696,18 @@ config TOUCHSCREEN_EDT_FT5X06
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called edt-ft5x06.
>  
> +config TOUCHSCREEN_RASPBERRYPI_TS
> +	tristate "Raspberry Pi's firmware base touch screen support"
> +	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> +	help
> +	  Say Y here if you have the offitial Raspberry Pi 7' scren on your
> +	  system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called raspberrypi-ts.
> +
>  config TOUCHSCREEN_MIGOR
>  	tristate "Renesas MIGO-R touchscreen"
>  	depends on (SH_MIGOR || COMPILE_TEST) && I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 5911a4190cd2..3eccb1925e89 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -109,3 +109,4 @@ obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
> +obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_TS)	+= raspberrypi-ts.o
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> new file mode 100644
> index 000000000000..edc92018687e
> --- /dev/null
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Raspberry Pi 3 firmware based touchscreen driver
> + *
> + * Copyright (C) 2015, 2017 Raspberry Pi
> + * Copyright (C) 2018 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input-polldev.h>
> +#include <linux/input/touchscreen.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_TS_DEFAULT_WIDTH	800
> +#define RPI_TS_DEFAULT_HEIGHT	480
> +
> +#define RPI_TS_MAX_SUPPORTED_POINTS	10
> +
> +#define RPI_TS_FTS_TOUCH_DOWN		0
> +#define RPI_TS_FTS_TOUCH_CONTACT	2
> +
> +#define RPI_TS_POLL_INTERVAL		17	/* 60fps */
> +
> +struct rpi_ts {
> +	struct platform_device *pdev;
> +	struct input_polled_dev *poll_dev;
> +	struct touchscreen_properties prop;
> +
> +	void __iomem *fw_regs_va;
> +	dma_addr_t fw_regs_phys;
> +
> +	int known_ids;
> +};
> +
> +struct rpi_ts_regs {
> +	u8 device_mode;
> +	u8 gesture_id;
> +	u8 num_points;
> +	struct rpi_ts_touch {
> +		u8 xh;
> +		u8 xl;
> +		u8 yh;
> +		u8 yl;
> +		u8 pressure; /* Not supported */
> +		u8 area;     /* Not supported */
> +	} point[RPI_TS_MAX_SUPPORTED_POINTS];
> +};
> +
> +/*
> + * We poll the memory based register copy of the touchscreen chip using the
> + * number of points register to know whether the copy has been updated (we
> + * write 99 to the memory copy, the GPU will write between 0 - 10 points)
> + */
> +static void rpi_ts_poll(struct input_polled_dev *dev)
> +{
> +	struct input_dev *input = dev->input;
> +	struct rpi_ts *ts = dev->private;
> +	struct rpi_ts_regs regs;
> +	int modified_ids = 0;
> +	long released_ids;
> +	int event_type;
> +	int touchid;
> +	int x, y;
> +	int i;
> +
> +	memcpy_fromio(&regs, ts->fw_regs_va, sizeof(regs));
> +	iowrite8(99, ts->fw_regs_va + offsetof(struct rpi_ts_regs, num_points));
> +
> +	if (regs.num_points == 99 ||
> +	    (regs.num_points == 0 && ts->known_ids == 0))
> +	    return;
> +
> +	for (i = 0; i < regs.num_points; i++) {
> +		x = (((int)regs.point[i].xh & 0xf) << 8) + regs.point[i].xl;
> +		y = (((int)regs.point[i].yh & 0xf) << 8) + regs.point[i].yl;
> +		touchid = (regs.point[i].yh >> 4) & 0xf;
> +		event_type = (regs.point[i].xh >> 6) & 0x03;
> +
> +		modified_ids |= BIT(touchid);
> +
> +		if (event_type == RPI_TS_FTS_TOUCH_DOWN ||
> +		    event_type == RPI_TS_FTS_TOUCH_CONTACT) {
> +			input_mt_slot(input, touchid);
> +			input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
> +			touchscreen_report_pos(input, &ts->prop, x, y, true);
> +		}
> +	}
> +
> +	released_ids = ts->known_ids & ~modified_ids;
> +	for_each_set_bit(i, &released_ids, RPI_TS_MAX_SUPPORTED_POINTS) {
> +		input_mt_slot(input, i);
> +		input_mt_report_slot_state(input, MT_TOOL_FINGER, 0);
> +		modified_ids &= ~(BIT(i));
> +	}
> +	ts->known_ids = modified_ids;
> +
> +	input_mt_sync_frame(input);
> +	input_sync(input);
> +}
> +
> +static void rpi_ts_dma_cleanup(void *data)
> +{
> +	struct rpi_ts *ts = data;
> +	struct device *dev = &ts->pdev->dev;
> +
> +	if(ts->fw_regs_va)

Drop the condition.

> +		dma_free_coherent(dev, PAGE_SIZE, ts->fw_regs_va,
> +				  ts->fw_regs_phys);
> +}
> +
> +static int rpi_ts_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct input_polled_dev *poll_dev;
> +	struct device_node *fw_node;
> +	struct rpi_firmware *fw;
> +	struct input_dev *input;
> +	struct rpi_ts *ts;
> +	u32 touchbuf;
> +	int ret;
> +
> +	fw_node = of_get_parent(np);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	fw = rpi_firmware_get(fw_node);
> +	of_node_put(fw_node);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts) {
> +		dev_err(dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +	ts->pdev = pdev;
> +
> +	ret = devm_add_action_or_reset(dev, rpi_ts_dma_cleanup, ts);
> +	if (ret)
> +		return ret;

This call needs to be after dma_zalloc_coherent(). Also (my personal
preference) can we please call this variable "error"? Then we can write
"if (error) ...".

> +
> +	ts->fw_regs_va = dma_zalloc_coherent(dev, PAGE_SIZE, &ts->fw_regs_phys,
> +					     GFP_KERNEL);
> +	if (!ts->fw_regs_va) {
> +		dev_err(dev, "failed to dma_alloc_coherent\n");
> +		return -ENOMEM;
> +	}
> +
> +	touchbuf = (u32)ts->fw_regs_phys;
> +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
> +				    &touchbuf, sizeof(touchbuf));
> +
> +	if (ret || touchbuf != 0) {
> +		dev_warn(dev, "Failed to set touchbuf, trying to get err:%x\n",
> +			 ret);
> +		return ret;
> +	}
> +
> +	poll_dev = devm_input_allocate_polled_device(dev);
> +	if (!poll_dev) {
> +		dev_err(dev, "Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +	ts->poll_dev = poll_dev;
> +	input = poll_dev->input;
> +
> +	input->name = "raspberrypi-ts";
> +	input->id.bustype = BUS_HOST;
> +	poll_dev->poll_interval = RPI_TS_POLL_INTERVAL;
> +	poll_dev->poll = rpi_ts_poll;
> +	poll_dev->private = ts;
> +
> +	__set_bit(EV_SYN, input->evbit);
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(EV_ABS, input->evbit);

No need to set these, EV_SYN is set by the input core, and KEY/ABS are
by input_set_abs_params() and input_mt_init_slots().

> +
> +	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +			     RPI_TS_DEFAULT_WIDTH, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +			     RPI_TS_DEFAULT_HEIGHT, 0, 0);
> +	touchscreen_parse_properties(input, true, &ts->prop);
> +
> +	input_mt_init_slots(input, RPI_TS_MAX_SUPPORTED_POINTS,
> +			    INPUT_MT_DIRECT | INPUT_MT_POINTER);

Error handling here please. Also, for touchscreens you do not need to
set INPUT_MT_POINTER, just INPUT_MT_DIRECT.

> +
> +	ret = input_register_polled_device(poll_dev);
> +	if (ret) {
> +		dev_err(dev, "could not register input device, %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rpi_ts_match[] = {
> +	{ .compatible = "raspberrypi,firmware-ts", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rpi_ts_match);
> +
> +static struct platform_driver rpi_ts_driver = {
> +	.driver = {
> +		.name   = "raspberrypi-ts",
> +		.of_match_table = rpi_ts_match,
> +	},
> +	.probe          = rpi_ts_probe,
> +};
> +module_platform_driver(rpi_ts_driver);
> +
> +MODULE_AUTHOR("Gordon Hollingworth");
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
> +MODULE_DESCRIPTION("Raspberry Pi 3 firmware based touchscreen driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.19.2
> 

Thanks.

-- 
Dmitry
