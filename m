Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938512087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kXS0umWZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mM9Hf6re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfBZMUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:20:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfBZMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:20:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4BE861B1C; Tue, 26 Feb 2019 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551183599;
        bh=0L2j6zvdXjrzqy9ZbBbURNM2rRLW6TAhwUkUjVDmT5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kXS0umWZm0Dgz7coqNLiqq/8b3oVQJhPGMEqMTqu9NedtqAxeY89+i9ibXQnr3/Yd
         0fedy9e3IfmKqxVw7vK6mz3LiehO19Pe95EMCbgmgaC5kCj2z7BgWRXAm+zv4EKyFJ
         dv/trn4ahnaD1gtwo0uXWTHvg9zJBEcwhUQY5hsc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DC9F66119D;
        Tue, 26 Feb 2019 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551183597;
        bh=0L2j6zvdXjrzqy9ZbBbURNM2rRLW6TAhwUkUjVDmT5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mM9Hf6re2fDRCczI4leov411RJUCjpTHp0tS6oUpqjJ1URjH4IAfBlIgYaP0J5T9E
         vbVbtRFTFwRYDkOdAysgAomYABo1FI/pglW4W5ysvZQzYnPY7k/UwDOXLr8bfvu9+1
         ngvHIY31ThlyrREQ7kVO4G2NwYdAoIfodmBGs8vM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Feb 2019 17:49:56 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: Add delay after power-off pulse
In-Reply-To: <20190225234954.82942-4-mka@chromium.org>
References: <20190225234954.82942-1-mka@chromium.org>
 <20190225234954.82942-4-mka@chromium.org>
Message-ID: <558de0e85225baf7d9ab402cfbaab9c7@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26 05:19, Matthias Kaehlcke wrote:
> During initialization the power-on pulse is currently sent inmediately
> after the prior power-off pulse. With this initialization often fails
> at boot time:
> 
> [   15.205224] Bluetooth: hci0: setting up wcn3990
> [   17.341062] Bluetooth: hci0: command 0xfc00 tx timeout
> [   22.101453] ERROR: Bluetooth initialization failed
> [   25.337740] Bluetooth: hci0: Reading QCA version information failed 
> (-110)
> 
> After a power-off pulse wait 10ms to give the controller time to power
> off.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index eacc108c422d0..c89c1ed87ffe9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1036,8 +1036,11 @@ static int qca_send_power_pulse(struct hci_uart
> *hu, bool on)
>  	usleep_range(100, 200);
>  	hci_uart_set_flow_control(hu, false);
> 
> +	/* Give to controller time to boot/shutdown */
>  	if (on)
>  		msleep(100);
> +	else
> +		msleep(10);
> 
>  	return 0;
>  }

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
