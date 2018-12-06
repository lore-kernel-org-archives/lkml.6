Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B1FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DC1208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="brQgcnZr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V7i27NWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DC1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeLFKkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:40:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:40:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 716ED607B5; Thu,  6 Dec 2018 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544092808;
        bh=fUivZL1s5upLZ6o4BY6b7ICJk+NquYmE+NS6SkUqvb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=brQgcnZrc39UBOq3uo71BZ6Em/BpdDcNbzGA6x9z5dtn6zSZSYfHhOyCwtGPxoNLz
         G/xb9qSuudDUSS+0TvGoKjx+wi8F171+/qL2u32dhfFB4QiR1AEM8WVkKmakqw5sQX
         rn8Vo2XXcYJqyEm6W/6XMJLkDCTer5a/236GEKj4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E071460792;
        Thu,  6 Dec 2018 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544092807;
        bh=fUivZL1s5upLZ6o4BY6b7ICJk+NquYmE+NS6SkUqvb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7i27NWmde+SYh9gGSpWeqnVq3H4/HRcwjSy4AraCRD9fKuz5nQBLvrnJzHx1JMN0
         b88B+LGnCyM7SBD/ET/D9QBWP3Q0NibBKLvFaYC41D9LeczkXYcK+H7dqH1WukB7t9
         cdO7bKoRJxst3ldCmXpDVCdWSQ4N3oL63MxwRbCk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Dec 2018 16:10:07 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181205062503.GG18087@localhost>
References: <20181130150247.26294-1-bgodavar@codeaurora.org>
 <20181130150247.26294-2-bgodavar@codeaurora.org>
 <20181205062503.GG18087@localhost>
Message-ID: <c9bcbaed89a18499fe42463b20367499@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2018-12-05 11:55, Johan Hovold wrote:
> On Fri, Nov 30, 2018 at 08:32:44PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> v3:
>>   * no change.
>> v2:
>>   * Updated function qca_send_power_pulse()
>>   * addressed reviewer comments.
> 
> Please make sure to include reviewers on CC when resending, and as
> someone else already mentioned, be a bit more specific about what
> changes you actually made in response to the review feedback you
> received.
> 

[Bala]: sure will add and provide more info in version change history.

>> v1:
>>  * initial patch
>> ---
>>  drivers/bluetooth/hci_qca.c | 37 
>> +++++++++++++------------------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..f5dd323c1967 100644
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
>> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
> 
> You're still using 0 as a timeout here which is broken, as I already
> told you.
> 

[Bala]: got the change now will update to timeout to non zero value.

> From 4.21 this will result in an indefinite timeout, but currently
> implies not to wait for a full write buffer to drain at all.
> 
> As I also mentioned, you need to to make sure to call
> serdev_device_write_wakeup() in the write_wakup() path if you are going
> to use serdev_device_write() at all.
> 

[Bala]: this where i am confused.
         calling serdev_device_write is calling an wakeup internally. 
below is the flow

         ttyport_write_buf:
               * calling serdev_device_write() will call write_buf() in 
this call we are enabling bit "TTY_DO_WRITE_WAKEUP" and calling write()
                 i.e. uart_write() where we call in start_tx. this will 
go to the vendor specific write where in isr we call uart_write_wakeup()
                 
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/qcom_geni_serial.c#L756

         
uart_write_wakeup()->ttyport_write_wakeup()->serdev_controller_write_wakeup()->hci_uart_write_wakeup()->hci_uart_tx_wakeup()

         the above is flow when serdev_device_write() is called, it is 
indirectly calling serdev_write_wakeup().

         Why actual we need to call an serdev_write_wakeup() is this 
wakeup related to the UART port or for the BT chip.

> Johan

-- 
Regards
Balakrishna.
