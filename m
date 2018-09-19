Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AE52150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QYoCNjSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AE52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbeISXAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:00:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33084 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732929AbeISXAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:00:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so3034370pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WnOCvoGqrkd4ntUXKQT7gBx5A1LjS48ql2JobwcP4Ow=;
        b=QYoCNjSHQqUmY0MIdJSXcUJw/ln5X0JTnh6o2neTynngW0E9s4lxf0BiTBLNKBq6dc
         3jViMI9M6KS+IlMmIZQPGGhFWWGa4W8sZjH99iD6oW8oBlF1ELN6WuLS6D4drIlIVc4C
         vkzhdNWadzmdRImHkpkpUyEN12V87IRdkjK6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WnOCvoGqrkd4ntUXKQT7gBx5A1LjS48ql2JobwcP4Ow=;
        b=eqgH78ptfVQjxcg8XeGiB5jz4+TyQ3MDWXXxXP7U5ikRaicDpnGrS3R1ABnN61dlT4
         TSxrdjcvTtYKfVCwjxdMuj1VFVgDODcpirp4MQ5CjJqZh56lxcx3U9Ay2S37AMUgz7qM
         7TFihE//Lt9GxhMNkMr2pGy0Ql7QGRBJXg58FNrE4WxDPoUJ38NloQzalfL7VeDwukB4
         6jabBmic79Bm6NsEA2HKyO/b8p93S3bpcCOJ0jBzbCNo/eomLox5+xeiu3TRJZQLCv0Q
         SdGWD60gBg8HqMMXvLi3IsKM+LKNZh8Elzi3swmsAHnuYHrB+qopRIrKPXAth8WTgtJF
         DxLg==
X-Gm-Message-State: APzg51DUSRHu1lei0j7Bofh0cosatPx7uVxelcokbn/cpX6yHhHn7E5v
        VYc5/APyBRG0czuquayQ7zFMMafO9dE=
X-Google-Smtp-Source: ANB0Vda5ofWIzdwmpn2q+guI7oxE36/OfAkul815421iaT2DB3HS8h45MeKynIlsGgWbQD39LhNTuw==
X-Received: by 2002:a65:6406:: with SMTP id a6-v6mr2717853pgv.60.1537377698905;
        Wed, 19 Sep 2018 10:21:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e190-v6sm45065576pfc.81.2018.09.19.10.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:21:38 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:21:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
Message-ID: <20180919172137.GQ22824@google.com>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
 <20180919152113.7611-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180919152113.7611-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 08:51:13PM +0530, Balakrishna Godavarthi wrote:
> This patch enables power off support for hci down and power on support
> for hci up. As wcn3990 power sources are ignited by regulators, we will
> turn off them during hci down, i.e. an complete power off of wcn3990.
> So while hci up, we will call vendor specific open/close and setup which
> will turn on the regulators, requests BT chip version and download the
> firmware.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 74f5fede0274..c3038afa42af 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -168,6 +168,7 @@ struct qca_serdev {
>  
>  static int qca_power_setup(struct hci_uart *hu, bool on);
>  static void qca_power_shutdown(struct hci_uart *hu);
> +static int qca_power_off(struct hci_dev *hdev);
>  
>  static void __serial_clock_on(struct tty_struct *tty)
>  {
> @@ -1099,8 +1100,26 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  static int qca_wcn3990_init(struct hci_uart *hu)
>  {
>  	struct hci_dev *hdev = hu->hdev;
> +	struct qca_serdev *qcadev;
>  	int ret;
>  
> +	/* Check for vregs status, may be hci0 down has turned
> +	 * off the vregs.
> +	 */

nit: it's not necessarily 'hci0', there may be systems with more than
one Bluetooth controller. You could say hciN instead, you might also
want to put quotes around 'hciN down' to make clearer this is
referring to a command.

> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +	if (qcadev->bt_power->vregs_on == false) {

nit:
	if (!qcadev->bt_power->vregs_on) {

is more common and easier to read IMO

> +		serdev_device_close(hu->serdev);
> +		ret = qca_power_setup(hu, true);
> +		if (ret)
> +			return ret;
> +
> +		ret = serdev_device_open(hu->serdev);
> +		if (ret) {
> +			bt_dev_err(hu->hdev, "failed to open port");

switch the regulators off again?

> +			return ret;
> +		}
> +	}
> +
>  	/* Forcefully enable wcn3990 to enter in to boot mode. */
>  	host_set_baudrate(hu, 2400);
>  	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
> @@ -1152,6 +1171,12 @@ static int qca_setup(struct hci_uart *hu)
>  
>  	if (qcadev->btsoc_type == QCA_WCN3990) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> +
> +		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
> +		 * setup for every hci0 up.

nit: 'hciN up'?

> +		 */
> +		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +		hu->hdev->shutdown = qca_power_off;
>  		ret = qca_wcn3990_init(hu);
>  		if (ret)
>  			return ret;
> @@ -1242,6 +1267,14 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	qca_power_setup(hu, false);
>  }
>  
> +static int qca_power_off(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +
> +	qca_power_shutdown(hu);

Would it make sense to add a return value qca_power_shutdown() now
that it is called by a non-void function? Might not be worth the
hassle though, hci_dev_do_close() - the only caller of
hdev->shutdown() - doesn't check the return value either.

Cheers

Matthias
