Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BDAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53A0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bx0QZ2QX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EZAIo/rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfAJOe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:34:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfAJOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:34:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BAEBA6095E; Thu, 10 Jan 2019 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547130865;
        bh=VvXTEQoOMSpoVxGTN9aA4mY5gyUWqTpppdcQPs3QOn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bx0QZ2QXX7GhK9jgUPBi3SGLSxjixlAPRAv8r7Oe8vPz8xbTtwbGgh9X46wOz26BH
         rAVphXQ38OwGYnOh+hlbF39Q6s1nMHb06B9bUWNCCoyeh0dm0pvjy6cEwVzlO/0xHs
         U8qglXnr75A0xvFg/O1uNj1ffa2vXK2CtKYUfNGI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B86DF608FD;
        Thu, 10 Jan 2019 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547130853;
        bh=VvXTEQoOMSpoVxGTN9aA4mY5gyUWqTpppdcQPs3QOn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZAIo/rTZtV/BTP/ELhOCo4GBq7OmnRpVcTFHJVEBIiBkcAJRZqXb2pEcv4B1DZhX
         2xUlpTFEeZXaBpJ1zCYAtfcCXxMS9W0tatDLYX2WsjRGDpGjyLq46WCSEGP6ZJ73Us
         aGXwZAJMKuxUCuUH8h9di9ffkqlajhE/kZpuss68=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 20:04:12 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20190109145224.GN14782@localhost>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
Message-ID: <b5160d8862b49f0369fa58610516d354@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2019-01-09 20:22, Johan Hovold wrote:
> On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
>> This patch will help to stop frame reassembly errors while changing
>> the baudrate. This is because host send a change baudrate request
>> command to the chip with 115200 bps, Whereas chip will change their
>> UART clocks to the enable for new baudrate and sends the response
>> for the change request command with newer baudrate, On host side
>> we are still operating in 115200 bps which results of reading garbage
>> data. Here we are pulling RTS line, so that chip we will wait to send 
>> data
>> to host until host change its baudrate.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 5a07c2370289..1680ead6cc3d 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -963,7 +963,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>>  	struct qca_data *qca = hu->priv;
>>  	struct sk_buff *skb;
>> -	struct qca_serdev *qcadev;
>>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>> 
>>  	if (baudrate > QCA_BAUDRATE_3200000)
>> @@ -977,13 +976,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  		return -ENOMEM;
>>  	}
>> 
>> -	/* Disabling hardware flow control is mandatory while
>> -	 * sending change baudrate request to wcn3990 SoC.
>> -	 */
>> -	qcadev = serdev_device_get_drvdata(hu->serdev);
>> -	if (qcadev->btsoc_type == QCA_WCN3990)
>> -		hci_uart_set_flow_control(hu, true);
>> -
>>  	/* Assign commands to change baudrate and packet type. */
>>  	skb_put_data(skb, cmd, sizeof(cmd));
>>  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> @@ -999,9 +991,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>>  	set_current_state(TASK_RUNNING);
>> 
>> -	if (qcadev->btsoc_type == QCA_WCN3990)
>> -		hci_uart_set_flow_control(hu, false);
>> -
>>  	return 0;
>>  }
>> 
>> @@ -1086,6 +1075,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type 
>> speed_type)
>>  {
>>  	unsigned int speed, qca_baudrate;
>> +	struct qca_serdev *qcadev;
>>  	int ret;
>> 
>>  	if (speed_type == QCA_INIT_SPEED) {
>> @@ -1097,6 +1087,15 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		if (!speed)
>>  			return 0;
>> 
>> +		/* Deassert RTS while changing the baudrate of chip and host.
>> +		 * This will prevent chip from transmitting its response with
>> +		 * the new baudrate while the host port is still operating at
>> +		 * the old speed.
>> +		 */
>> +		qcadev = serdev_device_get_drvdata(hu->serdev);
>> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> +			serdev_device_set_rts(hu->serdev, false);
>> +
> 
> This may not do what you want unless you also disable hardware flow
> control.
> 
> Johan


Here my requirement here is to block the chip to send its data before 
HOST changes
it is baudrate. So if i disable flow control lines of HOST which will be 
in low state.
so that the chip will send it data before HOST change the baudrate of 
HOST. which results in
frame reassembly error.

-- 
Regards
Balakrishna.
