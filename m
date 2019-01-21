Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D8C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473AA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548060989;
	bh=ljoqcITDvkcqTfkTIOdLmre0eIJ7TDdk3SpkC0S0AGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nHZe5iLSIjAcVGRwNctcROjm4WJHBaI04x+gH9JIyFHOq6Vw+jh7gvFm38y2fAjiI
	 XsCZj1w7ePQ0PbV94kSCQ1Mv4lnIdmwkrU1IT0hSTsvzDhioHB9hh3ViAaDe8g+lNI
	 SzUK4h6To/CR2XjTlt6ynV92BbtkxMVA8NosanMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfAUI41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:56:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39038 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfAUI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:56:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so16810872ljh.6;
        Mon, 21 Jan 2019 00:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71c5hyAY1EO0S0MOpM0Em5vA0o1Gvicjzd3MBEoNQCA=;
        b=YSjUJuA3k/wPEQzhAm5g9oTNo9Bl+8XeOO/Fywk+2447YnrmRNLPv1axuiWOIHAejE
         YlWy8DZdoh9I4HlLGQ3/GIbRC7WKsyn2sLy5kGWlzjVyx585Cvr9McP6yEP83HkWY5dX
         F7YUrsDRBS8TrJoNGFqVWo0hBxxrob+m4lNrJEU+uxiQPQFprfEo+1Unia434/BFCBKY
         G43uyMYHcA6bZGK7xKbeOLd4tFb8vBQLJ4AaqB8tj32yrxwaMCQp+cMIOb2ojswe9JJ0
         rG+3z2bZAl9FIynS57jV+OyoN63omlWfAJgidsCwpmsXO3QwoL3pT2lZ9/wu6C7IBbtY
         9taw==
X-Gm-Message-State: AJcUukf6xAlmcodI5xv4Emo5ia2biMAfnmtkZxNpgy/aWU+pCwkskJ2P
        zJfLkztVvPmXwbHMqmH3FdgM22rZ
X-Google-Smtp-Source: ALg8bN5V5F7mb0JqjYWPXZkemIKmk0W2dwrw8GFZ1oJPMXrJUKMnH9xI044Gfv2KhSpp+0encx/5Xw==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr1782139ljy.157.1548060980222;
        Mon, 21 Jan 2019 00:56:20 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f1sm2172504lfm.22.2019.01.21.00.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 00:56:19 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glVNN-0000QF-T7; Mon, 21 Jan 2019 09:56:14 +0100
Date:   Mon, 21 Jan 2019 09:56:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190121085613.GG3691@localhost>
References: <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
 <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com>
 <20190118094416.GB3691@localhost>
 <20190119003109.GD261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119003109.GD261387@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:31:09PM -0800, Matthias Kaehlcke wrote:
> On Fri, Jan 18, 2019 at 10:44:16AM +0100, Johan Hovold wrote:
> > On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:
> > 
> > > I observed that the qcom_geni_serial driver doesn't raise RTS with
> > > flow control disabled. It seems we have to investigate why that's the
> > > case. I agree that the driver should be platform agnostic.
> > 
> > Sounds like a driver bug, unless the hardware is just "odd". The
> > driver implementation of this looks very non-standard judging from a
> > quick peek.
> > 
> > In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
> > flow control is not enabled:
> > 
> > 	if (uart_console(uport) || !uart_cts_enabled(uport))
> > 		return;
> > 
> > Perhaps dropping the !uart_cts_enabled() test is sufficient.
> 
> Thanks for taking a look Johan, that was indeed the problem (also
> in set_mctrl()). I posted a fix: https://lore.kernel.org/patchwork/patch/1033611/

Nice (I did mean set_mctrl() above, as I think you noticed).

> Balakrishna, the following (applied on top of your patch) works for me
> with the UART patch above:
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9d5e41f159c78f..60bfdf01f72841 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1080,7 +1080,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
>  	struct qca_serdev *qcadev;
> -	int ret;
> +	int ret = 0;
>  
>  	if (speed_type == QCA_INIT_SPEED) {
>  		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> @@ -1097,22 +1097,27 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		 * the old speed.
>  		 */
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +		if (qcadev->btsoc_type == QCA_WCN3990) {
> +			hci_uart_set_flow_control(hu, true);

Wow, yeah, this parameter inversion is indeed confusing...

>  			serdev_device_set_rts(hu->serdev, false);
> +		}

But looking at hci_uart_set_flow_control() now, it actually also
deasserts RTS. So all you need here is the hci_uart_set_flow_control()
call.  

And that makes the inversion make a bit more sense too, even if the
naming is a bit unfortunate with respect to
serdev_device_set_flow_control() at least.

>  		qca_baudrate = qca_get_baudrate_value(speed);
>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>  		if (ret)
> -			return ret;
> +			goto out;
>  
>  		host_set_baudrate(hu, speed);
>  
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +out:
> +		if (qcadev->btsoc_type == QCA_WCN3990) {
> +			hci_uart_set_flow_control(hu, false);
>  			serdev_device_set_rts(hu->serdev, true);
> +		}

And same here.

Johan
