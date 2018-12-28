Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA39C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AA82087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G9awb8kk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ArBWALbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbeL1HL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:11:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeL1HL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:11:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A05DA606AC; Fri, 28 Dec 2018 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545981085;
        bh=zvC21DsYjP6O8rYsMcFgO5dBO9t4iGnpB+DAZelr1/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G9awb8kkDKJG81ib3huwfD8XEPQXbaFAVrrJLLHzzrNz+cIvYFHFhZhhLSV7+6EV+
         b5OexoAfr1UTMkfE19Rq10sKepv9QI7ZOM+z/+VEPL2j35NiLMAX3SVtYnAtfzvn1J
         XtPKDpTAbTQOebyCGQkeFTaMG27GvJDKZCiQ0lSY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A9B6D606AC;
        Fri, 28 Dec 2018 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545981084;
        bh=zvC21DsYjP6O8rYsMcFgO5dBO9t4iGnpB+DAZelr1/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ArBWALbeenRvrkivh+wwW/fBMgN5z3LkOjbNPctuvraGdPyIsjaSfKAu/AQUlPe3m
         cCjhWxSi1/gllqFNdekjCJksZomR+0vwdquogAQrKj2oJ2kMRvRMvBZd6o+CyJ0dwI
         mqwnL89//LgxqxeOQwyYpSj01UY9BAbaHc+/kXiw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 12:41:24 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/6] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181227201856.GJ261387@google.com>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
 <20181227073136.8431-2-bgodavar@codeaurora.org>
 <20181227201856.GJ261387@google.com>
Message-ID: <952efcf13141c6f92d66ddbe396d4983@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Matthias,

On 2018-12-28 01:48, Matthias Kaehlcke wrote:
> On Thu, Dec 27, 2018 at 01:01:31PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v6:
>>  * added serdev_device_write_flush() in qca_send_power_pulse
>>    instead during the power off pulse.
>> 
>> Changes in v5:
>>  * added serdev_device_write_flush() in qca_power_off().
>> 
>> ---
>>  drivers/bluetooth/hci_qca.c | 38 
>> ++++++++++++++-----------------------
>>  1 file changed, 14 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..507a2355c758 100644
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
>> @@ -1029,19 +1027,17 @@ static int qca_send_power_pulse(struct hci_dev 
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
>> +	serdev_device_write_flush(hu->serdev);
>> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
> 
> nit: why clutter the code flow by putting the log statement in the
> middle of code that is actually doing something with the serial
> interface?
> 
> In case you respin anyway I suggest to structure it like this:
> 
>   bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
> 
>   hci_uart_set_flow_control(hu, true);
>   serdev_device_write_flush(hu->serdev);
>   ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> 
> 
>>  	hci_uart_set_flow_control(hu, true);
>> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
>> +	if (ret < 0) {
>> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> 
> nit: especially on 'embedded' devices 'SoC' is typically associated
> with the CPU running Linux, you might want to change it to
> 'controller'.
> 

[Bala]: will update.

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
>> 
>>  	/* Wait for 100 uS for SoC to settle down */
>>  	usleep_range(100, 200);
> 
> I said earlier the delay here should be enough to ensure that the byte
> gets transferred from a hardware buffer/FIFO to the controller,
> however that didn't take into account that the power pulses are sent
> with a baudrate of 2400. That translates to ~240 bytes/s, hence a
> delay of 5 ms is needed to be on the safe side.
> 

[Bala]: sure will update the delay of 5 ms.

> In case you change the delay please also update the comment to make
> clear this is not only time for the BT controller to settle, but also
> to guarantee that the command was actually sent to the controller.
> 

[Bala]: will update the comment.

> So far it seems no problems have been observed, though this could be
> thanks to the 100 ms delay in qca_wcn3990_init().
> 
> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
