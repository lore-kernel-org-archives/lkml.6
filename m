Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96731C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5355621741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g1q2+Q27";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C0VusyK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLZFpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:45:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLZFpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:45:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 726FC6022B; Wed, 26 Dec 2018 05:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545803140;
        bh=kpD3eNBoqGvCMJ6Hoz8JZRHBTH3mTP6il4+Iv3QNsrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1q2+Q27fRanGSzJr+B9R9/F7zGkqALhA2XJv1UNRnOrvNPuYbJilTtl1H4QsQAKu
         FmNXd7kju5s+8GKjcuiNKjXcO9XMFCWTi7ia81Ie7wbORl90n75ODIiGWbXBAnKw7y
         Ff+tGFvTpXRVyEjD6e4UgF8DRALX9E/keUB+DQNo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 06A846022B;
        Wed, 26 Dec 2018 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545803131;
        bh=kpD3eNBoqGvCMJ6Hoz8JZRHBTH3mTP6il4+Iv3QNsrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C0VusyK2R/qhLjOFjhRg41wtAN9IyapYb/sBZrfk2/EgUcLoPy4Q2zsq6hGHyLBwV
         dEK8jsyn8oRq8WCHf8wQ3P7da/yrdqn5lR5ASHDcnIZU1gv6cI/frann72gH3vMn2N
         FLK41iwkJmh8NUhkR+x7AUqlImB5zqD4DQRTjE8E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Dec 2018 11:15:30 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20181222003116.GE261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20181222003116.GE261387@google.com>
Message-ID: <a8a0c1dc563faa62cf8a6d952295eee6@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-12-22 06:01, Matthias Kaehlcke wrote:
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
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>> @@ -1104,6 +1103,9 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  			return ret;
>> 
>>  		host_set_baudrate(hu, speed);
>> +
>> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> +			serdev_device_set_rts(hu->serdev, true);
>>  	}
>> 
>>  	return 0;
> 
> I looked for ways to do without this change, but didn't find a good
> solution. There are several possible problems with baudrate changes:
> 
> 1) send request to BT controller to change the baudrate
> 
>   this is an asynchronous operation, the actual baudrate change can
>   be delayed for multiple reasons, e.g.:
> 
>   - request sits in the BT driver's TX queue
> 
>     this could be worked around by checking skb_queue_empty()
> 
>   - request sits in the UART buffer
> 
>     a workaround for this could be calling
>     serdev_device_wait_until_sent() (only available with serdev though)
> 
>   - the request sits in the UART FIFO
> 
>     will be sent out 'immediately'. no neat solution available AFAIK,
>     a short sleep could be an effective workaround
> 
>   - the controller may have a short delay to apply the change
> 
>     Also no neat solution here. A/the same short sleep could work
>     around this
> 
> 2) change baudrate of the host UART
>   - this must not happen before the baudrate change request has been
>     sent to the BT controller, otherwise things are messed up
>     seriously
> 
>     Ideally set_termios would make sure all pending data is sent
>     before the change is applied, some UART drivers do this, others
>     don't, so we can't rely on this.
> 
> 3) BT controller sends data after baudrate change
> 
>   a few ms after a baudrate change the BT controller sends data
>   (4, 255, 2, 146, 1, 4, 14, 4, 1, 0, 0, 0) with the new baudrate
> 
>   - dunno what the data stands for, but the BT stack/driver appears to
>     be fine with it, as long as the host UART operates at the new
>     baudrate when the data is received.
> 
>   - if the data is received before the baudrate of the host UART is
>     changes we see 'frame reassembly' errors
> 
> 
[Bala]: the data is an vendor specific event and command complete event,
          4, 255, 2, 146, 1, : vendor specific event
          4, 14, 4, 1, 0, 0, 0: command complete event.

> In summary, I think it should be feasible to guarantee that the
> baudrate change of the host UART is always done after the controller
> changed it's baudrate, however we can't guarantee at the same time
> that the baudrate change of the host controller is completed before
> the BT controller sends its 'response'.
> 
> Using the RTS signal seems a reasonable way to delay the controller
> data until the host is ready, the only thing I don't like too much
> is that in this patch set we currently have two mechanisms to
> suppress/delay unwanted data. Unfortunately the RTS method isn't
> effective at initialization time.
> 
> Not the scope of this patch set, but I really dislike the 300 ms delay
> (BAUDRATE_SETTLE_TIMEOUT_MS) in qca_set_baudrate(), and wonder if it
> is actually needed (I seriously doubt that it takes the BT controller
> 300 ms to change its baudrate). I guess it's more a combination of what 
> I
> described above in 1), once we are done with this series I might try
> to improve this, unless somebody is really, really convinced that such
> a gigantic delay is actually needed.
> 
[Bala]:  Thanks for detail analysis.
         even i feel the same whether is it really required to have an 
delay of 300ms.
         But during our testing we found the it depends on the controller 
clock settling time.
         all observations are less than 100 ms. will update this change 
in separate patch series.

> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
