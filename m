Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB04C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0302171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m6xPf4Ep";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SY2LvpQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1Npx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:45:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Npx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:45:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBD7360851; Mon, 28 Jan 2019 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548683149;
        bh=NijZksKMHZ/9rah5scXmUB3OrJFZczGzQ6VzUkGep8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6xPf4EpSsBG9lfUo/rNmpRLrzq7a1i+5xyL10Pkfzvnp4dX0vI2tCMuBVVoWCmgr
         NDLHlYiltB0nV/vZB5zWDHorZjZPZJDBpZ33jaQah+AE+WP1A4wD45V7P/fjpnrHc9
         EOAfZfRpxmGJCeReD5VBP0dIm/b3GqnQYeU0Aw8k=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 96F37602F8;
        Mon, 28 Jan 2019 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548683148;
        bh=NijZksKMHZ/9rah5scXmUB3OrJFZczGzQ6VzUkGep8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SY2LvpQcnWz1AbmI4sSoLc/4vfe8818ZqErzQZO3GzmuJbs3Sg68Ri7TO2u+1bIAZ
         TRXmtpIE8uJlIaCTGqRa7E+j2yRMPbaLZ29y9/ntjYC2VwUHcGQIdG+R84UQ6pDbrh
         CD2K+dO3DgZ8HLZ+aVK5E1oFxc2bi+t2SylTP8rA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jan 2019 19:15:48 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20190125001259.GB81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-3-bgodavar@codeaurora.org>
 <20190125001259.GB81583@google.com>
Message-ID: <6b18e30fb1b747d674a75cb265b5821b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-25 05:42, Matthias Kaehlcke wrote:
> Hi Balakrishna,
> 
> On Thu, Jan 24, 2019 at 05:38:07PM +0530, Balakrishna Godavarthi wrote:
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
>> Changes in v9:
>>  * disabled flow control while setting the baudrate of HOST and chip.
>> ---
>>  drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index c08f4d105e73..6b5bcd44e24c 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -964,7 +964,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>>  	struct qca_data *qca = hu->priv;
>>  	struct sk_buff *skb;
>> -	struct qca_serdev *qcadev;
>>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>> 
>>  	if (baudrate > QCA_BAUDRATE_3200000)
>> @@ -978,13 +977,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
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
>> @@ -1000,9 +992,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
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
>> @@ -1089,6 +1078,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type 
>> speed_type)
>>  {
>>  	unsigned int speed, qca_baudrate;
>> +	struct qca_serdev *qcadev;
>>  	int ret;
>> 
>>  	if (speed_type == QCA_INIT_SPEED) {
>> @@ -1100,6 +1090,15 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		if (!speed)
>>  			return 0;
>> 
>> +		/* Deassert RTS while changing the baudrate of chip and host.
>> +		 * This will prevent chip from transmitting its response with
>> +		 * the new baudrate while the host port is still operating at
>> +		 * the old speed.
>> +		 */
> 
> It is not necessarily evident which action deasserts RTS, I suggest to
> rephrase it to something like:
> 
> "Disable flow control for wcn3990 to deassert RTS while ... "
> 

[Bala]: will update.

>> +		qcadev = serdev_device_get_drvdata(hu->serdev);
>> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> +			hci_uart_set_flow_control(hu, true);
>> +
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> 
> flow control should be re-enabled in the error path.
> 
> Cheers
> 
> Matthias

[Bala; will update.

-- 
Regards
Balakrishna.
