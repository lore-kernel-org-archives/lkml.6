Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2202054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WLlFwYtX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gBkjD5R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAQK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:27:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfAQK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:27:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E63460A0A; Thu, 17 Jan 2019 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547720873;
        bh=NOsk1mAdMP9C98CozzoBaA3CYvF+HcfMMSA7Tf0HRMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WLlFwYtXWMuJW042vYCGtfcTeQD5PgxPXs6GjPsJrwbZrn6iKNqTSXNxa6t6b5hUT
         TylTSNt2KqaYnzsjFVp5dCNXGrSAZ/2WGpnuUCMv0Bu1sjZbaNMoyzF438MN3lWCTw
         K1RCilKFoWrpNyqSMcvhJMluLkkUU9Nwo0xdFrHc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2EBB460A08;
        Thu, 17 Jan 2019 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547720869;
        bh=NOsk1mAdMP9C98CozzoBaA3CYvF+HcfMMSA7Tf0HRMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gBkjD5R6AHPCWR7OlblBly/tJY6Vr3jjzsJkos6UICNvyKMT6+mB/op78pbVa6kjS
         snlDAHhpNoZkSXKTTQxwcfqiTWjU4D3XDZRup/590Q7Sn1SZV7qoMiQxHaa7KvgHBq
         fLn9YMsMTaOhBK2bUC0mAXA6+knZj6b1JlssqhGs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 15:57:48 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/3] Bluetooth: hci_qca: Disable IBS state machine and
 flush Tx buffer
In-Reply-To: <20190116230801.GT261387@google.com>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
 <20190116114603.500-4-bgodavar@codeaurora.org>
 <20190116230801.GT261387@google.com>
Message-ID: <5b507ee20e9e4ba022334433aa2f3691@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-17 04:38, Matthias Kaehlcke wrote:
> On Wed, Jan 16, 2019 at 05:16:03PM +0530, Balakrishna Godavarthi wrote:
>> During hci down we observed IBS sleep commands are queued in the Tx
>> buffer and hci_uart_write_work is sending data to the chip which is
>> not required as the chip is powered off. This patch will disable IBS
>> and flush the Tx buffer before we turn off the chip.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 7e4afcf40da2..7330ba71ada4 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1275,6 +1275,14 @@ static const struct qca_vreg_data qca_soc_data 
>> = {
>> 
>>  static void qca_power_shutdown(struct hci_uart *hu)
>>  {
>> +	struct qca_data *qca = hu->priv;
>> +
>> +	/* From this point we go into power off state. But serial port is
>> +	 * still open, stop queueing the IBS data and flush all the buffered
>> +	 * data in skb's.
>> +	 */
>> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +	qca_flush(hu);
>>  	host_set_baudrate(hu, 2400);
>>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>>  	qca_power_setup(hu, false);
> 
> Due to a race-condition there could be an IBS sleep command queued
> even after clearing the bit and flushing the queue.
> 
> In qca_enqueue() we have this:
> 
> static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> {
>         ...
> 
>         /* Don't go to sleep in middle of patch download or
>          * Out-Of-Band(GPIOs control) sleep is selected.
>          */
>         if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>                 skb_queue_tail(&qca->txq, skb);
>                 return 0;
>         }
> 
>         spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> }
> 
> With process X executing qca_power_shutdown() and process Y running
> qca_enqueue() this could happen:
> 
> [X] test_bit(STATE_IN_BAND_SLEEP_ENABLED)  => set
> [Y] clear_bit(STATE_IN_BAND_SLEEP_ENABLED)
> [Y] qca_flush(hu);
> [X] skb_queue_tail(&qca->txq, skb);
> 
> The following should fix this race:
> 
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -770,16 +770,17 @@ static int qca_enqueue(struct hci_uart *hu,
> struct sk_buff *skb)
>  	/* Prepend skb with frame type */
>  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> 
> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> +
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
>  	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
> +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
>  	}
> 
> -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -
>  	/* Act according to current state */
>  	switch (qca->tx_ibs_state) {
>  	case HCI_IBS_TX_AWAKE:
> @@ -1275,13 +1276,17 @@ static const struct qca_vreg_data qca_soc_data 
> = {
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
>  	struct qca_data *qca = hu->priv;
> +	unsigned long flags;
> 
>  	/* From this point we go into power off state. But serial port is
>  	 * still open, stop queueing the IBS data and flush all the buffered
>  	 * data in skb's.
>  	 */
> +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
>  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  	qca_flush(hu);
> +	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> +
[Bala]: Thanks for catch this. yes you are rite, we will have an byte 
queued in the skb.
         will update with the lock.

>  	host_set_baudrate(hu, 2400);
>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	qca_power_setup(hu, false);
> 
> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
