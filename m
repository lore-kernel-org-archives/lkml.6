Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C41C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC7208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BV6PWdRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAC7208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeGJQMv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:12:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42309 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934326AbeGJQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:12:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so4788117pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7iAqTtNY9PmtH8oyDci/Y15mpa3jw3ZYXiM6Q2FQXlw=;
        b=BV6PWdRlpWFLUH0jtNmwKVl6qIVtNVckxkdLvLcKyu4rGo7ZIYcsMgYQzZ/TDIfhia
         LM2w+B66hr148LB6eNjE7K6ph1sYeT9zJDULx9lbJQF1T4DXJTvjKf9rony1WTs5a0X6
         gbQwqK/j2k5qzCc5+3IGlVYg1IDkwKz0AumHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7iAqTtNY9PmtH8oyDci/Y15mpa3jw3ZYXiM6Q2FQXlw=;
        b=b0z+86ZR4hFJPo5oKrAS2UWVrEY2FN6ze6KTz7RH+l2OZ7SNlY2ZRHDgghJy1kIEw6
         BXMLcGj2GFvlyAo69aOq/DXSyiAcLOjz66j2vRjTYc5DWhXhs2f6xqdmkRp0GHd+MwiQ
         S6X/N7Ejp066+Bg56wLV1kP+PiJNY/F6GRtPKt7buABMFLNZ+tD6ZUMDPLlxndA/bDEo
         dJ9alEnALwoiY22A4TbriOiSVIeEvpVRAVtZxB/s6TCS1HGBYO7iSzRaja6kJoZMxLYO
         6XXa/qqzBMKOo0OyhLUMXxKB1Qw2658tBM/XR2+vNtNubndQKldckt0w8wXjhfM6tH46
         rXVQ==
X-Gm-Message-State: APt69E3Ji/smu93RSxKk/1SRCzSEU/m/9wgYv4JWCeMuNf5H6LcbXWpc
        WPAVIDT+KoTNZq2wsf+ESjwRIg==
X-Google-Smtp-Source: AAOMgpcikVlbp50I33E9S0CxEi80p74eIjGLIoPSYZa4MhrXIJAJfZFD7ZXYZLvGadnViQho2fM90A==
X-Received: by 2002:a63:b213:: with SMTP id x19-v6mr23290048pge.393.1531239168060;
        Tue, 10 Jul 2018 09:12:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id u185-v6sm20130805pfu.134.2018.07.10.09.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:12:47 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:12:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180710161246.GP129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-5-bgodavar@codeaurora.org>
 <20180706194059.GJ129942@google.com>
 <55c70cb40b421ab87c36dd2ecf886c1b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55c70cb40b421ab87c36dd2ecf886c1b@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:49:20PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-07 01:10, Matthias Kaehlcke wrote:
