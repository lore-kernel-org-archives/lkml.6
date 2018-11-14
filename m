Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBCEC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BC7224E0
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCEWcqXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BC7224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbeKOBbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:31:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39611 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbeKOBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:31:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so11803075lfh.6;
        Wed, 14 Nov 2018 07:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxuyA6K3eFznfbr2HJR5peke0YfBJniX+SvMsHc8lJU=;
        b=sCEWcqXvyQMq7WjKCExXW+cCb9Rv6DY/CJlcmInQ+jVqe+v32DYYNFL4/6bt66ZFNj
         CjNefWx/GvtfM4yjl+EwjSS5RgnHt65SZw8Z4Qyzy2ZISvTgSAE3NFVjp3PECilXNfmx
         OyI5K6fpbaewwBme7czFC0N+yhzAraBHWoZgLrVKCajXeDORJL5BZbOT4VFqHrUyw9Bh
         KKlcI6R9Go5MBdqsnP98X9hjpj1HShluA4vboh2mlCN+M0CP12BTzA2VxtkzmMZi/Kzy
         uA5+yTTQmPl6k/yYHj+o053P7MAvd8Qcr05uSUr36zdFh1NKOEmF6mF3c61GaM5ViUaA
         dafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxuyA6K3eFznfbr2HJR5peke0YfBJniX+SvMsHc8lJU=;
        b=Al6+dmDlkj23VnWhCoUqmeMLwVC9bl3QZOCS9rFMAsYQF8VdwA5NLKeYBwulmiEnhh
         Hh/nIoGuGCbuN9jjA3aXqmhzzbjcznZIoNU6VAaxfjiOUBC/ZGwHm0l43TidL09cwrYw
         LiB+MEnavo+cb+sHO6/uyD/TprvYLEdR8r53Ngc/FUpVhf/tpubAoixipT4Vt7DCQI2H
         H7L9f+A5gUwtZqjv+Al+sM+qHZGC5UTF2QgPeSufYIJnGkMCnGU7fY5RoH4QPiXKJ7EZ
         kBlpwwxrHegH6UxbuZyrB7a0/5ZPnNeC7m9duMrp/p7WrYio7KdMqzU9FlyzsDLaIcQo
         wvnw==
X-Gm-Message-State: AGRZ1gK3AkIYsnDBMdSF/VfRuJRFJZWTzftIPj2SZ9Eoe9Gr3REiYi9n
        VoKJ/c1p/vKAwBm0Ypq2EOE=
X-Google-Smtp-Source: AJdET5fL8RlXSAVhJgY6Ojly6xH0/+zgBhgP4LVL9SwPb5V1McZHE48KGnY63ujexAGKH0IPO8eNSw==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr1254108lff.88.1542209246335;
        Wed, 14 Nov 2018 07:27:26 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i78sm3968314lfa.9.2018.11.14.07.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:27:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gMx4c-0005H9-T4; Wed, 14 Nov 2018 16:27:22 +0100
Date:   Wed, 14 Nov 2018 16:27:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181114152722.GA19900@localhost>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106120528.30342-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Don't you want a non-zero timeout here? Otherwise you might as well call
serdev_device_write() directly.

Also have you made sure that serdev_device_write_wakeup() is called in
the drivers write-wakeup callback as serdev_device_write() requires?

See this series in case what you really wanted was to wait indefinitely
(you can use MAX_SCHEDULE_TIMEOUT):

	https://lkml.kernel.org/r/<20181114150904.19653-1-johan@kernel.org>

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
> @@ -1283,7 +1278,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  
>  	host_set_baudrate(hu, 2400);
>  	hci_uart_set_flow_control(hu, true);
> -	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
> +	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);

Same here.

> +	serdev_device_wait_until_sent(serdev, 0);
>  	hci_uart_set_flow_control(hu, false);
>  	qca_power_setup(hu, false);
>  }

Johan
