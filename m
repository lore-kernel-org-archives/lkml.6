Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id G+tpDMx1HlsPGAAAmS7hNA
	; Mon, 11 Jun 2018 13:14:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2096C607BB; Mon, 11 Jun 2018 13:14:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A6246601C3;
	Mon, 11 Jun 2018 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6246601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933221AbeFKNOu convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 09:14:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40242 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFKNOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:14:48 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6AF05CF185;
        Mon, 11 Jun 2018 15:21:29 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 14/24] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180611115240.32606-15-ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 15:14:46 +0200
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EBCCCD1F-0F23-4599-8A78-32BBF2DAF746@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-15-ricardo.ribalda@gmail.com>
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
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/mfd/rave-sp.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 5c858e784a89..c0ecfbc16dca 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *serdev)
> 
> MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
> 
> +static struct serdev_device_id rave_sp_serdev_id[] = {
> +	{ "rave-sp", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
> +
> static struct serdev_device_driver rave_sp_drv = {
> 	.probe			= rave_sp_probe,
> 	.driver = {
> 		.name		= "rave-sp",
> 		.of_match_table	= rave_sp_dt_ids,
> 	},
> +	.id_table = rave_sp_serdev_id,
> };
> module_serdev_device_driver(rave_sp_drv);

so I would actually prefer that we not duplicate the .driver.name in the .id_table. This one for example is non-functional since all supported hardware needs a specific .data entry. It will fail here:

        sp->variant = of_device_get_match_data(dev);                             
        if (!sp->variant)                                                        
                return -ENODEV;

Maybe we focus first on getting the base support for new_device etc. merged and use the Edison Bluetooth platform driver support in hci_bcm.c so we can do a real cleanup there. And then later add broad new_device support. Some of these instances should be just fine with never getting it since they require to many per device quirks to make things functional. A blind search+replace is not going to work.

And things like device_get_match_data() should work as well even if the hardware is listed via serdev_device_id. Drivers that are solely DT centric will need a lot more work before dynamic adding of serdev devices can happen.

Regards

Marcel
