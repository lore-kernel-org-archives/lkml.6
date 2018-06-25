Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96090C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BB262A8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VqvxiRxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6BB262A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755717AbeFYXVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:21:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33229 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFYXU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:20:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so7169183pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CXwvg4jdzXe1+J/Zq2xdWO8h+iEXCW4vj1lAjZYRdL8=;
        b=VqvxiRxVns4QM5eppNQyYCi+Iw75i2Ydbc9tH1eqgnQtLqFOiGo5i+H5GXF8fjFGIt
         cVIUHwEGSu6wX9lzYFmHFU5eKbjYTGAHgs7WvFWmnX5GGYKQw6tticdwpJR4IQfA+VuA
         NrsFLmLBs4ngbq5Rra48iuCIqV8nC4nTMYs2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CXwvg4jdzXe1+J/Zq2xdWO8h+iEXCW4vj1lAjZYRdL8=;
        b=WZ0trICly/of8aigcZDRNqgpFonfaDysw1aW0sJ+Jrfem6l7F+BeVKApie1V1j3ZXh
         0AoePM2+ryFy9wknHDHP7HY+lXQ/OrirVWVi5RVpXRuRu/YyMKlPFWlnZUVV7ZkwaC6Y
         MH+GOZbXEmXh9M6Or9hCKjDGOZtAxBawQuPq0W7VLme0WJa+6E73FltHu98ZnCO1HrOR
         sHvObCkkhJg8d/PnhRcz0Q9iG8xjpXMZqJ5PylesmI7w8ePqayS9L10mXHwMm1tqOzzY
         T9+xu5dAdEqO96b9pbc8/sjrJBEZXPuHgCBEBhZ9vWGP0nAri3RikGbwClSH+lSDIZw8
         U8BQ==
X-Gm-Message-State: APt69E32Rc855i7AW09zCcDkx0qrpyeNwp187E6wJaP2jd8nU7QURVjD
        gc4XLrAxfjukfXbWqiCvwTpUGg==
X-Google-Smtp-Source: ADUXVKIa0NHp8jzDLGtbgnLEheX5VfoJYFSvlT83AMlJGLoYQ0P7xce8K/AIAeyO8TJpArL/FlfIDg==
X-Received: by 2002:a65:444d:: with SMTP id e13-v6mr3900024pgq.122.1529968858606;
        Mon, 25 Jun 2018 16:20:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id g12-v6sm114032pfh.164.2018.06.25.16.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 16:20:58 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:20:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180625232057.GH129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625134013.19684-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 07:10:09PM +0530, Balakrishna Godavarthi wrote:
> Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
> SoC, to use the same function instead of duplicating the function.
> Added new arguments soc_type and soc_ver to the functions.
> 
> These arguments will help to decide type of firmware files
> to be loaded into Bluetooth chip.
> soc_type holds the Bluetooth chip connected to APPS processor.
> soc_ver holds the Bluetooth chip version.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v8:
>     * updated soc_type with enum.
> 
> Changes in v7:
>     * initial patch
>     * redefined qca_uart_setup function to generic.
> ---
>  drivers/bluetooth/btqca.c   | 23 ++++++++++++-----------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c |  3 ++-
>  3 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..3b25be1be19c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>  
> -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +		   enum qca_btsoc_type soc_type, u32 soc_ver)
>  {
> -	u32 rome_ver = 0;
>  	struct rome_config config;
>  	int err;
>  
> @@ -337,19 +337,20 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>  
>  	config.user_baud_rate = baudrate;
>  
> -	/* Get QCA version information */
> -	err = qca_read_soc_version(hdev, &rome_ver);
> -	if (err < 0 || rome_ver == 0) {
> -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
> -		return err;
> +	if (!soc_ver) {
> +		/* Get QCA version information */
> +		err = qca_read_soc_version(hdev, &soc_ver);
> +		if (err < 0 || soc_ver == 0) {
> +			bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> +			return err;
> +		}
> +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>  	}

I thought we agreed in the discussion on "[v7,4/8] Bluetooth: btqca:
Redefine qca_uart_setup() to generic function" to call
qca_read_soc_version() in common code. Did I misinterpret that?

> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 5c9851b11838..24d6667eecf1 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> ...
> -static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> +static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +				 enum qca_btsoc_type soc_type, u32 soc_ver);

Remove trailing semicolon.
