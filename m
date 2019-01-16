Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E759C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F171C20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ys6yE7gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfAPUW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:22:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46199 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfAPUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:22:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so3522583ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ATF5Lt37lZd4XR74weI4YdFP5xD4fmjGIe3UjfXgJs0=;
        b=Ys6yE7gBUdham7sCbDYYl11kLIa783zCix6NZY6wSopEKMswotxOPX72RIau9tLorw
         DgXo9dA18KrdLiTuLCrCzThRVMww1nd7ysfTAsrLJ3tXtBAr/J6uIcr9KElWzXcQX7ga
         M+et3ytePBaFUe9nNwLd7/EeOUuZoWsWvTPs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATF5Lt37lZd4XR74weI4YdFP5xD4fmjGIe3UjfXgJs0=;
        b=LBNukBqKVu37HpA01L3519BtdgobGRRjR4wGnmpn5v1FW4hHXDlvXdmhWJs3J14Rem
         X6x2K56LxYYju9PFgVN3CH3qFPlDf4JgGizzOoZNt0dIgXHqR5YNZPauwlOGerW+A5qG
         YwAIyAXz2iK05cNbQDLNsld9KSJxH2eJyffVC4MDPhjVa3jAEQV8cuVBgD5rTj7DAFZN
         zpgqf/vCN+lTe7fuCHzkYn/XiZSnaiijPDtPYS9UKC6OffWjgZUHkxq9x2X59Lj+B9p5
         UkNvEJYQ1Br+aCEuEKiq/ioeSDD9JKOlNInsVy+oXcC6Dy83dCVxZVLwP6WdulyRHgFa
         0Xkw==
X-Gm-Message-State: AJcUukf4SLQGz6AMCQ5vFxEecJxdWKpONLs/DC0DFz0VvuB4OW/RJkK5
        LjceeSYb3f7yZwxKQOOhV+CROw==
X-Google-Smtp-Source: ALg8bN4pJ040ecnF/7FzaQXtnqodtpti32I7WuYPl7fiovVlgvXoKdQZPcjhefmCzNbqbTt7h/CBNQ==
X-Received: by 2002:a17:902:b03:: with SMTP id 3mr11614360plq.91.1547670175228;
        Wed, 16 Jan 2019 12:22:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i184sm9684698pfc.41.2019.01.16.12.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 12:22:54 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:22:53 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20190116202253.GS261387@google.com>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
 <20190116114603.500-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116114603.500-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:16:01PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v8:
>  * Updated 1 second timeout instead of indefinite wait.
> 
> Changes in v7:
>  *  updated the wait time to 5 ms after sending power pulses.
> 
> Changes in v6:
>  * added serdev_device_write_flush() in qca_send_power_pulse
>    instead during the power off pulse.
> 
> Changes in v5:
>  * added serdev_device_write_flush() in qca_power_off().
> ---
>  drivers/bluetooth/hci_qca.c | 46 ++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..681bfa30467e 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -60,6 +60,7 @@
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>  #define BAUDRATE_SETTLE_TIMEOUT_MS	300
> +#define POWER_PULSE_TRANS_TIMEOUT_MS	1000

nit: Not that it should make a different in normal operation, but 1s
seems extreme. Is there really any chance that the byte hasn't been
sent after say 100ms (which is still an eternity for a single byte)?

>  /* susclk rate */
>  #define SUSCLK_RATE_32KHZ	32768
> @@ -1013,11 +1014,10 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
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
> +	int timeout = __msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);

use msecs_to_jiffies()

>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1029,22 +1029,22 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  	 * save power. Disabling hardware flow control is mandatory while
>  	 * sending power pulses to SoC.
>  	 */
> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> -
> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to controller", cmd);
>  
> +	serdev_device_write_flush(hu->serdev);
>  	hci_uart_set_flow_control(hu, true);
> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> +	if (ret < 0) {
> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x", cmd);
> +		return ret;
> +	}
>  
> -	skb_put_u8(skb, cmd);
> -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> -
> -	skb_queue_tail(&qca->txq, skb);
> -	hci_uart_tx_wakeup(hu);
> -
> -	/* Wait for 100 uS for SoC to settle down */
> -	usleep_range(100, 200);
> +	serdev_device_wait_until_sent(hu->serdev, timeout);
> +	/* Wait of 5ms is required for assuring to send the byte on the Tx
> +	 * line and also for the controller to settle down for the received
> +	 * byte.
> +	 */
> +	usleep_range(5000, 6000);

I incorrectly claimed that there might be still bytes sitting in the
UART FIFO when serdev_device_wait_until_sent() returns, Johan
corrected me on that (thanks!). So if it takes the SoC 100us to settle
down we should be good with the original code.

Cheers

Matthias
