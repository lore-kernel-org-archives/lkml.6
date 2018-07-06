Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A173EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED2022545
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0ZIvAhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED2022545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934815AbeGFTlD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:41:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33628 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934729AbeGFTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:41:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so9205586pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKWVKrrkCeg3NSj77/ogB2fnCyThk2/7/0fTmXzt0wA=;
        b=d0ZIvAhFyTSD+WCRY30qXoY09pJ1SovxS1/vYR5WnsfV57pIE9X7eFNR/sRpwhbjtu
         s0nt89YwugdKFqkWvPuK2Of/mKWwtw5eXn3AZZ6689Oy9tEuqixAmeiB9TPQxZcOUHF1
         5uxStZgm3dCtrCMGuL6o4YgPQrbGEkiLsUrqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKWVKrrkCeg3NSj77/ogB2fnCyThk2/7/0fTmXzt0wA=;
        b=BLYjI78f/aGi8DW6cIF2CepQLbmShzJDiqGE8xOUpMnQVKWwiyCwQ3Wt5vTbwZSLmg
         HOElKoA8PknWE/O/S9hdUjqyfODLoHw7GE3izEm9yoMwqMJaSUl44AwipFL9BfGNv4ul
         LwR+h94vVrAuHMVwDRhsQV/d0w7hMFuyHXt7kFZbKya0ScoEfOOCc+Tnqj58In077umF
         Rtx/hyGYFyYTemVNLqKhvJz3VL1gccI9tQCIOdL6dKyQFqbQABoCwt1aEpqCR55QhbwH
         TBYVFntsWFeQ+YteBVz5XPUpgthN0LHax/7HoPO3aoQ9dYhpj3b9oxnXO3u7iYbXDDwd
         XU/w==
X-Gm-Message-State: APt69E1Vy1p+P5I99Wcry8zy9FfFpJS+QsjKEcvQblGlZcJayscntnX7
        TLrUmB0Rof4aQYGoVmlfWIwhxA==
X-Google-Smtp-Source: AAOMgpdVRCw+QTsYvp7jIxpf8AkvmQZ6ywd1vrLJ1ZG2KxiNrOTRx73p5INGA5psyAimOBo70R1A/Q==
X-Received: by 2002:a65:520d:: with SMTP id o13-v6mr10379043pgp.282.1530906060417;
        Fri, 06 Jul 2018 12:41:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 127-v6sm16547392pfe.0.2018.07.06.12.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:40:59 -0700 (PDT)
