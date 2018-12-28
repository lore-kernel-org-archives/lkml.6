Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D750CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18EC2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPaUql2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbeL1RUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:20:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45143 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeL1RUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:20:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so10281545pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oP6EXeoKga9EyAT8/CpqpzKmJlIM2+7upTyVGXCkTMo=;
        b=LPaUql2cNV2SR42v6AopeTYlCKquTfKqsaafT2hdm+SMI2GqCWqMp1moh+GTyyDSzO
         x6H6e29+PwGsyMLyGHCbLW9HvGHVWYLbhHW3inZxYDJtZgy9zzOhhiJ3CsIrwRPDzYs1
         Ig7LEd4hQytgDBk4PkE/Y7e28RwZHifxYaH14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oP6EXeoKga9EyAT8/CpqpzKmJlIM2+7upTyVGXCkTMo=;
        b=YqRCQD+w307pAYPJs8ElZOVFx2vi5vKH4njVFP134mwCfeRZX7Ciw6UMgTB/o+ZuaZ
         97UfoFsfiLrdUwcPguG6meBts+HwlW0BG9STzhXam1ptoZyvfv5IHceWEJEW981GwldF
         THAfFJdFG0Zt8JbYrVbxpZ9oEoYtDIJ65L1FmtzXKgOUgTGNvedBGH77lcO6FdD14cNO
         ruJ+m/mF8HS/S1rPki2dmpqf83kQ3O/ljgUehLq99vXauYkiTdui5eWiRSO6BncRYY8B
         dNjF2ypXZj2OUHWOSksoV6dSOQ0UmZM0MkLXGSiPCDeRH5X2t6dwxLFVEuLuvtMz1HS2
         776A==
X-Gm-Message-State: AJcUukekbTgPbBuFd5UROFNuiu8y5Y/Hd5gXFT1ugwaGf04hhZg902ZT
        PvLhA36KBzwe8SczHBT2GIzsPlpfYHI5EA==
X-Google-Smtp-Source: ALg8bN6Y+radJH/t9iM/AHoWSGnex41cwDgv4nW9XaG7PoL97k7RU7o5ba/fgARcSSIPc4Tl+xSLZg==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr27220501pgg.401.1546017606510;
        Fri, 28 Dec 2018 09:20:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l74sm19858095pfb.145.2018.12.28.09.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 09:20:05 -0800 (PST)
Date:   Fri, 28 Dec 2018 09:20:05 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181228172005.GM261387@google.com>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181228114819.17479-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:18:16PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
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
>  drivers/bluetooth/hci_qca.c | 43 ++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..2aab34b3e696 100644
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
> @@ -1029,22 +1027,23 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
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
> +	serdev_device_wait_until_sent(hu->serdev, 0);
>  
> -	/* Wait for 100 uS for SoC to settle down */
> -	usleep_range(100, 200);
> +	/* Wait of 5ms is required for assuring to send the byte on the Tx
> +	 * line and also for the controller to settle down for the received
> +	 * byte.
> +	 */
> +	usleep_range(5000, 6000);

We could be more flexible with the range, e.g. 5 to 10 ms, but it's
also fine as is.

>  	hci_uart_set_flow_control(hu, false);
>  
>  	return 0;
> @@ -1116,7 +1115,6 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  
>  static int qca_wcn3990_init(struct hci_uart *hu)
>  {
> -	struct hci_dev *hdev = hu->hdev;
>  	struct qca_serdev *qcadev;
>  	int ret;
>  
> @@ -1139,12 +1137,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
>  
>  	/* Forcefully enable wcn3990 to enter in to boot mode. */
>  	host_set_baudrate(hu, 2400);
> -	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
> +	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	if (ret)
>  		return ret;
>  
>  	qca_set_speed(hu, QCA_INIT_SPEED);
> -	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
> +	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWERON_PULSE);
>  	if (ret)
>  		return ret;
>  
> @@ -1274,13 +1272,8 @@ static const struct qca_vreg_data qca_soc_data = {
>  
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
> -	struct serdev_device *serdev = hu->serdev;
> -	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
> -
>  	host_set_baudrate(hu, 2400);
> -	hci_uart_set_flow_control(hu, true);
> -	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
> -	hci_uart_set_flow_control(hu, false);
> +	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	qca_power_setup(hu, false);
>  }
>  

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
