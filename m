Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55350C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CBA20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLgoBVTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CBA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbeGZVJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:09:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37601 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbeGZVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:09:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so1784135pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uDqr/AlnhD5B7kBWsFKuFkX/c+qGkQMHpueWhO+he6k=;
        b=MLgoBVTq2lU+w+c1VI5WAUcgOXWqM1lyYXCRUW69EsZ41zWTYzHTbX31RFESZ8qL9J
         rI82nIzYp87fjzq0W+ZaD/nCF0yh6iB0kArPISnhPY6QbqSD40b731082mcBie5tVizd
         oedIjjGaTWz0dNdD5joRyre2rLOwNoZPU8Rgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uDqr/AlnhD5B7kBWsFKuFkX/c+qGkQMHpueWhO+he6k=;
        b=tM0D7xwgXiPsqzoZu0kJlmxULPrgsK9m9ZTQB9vAzTVq8qNeQiyhK7H+tbglxf+FAk
         JUtJxjLySQ6Qflbej1daBVaya4jFhqhRvr1Ea1r2teYXq2Q97t9TZrO3piyu/ZG0+dhq
         S0u5ADsi0RGSvxwlV8xildT+RJeHSFHAI0TRF1wqhyvlRq6em2azJtQiU7s8lxGWthV9
         WVN0Bo5orYonUn8bkPxRb8Hao+fRHkV3MF/0bAFnDF6yrSdwz/q/psTz5ilHO/t2qUv6
         NKSF4Zp4uUAi6RuF7KsvtQkd6cgMLZmFWZIrQXxb25kaKGVomT5waAn4z5foyjwU04V2
         w12g==
X-Gm-Message-State: AOUpUlE05xi4vKqGG2aKfCHUZwZybzrVZq871GyZ0F5U4nbsz0gzDBin
        nfHj1ZXZMMFGFZ4FjYoGurj5wA==
X-Google-Smtp-Source: AAOMgpd2k6xpVMMo6gLy0WgBX1MYBT8qPG7MF5KQ9dV+tC7JjpbQjZhJ7IKtntxGV+0YOdr699rjGw==
X-Received: by 2002:a62:a119:: with SMTP id b25-v6mr3421090pff.163.1532634691122;
        Thu, 26 Jul 2018 12:51:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id n9-v6sm5038125pfg.21.2018.07.26.12.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:51:30 -0700 (PDT)
Date:   Thu, 26 Jul 2018 12:51:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180726195129.GW129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
 <20180725183144.GQ129942@google.com>
 <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 07:51:13PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-26 00:01, Matthias Kaehlcke wrote:
