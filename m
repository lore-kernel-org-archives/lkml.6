Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5091C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B278622360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VhfquosB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B278622360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeKOFky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:40:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38295 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeKOFky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:40:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4-v6so8257052plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nm/2wI5AEDIbrgPhv4v8syD5aJvTbh1Twc4e5rNF9O0=;
        b=VhfquosBG+l5R9LT/oKenw5GzeU7KrEBA5UR4Bp1IG7udu1RANBEPWVHK4ImUSYi6d
         3K/YtP6gMYNOL71rBrf32MWyB9h3ILXXEteuL8mAfhhCkXBmdX6LcNH0TmIEQlOj7tIW
         1VkWcx9vJH5HmNo0IZnxqMP838zzep2XBqznA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nm/2wI5AEDIbrgPhv4v8syD5aJvTbh1Twc4e5rNF9O0=;
        b=XDdw16ZdgSngstXVIWOfpq9nxkSbNUxJmj3RzFfANuRVsSqHQz1OHp1bpS+IjvQKVC
         rEOHdBC3iUs9zeR/9CxII6Zgeb1hhIp/TfVnyYZ35C7pOHQu3OeNlNe3NMqBYEV2pbil
         uRjvY4d5A2P6uFS2T3ILhBsB+XV/2VBPt63eD6LDw58CHoPnLx6khsx0IeiWXFmQO0QE
         PZqhl+cMMvYzvJo4VgIbDpA3weBH7h51ePIJgLx4nxLO06qiaz4vuxWCW5LKXxAy+CgN
         f/R+Wxr4n47+oub4om9cv4QNOQco77Q2STtY9ghoo2+l5hlsMInlH/UoK0G++OPaBjNS
         kXyw==
X-Gm-Message-State: AGRZ1gLCRYjSOGjZnrS8MJEm3MjJoxk+z0zqdatuxVJOnPwTuVK56X8f
        f2UhG6uG3fUZGv4yk/WqDiBUNw==
X-Google-Smtp-Source: AJdET5evO9r20rlx1RgYipBp1aUoFIaiKt9SwygkrPVgXjYZEEIjlyNiSpn7TmdT0OIBzsn95zQaaA==
X-Received: by 2002:a17:902:4523:: with SMTP id m32-v6mr3016165pld.276.1542224182027;
        Wed, 14 Nov 2018 11:36:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o81-v6sm39197466pfa.170.2018.11.14.11.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:36:21 -0800 (PST)
Date:   Wed, 14 Nov 2018 11:36:20 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 4/4] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
Message-ID: <20181114193620.GJ22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-5-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106120528.30342-5-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:35:28PM +0530, Balakrishna Godavarthi wrote:
> [  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> 
> The above errors log on console due to receiving of stray bytes
> when wcn3990 boot up's i.e. when during initial setup procedure.

Please shortly introduce the topic instead of starting with the log
messages.

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 97b57e0f4725..341f80606574 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -56,6 +56,7 @@
>  
>  /* Controller states */
>  #define STATE_IN_BAND_SLEEP_ENABLED	1
> +#define STATE_DISCARD_RX		2
>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> @@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
>  		} else {
>  			hu->init_speed = qcadev->init_speed;
>  			hu->oper_speed = qcadev->oper_speed;
> +			set_bit(STATE_DISCARD_RX, &qca->flags);
>  			ret = qca_power_setup(hu, true);
>  			if (ret) {
>  				destroy_workqueue(qca->workqueue);
> @@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
>  	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>  		return -EUNATCH;
>  
> +	/* We discard Rx data received while device is in booting
> +	 * stage, this is due multiple baudrate switch is causing
> +	 * UART to read some garbage data.
> +	 */

This isn't entirely correct. I saw frame reassembly errors before
qca_wcn3990_init() is called, i.e. no baudrate changes. Some of the
garbage seems to be sent shortly after powering on the controller.

> +	if (test_bit(STATE_DISCARD_RX, &qca->flags))
> +		return 0;
> +
>  	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
>  				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
>  	if (IS_ERR(qca->rx_skb)) {
> @@ -1192,10 +1201,12 @@ static int qca_setup(struct hci_uart *hu)
>  		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>  		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>  		hu->hdev->shutdown = qca_power_off;
> +
>  		ret = qca_wcn3990_init(hu);
>  		if (ret)
>  			return ret;
>  
> +		clear_bit(STATE_DISCARD_RX, &qca->flags);
>  		ret = qca_read_soc_version(hdev, &soc_ver);
>  		if (ret)
>  			return ret;
> @@ -1278,8 +1289,15 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	struct serdev_device *serdev = hu->serdev;
>  	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
>  
> -	host_set_baudrate(hu, 2400);
> +	/* From this point we go into power off state,
> +	 * disable IBS and discard all the queued data.
> +	 */
> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	set_bit(STATE_DISCARD_RX, &qca->flags);
> +	qca_flush(hu);
> +
>  	hci_uart_set_flow_control(hu, true);
> +	host_set_baudrate(hu, 2400);
>  	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
>  	serdev_device_wait_until_sent(serdev, 0);
>  	hci_uart_set_flow_control(hu, false);

This change won't win a beauty price, but it seems it is needed to
suppress the 'frame reassembly' spam, unless the controller can be
convinced to stop sending garbage in the first place.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
