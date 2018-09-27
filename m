Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C3BC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F141C21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F141C21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0QQj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:16:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41379 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeI0QQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:16:39 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 55710CF16A;
        Thu, 27 Sep 2018 12:06:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] btsdio: Do not bind to non-removable BCM43430
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180927095455.32247-1-acho@suse.com>
Date:   Thu, 27 Sep 2018 11:59:08 +0200
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>, jlee@suse.com
Content-Transfer-Encoding: 8BIT
Message-Id: <DE21BFD5-3A79-4D64-9DB1-4A2DCDBBE359@holtmann.org>
References: <20180927095455.32247-1-acho@suse.com>
To:     "Cho, Yu-Chen" <acho@suse.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Chen,

> BCM43430 devices soldered onto the PCB (non-removable)
> use an UART connection for bluetooth.
> But also advertise btsdio support on their 3th sdio function.
> 
> Signed-off-by: Cho, Yu-Chen <acho@suse.com>
> ---
> drivers/bluetooth/btsdio.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> index 20142bc77554..84d23d786ce5 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -297,7 +297,8 @@ static int btsdio_probe(struct sdio_func *func,
> 	 * uart connection for bluetooth, ignore the BT SDIO interface.
> 	 */
> 	if (func->vendor == SDIO_VENDOR_ID_BROADCOM &&
> -	    func->device == SDIO_DEVICE_ID_BROADCOM_43341 &&
> +	    (func->device == SDIO_DEVICE_ID_BROADCOM_43341 ||
> +	    func->device == SDIO_DEVICE_ID_BROADCOM_43430) &&
> 	    !mmc_card_is_removable(func->card->host))
> 		return -ENODEV;

This will turn quickly unreadable. Can we turn the func->device test into a switch statement.

	if (!mmc_card_is_rem.. && func->vendor == SDIO_ID..) {
		switch (func->device) {
		case SDIO_DEV..
			return -ENODEV;
	}

Regards

Marcel

