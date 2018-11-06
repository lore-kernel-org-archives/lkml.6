Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6706C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C22085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5C22085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeKFV6q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:58:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58342 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeKFV6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:58:46 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2DE44CF2A2;
        Tue,  6 Nov 2018 13:41:12 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v1 3/4] Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE
 flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181106120528.30342-4-bgodavar@codeaurora.org>
Date:   Tue, 6 Nov 2018 13:33:43 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <462C4F58-E6E2-4B20-B074-72DDFA6D7364@holtmann.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-4-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> During hci down we are sending reset command to chip, which
> is not required for wcn3990, as hdev->shutdown() will turn off the
> regulators.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> drivers/bluetooth/hci_qca.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 8301663f0004..97b57e0f4725 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1190,6 +1190,7 @@ static int qca_setup(struct hci_uart *hu)
> 		 */
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
> 		hu->hdev->shutdown = qca_power_off;
> 		ret = qca_wcn3990_init(hu);
> 		if (ret)

I am pretty certain that you didn’t want this quirk:

        /* When this quirk is set, the HCI Reset command is send when            
         * closing the transport instead of when opening it.

This quirk is for Bluetooth 1.0b devices where the HCI_Reset behavior was not clear or for devices that actually misbehave with the initial HCI_Reset.

In addition, you commit message is totally misleading. That is not what is happening with this quirk.

Regards

Marcel