Date:   Fri, 6 Jul 2018 12:40:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180706194059.GJ129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-5-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705165515.13340-5-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:25:12PM +0530, Balakrishna Godavarthi wrote:
> In function qca_setup, we set initial and operating speeds for Qualcomm
> Bluetooth SoC's. This block of code is common across different
> Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> a wrapper function to set the speeds. So that future coming SoC's
> can use these wrapper functions to set speeds.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v9:
>     * added corner case to fail driver if speeds are missing.
> 
> Changes in v8:
>     * common function to set INIT and operating speeds.
> 
> Changes in v7:
>     * initial patch
>     * created wrapper functions for init and operating speeds.
> ---
>  drivers/bluetooth/hci_qca.c | 94 ++++++++++++++++++++++++++++---------
>  1 file changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c02e1d465cca..9106547324fa 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -119,6 +119,11 @@ struct qca_data {
>  	u64 votes_off;
>  };
>  
> +enum qca_speed_type {
> +	QCA_INIT_SPEED = 1,
> +	QCA_OPER_SPEED
> +};
> +
>  struct qca_serdev {
>  	struct hci_uart	 serdev_hu;
>  	struct gpio_desc *bt_en;
> @@ -923,6 +928,62 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
>  		hci_uart_set_baudrate(hu, speed);
>  }
>  
> +static unsigned int qca_get_speed(struct hci_uart *hu,
> +				  enum qca_speed_type speed_type)
> +{
> +	unsigned int speed = 0;
> +
> +	if (speed_type == QCA_INIT_SPEED) {
> +		if (hu->init_speed)
> +			speed = hu->init_speed;
> +		else if (hu->proto->init_speed)
> +			speed = hu->proto->init_speed;
> +	} else {
> +		if (hu->oper_speed)
> +			speed = hu->oper_speed;
> +		else if (hu->proto->oper_speed)
> +			speed = hu->proto->oper_speed;
> +	}
> +
> +	return speed;
> +}
> +
> +static int qca_check_speeds(struct hci_uart *hu)
> +{
> +	/* One or the other speeds should be non zero. */
> +	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
> +	    !qca_get_speed(hu, QCA_OPER_SPEED))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> +{
> +	unsigned int speed, qca_baudrate;
> +	int ret;
> +
> +	if (speed_type == QCA_INIT_SPEED) {
> +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> +		if (speed)
> +			host_set_baudrate(hu, speed);

mega-nit: for consistency with the 'else' branch you could return if
'speed == 0'. Not important though, feel free to ignore.

> +	} else {
> +		speed = qca_get_speed(hu, QCA_OPER_SPEED);
> +		if (!speed)
> +			return 0;
> +
> +		qca_baudrate = qca_get_baudrate_value(speed);
> +		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
> +		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> +		if (ret)
> +			return ret;
> +
> +		host_set_baudrate(hu, speed);
> +	}
> +
> +	return 0;
> +}
> +
>  static int qca_setup(struct hci_uart *hu)
>  {
>  	struct hci_dev *hdev = hu->hdev;
> @@ -933,37 +994,24 @@ static int qca_setup(struct hci_uart *hu)
>  
>  	bt_dev_info(hdev, "ROME setup");
>  
> +	ret = qca_check_speeds(hu);
> +	if (ret)
> +		return ret;
> +
>  	/* Patch downloading has to be done without IBS mode */
>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  
>  	/* Setup initial baudrate */
> -	speed = 0;
> -	if (hu->init_speed)
> -		speed = hu->init_speed;
> -	else if (hu->proto->init_speed)
> -		speed = hu->proto->init_speed;
> -
> -	if (speed)
> -		host_set_baudrate(hu, speed);
> +	qca_set_speed(hu, QCA_INIT_SPEED);
>  
>  	/* Setup user speed if needed */
> -	speed = 0;
> -	if (hu->oper_speed)
> -		speed = hu->oper_speed;
> -	else if (hu->proto->oper_speed)
> -		speed = hu->proto->oper_speed;
> -
> +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
>  	if (speed) {
> -		qca_baudrate = qca_get_baudrate_value(speed);
> -
> -		bt_dev_info(hdev, "Set UART speed to %d", speed);
> -		ret = qca_set_baudrate(hdev, qca_baudrate);
> -		if (ret) {
> -			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
> -				   ret);
> +		ret = qca_set_speed(hu, QCA_OPER_SPEED);
> +		if (ret)
>  			return ret;
> -		}
> -		host_set_baudrate(hu, speed);
> +
> +		qca_baudrate = qca_get_baudrate_value(speed);
>  	}

One doubt, the outcome of this change is:

	qca_set_speed(hu, QCA_INIT_SPEED);

	/* Setup user speed if needed */
	speed = qca_get_speed(hu, QCA_OPER_SPEED);
	if (speed) {
		ret = qca_set_speed(hu, QCA_OPER_SPEED);
		if (ret)
			return ret;

		qca_baudrate = qca_get_baudrate_value(speed);
	}

So we set the init speed and then directly switch to operating speed
if it is defined.

Couldn't we do this instead:

	/* Setup user speed if needed */
	speed = qca_get_speed(hu, QCA_OPER_SPEED);
	if (speed) {
		ret = qca_set_speed(hu, QCA_OPER_SPEED);
		if (ret)
			return ret;

		qca_baudrate = qca_get_baudrate_value(speed);
	} else {
	       qca_set_speed(hu, QCA_INIT_SPEED);
	}

?

Or is setting the init speed needed before the operating speed can be
set? Sorry if we discussed this earlier in this series, I know I had a
few doubts about the speed management but don't recall this one
specifically.

Other than that:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
