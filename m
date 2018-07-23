Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F252ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PP+yvKhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbeGWS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:58:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45450 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbeGWS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:58:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so236247pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hjrP48NPyDXItOmWLRxUGSUR+S+p/QD98sxKZ5eZlzA=;
        b=PP+yvKhzwnKdqzO0xjV24N1Mg6vPmdXeoQwYVKKGtFsoS6xGP9L4KfzvtEIokHQ+KJ
         GOJzUXj1/F03SYmeiRKKv4IjM4w4S/eNmOxwlaqVQzyTfLbXjMxemEAGyzjeLNqutzV6
         KmSsNfWbwesva71mlpna0i8uq2rRfw0pB4hno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hjrP48NPyDXItOmWLRxUGSUR+S+p/QD98sxKZ5eZlzA=;
        b=f30e8yZHMNM6zFK+JGmpvhmHTVQwxK5wONOCvu/N/0d7H+MUM+NZUg56YFDcjiWJMX
         V+gAdd2Og4Gsa1EGMeYuLxFhtxkbg0EJgzWgOWEvns99EyKt3h0hXaPQkJD3BlDnxqop
         UwMrIutYWHJlI9DBk5Ed9LJVHbAdMvDSzZpZJKW4dCxBh6oPnWfIbDtr82dcBFuP+ZZI
         DZAwj3Kyu7RqlPu248fK39y8+W7iLb0GRpNGy6NJFqKaecNGl3QTUkTNqKVSqrz4Z9MG
         89pDHmZR+n7p5xy87DtXg/pZaiSz9PioTQceaWlSxQH6jV1VNO48AAbASesu6W+Ebq8Z
         tdxA==
X-Gm-Message-State: AOUpUlHzNfswMKUzUzIWchYbFzi2GFY7OvijfuWNZ6RK8pfC8q0/Vod5
        mksuBCKnl4N+NWY2PffNiI4fbQ==
X-Google-Smtp-Source: AAOMgpccRQBOH9+jeZQmb+cMvcG25XL6rKDSpecEL20NXLSOeDW+HA8k85OBLBv5sn3uaJHNqs9G6Q==
X-Received: by 2002:a63:4811:: with SMTP id v17-v6mr12895267pga.379.1532368572849;
        Mon, 23 Jul 2018 10:56:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17595504pfi.180.2018.07.23.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:56:12 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:56:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180723175611.GL129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-5-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720133243.6851-5-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 07:02:40PM +0530, Balakrishna Godavarthi wrote:
> In function qca_setup, we set initial and operating speeds for Qualcomm
> Bluetooth SoC's. This block of code is common across different
> Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> a wrapper function to set the speeds. So that future coming SoC's
> can use these wrapper functions to set speeds.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 93 ++++++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 5f1c0a8fd5cd..5f8a74d65bec 100644
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
> @@ -923,6 +928,61 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
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
> +	if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
> +	    !qca_get_speed(hu, QCA_OPER_SPEED))
> +		return -EINVAL;

You changed this from:

	/* One or the other speeds should be non zero. */
	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
	    !qca_get_speed(hu, QCA_OPER_SPEED))
		return -EINVAL;

There is no entry in the change log. What is the reason for this
change?
