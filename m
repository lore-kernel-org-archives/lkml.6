Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C829C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0402148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JT6LCeJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeL0US7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:18:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbeL0US7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:18:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so9159118pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GYI91X033NSGnZvBjCnNcYSVYclCXDlVA3GrVYN52WE=;
        b=JT6LCeJzsDqjYqwqIusUOw+5OclRiNrmeisQkl4DNHqadMhxqaBCtvFhiItR2qL5c1
         ZNcm9y8UxeU5CQ4iptj32xuvbOeYdW+4kq/IV6Ilusr1IjBnqL13Lkn4ia8+77cQXZHd
         VIQTU6Lv1wHxCXl+cd0AVnzB6syz8JVdYSThA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYI91X033NSGnZvBjCnNcYSVYclCXDlVA3GrVYN52WE=;
        b=J8hkn2wrvC44ffOmB3blYNA1pn8B9c/mhiZ16NC//yo5ZAihAgo+RXoFOIux+/9Wrv
         KOxyrX/4GKRkDjUcD4yKg5wObWS1tWCx1ahtRucdDmb3suOuoTj3StCXyqUsNw5Ssrk5
         SnCODuoPpukUm9ZlB5/Rb5IESyMYL/lxAFBfLMzV1todhzIK+lS52S/5cC5ZLoTlsvm1
         20M0aoC4jPLIUwsDt8+VxfRbebihuaXDZq4Ng3m/uiNDUcA8fzHepnrKlXTLnyBUnaaH
         IWE/69rR+kRA+I2ac5yLr7EK9IXqDImeObUa+3igbibjmfbiL6LxvMPin0WUqB9wZzIv
         VD7Q==
X-Gm-Message-State: AA+aEWYJFuJ46hLolT6JwTo7BsCj+C5TmYy3CCw5JtWFbylEuWckYIy9
        QCk1V15VfR+7qaFgAMr9yjiTjA==
X-Google-Smtp-Source: AFSGD/XiGGfmU/3etUsizltHcSqH7L6d8qJ68T43Duk8gi9QGDRQdb9Hj4L6izSHEIY5/iAu4ixG6A==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr25299607pfi.44.1545941938146;
        Thu, 27 Dec 2018 12:18:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v62sm62071727pfd.163.2018.12.27.12.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 12:18:57 -0800 (PST)
Date:   Thu, 27 Dec 2018 12:18:56 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/6] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181227201856.GJ261387@google.com>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
 <20181227073136.8431-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181227073136.8431-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 01:01:31PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v6:
>  * added serdev_device_write_flush() in qca_send_power_pulse
>    instead during the power off pulse.
> 
> Changes in v5:
>  * added serdev_device_write_flush() in qca_power_off().
> 
> ---
>  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..507a2355c758 100644
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
> @@ -1029,19 +1027,17 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  	 * save power. Disabling hardware flow control is mandatory while
>  	 * sending power pulses to SoC.
>  	 */
> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> -
> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> +	serdev_device_write_flush(hu->serdev);
> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);

nit: why clutter the code flow by putting the log statement in the
middle of code that is actually doing something with the serial
interface?

In case you respin anyway I suggest to structure it like this:

  bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);

  hci_uart_set_flow_control(hu, true);
  serdev_device_write_flush(hu->serdev);
  ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));


>  	hci_uart_set_flow_control(hu, true);
> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> +	if (ret < 0) {
> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",

nit: especially on 'embedded' devices 'SoC' is typically associated
with the CPU running Linux, you might want to change it to
'controller'.

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
>  
>  	/* Wait for 100 uS for SoC to settle down */
>  	usleep_range(100, 200);

I said earlier the delay here should be enough to ensure that the byte
gets transferred from a hardware buffer/FIFO to the controller,
however that didn't take into account that the power pulses are sent
with a baudrate of 2400. That translates to ~240 bytes/s, hence a
delay of 5 ms is needed to be on the safe side.

In case you change the delay please also update the comment to make
clear this is not only time for the BT controller to settle, but also
to guarantee that the command was actually sent to the controller.

So far it seems no problems have been observed, though this could be
thanks to the 100 ms delay in qca_wcn3990_init().

Cheers

Matthias
