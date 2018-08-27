Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1084208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="doVe+0OH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="btylBnWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1084208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH0QzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:55:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeH0QzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:55:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16D14606DB; Mon, 27 Aug 2018 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535375312;
        bh=pgB47C1v03GFBY23oJcxu/O/kbfUJ3RCh/VmykCjpag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=doVe+0OHiEgEZ59E95ge0+yuKjVmpOFMMF/wQQAThW+6VgyDkXVuNOqHaD8K7Jl+z
         5lsCjyg5PgEBkexShu6aiin7QnEbYJv47Et8oDy6d00dSo8ogCRN8Q9mb96dGruo76
         Uj9XvTmzdHsIjeIm6cGsvXtjPdL1/RTyCDpYHr0k=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8C58A60541;
        Mon, 27 Aug 2018 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535375311;
        bh=pgB47C1v03GFBY23oJcxu/O/kbfUJ3RCh/VmykCjpag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=btylBnWoYusE+HUuUZ0pJttMZD4xh/Hro+dCFZONVoM0EQvydqBVz6JCtcghz2S4v
         Cao4i3apnkwdhEHF6UApjnodIHf/YfjLc64MRbGZszsk+uIr60AyLBmayHdEfZr1Cg
         IryzO95/z/psKilehmqOOyWSxWbDVHXeA1G30lPg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 27 Aug 2018 18:38:31 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
In-Reply-To: <E6C34892-0C0F-45E7-AC05-79A4A409FC48@holtmann.org>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
 <20180823112935.17342-2-bgodavar@codeaurora.org>
 <E6C34892-0C0F-45E7-AC05-79A4A409FC48@holtmann.org>
Message-ID: <6ac01029af09b131523e8c0e27d56a2c@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-08-25 00:20, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>> This patch enables power off support for hci down and power on support
>> for hci up. As wcn3990 power sources are ignited by regulators, we 
>> will
>> turn off them during hci down, i.e. an complete power off of wcn3990.
>> So while hci up, we will call vendor specific open/close and setup 
>> which
>> will turn on the regulators, requests BT chip version and download the
>> firmware.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
>> 1 file changed, 34 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index e182f6019f68..98d33c6b8909 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
>> 	struct qca_serdev *qcadev;
>> 	struct qca_data *qca = hu->priv;
>> 
>> +	if (!qca)
>> +		return 0;
>> +
>> 	BT_DBG("hu %p qca close", hu);
>> 
>> 	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
>> @@ -1098,6 +1101,32 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>> 	return 0;
>> }
>> 
>> +static int hci_uart_open(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +
>> +	BT_DBG("%s %p", hdev->name, hdev);
>> +	set_bit(HCI_UART_PROTO_READY, &hu->flags);
>> +
>> +	return qca_open(hu);
>> +}
>> +
>> +static int hci_uart_close(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +
>> +	BT_DBG("%s %p", hdev->name, hdev);
>> +
>> +	/* After this step, we should not allow Tx and Rx work
>> +	 * function to execute. As we are freeing qca tx and rx
>> +	 * buffers which may cause kernel crash.
>> +	 */
>> +	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>> +	qca_close(hu);
>> +
>> +	return 0;
>> +}
>> +
>> static int qca_wcn3990_init(struct hci_uart *hu)
>> {
>> 	struct hci_dev *hdev = hu->hdev;
>> @@ -1154,6 +1183,11 @@ static int qca_setup(struct hci_uart *hu)
>> 
>> 	if (qcadev->btsoc_type == QCA_WCN3990) {
>> 		bt_dev_info(hdev, "setting up wcn3990");
>> +
>> +		hdev->open  = hci_uart_open;
>> +		hdev->close = hci_uart_close;
>> +		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>> +
> 
> I do not get this change and I am also against it. Once hdev->open and
> hdev->close are assigned, don’t re-assign them. You called
> hci_register_dev and you are not changing the basic transport
> open/close functions after that. If you need some vendor specific
> things to open and close the transport, then do it properly.
> 

[Bala]: the reason to re-assign hdev->close & hdev->open is, when we do 
an hci0 down we are
         shutting down the regulators to turn off wcn3990 and closing the 
vendor proto i.e.clearing the memory too.,
         So we are re-assigning the hdev->close to proto close. Here is 
the use case of the above change wrt mobile handset.
         we will setup BT during bootup, i.e. we enable the clocks or 
regulators to turn on BT chip connected.
         let us assume that we turn off the BT chip i.e. hci0 down. so to 
current implementation we will down the HCI0,
         but still we have our uart clocks or BT clocks are regulators 
are enabled. This is causing power and memory consumption.

> When I posted the btuart.c serdev driver, it would be a lot easier to
> add vendor specific things then to hci_serdev.c which is still kinda
> hacked onto a line discipline driver.
> 

[Bala]: when can we expect btuart.c serdev driver.

> Regards
> 
> Marcel

-- 
Regards
Balakrishna.
