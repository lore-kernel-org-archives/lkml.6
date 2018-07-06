Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D37322B1C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BgphqTLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D37322B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeGFWf3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:35:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45516 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbeGFWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:35:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9-v6so52496pgp.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eAisAeWpa4NmFtF1L0ywHV6fjDeTIIXqjKpWPSKeDk=;
        b=BgphqTLQdgvhJbPPHtWU1JsbhvpHjSB7Ly0Hp3mMIssgfBPXX9bs1ilYIOwe5rFjnw
         hD1wMCINCXuDGBn9trsHmV3aBFvRfpYaVKKBwVm4ddHYpgCj4gh6dSSkRnHUvLt/Z/Ig
         zwlprz7ZoNxnpU40qCEpYn/BIp+lF9UVKzYf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eAisAeWpa4NmFtF1L0ywHV6fjDeTIIXqjKpWPSKeDk=;
        b=alAhWoR00+rnLaFZK4xkbFAwuTK//eURdKvmrIJj1wgidFQG/e9GJa9pbddut96y2L
         G65OI/WPLF0Yi/pj69hx6dN5RVNKaaPZpKi+dZcTFQKAUAWlKHQgLX1ABdd47ro4HQHi
         JHCfLjppJ+ZE2CUb7j+HuFxOcIsIeo1tz6KPkjdF8de07KaZ0/67v4NrgDxdI3J4lQfD
         sAP6unjp9kPGKkKfGq22Hl0ni3PGrx8WD1+uALkh1afXJtF55rBJBc4IqC2LYRpAd/Uc
         XP5niyl5T/P1U6nXOFvfOJNswpGqQbY1QJ7g84HSMM8AqalaLJGVEY1+kH5Qx4hkpgaR
         yo6A==
X-Gm-Message-State: APt69E0lypcr+dvOI89PFXzaoSoyQsoKFlQajWxLuVW0wr0o+GzS/lyO
        RGQuHTz5KBKN63DQc2LVvSoO1w==
X-Google-Smtp-Source: AAOMgpepIYdmBqU2U4ThBeYDquo94T+POGMoU+g7En0W1UnEBYbeIoz3Ya6x7bXRSdGqRoaERu2itQ==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr10828512pgd.172.1530916525724;
        Fri, 06 Jul 2018 15:35:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z25-v6sm12685502pgu.53.2018.07.06.15.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 15:35:25 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:35:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180706223524.GL129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705165515.13340-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:25:11PM +0530, Balakrishna Godavarthi wrote:
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
> Changes in v9:
>    * moved qca_read_soc_ver() to qca_setup().
> 
> Changes in v8:
>     * updated soc_type with enum.
> 
> Changes in v7:
>     * initial patch
>     * redefined qca_uart_setup function to generic.
> ---
>  drivers/bluetooth/btqca.c   | 17 ++++-------------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c | 11 ++++++++++-
>  3 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..03bcbaaf1ae9 100644
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
> @@ -337,19 +337,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>  
>  	config.user_baud_rate = baudrate;
>  
> -	/* Get QCA version information */
> -	err = qca_read_soc_version(hdev, &rome_ver);
> -	if (err < 0 || rome_ver == 0) {
> -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
> -		return err;
> -	}
> -
> -	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
> -
>  	/* Download rampatch file */
>  	config.type = TLV_TYPE_PATCH;
>  	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
> -		 rome_ver);
> +		 soc_ver);
>  	err = qca_download_firmware(hdev, &config);
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> @@ -359,7 +350,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
>  	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
> -		 rome_ver);
> +		 soc_ver);
>  	err = qca_download_firmware(hdev, &config);
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 5c9851b11838..a9c2779f3e07 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -124,10 +124,18 @@ struct tlv_type_hdr {
>  	__u8   data[0];
>  } __packed;
>  
> +enum qca_btsoc_type {
> +	QCA_INVALID = -1,
> +	QCA_AR3002,
> +	QCA_ROME,
> +	QCA_WCN3990
> +};
> +
>  #if IS_ENABLED(CONFIG_BT_QCA)
>  
>  int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
> +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +		   enum qca_btsoc_type soc_type, u32 soc_ver);
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
>  
>  #else
> @@ -137,7 +145,8 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> +static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> +				 enum qca_btsoc_type soc_type, u32 soc_ver)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index d7b60669b656..c02e1d465cca 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -929,6 +929,7 @@ static int qca_setup(struct hci_uart *hu)
>  	struct qca_data *qca = hu->priv;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>  	int ret;
> +	int soc_ver = 0;
>  
>  	bt_dev_info(hdev, "ROME setup");
>  
> @@ -965,8 +966,16 @@ static int qca_setup(struct hci_uart *hu)
>  		host_set_baudrate(hu, speed);
>  	}
>  
> +	/* Get QCA version information */
> +	ret = qca_read_soc_version(hdev, &soc_ver);
> +	if (ret < 0 || soc_ver == 0) {
> +		bt_dev_err(hdev, "QCA Failed to get version (%d)", ret);
> +		return ret;
> +	}
> +	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);

As commented on [1] I'd suggest to move some of the logging and error
handling to qca_read_soc_version(), especially since this sequence is
duplicated later in this series.

Not really the scope of this patch though, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

[1] https://patchwork.kernel.org/patch/10510029/
