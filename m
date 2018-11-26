Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C29C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685EE20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9qZWXLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685EE20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeK0GAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:00:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44179 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeK0GAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:00:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so6580376pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OWNqEkqpKl4WT7B6IGt+53Wt8VkERsOTBdUuXdHPFSo=;
        b=K9qZWXLPg0OuTE77bmwfiSOcVJgsB+oFhQK15uBcKKxF4452/c+EydbpMArkmKRH9T
         eWQ0hvYykSfpfY8DWJ/us7bdzuaqFascj8/Nq9CP36Rg8V6YggOOFRKKsbiA2kkCWnp7
         EJjbl/kBb4GsJgJ66NGS+ZV89wRSok9jf/BP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OWNqEkqpKl4WT7B6IGt+53Wt8VkERsOTBdUuXdHPFSo=;
        b=g4l04RCP0a5/VlvN6ey9zyfo/N/eSz5DRvdkeBHkqK2U2XdVaHR2+ZEmmFlex1AdvI
         BCKW5LFxOgIGNbD7UT33nIS1ISJX/5g6s1ySW97Yv8Rq2K8Uej/xzB1uwEGFxEDlxptD
         aLU5ktlz9dkSzsntDFlijI1PBQqxf88hiQ2Gu+Q3p1ObRUEI4gVQKdqTv3RRk8a6Fe/V
         mlL8R+PMOpIfXWRrKEbxkPmuXpIQoEnUGXGva9uikcfZI89egEW+02adAgPi+bnnd6QX
         ynaIrlpSwVJGd+lowvRCvZu3cVtIciUYgX2sYSnRB+g0Z40CqZfqKrdxrW8yKXIjkrMs
         /5/g==
X-Gm-Message-State: AGRZ1gLQIaNl9k6qx4MHvS4MeMRjN5++UP9l6fLI7Pb+YOpKYFxDIPEv
        KXRgGhLogbNTGhgcdgbltH2OIg==
X-Google-Smtp-Source: AFSGD/WF+2d59ctkZWeeTS9vL6D5mAZ4Prz/mqp3N25kkp8cSiSK00Bd+DUdNKfnbl3LjuFzeC3QmQ==
X-Received: by 2002:a63:a112:: with SMTP id b18mr26230872pgf.440.1543259116954;
        Mon, 26 Nov 2018 11:05:16 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b5sm1407338pfc.150.2018.11.26.11.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:05:16 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:05:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181126190515.GV22824@google.com>
References: <20181122121512.13136-1-bgodavar@codeaurora.org>
 <20181122121512.13136-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122121512.13136-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:45:10PM +0530, Balakrishna Godavarthi wrote:
> wcn3990 requires a power pulse to turn ON/OFF along with
> regulators. Sometimes we are observing the power pulses are sent
> out with some time delay, due to queuing these commands. This is
> causing synchronization issues with chip, which intern delay the
> chip setup or may end up with communication issues.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v2: 
>   * Updated function qca_send_power_pulse()
>   * addressed reviewer comments.

These unspecific descriptions require people to open v1, read through
the comments and assume you addressed all of them. Better describe
briefly what the actual changes are.

> v1:
>  * initial patch
> 
> ---
>  drivers/bluetooth/hci_qca.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..f5dd323c1967 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
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
>  
>  	/* These power pulses are single byte command which are sent
>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>  	 * save power. Disabling hardware flow control is mandatory while
>  	 * sending power pulses to SoC.
>  	 */
> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> -
> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> -
> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
>  	hci_uart_set_flow_control(hu, true);
> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
> +	if (ret < 0) {
> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> +			   cmd);

Re-enable flow control? The controller or serial port might be in a
non-operational state anyway, but better not complicate matters
further.

Cheers

Matthias
