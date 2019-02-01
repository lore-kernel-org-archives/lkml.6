Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E32C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A976421872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pMg4kouD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AgN2AW1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfBALkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:40:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfBALkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:40:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB7D160398; Fri,  1 Feb 2019 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549021213;
        bh=IP+poZF0mbxXJzUpkT/Te60hF3Qk4fALjWJMwBcOJZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMg4kouDVbZySoyiHi5zN+iaqLiw9JYVwhgHBlJq87AUkcfUSttRqIad1inIcO6ky
         yVKJ1T/OWZnwB8YktzOx4DNKh79m8kEMjUq+TZ0Yd7GhSFJ+owWXBLSa6Iij64Erm2
         +7FwqTUUQCFNCrRtahmRlD4pTsyXe5O8feh/ew+8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EFC0B60398;
        Fri,  1 Feb 2019 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549021212;
        bh=IP+poZF0mbxXJzUpkT/Te60hF3Qk4fALjWJMwBcOJZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AgN2AW1fzVzzz0jvPKZ09fQA4j6E0aO5Ww8ne+8LzBYYS36+f/SHxYz849kgh6oM4
         OjO6k3hPhR2IxzRyg4pSeRcNAmTBcfFfaWa9B65R19m4IeVqUIILYIYrmoBqYAE9Oz
         f4ZRtNRFY5xkry6/rOm1EM9x1q1mghnIEeaePuF0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Feb 2019 17:10:11 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 3/3] Bluetooth: hci_qca: Disable IBS state machine and
 flush Tx buffer
In-Reply-To: <20190125005534.GC81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-4-bgodavar@codeaurora.org>
 <20190125005534.GC81583@google.com>
Message-ID: <75923da910c43e7e5e033f4ff4360a90@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-25 06:25, Matthias Kaehlcke wrote:
> On Thu, Jan 24, 2019 at 05:38:08PM +0530, Balakrishna Godavarthi wrote:
>> During hci down we observed IBS sleep commands are queued in the Tx
>> buffer and hci_uart_write_work is sending data to the chip which is
>> not required as the chip is powered off. This patch will disable IBS
>> and flush the Tx buffer before we turn off the chip.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes v9:
>>   * added lock while disabling the IBS state machine.
>> 
>> ---
>>  drivers/bluetooth/hci_qca.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 6b5bcd44e24c..99ddc35f08c6 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -771,16 +771,17 @@ static int qca_enqueue(struct hci_uart *hu, 
>> struct sk_buff *skb)
>>  	/* Prepend skb with frame type */
>>  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>> 
>> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
>> +
>>  	/* Don't go to sleep in middle of patch download or
>>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>>  	 */
>>  	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>>  		skb_queue_tail(&qca->txq, skb);
>> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>>  		return 0;
>>  	}
>> 
>> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
>> -
>>  	/* Act according to current state */
>>  	switch (qca->tx_ibs_state) {
>>  	case HCI_IBS_TX_AWAKE:
>> @@ -1273,6 +1274,18 @@ static const struct qca_vreg_data qca_soc_data 
>> = {
>> 
>>  static void qca_power_shutdown(struct hci_uart *hu)
>>  {
>> +	struct qca_data *qca = hu->priv;
>> +	unsigned long flags;
>> +
>> +	/* From this point we go into power off state. But serial port is
>> +	 * still open, stop queueing the IBS data and flush all the buffered
>> +	 * data in skb's.
>> +	 */
>> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
>> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +	qca_flush(hu);
>> +	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>> +
>>  	host_set_baudrate(hu, 2400);
>>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>>  	qca_power_setup(hu, false);
> 
> I was about to add my 'Reviewed-by' tag, but I'm still left with a
> doubt. This patch certainly improves the situation by clearing the IBS
> bit and flushing the buffered data, however IIUC new data could still
> be added to the TX queue after releasing the spinlock:
> 
> static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> {
> 	...
> 
> 	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> 		skb_queue_tail(&qca->txq, skb);
> 
> 	...
> }
> 
> To prevent this a boolean/bit like 'shutting_down' or similar would be
> needed (I don't think there is something common in the HCI core),
> which is set in qca_power_shutdown(). If the bit is set qca_enqueue()
> discards the data.
> 
> Not sure how important this is, and I don't want to add necessarily
> more revisions to this series. If it is preferable to have an empty
> queue after shutdown maybe it can be done in a follow up patch.
> 
> Thanks
> 
> Matthias

[Bala]: during shutdown Bt stack will not send any data to the Bt  
kernel Tx path.
         so this call may not be called. once we shutdown chip.

-- 
Regards
Balakrishna.
