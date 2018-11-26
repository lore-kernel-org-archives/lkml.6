Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PChYuc5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADB920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeK0GhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:37:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36273 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeK0GhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:37:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so6649254pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8k2YtHI7XBnd3/667SiR7CshYKJKmltQZinOc/YlDxQ=;
        b=PChYuc5xK1m2QUjJ6faPzhQ41GTEr+dr4znwHpoHbubWRpuZ4X0Dp0O2IZLiXXhLBv
         aNVPUz46zNW2nZzfxf58ifyCWnQ3he2PC0Md03pFvFpFLlK/Fuj3lWxbdFt5tC9F/X3u
         GfxkyTMfIP4ggztbxSVlziGsEDhjkG2dsgEfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8k2YtHI7XBnd3/667SiR7CshYKJKmltQZinOc/YlDxQ=;
        b=CBKTq+e3v/Ogf8mgHe2+30vfz3ztYhnETROYotNQ8PeAlvl1ZzGtfSd15MgJD9YEMw
         RqDPHSKbmqI8G9FCdXaMHUHhUOugcfQ8oC+xigNW5uLdbbPyjtl/v+TiBmqEg0gfKSGo
         ONjfywVMuOgATUsq354pxZdnofaIKJsqEN1WvNPLz8drEKRE2xGb7OVu5dI59p8WCM6d
         ILEHHGUQ816o/PLQNE7Csqk6wN03j9O+aWYPQTd6OLEGRyRY05HeOPjnTLkDqcsIZveq
         tII81POKQ90mqAQqKoRdKT8R021+4BgR3GIkGwI73aHxcAA+vZHV6DzF2wFYCpRPOtcs
         UNkA==
X-Gm-Message-State: AA+aEWZyAALb1L7dFP0oURNDfRZY2kdFWQTjwkBtIl4YZ+E+klQ0yIV2
        9iCYeAGSm79MEO8DdW1oIMqxqQ==
X-Google-Smtp-Source: AFSGD/UgJ5a6X6tdX98vvjDVT2vPvLNkzL81Muvg/SekmsMPuK/09DDjIR2AuWag1GqJ0Xmm4psArg==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr26373176pge.29.1543261332108;
        Mon, 26 Nov 2018 11:42:12 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id n2sm1156710pgp.75.2018.11.26.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:42:11 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:42:10 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20181126194210.GW22824@google.com>
References: <20181122121512.13136-1-bgodavar@codeaurora.org>
 <20181122121512.13136-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122121512.13136-3-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:45:11PM +0530, Balakrishna Godavarthi wrote:
> This patch will help to stop frame reassembly errors while changing
> the baudrate. This is because host send a change baudrate request
> command to the chip with 115200 bps, Whereas chip will change their
> UART clocks to the enable for new baudrate and sends the response
> for the change request command with newer baudrate, On host side
> we are still operating in 115200 bps which results of reading garbage
> data. Here we are pulling RTS line, so that chip we will wait to send data
> to host until host change its baudrate.

Thanks for updating the commit message and provide more details!

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
>  * updated commit text and comments.
> v1:
>  * initial patch
> ---
>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f5dd323c1967..ed905ea1c58a 100644
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
> +		/* Deassert RTS while changing the baudrate of chip and host.
> +		 * This will stop chip to transmit it response with an newer
> +		 * baudrate until we change the baudarte.

nit: baudrate

re-nit (to consider if you respin anyway): 'This prevents the chip
from transmitting its response with the new baudrate while the host
port is still operating at the old speed'?
(I'm not a native English speaker, probably there is still room for
improvement ;-)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