> > On Thu, Jul 05, 2018 at 10:25:12PM +0530, Balakrishna Godavarthi wrote:
> > > In function qca_setup, we set initial and operating speeds for
> > > Qualcomm
> > > Bluetooth SoC's. This block of code is common across different
> > > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > > a wrapper function to set the speeds. So that future coming SoC's
> > > can use these wrapper functions to set speeds.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > ---
> > > Changes in v9:
> > >     * added corner case to fail driver if speeds are missing.
> > > 
> > > Changes in v8:
> > >     * common function to set INIT and operating speeds.
> > > 
> > > Changes in v7:
> > >     * initial patch
> > >     * created wrapper functions for init and operating speeds.
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 94
> > > ++++++++++++++++++++++++++++---------
> > >  1 file changed, 71 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index c02e1d465cca..9106547324fa 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -119,6 +119,11 @@ struct qca_data {
> > >  	u64 votes_off;
> > >  };
> > > 
> > > +enum qca_speed_type {
> > > +	QCA_INIT_SPEED = 1,
> > > +	QCA_OPER_SPEED
> > > +};
> > > +
> > >  struct qca_serdev {
> > >  	struct hci_uart	 serdev_hu;
> > >  	struct gpio_desc *bt_en;
> > > @@ -923,6 +928,62 @@ static inline void host_set_baudrate(struct
> > > hci_uart *hu, unsigned int speed)
> > >  		hci_uart_set_baudrate(hu, speed);
> > >  }
> > > 
> > > +static unsigned int qca_get_speed(struct hci_uart *hu,
> > > +				  enum qca_speed_type speed_type)
> > > +{
> > > +	unsigned int speed = 0;
> > > +
> > > +	if (speed_type == QCA_INIT_SPEED) {
> > > +		if (hu->init_speed)
> > > +			speed = hu->init_speed;
> > > +		else if (hu->proto->init_speed)
> > > +			speed = hu->proto->init_speed;
> > > +	} else {
> > > +		if (hu->oper_speed)
> > > +			speed = hu->oper_speed;
> > > +		else if (hu->proto->oper_speed)
> > > +			speed = hu->proto->oper_speed;
> > > +	}
> > > +
> > > +	return speed;
> > > +}
> > > +
> > > +static int qca_check_speeds(struct hci_uart *hu)
> > > +{
> > > +	/* One or the other speeds should be non zero. */
> > > +	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
> > > +	    !qca_get_speed(hu, QCA_OPER_SPEED))
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type
> > > speed_type)
> > > +{
> > > +	unsigned int speed, qca_baudrate;
> > > +	int ret;
> > > +
> > > +	if (speed_type == QCA_INIT_SPEED) {
> > > +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> > > +		if (speed)
> > > +			host_set_baudrate(hu, speed);
> > 
> > mega-nit: for consistency with the 'else' branch you could return if
> > 'speed == 0'. Not important though, feel free to ignore.
> > 
> > > +	} else {
> > > +		speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > > +		if (!speed)
> > > +			return 0;
> > > +
> > > +		qca_baudrate = qca_get_baudrate_value(speed);
> > > +		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
> > > +		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		host_set_baudrate(hu, speed);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int qca_setup(struct hci_uart *hu)
> > >  {
> > >  	struct hci_dev *hdev = hu->hdev;
> > > @@ -933,37 +994,24 @@ static int qca_setup(struct hci_uart *hu)
> > > 
> > >  	bt_dev_info(hdev, "ROME setup");
> > > 
> > > +	ret = qca_check_speeds(hu);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	/* Patch downloading has to be done without IBS mode */
> > >  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> > > 
> > >  	/* Setup initial baudrate */
> > > -	speed = 0;
> > > -	if (hu->init_speed)
> > > -		speed = hu->init_speed;
> > > -	else if (hu->proto->init_speed)
> > > -		speed = hu->proto->init_speed;
> > > -
> > > -	if (speed)
> > > -		host_set_baudrate(hu, speed);
> > > +	qca_set_speed(hu, QCA_INIT_SPEED);
> > > 
> > >  	/* Setup user speed if needed */
> > > -	speed = 0;
> > > -	if (hu->oper_speed)
> > > -		speed = hu->oper_speed;
> > > -	else if (hu->proto->oper_speed)
> > > -		speed = hu->proto->oper_speed;
> > > -
> > > +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > >  	if (speed) {
> > > -		qca_baudrate = qca_get_baudrate_value(speed);
> > > -
> > > -		bt_dev_info(hdev, "Set UART speed to %d", speed);
> > > -		ret = qca_set_baudrate(hdev, qca_baudrate);
> > > -		if (ret) {
> > > -			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
> > > -				   ret);
> > > +		ret = qca_set_speed(hu, QCA_OPER_SPEED);
> > > +		if (ret)
> > >  			return ret;
> > > -		}
> > > -		host_set_baudrate(hu, speed);
> > > +
> > > +		qca_baudrate = qca_get_baudrate_value(speed);
> > >  	}
> > 
> > One doubt, the outcome of this change is:
> > 
> > 	qca_set_speed(hu, QCA_INIT_SPEED);
> > 
> > 	/* Setup user speed if needed */
> > 	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > 	if (speed) {
> > 		ret = qca_set_speed(hu, QCA_OPER_SPEED);
> > 		if (ret)
> > 			return ret;
> > 
> > 		qca_baudrate = qca_get_baudrate_value(speed);
> > 	}
> > 
> > So we set the init speed and then directly switch to operating speed
> > if it is defined.
> > 
> > Couldn't we do this instead:
> > 
> > 	/* Setup user speed if needed */
> > 	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > 	if (speed) {
> > 		ret = qca_set_speed(hu, QCA_OPER_SPEED);
> > 		if (ret)
> > 			return ret;
> > 
> > 		qca_baudrate = qca_get_baudrate_value(speed);
> > 	} else {
> > 	       qca_set_speed(hu, QCA_INIT_SPEED);
> > 	}
> > 
> > 
> 
> [Bala]: above else block is not required.
>         if we have operating speed to set, then we need to send the baud
> rate change request to BT chip on INIT baud rate. so before sending or
> setting operating baud rate.. HOST driver should be on the HOST init baud
> rate.
>         Pls refer below for more info how we set speed and hci driver works.
> > 
> > Or is setting the init speed needed before the operating speed can be
> > set? Sorry if we discussed this earlier in this series, I know I had a
> > few doubts about the speed management but don't recall this one
> > specifically.
> > 
> 
> [Bala]: Let me give a big picture how we make BT work via serdev HCI arch.
> (qca chip is taken as reference)
> 
>         1. first of all, probe is called when we have compatible string
> matches in qca_bluetooth_of_match table.
>         2. that will call qca_serdev_probe() in which based on BT device
> connected to the platform, we decide IO's
>            which required from HOST to chip i.e.. controls required to turn
> ON/OFF BT. which includes clocks and regulators and GPIO's.
>         3. in qca_serdev_probe() we call  hci_uart_register_device() and
> pass ops (operations handler) handler for driver registration.
>         4. in hci_uart_register_device(), we call qca_open().. where we open
> the port via serdev_device_open() that
>            intern will call Qualcomm specific lower level UART driver i.e..
> where we read and write to port register address.
>            so serdev_device_open() is a common function to all BT chip
> vendor, but the open routine in the low level driver is completely vendor
> dependent.
>            for example, some vendors will set an default UART speed (speed
> can be any) while opening the uart_port(). where as other will not set. Just
> open the port with basic configurations.
> 
>         5. coming back to qca_open(), we try to make chip to boot up by
> enabling clock from HOST for BT chip to operate..  it is purely chip
> defined.
>         6. moving back to hci_uart_register_device()... we will call
> hci_register_dev() in that function we call hci_power_on().. that will call
> hci_dev_do_open()
>         7. in hci_dev_do_open() we call hdev->setup() i.e. hci_uart_setup()
> in that function we set initial baud rate and operating bartender if we have
> protos defined for setting chip baud rate.(in our case it is null)
> 
>         8. so it will call setup function will be vendor specific.. as we
> are using an UART, HOST and chip need to stick to the agreement of initial
> UART speed for commands to send until and change baud rate request is
>            sent.
>         9. now in qca_setup(), we setup an initial host baud rate i.e. what
> we have agreement with BT chip for initial communication. Now here the
> question comes why are we setting init speed again and again
>            i.e uart_open() and hci_uart_setup().. here is the answer, wt
> ever layer we have are common to all vendors may also tend to change. we
> can't take a risk, we will setup init baud rate in vendor layer i.e.
>            qca_setup().
>         10. then we need to change the baud rate of chip..so we need to send
> commands to chip. at wt speed we need to send change baud rate request is
> totally based on agreement with BT Chip. so here we use initial
>             baud rate.
>         11. we need to change baud rate request command to chip on init baud
> rate. if command sending is successful we change the host baud rate from
> init to operating baud rate.. else we operate on init baud rate.
> 
> 
>         the above is based on my understanding. Pls let me know if i have
> cleared your doubt.

Thanks for the explanation. I focussed on the final outcome (operating
speed is set) and ignored that the host port needs to be at init speed
in order to send the baud rate change command to the chip.

Cheers

Matthias
