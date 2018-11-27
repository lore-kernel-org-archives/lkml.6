Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD4FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4AA2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZPrjJQEG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KV5lSGtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4AA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeK0RiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:38:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeK0RiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:38:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A04DB60246; Tue, 27 Nov 2018 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543300869;
        bh=LgaQmQG36N5dIAbDS8Pfcmp8KC9VrC5TKhqKRdPb9Yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZPrjJQEGmIRp8eFd6i3TS4SkIMP7yNlkwwKPRECOqzwSd1tgY3LGNMxLrlqnoSlJK
         /MU7P3s8pYeqMY1RH4o6ixPyn5zkEyJFudE4UDtIJnidxhE9bfaXD3Qo5GzLGiQ8PP
         inqZ6K43gcdNzCwEjWebeTgSDjRZ20z5mWbnSODE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BF2EB60246;
        Tue, 27 Nov 2018 06:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543300868;
        bh=LgaQmQG36N5dIAbDS8Pfcmp8KC9VrC5TKhqKRdPb9Yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KV5lSGtW2WEUh0+W+dGbWC5tWuaKB6WLhHhyEpS73dw7UD+slbcGneEnmM73mkuzo
         yn+dZKYvesgjXiwm4fI5hJcIi3upHEC9+La918zqvls2d/dToKN12spEeBl7WQsCIC
         3k1UsYwLNA/PS3fRFFnM8KHY/0s4s1eqK7P8pqt0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Nov 2018 12:11:08 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20181126194210.GW22824@google.com>
References: <20181122121512.13136-1-bgodavar@codeaurora.org>
 <20181122121512.13136-3-bgodavar@codeaurora.org>
 <20181126194210.GW22824@google.com>
Message-ID: <ad8de20da986b530dd53d83c96da7b7b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-11-27 01:12, Matthias Kaehlcke wrote:
> On Thu, Nov 22, 2018 at 05:45:11PM +0530, Balakrishna Godavarthi wrote:
>> This patch will help to stop frame reassembly errors while changing
>> the baudrate. This is because host send a change baudrate request
>> command to the chip with 115200 bps, Whereas chip will change their
>> UART clocks to the enable for new baudrate and sends the response
>> for the change request command with newer baudrate, On host side
>> we are still operating in 115200 bps which results of reading garbage
>> data. Here we are pulling RTS line, so that chip we will wait to send 
>> data
>> to host until host change its baudrate.
> 
> Thanks for updating the commit message and provide more details!
> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> v2:
>>  * updated commit text and comments.
>> v1:
>>  * initial patch
>> ---
>>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f5dd323c1967..ed905ea1c58a 100644
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
>> @@ -1097,6 +1087,14 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		if (!speed)
>>  			return 0;
>> 
>> +		/* Deassert RTS while changing the baudrate of chip and host.
>> +		 * This will stop chip to transmit it response with an newer
>> +		 * baudrate until we change the baudarte.
> 
> nit: baudrate
> 
> re-nit (to consider if you respin anyway): 'This prevents the chip
> from transmitting its response with the new baudrate while the host
> port is still operating at the old speed'?
> (I'm not a native English speaker, probably there is still room for
> improvement ;-)

[Bala]: will update.

> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
Regards
Balakrishna.
