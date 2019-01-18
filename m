Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D16C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E58020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfARK7a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:59:30 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39167 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfARK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:59:30 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 45B42CEE14;
        Fri, 18 Jan 2019 12:07:15 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] bluetooth: hci_bcm: Check for driver_register failure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181228194827.10504-1-pakki001@umn.edu>
Date:   Fri, 18 Jan 2019 11:59:28 +0100
Cc:     kjlu@umn.edu, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A6573C2B-CEA7-4B48-B812-B76D01E175AC@holtmann.org>
References: <20181228194827.10504-1-pakki001@umn.edu>
To:     Aditya Pakki <pakki001@umn.edu>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

> While initializing the driver, the function platform_driver_register can
> fail and return an error. Consistent with other invocations, this patch
> returns the error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
> drivers/bluetooth/hci_bcm.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ddbe518c3e5b..f5ddb0f19c31 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1442,7 +1442,12 @@ int __init bcm_init(void)
> 	/* For now, we need to keep both platform device
> 	 * driver (ACPI generated) and serdev driver (DT).
> 	 */
> -	platform_driver_register(&bcm_driver);
> +	int rc;
> +
> +	rc = platform_driver_register(&bcm_driver);
> +	if (rc)
> +		return rc;
> +

actually I am fine with ignoring the error here since the usage of a platform device should be removed at some point. It was sort of a hack before we had proper ACPI integration and serdev support.

Regards

Marcel

