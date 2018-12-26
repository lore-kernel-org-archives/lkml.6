Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7720FC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B32218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HErX3eNh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LaVLPgxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLZGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:32:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLZGcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:32:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FC756063A; Wed, 26 Dec 2018 06:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545805921;
        bh=yc3YOlw5YRZPQnvBO5Cfs9OxCK5LjyNvarlYvqJeYAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HErX3eNhahidNYRUctRgNBg3ZLsR7pn6d7ha/55/L/RMrY4CDjY1RBK1jK+nbfOf1
         eGrAjQOV+n7gjglnUBvPXcsLAdGYzBwIgR1txmjCWBrNBMi4fr8k4Bld0VygCLxxjE
         E+ATUatE5dM3EsiGYzk1psLcdt70BpS7qcNEC8x0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 79808602A7;
        Wed, 26 Dec 2018 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545805911;
        bh=yc3YOlw5YRZPQnvBO5Cfs9OxCK5LjyNvarlYvqJeYAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LaVLPgxKHtMzBR/611NKqUqHZCjV1ZI97ZO8eMbFTV+x8HxJxI8UE1fLmwRgF4zpP
         uxi0tlOn5C9Ulrdf9obxT7l+P2ZLzgOH+BaEt8SRUnfDi341hTDjcsbDXBU3qn87lw
         MQY8eLVr3Mz6KTd+f0cYVP/t5rKN67ClX6JKz6/Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Dec 2018 12:01:51 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181222015947.GF261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com>
Message-ID: <379c7c10d70ad86e03122d051ce0cf6f@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-12-22 07:29, Matthias Kaehlcke wrote:
> On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 38 
>> ++++++++++++++-----------------------
>>  1 file changed, 14 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..5a07c2370289 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  		hci_uart_set_baudrate(hu, speed);
>>  }
>> 
>> -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
>>  {
>> -	struct hci_uart *hu = hci_get_drvdata(hdev);
>> -	struct qca_data *qca = hu->priv;
>> -	struct sk_buff *skb;
>> +	int ret;
>> 
>>  	/* These power pulses are single byte command which are sent
>>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev 
>> *hdev, u8 cmd)
>>  	 * save power. Disabling hardware flow control is mandatory while
>>  	 * sending power pulses to SoC.
>>  	 */
>> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
>> -
>> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> -	if (!skb)
>> -		return -ENOMEM;
>> -
>> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
>>  	hci_uart_set_flow_control(hu, true);
>> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
>> +	if (ret < 0) {
>> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
>> +			   cmd);
>> +		return ret;
>> +	}
>> 
>> -	skb_put_u8(skb, cmd);
>> -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> -
>> -	skb_queue_tail(&qca->txq, skb);
>> -	hci_uart_tx_wakeup(hu);
>> +	serdev_device_wait_until_sent(hu->serdev, 0);
> 
> serdev_device_wait_until_sent() might only guarantee that the UART
> circular buffer is empty (see
> https://elixir.bootlin.com/linux/v4.19/source/drivers/tty/tty_ioctl.c#L225),
> not that the data has actually sent (e.g. it might be sitting in
> the UART FIFO). However with this:
> 
>>  	/* Wait for 100 uS for SoC to settle down */
>>  	usleep_range(100, 200);
> 
> we should probably be fine, unless there's tons of data in the
> FIFO.
> 
> You currently call serdev_device_write_flush() in
> qca_power_shutdown(), I wonder if it would make sense to call it in
> qca_send_power_pulse(), regardless of whether it's an on or off

[Bala]: during sending the ON pulse we will not have any data in the
         UART circular buffer as this is the first command to send and we 
are sending it as soon as we open the port.
         so i taught why should be flush the circular as it is already 
empty.

> pulse. In any case we don't care if the chip receives any 'pending'
> data when we switch it on or off, right?
> 

[Bala]: during on we freshly open port and i see that flush() called 
while port opening.

https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/serial_core.c#L207



> Cheers
> 
> Matthias


-- 
Regards
Balakrishna.
