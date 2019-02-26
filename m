Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418942087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oc+uxhjS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VB/d8iOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfBZMSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:18:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:18:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E954E618D9; Tue, 26 Feb 2019 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551183526;
        bh=UONnNH4WOnsCiCy9kEILc/DeuLx3fQCQeeSJKKVvIdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oc+uxhjSQhVYDovwKpnsFTBHozAWdi1I/qdnrsvhzDRYPwD1T4MY4Fz6C81BMwWqY
         yFuRu/LK4byLJ3kVWWM5F4kgOcVYopxpuP4gi35U6zf6hencLFn/cnGIcBEAi6Jrl/
         9w0jcflnb2k+XbcW7Gaz6zM1GTuA3wrgRLGnKlFc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 58AED617AA;
        Tue, 26 Feb 2019 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551183525;
        bh=UONnNH4WOnsCiCy9kEILc/DeuLx3fQCQeeSJKKVvIdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VB/d8iOupZFbV6TkqIqbojyKt7niCXXldLWj6zN3dE+YDD9O+I5Rhb/EgzHPZpK9b
         5TlRgB3BCA5XBvuFkxyHZtPp99OG8wj+IvLgs0CnO38oCnUUjb5QlBtk7V+/RNy5f4
         rnkCWZFtvX6yRp87hourB1DjPZIFY7UoG/LA94Ew=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Feb 2019 17:48:45 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantg@codeaurora.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Move boot delay to
 qca_send_power_pulse()
In-Reply-To: <20190225234954.82942-3-mka@chromium.org>
References: <20190225234954.82942-1-mka@chromium.org>
 <20190225234954.82942-3-mka@chromium.org>
Message-ID: <c4f0563baa3b61a3bd1725d71517495e@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26 05:19, Matthias Kaehlcke wrote:
> After sending a power on pulse the driver has a delay of 100ms
> to allow the host controller to boot. Move the delay into
> qca_send_power_pulse(), since it is directly related with the
> power-on pulse.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e4128774e9686..eacc108c422d0 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1036,6 +1036,9 @@ static int qca_send_power_pulse(struct hci_uart
> *hu, bool on)
>  	usleep_range(100, 200);
>  	hci_uart_set_flow_control(hu, false);
> 
> +	if (on)
> +		msleep(100);
> +
>  	return 0;
>  }
> 
> @@ -1148,9 +1151,6 @@ static int qca_wcn3990_init(struct hci_uart *hu)
>  	if (ret)
>  		return ret;
> 
> -	/* Wait for 100 ms for SoC to boot */
> -	msleep(100);
> -
>  	/* Now the device is in ready state to communicate with host.
>  	 * To sync host with device we need to reopen port.
>  	 * Without this, we will have RTS and CTS synchronization

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
