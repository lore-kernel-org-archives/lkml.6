Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8FC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C30218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a40iWt1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfAYBO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:14:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAYBOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:14:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so3474184pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 17:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+5DQI999ajUqCArFEiIV2zdq64KwEmFrspdMbb9YOM=;
        b=a40iWt1ikL4vIhxIoE1K7/fUIXfa/3tz241xbFVKhaJWBCo42oaxXU+b7b5Uy5zVVK
         hj1XmGHncIng5H7jt+tUzbOlJMjnQmFVhInyKhg/8BjfZ2aBx1kEa9zUEfkWmM+v9jGY
         rQ7XbKZl9Fv1qUOy/Pf1MjmgYAugZB+9uJQCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+5DQI999ajUqCArFEiIV2zdq64KwEmFrspdMbb9YOM=;
        b=ZJc93EvKCNjuwhyJIHepWjsl1Gq0A0W89JAm4LkA3pPoppjJJL99iQo3ukPaJcTVFl
         pi1f4FGTpMxXTLKcSCAxoKpBM97NYpbYQo5dBwqhl6iJTLxb/eqG/nmqokAvlKoC8n2p
         YKATLQ0WqHrY3AAUbRAQ8cmHnjaoH+OSqoQP7fcKGiOqbVZDYIPWG/B/gZeM4pAS6lQf
         Yl/eOLBkEBimMwI06IbJftDmIUANjiU4JxcD0wGtf5qn1ERnekKjOaSc2AX2Q97k6Kzc
         NKfArF5rTqYcTxGSQegwurChGGC+OZ/Q3RJ5cPVnWCUrrdIoQRRhV8Ss25ryDVnh90lL
         SjDQ==
X-Gm-Message-State: AJcUukeLMEVBI75ZCOmKIXdyWSCboMeqC76P5XiPRyl+SjJ7WgofGtG3
        ci4gaqFS9IyMpb4xHdxNF+Dw4A==
X-Google-Smtp-Source: ALg8bN6eINzDD4ySYFln3BvvB+l303BtgeHHI+9sZy0ttfPkSjIwQpNxohaZKwo2t980dX8awcticg==
X-Received: by 2002:a62:1542:: with SMTP id 63mr8885809pfv.230.1548378864531;
        Thu, 24 Jan 2019 17:14:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 85sm31641435pfw.17.2019.01.24.17.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 17:14:23 -0800 (PST)
Date:   Thu, 24 Jan 2019 17:14:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20190125011412.GE81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124120808.8275-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 05:38:06PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v9:
>  * Reverted to 100us sleep.
>  * used inline call msecs_to_jiffies()
> 
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
>  drivers/bluetooth/hci_qca.c | 40 +++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..c08f4d105e73 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -60,6 +60,7 @@
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>  #define BAUDRATE_SETTLE_TIMEOUT_MS	300
> +#define POWER_PULSE_TRANS_TIMEOUT_MS	1000

I still doubt that this mega-timeout of 1s is needed, but it shouldn't
do any harm either, so whatever ...

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
> +	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
>  
>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1029,21 +1029,19 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
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
> +	serdev_device_wait_until_sent(hu->serdev, timeout);
>  
> -	/* Wait for 100 uS for SoC to settle down */
> +	/* Wait for 100 uS for SoC to settle down for the received byte. */

I don't think 'for the received byte' adds much value here. If you
respin anyway I'd suggest to leave the comment as is.

>  	usleep_range(100, 200);
>  	hci_uart_set_flow_control(hu, false);
>  
> @@ -1116,7 +1114,6 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  
>  static int qca_wcn3990_init(struct hci_uart *hu)
>  {
> -	struct hci_dev *hdev = hu->hdev;
>  	struct qca_serdev *qcadev;
>  	int ret;
>  
> @@ -1139,12 +1136,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
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
> @@ -1274,13 +1271,8 @@ static const struct qca_vreg_data qca_soc_data = {
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

Looks good to me besides possible minor improvements:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
