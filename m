Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F022150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PO8DV/GQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F022150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbeHBTHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:07:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38736 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbeHBTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:07:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so1687898pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzAGkaObs93zKCy/Pg5AiUG09+bjNoD4wPhlYbFM5cw=;
        b=PO8DV/GQetAYW7kphG6MM93bQeovf3yaqLhKbua+py6WpYCXYtrm4CtBDzBOQG4Dco
         oT1V/Z3bfPJ4bJRD01ctHa0EI7DWWPfcpSmlQyKRKMl7bcInFf2XSSRBs+IcmmBBL44c
         ignqpprAoUXBz3onlqU2uSnb50ESVqoEfLo+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzAGkaObs93zKCy/Pg5AiUG09+bjNoD4wPhlYbFM5cw=;
        b=Wa7lqFrx7z+U8Yy7AH9grQZnU1qbiHzb+ZNDyokp6r8WyLMScpYYZH+v/qq9A02EjU
         W2HwgYh+mUxvv8NwsI6rX7sy1qS0sNBFgNSaCw2bneZAI7qX3DNoas3QlHlaRBhPrF35
         0EN3CcNa+5NMMR8AO+BBv1CyJNXjmgvpVCLUQMl2ZIRWZAwDZv2XDZq8DuJYKUthpKAZ
         POkRyMTkXuM6QneGedEJy7oXl+PcRJGtoL5o4FYeC0/QsHAJppqYUwW8+H3OvRlzpsOd
         2Ds+sg8b0sAJa33p2DDv6WdPBgjvXcGLChkPR3+nJTPkRcwyOYZsR5A3s7nLZxbMnKVu
         rcsg==
X-Gm-Message-State: AOUpUlH98Rbk9mRhTMN9Qw56vTLnHMh5RFJorzUvI0xOp6Dxvc+WUmas
        vpTBVOJcvUjuSU7nYUr6Ut6i5Q==
X-Google-Smtp-Source: AAOMgpeeOyv87r1eBar2ub2wLG/kd5OHHgg5xKtOCdx15u7ufufE/1RbBrk5U9tOWqj4TA8cHPyi3Q==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr338018pfj.175.1533230119673;
        Thu, 02 Aug 2018 10:15:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id u83-v6sm9153417pfj.37.2018.08.02.10.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 10:15:18 -0700 (PDT)
Date:   Thu, 2 Aug 2018 10:15:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v12 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180802171518.GM68975@google.com>
References: <20180802132518.8680-1-bgodavar@codeaurora.org>
 <20180802132518.8680-8-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180802132518.8680-8-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

only two minor comments, though I hate to make you respin once more
for nits. I also noticed a possible error in the DT bindings, so maybe
you'd have to respin anyway ...

On Thu, Aug 02, 2018 at 06:55:18PM +0530, Balakrishna Godavarthi wrote:
> Add support to set voltage/current of various regulators
> to power up/down Bluetooth chip wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v12:
>     * removed retrying iteration loop in qca_wcn3990_init.
>  
> Changes in v11:
>     * removed support to read regulator currents from dts.	
>     * updated review comments.
> 
> Changes in v10:
>     * added support to read regulator currents from dts.
>     * added support to try to connect with chip if it fails to respond to initial commands
>     * updated review comments.
> 
> changes in v9:
>     * moved flow control to vendor and set_baudarte functions.
>     * removed parent regs.
> 
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
>  drivers/bluetooth/btqca.h   |   3 +
>  drivers/bluetooth/hci_qca.c | 404 +++++++++++++++++++++++++++++++-----
>  2 files changed, 360 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index a9c2779f3e07..0c01f375fe83 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -37,6 +37,9 @@
>  #define EDL_TAG_ID_HCI			(17)
>  #define EDL_TAG_ID_DEEP_SLEEP		(27)
>  
> +#define QCA_WCN3990_POWERON_PULSE	0xFC
> +#define QCA_WCN3990_POWEROFF_PULSE	0xC0
> +
>  enum qca_bardrate {
>  	QCA_BAUDRATE_115200 	= 0,
>  	QCA_BAUDRATE_57600,
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a6e7d38ef931..24ce42babe6d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
>
> ...
>
> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	int ret;
> +
> +	/* Forcefully enable wcn3990 to enter in to boot mode. */
> +	host_set_baudrate(hu, 2400);
> +	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
> +	if (ret)
> +		return ret;
> +
> +	qca_set_speed(hu, QCA_INIT_SPEED);
> +	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for 100 ms for SoC to boot */
> +	msleep(100);
> +
> +	/* Now the device is in ready state to communicate with host.
> +	 * To sync host with device we need to reopen port.
> +	 * Without this, we will have RTS and CTS synchronization
> +	 * issues.
> +	 */
> +	serdev_device_close(hu->serdev);
> +	ret = serdev_device_open(hu->serdev);
> +	if (ret) {
> +		bt_dev_err(hu->hdev, "failed to open port");
> +		return ret;
> +	}
> +
> +	hci_uart_set_flow_control(hu, false);
> +	ret = qca_read_soc_version(hdev, soc_ver);
> +
> +	return ret;

return qca_read_soc_version(hdev, soc_ver);

> +static int qca_power_setup(struct hci_uart *hu, bool on)
> +{
> +	struct qca_vreg *vregs;
> +	struct regulator_bulk_data *vreg_bulk;
> +	struct qca_serdev *qcadev;
> +	int i, num_vregs, ret = 0;
> +
> +	qcadev = serdev_device_get_drvdata(hu->serdev);
> +	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_data ||
> +	    !qcadev->bt_power->vreg_bulk)
> +		return -EINVAL;
> +
> +	vregs = qcadev->bt_power->vreg_data->vregs;
> +	vreg_bulk = qcadev->bt_power->vreg_bulk;
> +	num_vregs = qcadev->bt_power->vreg_data->num_vregs;
> +	BT_DBG("on: %d", on);
> +	if (on  && !qcadev->bt_power->vregs_on) {

Remove extra blank after 'on'

Other than that:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for following through!
