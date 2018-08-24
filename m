Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17954C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4A9208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4A9208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeHXW0j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:26:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50762 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeHXW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:26:39 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6627CEF96;
        Fri, 24 Aug 2018 20:57:52 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180823112935.17342-2-bgodavar@codeaurora.org>
Date:   Fri, 24 Aug 2018 20:50:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E6C34892-0C0F-45E7-AC05-79A4A409FC48@holtmann.org>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
 <20180823112935.17342-2-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> This patch enables power off support for hci down and power on support
> for hci up. As wcn3990 power sources are ignited by regulators, we will
> turn off them during hci down, i.e. an complete power off of wcn3990.
> So while hci up, we will call vendor specific open/close and setup which
> will turn on the regulators, requests BT chip version and download the
> firmware.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
> 1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e182f6019f68..98d33c6b8909 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
> 	struct qca_serdev *qcadev;
> 	struct qca_data *qca = hu->priv;
> 
> +	if (!qca)
> +		return 0;
> +
> 	BT_DBG("hu %p qca close", hu);
> 
> 	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
> @@ -1098,6 +1101,32 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> 	return 0;
> }
> 
> +static int hci_uart_open(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +
> +	BT_DBG("%s %p", hdev->name, hdev);
> +	set_bit(HCI_UART_PROTO_READY, &hu->flags);
> +
> +	return qca_open(hu);
> +}
> +
> +static int hci_uart_close(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +
> +	BT_DBG("%s %p", hdev->name, hdev);
> +
> +	/* After this step, we should not allow Tx and Rx work
> +	 * function to execute. As we are freeing qca tx and rx
> +	 * buffers which may cause kernel crash.
> +	 */
> +	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> +	qca_close(hu);
> +
> +	return 0;
> +}
> +
> static int qca_wcn3990_init(struct hci_uart *hu)
> {
> 	struct hci_dev *hdev = hu->hdev;
> @@ -1154,6 +1183,11 @@ static int qca_setup(struct hci_uart *hu)
> 
> 	if (qcadev->btsoc_type == QCA_WCN3990) {
> 		bt_dev_info(hdev, "setting up wcn3990");
> +
> +		hdev->open  = hci_uart_open;
> +		hdev->close = hci_uart_close;
> +		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +

I do not get this change and I am also against it. Once hdev->open and hdev->close are assigned, don’t re-assign them. You called hci_register_dev and you are not changing the basic transport open/close functions after that. If you need some vendor specific things to open and close the transport, then do it properly.

When I posted the btuart.c serdev driver, it would be a lot easier to add vendor specific things then to hci_serdev.c which is still kinda hacked onto a line discipline driver.

Regards

Marcel

