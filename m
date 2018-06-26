Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72E2263AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZCgHPq6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72E2263AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935018AbeFZBGI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:06:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32785 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeFZBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:06:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so6840358pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnvwAyj8ZtH00+Wn+SIacL5vPle4pk+pMqZqrDXiS4g=;
        b=ZCgHPq6f5OIzGiDQFxqVcg2lsAKybFvY51la3LyNNnPzSBuuUzwDJUDbBYFM8Dc+ww
         Zjlgl2GKj/iUMRc9mQQCpoEiMbSuXp6BChhflG80xOjFO/kcKVuA5UwU3Geyvx9bKmXg
         qrieXLSv2vAO2ja1zDWbFU+z/+cXBshcgP6pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnvwAyj8ZtH00+Wn+SIacL5vPle4pk+pMqZqrDXiS4g=;
        b=kOr/SbHOatpgXBhVkLC2mABv1z7epdC32xgep9EdVYr4xkvLGSXlQNq+N8QM4YPwt9
         heyFkfnTqpex3OiqKDhuzaKAqVPMXXACQ5oKU0pQ3SBPlPm0lPPguAabUoeoVdc5uXzB
         5Yz+u25M6Utnn5DWLMi+qwJUdM/m+eg9Tbmqw+Ir6k12JtqlKeq5A8UAEEn2hUwI+xCZ
         GB8H6OckyCpgMrSE0rM4zQTkdLcUDq+zKFRIS6J2VuHMSZDU5XlT30+eGKGeuSpethZb
         VW/io3HbIB2/hK9oAjiktkWYMxWhPi7DeoDiG2OSK2DNBH0uGbC6bZkM4jH2Ua+EahFs
         g/Mw==
X-Gm-Message-State: APt69E2anIa3AQ22B5pGGLDmctZqOyriYwn6q0CypR90ruM39FYnnFy2
        j42DEvhe95ZfdoC4Ab53Q7YHRQ==
X-Google-Smtp-Source: ADUXVKLP6BLMVfXsDc3Se2Wv5luw4K00w30krtA/VerwBhewz5U6yD9byZYJYAhxvzilLA8g95hpXQ==
X-Received: by 2002:a65:4783:: with SMTP id e3-v6mr12624428pgs.235.1529975160800;
        Mon, 25 Jun 2018 18:06:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id k9-v6sm313685pfc.179.2018.06.25.18.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 18:06:00 -0700 (PDT)
Date:   Mon, 25 Jun 2018 18:05:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180626010559.GK129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-8-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625134013.19684-8-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 07:10:13PM +0530, Balakrishna Godavarthi wrote:
> Add support to set voltage/current of various regulators
> to power up/down Bluetooth chip wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> changes in v8:
>     * closing qca buffer, if qca_power_setup fails
>     * chnaged ibs start timer function call location.
>     * updated review comments.
>   	
> changes in v7:
>     * addressed review comments.
> 
> changes in v6:
>     * Hooked up qca_power to qca_serdev.
>     * renamed all the naming inconsistency functions with qca_*
>     * leveraged common code of ROME for wcn3990.
>     * created wrapper functions for re-usable blocks.
>     * updated function of _*regulator_enable and _*regualtor_disable.  
>     * removed redundant comments and functions.
>     * addressed review comments.
> 
> Changes in v5:
>     * updated regulator vddpa min_uV to 1304000.
>       * addressed review comments.
>  
> Changes in v4:
>     * Segregated the changes of btqca from hci_qca
>     * rebased all changes on top of bluetooth-next.
>     * addressed review comments.
> 
> ---
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 28187a89b850..bd4c9a78716f 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> ...
> +static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +	struct sk_buff *skb;
> +
> +	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
> +
> +	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> +	if (!skb) {
> +		bt_dev_err(hdev, "Failed to allocate memory for vendor packet");

As mentioned on v7, custom OOM messages should be avoided.

>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
> +	struct qca_serdev *qcadev;
>  	unsigned int speed, qca_baudrate;
>  	int ret;
>  
> @@ -971,6 +1054,13 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		return 0;
>  	}
>  
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +	/* Disabling hardware flow control is preferred while
> +	 * sending change baud rate command to SoC.
> +	 */

Is it only preferred or must be?

> +	if (qcadev->btsoc_type == QCA_WCN3990)
> +		hci_uart_set_flow_control(hu, true);
> +

nit: consider doing this just before qca_set_baudrate(). It doesn't
make a difference but leaves it clearer what exactly needs to be
'protected' (analogy to locking).

>  	qca_baudrate = qca_get_baudrate_value(speed);
>  	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>  	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> @@ -980,8 +1070,10 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  	}
>  
>  	host_set_baudrate(hu, speed);
> +	if (qcadev->btsoc_type == QCA_WCN3990)
> +		hci_uart_set_flow_control(hu, false);

>  static int qca_setup(struct hci_uart *hu)
> @@ -989,10 +1081,11 @@ static int qca_setup(struct hci_uart *hu)
>  	struct hci_dev *hdev = hu->hdev;
>  	struct qca_data *qca = hu->priv;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> +	struct qca_serdev *qcadev;
>  	int ret;
>  	int soc_ver = 0;
>  
> -	bt_dev_info(hdev, "ROME setup");
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>  
>  	/* Patch downloading has to be done without IBS mode */
>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> @@ -1000,6 +1093,35 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup initial baudrate */
>  	qca_set_speed(hu, QCA_INIT_SPEED);
>  
> +	if (qcadev->btsoc_type == QCA_WCN3990) {
> +		bt_dev_dbg(hdev, "setting up wcn3990");
> +		hci_uart_set_flow_control(hu, true);
> +		ret = qca_send_vendor_cmd(hdev, QCA_WCN3990_POWERON_PULSE);
> +		if (ret)
> +			return ret;
> +
> +		hci_uart_set_flow_control(hu, false);
> +		serdev_device_close(hu->serdev);
> +		ret = serdev_device_open(hu->serdev);
> +		if (ret) {
> +			bt_dev_err(hdev, "failed to open port");
> +			return ret;
> +		}
> +
> +		msleep(100);

Is the sleep really related with _open() or is it rather that the
device needs to settle after the power on pulse? In the latter case
I'd suggest to do the sleep before _open(), if it doesn't make a
functional difference (makes the code a bit more self documenting).

> +		/* Setup initial baudrate */
> +		qca_set_speed(hu, QCA_INIT_SPEED);
> +		hci_uart_set_flow_control(hu, false);

This is still a bit noisy with all the open/close and flow control
stuff. If I understand correctly this essentially switches the
controller on (or resets it?) and brings it (and the driver) into a
sane state. Would it make sense to move the above block into a
wcn3990_init/reset() or so?
