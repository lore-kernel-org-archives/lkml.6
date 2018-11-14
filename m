Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445DAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24CB214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwYppH7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24CB214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbeKNL4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 06:56:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42723 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbeKNL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 06:56:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so4231386pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mkDhlP+vnX9nlcZ05WMCnjnXQtdM1dvqSuPMuNK8H8g=;
        b=GwYppH7DxBaANVuE/9CpvdsInLaNmJUFdk5cDHduveMa85uwtv1/SLEZTs4gphalpA
         tqHrJqGwpX72t+N8TTArvjyv9svJ3t9cEu0qGfofuqoN4cMmXoj7bJbG6/xAlSnG7ew6
         9LzPQL2OTcnNkGPVI4bZQJ43sc9bUBFaZx/J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkDhlP+vnX9nlcZ05WMCnjnXQtdM1dvqSuPMuNK8H8g=;
        b=OQO0UaLGjIP/8o0hDycR9sUVyG5HBgeuf41DkV5RsswnFVdgFTthO9W7z+b9QAZVvN
         XRyG7D3u1JDDekC5rTnC6e1t4SL6QCVrMdeueZM6FiFh5+1+2m8KSKUEtZbv+lKY6JuF
         Jsg4A/Zc5ZWmXTOpQ0lcWlSDvuVX1luGWfq/3R/8+s0x/o5YBgQDJxYTyOBI15Zh9jk2
         GjZIdTHcr3LSMf/VUKB3Ro0zGsyrujlYWHhM+0cLVzCvwuOgsPecht6DA0t11+CpLqVG
         zAcpbuHF6Xm2pyNCATdN93Mi5HefJVMsVUrrMl5DmYymDOs5ASAJYaAs9fw00HeI1Ogt
         84yQ==
X-Gm-Message-State: AGRZ1gKqIKXI7cYB2LAWC5pXTJTWeD6Ez2eI/34X+D5OJzgrhyhwTKKz
        GuIWSH2DGTwenGHloHfc7Z7k+g==
X-Google-Smtp-Source: AJdET5ehskN547xGoFPBB3qc2LzXzISQGt6bpnAqoIuRkU7XV/ZO0XPlWjp9WjYMVpZCTd5gZetDCA==
X-Received: by 2002:a17:902:bd8e:: with SMTP id q14mr3195633pls.146.1542160506513;
        Tue, 13 Nov 2018 17:55:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id q195sm21810305pgq.7.2018.11.13.17.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 17:55:05 -0800 (PST)
Date:   Tue, 13 Nov 2018 17:55:04 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] Bluetooth: hci_qca: Pull RTS line high for
 baudrate change command
Message-ID: <20181114015504.GH22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106120528.30342-3-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:35:26PM +0530, Balakrishna Godavarthi wrote:
> This patch will pull the RTS line high instead of turning off the
> flow control, while changing baudrate of host and chip.

Please don't only describe what is changed, but also why this change
is necessary.

IIUC the BT chip honors flow control during baudrate changes, however
it sometimes sends 'garbage' which results in "Bluetooth: hci0: Frame
reassembly failed (-84)" messages.

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 051f081d1835..8301663f0004 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -963,7 +963,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>  	struct qca_data *qca = hu->priv;
>  	struct sk_buff *skb;
> -	struct qca_serdev *qcadev;
>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>  
>  	if (baudrate > QCA_BAUDRATE_3200000)
> @@ -977,13 +976,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  		return -ENOMEM;
>  	}
>  
> -	/* Disabling hardware flow control is mandatory while
> -	 * sending change baudrate request to wcn3990 SoC.
> -	 */
> -	qcadev = serdev_device_get_drvdata(hu->serdev);
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> -		hci_uart_set_flow_control(hu, true);
> -
>  	/* Assign commands to change baudrate and packet type. */
>  	skb_put_data(skb, cmd, sizeof(cmd));
>  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> @@ -999,9 +991,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>  	set_current_state(TASK_RUNNING);
>  
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> -		hci_uart_set_flow_control(hu, false);
> -
>  	return 0;
>  }
>  
> @@ -1086,6 +1075,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
> +	struct qca_serdev *qcadev;
>  	int ret;
>  
>  	if (speed_type == QCA_INIT_SPEED) {
> @@ -1097,6 +1087,14 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		if (!speed)
>  			return 0;
>  
> +		/* Pulling RTS line to high is mandatory while sending change
> +		 * baudrate request to SoC and also while setting the host
> +		 * baudrate.
> +		 */

Instead of just stating that this is 'mandatory' explain why it is
needed. Also better say 'Deassert RTS' instead of the more lower level
'Pulling RTS line to high'. It could be something like 'Deassert RTS
to prevent the BT controller from sending garbage during the baudrate
change.'

> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		if (qcadev->btsoc_type == QCA_WCN3990)
> +			serdev_device_set_rts(hu->serdev, false);
> +
>  		qca_baudrate = qca_get_baudrate_value(speed);
>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> @@ -1104,6 +1102,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  			return ret;
>  
>  		host_set_baudrate(hu, speed);
> +
> +		if (qcadev->btsoc_type == QCA_WCN3990)
> +			serdev_device_set_rts(hu->serdev, true);
>  	}
>  
>  	return 0;

Tested-by: Matthias Kaehlcke <mka@chromium.org>
