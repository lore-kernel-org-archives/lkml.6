Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DAC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808C2196F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLujoqmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbeLVB7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 20:59:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45488 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLVB7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 20:59:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so3240353plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 17:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y9j/0ZCEHfNjripmRqToTQAHB6Hfe0JOyVyQTlDXgmY=;
        b=KLujoqmzLUIixdu3As/inbuiaG4jgO8QEa7/AHAz2tUr6Svc+5DGlwdxqvNhynd3iS
         5Ens+u1DlUEuIGssUz54DRYJxKuaQ4sHFPTE8J1MxsCAC/m6k/I+VDJ7LSTeTJmy8Fhc
         8oDLwiyXgh8aHgx8W9qLEjucLpmR9Aa73r4/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y9j/0ZCEHfNjripmRqToTQAHB6Hfe0JOyVyQTlDXgmY=;
        b=tkho4jUgrbCUBHarlwViwT7MOmXsvYXFNVeZOnswBKZ8QqSLXRYd8sjy+XrHMooSCv
         vHuCbPRmTi3f+E7sw2QEdYJoWfi6lUc/rp0Jw7b+z/DKsS3BfrFO9udxMvd8A09ScI60
         KhI7WZNUeAew5r4jlYTTzfzCyiFlAZBYb6vhzIW5A5TKwFCs3a5IM5p/PpcwFqbIc0A0
         /yq0Oz55bm2Sy+RvsfgNp/UEtShX584+8hchW1P8X746YNL1EWNZ72FCMO2pnb5wirbd
         AiUAl2ROPNqvlTlUmIFgVyXyUz5ueUWnJvFCbJZSCisDYn6plCZafrZZivDFsBk8ruXk
         EKzQ==
X-Gm-Message-State: AJcUukdfCHoFkVsXK8FHj13twc17WzHgx4BJY8jN/j+z/wTNKU40rm2C
        zzp8p/dmRVGSzICQplSHF9YTag==
X-Google-Smtp-Source: ALg8bN6DhafH1HbNSg/7NZoyce0De0wNXprA1421sC2oCMDU2/a+iTCZkVFW1LNvHi9Cj+fkSM5lfA==
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr4794527pll.320.1545443988779;
        Fri, 21 Dec 2018 17:59:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o13sm35780703pfk.57.2018.12.21.17.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 17:59:47 -0800 (PST)
Date:   Fri, 21 Dec 2018 17:59:47 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181222015947.GF261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220144639.15928-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..5a07c2370289 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
>  		hci_uart_set_baudrate(hu, speed);
>  }
>  
> -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
>  {
> -	struct hci_uart *hu = hci_get_drvdata(hdev);
> -	struct qca_data *qca = hu->priv;
> -	struct sk_buff *skb;
> +	int ret;
>  
>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  	 * save power. Disabling hardware flow control is mandatory while
>  	 * sending power pulses to SoC.
>  	 */
> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> -
> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
>  	hci_uart_set_flow_control(hu, true);
> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> +	if (ret < 0) {
> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> +			   cmd);
> +		return ret;
> +	}
>  
> -	skb_put_u8(skb, cmd);
> -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> -
> -	skb_queue_tail(&qca->txq, skb);
> -	hci_uart_tx_wakeup(hu);
> +	serdev_device_wait_until_sent(hu->serdev, 0);

serdev_device_wait_until_sent() might only guarantee that the UART
circular buffer is empty (see
https://elixir.bootlin.com/linux/v4.19/source/drivers/tty/tty_ioctl.c#L225),
not that the data has actually sent (e.g. it might be sitting in
the UART FIFO). However with this:

>  	/* Wait for 100 uS for SoC to settle down */
>  	usleep_range(100, 200);

we should probably be fine, unless there's tons of data in the
FIFO.

You currently call serdev_device_write_flush() in
qca_power_shutdown(), I wonder if it would make sense to call it in
qca_send_power_pulse(), regardless of whether it's an on or off
pulse. In any case we don't care if the chip receives any 'pending'
data when we switch it on or off, right?

Cheers

Matthias