> > On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
> > > Hi Matthias,
> > > 
> > > On 2018-07-24 01:24, Matthias Kaehlcke wrote:
> > > > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
> > > > > +	 * sometimes we will face communication synchronization issues,
> > > > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
> > > > > +	 * to overcome these issues, we try to communicate by performing an
> > > > > +	 * COLD power OFF and ON.
> > > > > +	 */
> > > > > +	for (i = 1; i <= 10 && ret; i++) {
> > > >
> > > > Is it really that bad that more than say 3 iterations might be needed?
> > > >
> > > [Bala]: will restrict to 3 iterations.
> > 
> > Is 3x expected to be enough to 'guarantee' as successful
> > initialization? Just wondered about the 10x since it suddendly changed
> > from 1x. What is the failure rate without retries?
> > 
> > Could you provide more information about the 'communication
> > synchronization issues'? Is the root cause understood? Maybe there is
> > a better way than retries.
> > 
> 
> [Bala]: basically before sending a every patch series we run a stress test
> to the driver to detect the bugs.
>         in recent test results found one interesting bug that BT setups
> fails with version request timeouts,
>         after we do a reboot for the device.
>         we debugged the issue and found that wcn3900 is not responding to
> the version request commands
>         sent by HOST. this is because before reboot, wcn3990 is in on state
> i.e. we are communicating to device.
>         then we did a reboot and HOST is not sending a power off request to
> the regulators to turn off.
>         so after reboot wcn3990 is still in ON state where it will not
> respond to version request commands which in turn fails HCI_SETUP.
>         so we are sending the power off pulse and then sending the power on
> pulse.
>         coming back to 3x or 10x iteration this is to avoid any such
> synchronization issues.
>         i agreed for 3x because of stress test results. we have success rate
> of 99% for single iteration, where as 3x iterations will helps to handle 1%
> fails cases.

Thanks for the clarification. Couldn't you assure the device is in a
defined state by calling qca_power_shutdown() as one of the first
things in qca_wcn3990_init()?

Some more comments on the functions, for if the retry loop is kept:

> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	int i, ret = 1;
> +
> +	/* WCN3990 is a discrete Bluetooth chip connected to APPS processor.
> +	 * sometimes we will face communication synchronization issues,
> +	 * like reading version command timeouts. In which HCI_SETUP fails,
> +	 * to overcome these issues, we try to communicate by performing an
> +	 * COLD power OFF and ON.
> +	 */
> +	for (i = 1; i <= 10 && ret; i++) {
> +		/* This helper will turn ON chip if it is powered off.
> +		 * if the chip is already powered ON, function call will
> +		 * return zero.
> +		 */
> +		ret = qca_power_setup(hu, true);
> +		if (ret)
> +			goto regs_off;

A failure here is not caused by a communication problem, so this
should probably be a 'return' instead of a 'goto'.

> +
> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
> +		host_set_baudrate(hu, 2400);
> +		ret = qca_send_vendor_pulse(hdev, QCA_WCN3990_FORCE_BOOT_PULSE);
> +		if (ret)
> +			goto regs_off;
> +
> +		qca_set_speed(hu, QCA_INIT_SPEED);
> +		ret = qca_send_vendor_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
> +		if (ret)
> +			goto regs_off;
> +
> +		/* Wait for 100 ms for SoC to boot */
> +		msleep(100);
> +
> +		/* Now the device is in ready state to communicate with host.
> +		 * To sync HOST with device we need to reopen port.
> +		 * Without this, we will have RTS and CTS synchronization
> +		 * issues.
> +		 */
> +		serdev_device_close(hu->serdev);
> +		ret = serdev_device_open(hu->serdev);
> +		if (ret) {
> +			bt_dev_err(hu->hdev, "failed to open port");
> +			break;

			return ret;

> +		}
 > +
> +		hci_uart_set_flow_control(hu, false);
> +		ret = qca_read_soc_version(hdev, soc_ver);
> +		if (ret < 0 || soc_ver == 0)
> +			bt_dev_err(hdev, "Failed to get version:%d", ret);

nit: add a space between ':' and '%d'

> +
> +		if (!ret)
> +			break;

			return 0;

> +
> +regs_off:
> +		bt_dev_err(hdev, "retrying to establish communication: %d", i);
> +		qca_power_shutdown(hdev);

Is qca_power_shutdown() needed or would qca_power_setup(hu,
false) be enough? This is qca_power_shutdown():

static int qca_power_shutdown(struct hci_dev *hdev)
{
        struct hci_uart *hu = hci_get_drvdata(hdev);

        host_set_baudrate(hu, 2400);
        qca_send_vendor_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
        return qca_power_setup(hu, false);
}

It additionally sends the power off pulse, which is also done in the
loop (though it is currently called QCA_WCN3990_FORCE_BOOT_PULSE).

The code flow with the gotos and the error handling at the end of the
loop is a bit messy. Moving the power down to the top of the loop
(basically in line with my comment above to get rid of the loop) would
help here. In this case checking 'ret' in the loop condition (which I
suggested to remove) would make sense, since it elimninates the need
for the break/return in the success case. But if we can do without the
loop even better :)

> > If I understand correctly you describe a hypothetical situation of a
> > future wcn3990 variant having lower power requirements. I'd say let's
> > deal with this when these chips actually exist and need to be
> > supported by Linux. As of now it seems there is no need for current
> > limits in the DT.
> > 
> 
> [Bala]: will remove current property for dts.
>         in previous mail you asked me a question for currents
>         "The currents of 300mA and 450mA seem high for Bluetooth, I'm not an
>          expert in this area though, they might be reasonable peak currents
> for
>          certain use cases."
> 
>          yes we require 450mA and 300mA of current for rf and ch0 pins.
> setting regulator to required load will not pump load current to wcn3990
>         it depends on operations, typical the above are the max current
> drawn by the two pins.

Ok, thanks for confirming.

