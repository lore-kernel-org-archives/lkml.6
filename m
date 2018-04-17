Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeDQHZt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:25:49 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35310 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeDQHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:25:46 -0400
X-Google-Smtp-Source: AIpwx4+IqOxmmOkUmyr/keZBPCk69KzyO53s7yvjHr9K1XH4wzs1Su7AEJyLrZiAc8YBHB3jQweEcw==
Date: Tue, 17 Apr 2018 09:25:30 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaotong.lu@spreadtrum.com
Subject: Re: [PATCH 2/2] input: misc: Add Spreadtrum vibrator driver
Message-ID: <20180417072530.GA4629@gmail.com>
References: <0bfdc811c2b3da3aa1cde2feef278a86503e3804.1523934640.git.baolin.wang@linaro.org>
 <b5580f22aaed9845af9b981319d6cefa04fddd35.1523934640.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5580f22aaed9845af9b981319d6cefa04fddd35.1523934640.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaotong,

On Tue, Apr 17, 2018 at 11:18:24AM +0800, Baolin Wang wrote:
> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>

[snip]

> +static int sc27xx_vibra_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct vibra_info *info;
> +	int ret;
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!info->regmap) {
> +		dev_err(&pdev->dev, "failed to get vibrator regmap.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(node, "reg", &info->base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to get vibrator base address.\n");
> +		return ret;
> +	}
> +
> +	info->input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!info->input_dev) {
> +		dev_err(&pdev->dev, "failed to allocate input device.\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->input_dev->name = "sc27xx:vibrator";
> +	info->input_dev->id.version = 0;
> +	info->input_dev->dev.parent = pdev->dev.parent;
> +	info->input_dev->close = sc27xx_vibra_close;
> +
> +	input_set_drvdata(info->input_dev, info);
> +	input_set_capability(info->input_dev, EV_FF, FF_RUMBLE);
> +	INIT_WORK(&info->play_work, sc27xx_vibra_play_work);
> +	info->enabled = false;
> +
> +	ret = input_ff_create_memless(info->input_dev, NULL, sc27xx_vibra_play);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register vibrator to FF.\n");
> +		return ret;
> +	}
> +
> +	ret = input_register_device(info->input_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register input device.\n");
> +		input_ff_destroy(info->input_dev);

I'm not sure how the input_ff is freed for managed devices.

Either you don't have to destroy it here, or you also need to destroy it
in a release() function.

> +		return ret;
> +	}
> +
> +	ret = sc27xx_vibra_hw_init(info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize the vibrator.\n");
> +		input_ff_destroy(info->input_dev);
> +		input_unregister_device(info->input_dev);

No need to unregister managed input devices.

> +		return ret;
> +	}

Cheers,
Marcus Folkesson
