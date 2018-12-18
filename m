Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE78CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA469217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YzsT2CdX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ewrGylHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeLRKzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:55:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:55:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B19B608CF; Tue, 18 Dec 2018 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545130531;
        bh=syovhEZG/kVQpGDcOSmofclNxCPjiQqO2q4Y0M0/+IY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YzsT2CdXH75I2W9JfQ8VuJa7V00a8vPUK9/PJc/3N57XhGveyRozvxgSeiyTyVs++
         wJX6uQ49lEBa1wti+Su0sOJsgnF6o5Kwm9Uaj8T4u2f/CfEjTAFcICxqeWNFL8p8uM
         E+2VE3TfI1Nnwb+t03rWWSaW93zAUeWAQLRyGBIk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6EC46605A5;
        Tue, 18 Dec 2018 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545130530;
        bh=syovhEZG/kVQpGDcOSmofclNxCPjiQqO2q4Y0M0/+IY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ewrGylHnO/7RsnuSGDybsN0IvJHRjbr05JqD/iHAqb6/1rflLW3fzryDKNOh8HVB/
         jv2KeJQlGp7t/1WVZ2Q9Q2C2RiFZ7gJI13xEHQo3cPVbQTL6WIQDKqRkPYZlAeLPkm
         k1XJwBp+T8za9idMHAzzqsGeDZDwzoG4oaQfDO5M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 16:25:30 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v4 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181218091306.GA10562@localhost>
References: <20181217141330.6294-1-bgodavar@codeaurora.org>
 <20181217141330.6294-2-bgodavar@codeaurora.org>
 <20181218091306.GA10562@localhost>
Message-ID: <854e80111cbcb8a23a9e1e486328eb8f@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2018-12-18 14:43, Johan Hovold wrote:
> On Mon, Dec 17, 2018 at 07:43:26PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> v4:
>>  * used serdev_device_write_buf() instead of serdev_device_write()
>> 
>> v3:
>>   * no change.
>> v2:
>>   * Updated function qca_send_power_pulse()
>>   * addressed reviewer comments.
>> 
>> v1:
>>  * initial patch
>> 
>> ---
>>  drivers/bluetooth/hci_qca.c | 37 
>> +++++++++++++------------------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..d8bc77c8c9b9 100644
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
> 
> As I mentioned earlier, serdev_device_write_buf() can buffer less than
> sizeof(cmd) bytes if the tty driver's write buffer is full (and return
> the number of bytes buffered).
> 
> How you want to deal with that is up to you and the bluetooth
> maintainers, but I think you want to at least log it even if you choose
> to ignore it.
> 
> Johan

[Bala]: thanks for reminding me for buffer size.
         we use the qca_send_power_pulse() where we use 
serdev_write_buf() to send
         a single byte commands to the chip during power ON or power OFF 
i.e. as soon as we open port or before close.

during power on:
         ideally open port can guarantee me to the have tty buffer empty 
as we didn't queued any data.
         let us assume that if the buffer is full(), 
serdev_device_write_buf() will return -1 (as  buffer is full)
         anyways i have check for return status to log the write_buf 
failure.

during power off:
         yes here we may face an issue as already we have some data 
queued in the buffer. i.e. due to previous transactions.
         I think we can achieve this by calling 
serdev_device_write_flush() and then calling serdev_device_write_buf().

-- 
Regards
Balakrishna.
