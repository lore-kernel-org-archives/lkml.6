Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ONZgHyxyHlsRXAAAmS7hNA
	; Mon, 11 Jun 2018 12:59:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 738AC607BB; Mon, 11 Jun 2018 12:59:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0780760385;
	Mon, 11 Jun 2018 12:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0780760385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeFKM7X convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 08:59:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42110 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:59:21 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id 14EF9CF185;
        Mon, 11 Jun 2018 15:06:02 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 11/24] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180611115240.32606-12-ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 14:59:19 +0200
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D4622EB7-BB18-4931-BF14-34995F7EBBA8@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-12-ricardo.ribalda@gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

> Export serdev table to the module header, allowing module autoload via
> udev/modprobe.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index f4d7846c06b8..ff0fd3502a90 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1327,8 +1327,10 @@ MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
> 
> static const struct serdev_device_id bcm_serdev_id[] = {
> 	{ "bcm43438-bt", },
> +	{ "hci_uart_bcm", },
> 	{}
> };
> +MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);

so this one I can see real use of and is a good fix to finally clean up hci_bcm.c and remove platform support for the Edison hardware. However, I would really then first rename hci_uart_bcm into some Edison specific string since this is really just one outlier here. Everything else will have ACPI or DT support.

With that said, I do not understand why we need to duplicate the DT compatible strings in serdev_device_id. They will be enumerated fine via ACPI or DT in the first place. So if we want some new_id support, then wouldn’t an empty serdev_device_id table just be fine?

Regards

Marcel
