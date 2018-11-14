Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425052175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JMHMlt7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425052175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeKNKSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:18:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42981 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:18:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3041020pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vaPrL5AVs+QSJPGBukt1u2S4cdrUJEqxE7lIf1OY0cE=;
        b=JMHMlt7DSeuFoHJkZRU/5VdGNV/jn//Sg91XrMlmkkg8b4h+eEtwZBMc50VXXKz/VL
         0Y2I4cIi4iwg70wqeyGhIa6wWal2qZ61Btc2jiSa6b+Yl5ZmiVjyNCuIvOCSE8kl8Rdy
         qn/Ys7gUMh8VcgKKQJXCO3ERNEc0Zd5EEpxTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vaPrL5AVs+QSJPGBukt1u2S4cdrUJEqxE7lIf1OY0cE=;
        b=OwPrGSSdOvOxkiZwPUMU9/lWgS8t1XyDwf1BwekCdesvutec++DO8C8YBiwQ6+IPUV
         TCC0Qzb8o8VNI8vlHd0SQYp5UnTPjy5exxz9GqU3bDFC0hYxcvOBMR+tvetv8g96NdeJ
         yXZ9qscOoBmnmkc0EoHbLzL0HaLb0wVVCqrHbOQPewHJL4i9ia5lOhzF6SyHO1XpnSVL
         eW+giohPYhJwfcGzT6NHQ2NwpVZRhvvvHRjlkXl+8MmtkNH90vulkCYj0bLc0fE9QwqU
         1qEc2ok/Y0kq2dp8BawUZjoUgW3zuhvAuVJKh4KU9dh7+f32iDoHViVZ4RyWIESjfBWn
         djZg==
X-Gm-Message-State: AGRZ1gJ6wNbUavu5HV+tL7WEiI1ADa42pN+S9wydHa2Qx6SOgjAvKfW7
        VFDNwkIZt+F1dI4IsyzNIs90LYeqIBo=
X-Google-Smtp-Source: AJdET5ez3IrF06E+5fy+JSrcX4gco41KzioLzdsgd8C02DFCXvWlcIL+jD1BWVZxxtWuI5JCLD1MfQ==
X-Received: by 2002:a63:c447:: with SMTP id m7mr6731822pgg.27.1542154639355;
        Tue, 13 Nov 2018 16:17:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id x63-v6sm28278005pfk.14.2018.11.13.16.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 16:17:18 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:17:17 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181114001717.GG22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106120528.30342-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:35:25PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f72ded4ec9ae..051f081d1835 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1016,8 +1016,7 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
>  static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  {
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
> -	struct qca_data *qca = hu->priv;
> -	struct sk_buff *skb;
> +	int ret;
>  
>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1030,18 +1029,14 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  	 * sending power pulses to SoC.
>  	 */
>  	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> -
> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
>  	hci_uart_set_flow_control(hu, true);
> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
> +	if (ret < 0) {
> +		bt_dev_err(hdev, "failed to send power pulse %02x to SoC", cmd);
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

Is the delay still needed now that we wait for the pulse to be sent? I
didn't observe any problems without it in a few dozens of iterations.

> @@ -1283,7 +1278,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  
>  	host_set_baudrate(hu, 2400);
>  	hci_uart_set_flow_control(hu, true);
> -	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
> +	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
> +	serdev_device_wait_until_sent(serdev, 0);
>  	hci_uart_set_flow_control(hu, false);

You could call qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE)
instead, as an earlier patch set did before skbs were used to send the
power pulse.

You can also consider to set the baudrate in qca_send_power_pulse()
depending on the power pulse. On the plus side this would reduce a bit
of clutter in the callers of qca_send_power_pulse(), on the negative
side it would be harder to follow when baudrate changes occur (not
sure this is a problem). Up to you, just an idea.

Thanks

Matthias
